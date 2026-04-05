#include "vehicle/VehicleAgent.h"
#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>
#include <unordered_map>
#include <unordered_set>

namespace {
    constexpr int HEADING_UNKNOWN = -1;
    constexpr int HEADING_NORTH = 0;
    constexpr int HEADING_EAST = 1;
    constexpr int HEADING_SOUTH = 2;
    constexpr int HEADING_WEST = 3;

    int oppositeHeading(int heading) {
        if (heading == HEADING_NORTH) return HEADING_SOUTH;
        if (heading == HEADING_SOUTH) return HEADING_NORTH;
        if (heading == HEADING_EAST) return HEADING_WEST;
        if (heading == HEADING_WEST) return HEADING_EAST;
        return HEADING_UNKNOWN;
    }

    int headingFromRoadDirection(int road_type, common::Direction dir) {
        if (road_type == 0) {
            return (dir == common::Direction::FORWARD) ? HEADING_EAST : HEADING_WEST;
        }
        return (dir == common::Direction::FORWARD) ? HEADING_SOUTH : HEADING_NORTH;
    }

    int headingFromIntersectionStep(const common::Point& from, const common::Point& to) {
        if (from.x == to.x) {
            if (to.y > from.y) return HEADING_EAST;
            if (to.y < from.y) return HEADING_WEST;
        }
        if (from.y == to.y) {
            if (to.x > from.x) return HEADING_SOUTH;
            if (to.x < from.x) return HEADING_NORTH;
        }
        return HEADING_UNKNOWN;
    }

    int headingFromSquareToIntersection(const common::Point& square) {
        if (square == common::SQUARE_A) return HEADING_EAST;
        if (square == common::SQUARE_B) return HEADING_NORTH;
        if (square == common::SQUARE_C) return HEADING_WEST;
        if (square == common::SQUARE_D) return HEADING_SOUTH;
        return HEADING_UNKNOWN;
    }

    int headingFromIntersectionToSquare(const common::Point& square) {
        if (square == common::SQUARE_A) return HEADING_WEST;
        if (square == common::SQUARE_B) return HEADING_SOUTH;
        if (square == common::SQUARE_C) return HEADING_EAST;
        if (square == common::SQUARE_D) return HEADING_NORTH;
        return HEADING_UNKNOWN;
    }

    common::Point adjacentIntersectionForSquare(const common::Point& square) {
        if (square == common::SQUARE_A) return {0, 0};
        if (square == common::SQUARE_B) return {2, 0};
        if (square == common::SQUARE_C) return {2, 2};
        if (square == common::SQUARE_D) return {0, 2};
        return {-999, -999};
    }

    bool isAdjacentIntersectionForSquare(const common::Point& intersection, const common::Point& square) {
        return adjacentIntersectionForSquare(square) == intersection;
    }

    std::vector<std::pair<common::Point, int>> outgoingNeighbors(const common::Point& node) {
        std::vector<std::pair<common::Point, int>> neighbors;

        // Grid intersections
        if (node.x >= 0 && node.x < 3 && node.y >= 0 && node.y < 3) {
            if (node.x > 0) neighbors.push_back({{node.x - 1, node.y}, HEADING_NORTH});
            if (node.y < 2) neighbors.push_back({{node.x, node.y + 1}, HEADING_EAST});
            if (node.x < 2) neighbors.push_back({{node.x + 1, node.y}, HEADING_SOUTH});
            if (node.y > 0) neighbors.push_back({{node.x, node.y - 1}, HEADING_WEST});

            // Corner square-node links
            if (node == common::Point{0, 0}) neighbors.push_back({common::SQUARE_A, HEADING_WEST});
            if (node == common::Point{2, 0}) neighbors.push_back({common::SQUARE_B, HEADING_SOUTH});
            if (node == common::Point{2, 2}) neighbors.push_back({common::SQUARE_C, HEADING_EAST});
            if (node == common::Point{0, 2}) neighbors.push_back({common::SQUARE_D, HEADING_NORTH});

            return neighbors;
        }

        // Square nodes link to one adjacent corner intersection
        common::Point adj = adjacentIntersectionForSquare(node);
        if (adj.x != -999) {
            neighbors.push_back({adj, headingFromSquareToIntersection(node)});
        }

        return neighbors;
    }

    struct PathState {
        common::Point node;
        int incoming_heading;
        int pending_forbidden_heading;

        bool operator==(const PathState& other) const {
            return node == other.node &&
                   incoming_heading == other.incoming_heading &&
                   pending_forbidden_heading == other.pending_forbidden_heading;
        }
    };

    struct PathStateHash {
        std::size_t operator()(const PathState& s) const {
            std::size_t h1 = std::hash<common::Point>()(s.node);
            std::size_t h2 = std::hash<int>()(s.incoming_heading);
            std::size_t h3 = std::hash<int>()(s.pending_forbidden_heading);
            return h1 ^ (h2 << 1) ^ (h3 << 2);
        }
    };
}

namespace vehicle {
    VehicleAgent::VehicleAgent(common::Grid& grid, common::SimulationStats* stats)
        : grid(grid), stats_(stats), time_step(0) {}

    void VehicleAgent::addVehicle(int vehicle_id, common::Point start_pos) {
        common::Vehicle vehicle(vehicle_id, start_pos);
        grid.addVehicle(vehicle);
        intersection_incoming_heading.erase(vehicle_id);
        post_square_forbidden_heading.erase(vehicle_id);
    }

    void VehicleAgent::updateVehicles() {
        updateRoutePlanning();
        updateMovement();
    }

    void VehicleAgent::step() {
        updateVehicles();
        time_step++;
        if (stats_) {
            // Tick time and scan for any slot collisions after all moves.
            stats_->tick();
            int c = grid.detectCollisions();
            for (int i = 0; i < c; ++i) stats_->recordCollision();
        }
    }

    common::Vehicle* VehicleAgent::getVehicleById(int vehicle_id) {
        return grid.getVehicle(vehicle_id);
    }

    void VehicleAgent::updateRoutePlanning() {
        // Expand hardcoded square-node goals into shortest waypoint paths while
        // enforcing no-U-turn transitions at intersections.
        auto& grid_vehicles = grid.getVehicles();
        for (const auto& kv : grid_vehicles) {
            int vehicle_id = kv.first;
            common::Vehicle* vehicle_ptr = grid.getVehicle(vehicle_id);
            if (!vehicle_ptr) continue;

            auto route = vehicle_ptr->getRoute();
            if (route.empty()) continue;

            common::Point current = vehicle_ptr->getPosition();
            common::Point goal = route.front();

            // Route planning targets are square nodes (hardcoded per vehicle).
            // If route front is already an intersection waypoint, keep it.
            if (!grid.isSquareNode(goal)) continue;
            if (current == goal) continue;

            // If already at the corner intersection adjacent to this square,
            // movement can directly attempt the square transition.
            if (grid.isIntersection(current) && isAdjacentIntersectionForSquare(current, goal)) {
                continue;
            }

            std::vector<common::Point> path = computeShortestPathNoUTurn(vehicle_id, current, goal);
            if (path.empty()) {
                continue;
            }

            std::vector<common::Point> planned_route;
            planned_route.reserve(path.size() + route.size() - 1);
            planned_route.insert(planned_route.end(), path.begin(), path.end());
            planned_route.insert(planned_route.end(), route.begin() + 1, route.end());

            grid.setRoute(vehicle_id, planned_route);
        }
    }

    int VehicleAgent::getIncomingHeadingAtIntersection(int vehicle_id) const {
        auto it = intersection_incoming_heading.find(vehicle_id);
        if (it == intersection_incoming_heading.end()) return HEADING_UNKNOWN;
        return it->second;
    }

    void VehicleAgent::setIncomingHeadingAtIntersection(int vehicle_id, int heading) {
        intersection_incoming_heading[vehicle_id] = heading;
    }

    int VehicleAgent::getPostSquareForbiddenHeading(int vehicle_id) const {
        auto it = post_square_forbidden_heading.find(vehicle_id);
        if (it == post_square_forbidden_heading.end()) return HEADING_UNKNOWN;
        return it->second;
    }

    void VehicleAgent::clearPostSquareForbiddenHeading(int vehicle_id) {
        post_square_forbidden_heading.erase(vehicle_id);
    }

    std::vector<common::Point> VehicleAgent::computeShortestPathNoUTurn(
        int vehicle_id,
        const common::Point& start,
        const common::Point& goal) const {
        if (start == goal) return {};

        int start_heading = HEADING_UNKNOWN;
        if (grid.isIntersection(start)) {
            start_heading = getIncomingHeadingAtIntersection(vehicle_id);
        }
        int start_pending_forbidden = HEADING_UNKNOWN;
        int deferred_forbidden_after_square = HEADING_UNKNOWN;
        if (grid.isIntersection(start)) {
            start_pending_forbidden = getPostSquareForbiddenHeading(vehicle_id);
        } else if (grid.isSquareNode(start)) {
            deferred_forbidden_after_square = getPostSquareForbiddenHeading(vehicle_id);
        }

        PathState start_state{start, start_heading, start_pending_forbidden};
        std::queue<PathState> q;
        std::unordered_set<PathState, PathStateHash> visited;
        std::unordered_map<PathState, PathState, PathStateHash> parent;

        q.push(start_state);
        visited.insert(start_state);

        bool found = false;
        PathState goal_state{};

        while (!q.empty()) {
            PathState cur = q.front();
            q.pop();

            if (cur.node == goal) {
                found = true;
                goal_state = cur;
                break;
            }

            auto neighbors = outgoingNeighbors(cur.node);
            for (const auto& candidate : neighbors) {
                const common::Point& next_node = candidate.first;
                int out_heading = candidate.second;

                if (grid.isIntersection(cur.node) &&
                    cur.pending_forbidden_heading != HEADING_UNKNOWN &&
                    out_heading == cur.pending_forbidden_heading) {
                    continue; // Don't immediately reverse the pre-square approach road.
                }

                if (grid.isIntersection(cur.node) && cur.incoming_heading != HEADING_UNKNOWN) {
                    if (out_heading == oppositeHeading(cur.incoming_heading)) {
                        continue; // Reject U-turn transition.
                    }
                }

                int next_pending_forbidden = HEADING_UNKNOWN;
                if (cur == start_state && grid.isSquareNode(cur.node)) {
                    next_pending_forbidden = deferred_forbidden_after_square;
                }

                PathState next_state{next_node, out_heading, next_pending_forbidden};
                if (visited.find(next_state) != visited.end()) continue;

                visited.insert(next_state);
                parent[next_state] = cur;
                q.push(next_state);
            }
        }

        if (!found) return {};

        std::vector<common::Point> reversed_path;
        PathState cursor = goal_state;
        while (!(cursor == start_state)) {
            reversed_path.push_back(cursor.node);
            cursor = parent[cursor];
        }

        std::reverse(reversed_path.begin(), reversed_path.end());
        return reversed_path;
    }

    void VehicleAgent::updateMovement() {
        // Reset intersection crossing flags for this time step
        grid.resetAllIntersectionOccupancy();

        auto& grid_vehicles = grid.getVehicles();
        // Prevent a vehicle from being advanced more than once per global step.
        std::unordered_set<int> moved_this_step;

        // Phase 1: Process vehicles at intersections — try to enter a road
        for (const auto& kv : grid_vehicles) {
            int vehicle_id = kv.first;
            common::Vehicle* vehicle_ptr = grid.getVehicle(vehicle_id);
            if (!vehicle_ptr) continue;

            auto detailed_pos = vehicle_ptr->getDetailedPosition();

            if (detailed_pos.at_intersection) {
                if (vehicle_ptr->getRoute().empty()) continue;

                common::Point current = vehicle_ptr->getPosition();
                common::Point next = vehicle_ptr->getRoute().front();
                int incoming_heading = getIncomingHeadingAtIntersection(vehicle_id);
                int post_square_forbidden = getPostSquareForbiddenHeading(vehicle_id);

                // Check intersection crossing constraint
                if (grid.isIntersection(current) &&
                    grid.isIntersectionOccupiedThisStep(current.x, current.y)) {
                    continue; // Another car already crossing this intersection
                }

                // Determine which road, direction, and light to use
                int road_type, road_row, road_col;
                int light_index;
                common::Direction dir;

                if (grid.isSquareNode(current)) {
                    // Vehicle at a square node wants to enter the grid
                    // Determine which intersection to go to
                    common::Point adj_intersection = adjacentIntersectionForSquare(current);
                    if (adj_intersection.x == -999) continue;

                    // Route integrity: square node can only move to its adjacent corner intersection.
                    if (next != adj_intersection) {
                        continue;
                    }

                    // Enforce intersection crossing constraint for square-node entry.
                    if (grid.isIntersectionOccupiedThisStep(adj_intersection.x, adj_intersection.y)) {
                        continue;
                    }

                    if (grid.moveVehicleToIntersection(vehicle_id, adj_intersection)) {
                        grid.markIntersectionOccupied(adj_intersection.x, adj_intersection.y);
                        setIncomingHeadingAtIntersection(vehicle_id, headingFromSquareToIntersection(current));
                        moved_this_step.insert(vehicle_id);
                        // Pop the waypoint if it matches.
                        auto route = vehicle_ptr->getRoute();
                        if (!route.empty() && route.front() == adj_intersection) {
                            route.erase(route.begin());
                            grid.setRoute(vehicle_id, route);
                        }
                    }
                    continue;
                }

                // Vehicle at a grid intersection wants to move toward next waypoint
                if (grid.isSquareNode(next)) {
                    // Heading toward a square node
                    bool valid_square_transition = false;
                    int outgoing_heading = headingFromIntersectionToSquare(next);

                    // Determine the light for leaving the intersection toward the square node
                    if (next == common::SQUARE_A) {
                        light_index = 3; // West
                        valid_square_transition = (current == common::Point{0, 0});
                    } else if (next == common::SQUARE_B) {
                        light_index = 2; // South
                        valid_square_transition = (current == common::Point{2, 0});
                    } else if (next == common::SQUARE_C) {
                        light_index = 1; // East
                        valid_square_transition = (current == common::Point{2, 2});
                    } else if (next == common::SQUARE_D) {
                        light_index = 0; // North
                        valid_square_transition = (current == common::Point{0, 2});
                    } else {
                        continue;
                    }

                    if (!valid_square_transition) {
                        continue;
                    }

                    // Enforce no-U-turn at intersection movement level.
                    if (incoming_heading != HEADING_UNKNOWN &&
                        outgoing_heading == oppositeHeading(incoming_heading)) {
                        continue;
                    }

                    if (post_square_forbidden != HEADING_UNKNOWN &&
                        outgoing_heading == post_square_forbidden) {
                        continue;
                    }

                    if (grid.getLight(current.x, current.y, light_index) == common::LightState::GREEN) {
                        // Move to the square node directly (1-slot link)
                        if (grid.moveVehicleToIntersection(vehicle_id, next)) {
                            grid.markIntersectionOccupied(current.x, current.y);
                            if (incoming_heading != HEADING_UNKNOWN) {
                                post_square_forbidden_heading[vehicle_id] = oppositeHeading(incoming_heading);
                            } else {
                                clearPostSquareForbiddenHeading(vehicle_id);
                            }
                            // Post-move violation check (should always be green — catches bugs).
                            if (stats_ &&
                                grid.getLight(current.x, current.y, light_index) != common::LightState::GREEN) {
                                stats_->recordRedLightViolation();
                            }
                            moved_this_step.insert(vehicle_id);
                            auto route = vehicle_ptr->getRoute();
                            if (!route.empty()) {
                                route.erase(route.begin());
                                grid.setRoute(vehicle_id, route);
                                // Tour complete: vehicle reached SQUARE_A with empty route.
                                if (stats_ && next == common::SQUARE_A && route.empty() &&
                                    tours_recorded_.find(vehicle_id) == tours_recorded_.end()) {
                                    stats_->recordCompletedTour();
                                    tours_recorded_.insert(vehicle_id);
                                }
                            }
                        }
                    }
                    continue;
                }

                // Normal intersection-to-intersection movement
                if (current.y == next.y && current.x != next.x) {
                    // Vertical movement (north/south)
                    road_type = 1;
                    if (next.x > current.x) {
                        // Going south: FORWARD on vertical_roads[current.x][current.y]
                        road_row = current.x;
                        road_col = current.y;
                        dir = common::Direction::FORWARD;
                        light_index = 2; // South
                    } else {
                        // Going north: BACKWARD on vertical_roads[next.x][current.y]
                        road_row = next.x;
                        road_col = current.y;
                        dir = common::Direction::BACKWARD;
                        light_index = 0; // North
                    }
                } else if (current.x == next.x && current.y != next.y) {
                    // Horizontal movement (east/west)
                    road_type = 0;
                    if (next.y > current.y) {
                        // Going east: FORWARD on horizontal_roads[current.x][current.y]
                        road_row = current.x;
                        road_col = current.y;
                        dir = common::Direction::FORWARD;
                        light_index = 1; // East
                    } else {
                        // Going west: BACKWARD on horizontal_roads[current.x][next.y]
                        road_row = current.x;
                        road_col = next.y;
                        dir = common::Direction::BACKWARD;
                        light_index = 3; // West
                    }
                } else {
                    continue; // Invalid move (diagonal or same point)
                }

                int outgoing_heading = headingFromIntersectionStep(current, next);
                if (outgoing_heading == HEADING_UNKNOWN) continue;

                // Enforce no-U-turn at intersection movement level.
                if (incoming_heading != HEADING_UNKNOWN &&
                    outgoing_heading == oppositeHeading(incoming_heading)) {
                    continue;
                }

                if (post_square_forbidden != HEADING_UNKNOWN &&
                    outgoing_heading == post_square_forbidden) {
                    continue;
                }

                // Check traffic light and first slot availability
                if (grid.getLight(current.x, current.y, light_index) == common::LightState::GREEN) {
                    if (grid.canMoveToSlot(vehicle_id, road_type, road_row, road_col, 0, dir)) {
                        if (grid.moveVehicleToSlot(vehicle_id, road_type, road_row, road_col, 0, dir)) {
                            grid.markIntersectionOccupied(current.x, current.y);
                            clearPostSquareForbiddenHeading(vehicle_id);
                            moved_this_step.insert(vehicle_id);
                            // Post-move sanity check: light must still be green (single-threaded,
                            // so this always holds — catches any future logic bugs).
                            if (stats_ &&
                                grid.getLight(current.x, current.y, light_index) != common::LightState::GREEN) {
                                stats_->recordRedLightViolation();
                            }
                        }
                    }
                } else if (stats_) {
                    // Vehicle is blocked by a red light — not a violation, just waiting.
                    // No action needed; recorded here as a comment for clarity.
                    (void)0;
                }
            }
        }

        // Phase 2: Process vehicles on roads — slot-by-slot movement
        for (int road_type = 0; road_type < 2; ++road_type) {
            int max_row = (road_type == 0) ? 3 : 2;
            int max_col = (road_type == 0) ? 2 : 3;

            for (int row = 0; row < max_row; ++row) {
                for (int col = 0; col < max_col; ++col) {
                    // Process both directions
                    for (int d = 0; d < 2; ++d) {
                        common::Direction dir = static_cast<common::Direction>(d);

                        std::vector<int> vehicles_on_road = grid.getVehiclesOnRoad(road_type, row, col, dir);
                        if (vehicles_on_road.empty()) continue;

                        // Sort by slot descending (front vehicles first)
                        std::sort(vehicles_on_road.begin(), vehicles_on_road.end(),
                            [this](int a, int b) {
                                auto pos_a = grid.getVehicle(a)->getDetailedPosition();
                                auto pos_b = grid.getVehicle(b)->getDetailedPosition();
                                return pos_a.slot > pos_b.slot;
                            });

                        for (int vehicle_id : vehicles_on_road) {
                            common::Vehicle* vehicle_ptr = grid.getVehicle(vehicle_id);
                            if (!vehicle_ptr) continue;
                            if (moved_this_step.find(vehicle_id) != moved_this_step.end()) continue;

                            auto pos = vehicle_ptr->getDetailedPosition();
                            int current_slot = pos.slot;

                            if (current_slot < 29) {
                                // Try to move to next slot
                                if (grid.canMoveToSlot(vehicle_id, road_type, row, col, current_slot + 1, dir)) {
                                    if (grid.moveVehicleToSlot(vehicle_id, road_type, row, col, current_slot + 1, dir)) {
                                        moved_this_step.insert(vehicle_id);
                                    }
                                }
                            } else if (current_slot == 29) {
                                // At end of road — determine destination intersection based on direction
                                common::Point next_intersection;
                                if (road_type == 0) { // Horizontal
                                    if (dir == common::Direction::FORWARD) {
                                        next_intersection = {row, col + 1}; // Eastbound arrives at right intersection
                                    } else {
                                        next_intersection = {row, col}; // Westbound arrives at left intersection
                                    }
                                } else { // Vertical
                                    if (dir == common::Direction::FORWARD) {
                                        next_intersection = {row + 1, col}; // Southbound arrives at bottom intersection
                                    } else {
                                        next_intersection = {row, col}; // Northbound arrives at top intersection
                                    }
                                }

                                // Check intersection crossing constraint
                                if (grid.isIntersection(next_intersection) &&
                                    grid.isIntersectionOccupiedThisStep(next_intersection.x, next_intersection.y)) {
                                    continue; // Intersection busy, wait at slot 29
                                }

                                if (grid.moveVehicleToIntersection(vehicle_id, next_intersection)) {
                                    if (grid.isIntersection(next_intersection)) {
                                        grid.markIntersectionOccupied(next_intersection.x, next_intersection.y);
                                    }
                                    setIncomingHeadingAtIntersection(
                                        vehicle_id,
                                        headingFromRoadDirection(road_type, dir));
                                    moved_this_step.insert(vehicle_id);
                                    // Remove the reached waypoint from route
                                    auto route = vehicle_ptr->getRoute();
                                    if (!route.empty() && route.front() == next_intersection) {
                                        route.erase(route.begin());
                                        grid.setRoute(vehicle_id, route);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
