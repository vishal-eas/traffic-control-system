#include "vehicle/VehicleAgent.h"
#include <iostream>
#include <vector>
#include <algorithm>
#include <limits>
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

    int squareRoadIndex(const common::Point& square) {
        if (square == common::SQUARE_A) return 0;
        if (square == common::SQUARE_B) return 1;
        if (square == common::SQUARE_C) return 2;
        if (square == common::SQUARE_D) return 3;
        return -1;
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

    bool containsPoint(const std::vector<common::Point>& points, const common::Point& target) {
        return std::find(points.begin(), points.end(), target) != points.end();
    }

    common::Point firstSquareInRoute(const std::vector<common::Point>& route) {
        for (const auto& point : route) {
            if (point == common::SQUARE_A || point == common::SQUARE_B ||
                point == common::SQUARE_C || point == common::SQUARE_D) {
                return point;
            }
        }
        return {-999, -999};
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
        completed_tours_by_vehicle_[vehicle_id] = 0;
        tour_templates_.erase(vehicle_id);
        vehicle_start_step_[vehicle_id] = time_step;
        vehicle_wait_steps_[vehicle_id] = 0;
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
        auto& grid_vehicles = grid.getVehicles();

        for (const auto& kv : grid_vehicles) {
            int vehicle_id = kv.first;
            common::Vehicle* vehicle_ptr = grid.getVehicle(vehicle_id);
            if (!vehicle_ptr) continue;

            auto route = vehicle_ptr->getRoute();
            common::Point current = vehicle_ptr->getPosition();
            captureTourTemplateIfNeeded(vehicle_id, route);

            if (route.empty()) {
                if (current == common::SQUARE_A) {
                    auto template_it = tour_templates_.find(vehicle_id);
                    if (template_it == tour_templates_.end() || template_it->second.empty()) {
                        tour_templates_[vehicle_id] = defaultTourTemplateForVehicle(vehicle_id);
                        template_it = tour_templates_.find(vehicle_id);
                    }
                    route = template_it->second;
                    grid.setRoute(vehicle_id, route);
                } else {
                    continue;
                }
            }

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

    int VehicleAgent::estimateTravelCost(
        int vehicle_id,
        const common::Point& start,
        const common::Point& goal) const {
        std::vector<common::Point> path = computeShortestPathNoUTurn(vehicle_id, start, goal);
        if (path.empty()) {
            return std::numeric_limits<int>::max() / 4;
        }

        int cost = 0;
        common::Point previous = start;
        for (const auto& node : path) {
            if (grid.isSquareNode(previous) || grid.isSquareNode(node)) {
                cost += 2;
                const common::Point square = grid.isSquareNode(previous) ? previous : node;
                const int square_index = squareRoadIndex(square);
                const common::Road* road = grid.getRoad(2, square_index, 0);
                if (road) {
                    common::Direction dir =
                        grid.isSquareNode(previous) ? common::Direction::BACKWARD
                                                    : common::Direction::FORWARD;
                    if (road->isSlotOccupied(0, dir)) {
                        cost += 8;
                    }
                }
            } else {
                cost += 31;

                int road_type = -1;
                int road_row = -1;
                int road_col = -1;
                common::Direction dir = common::Direction::FORWARD;

                if (previous.y == node.y && previous.x != node.x) {
                    road_type = 1;
                    if (node.x > previous.x) {
                        road_row = previous.x;
                        road_col = previous.y;
                        dir = common::Direction::FORWARD;
                    } else {
                        road_row = node.x;
                        road_col = previous.y;
                        dir = common::Direction::BACKWARD;
                    }
                } else if (previous.x == node.x && previous.y != node.y) {
                    road_type = 0;
                    if (node.y > previous.y) {
                        road_row = previous.x;
                        road_col = previous.y;
                        dir = common::Direction::FORWARD;
                    } else {
                        road_row = previous.x;
                        road_col = node.y;
                        dir = common::Direction::BACKWARD;
                    }
                }

                const common::Road* road = grid.getRoad(road_type, road_row, road_col);
                if (road) {
                    int occupancy = 0;
                    for (int slot = 0; slot < road->slotCount(); ++slot) {
                        if (road->isSlotOccupied(slot, dir)) {
                            occupancy++;
                            if (slot >= road->slotCount() - 5) {
                                cost += 3;
                            }
                        }
                    }
                    cost += occupancy * 2;
                }
            }
            previous = node;
        }

        return cost;
    }

    std::vector<common::Point> VehicleAgent::extractRemainingSquareGoals(
        const std::vector<common::Point>& route) const {
        return extractSquareGoals(route);
    }

    std::vector<common::Point> VehicleAgent::extractSquareGoals(
        const std::vector<common::Point>& route) const {
        std::vector<common::Point> goals;
        for (const auto& point : route) {
            if (grid.isSquareNode(point) && !containsPoint(goals, point)) {
                goals.push_back(point);
            }
        }
        return goals;
    }

    std::vector<common::Point> VehicleAgent::defaultTourTemplateForVehicle(int vehicle_id) const {
        if ((vehicle_id % 2) == 0) {
            return {common::SQUARE_D, common::SQUARE_C, common::SQUARE_B, common::SQUARE_A};
        }
        return {common::SQUARE_B, common::SQUARE_C, common::SQUARE_D, common::SQUARE_A};
    }

    void VehicleAgent::captureTourTemplateIfNeeded(
        int vehicle_id,
        const std::vector<common::Point>& route) {
        if (tour_templates_.find(vehicle_id) != tour_templates_.end()) {
            return;
        }

        const std::vector<common::Point> square_goals = extractSquareGoals(route);
        if (square_goals.size() == 4 && square_goals.back() == common::SQUARE_A) {
            tour_templates_[vehicle_id] = square_goals;
        }
    }

    bool VehicleAgent::hasVehicleAheadWithinVisibility(
        int vehicle_id,
        int road_type,
        int row,
        int col,
        int current_slot,
        common::Direction dir) const {
        (void)vehicle_id;
        (void)road_type;
        (void)row;
        (void)col;
        const common::Road* road = grid.getRoad(road_type, row, col);
        if (!road) {
            return false;
        }

        const int visibility_slots = 30;
        const int last_slot = road->slotCount() - 1;
        const int max_slot = std::min(last_slot, current_slot + visibility_slots);

        for (int slot = current_slot + 1; slot <= max_slot; ++slot) {
            if (road->isSlotOccupied(slot, dir)) {
                return true;
            }
        }
        return false;
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
            if (!detailed_pos.at_intersection || vehicle_ptr->getRoute().empty()) {
                continue;
            }

            common::Point current = vehicle_ptr->getPosition();
            common::Point next = vehicle_ptr->getRoute().front();
            int incoming_heading = getIncomingHeadingAtIntersection(vehicle_id);
            int post_square_forbidden = getPostSquareForbiddenHeading(vehicle_id);

            int road_type = -1;
            int road_row = -1;
            int road_col = 0;
            int light_index = -1;
            bool requires_green = false;
            common::Direction dir = common::Direction::FORWARD;

            if (grid.isSquareNode(current)) {
                common::Point adj_intersection = adjacentIntersectionForSquare(current);
                int square_index = squareRoadIndex(current);
                if (adj_intersection.x == -999 || square_index < 0 || next != adj_intersection) {
                    continue;
                }

                road_type = 2;
                road_row = square_index;
                dir = common::Direction::BACKWARD;
            } else if (grid.isSquareNode(next)) {
                if (!isAdjacentIntersectionForSquare(current, next)) {
                    continue;
                }

                int outgoing_heading = headingFromIntersectionToSquare(next);
                if (outgoing_heading == HEADING_UNKNOWN) continue;
                if (incoming_heading != HEADING_UNKNOWN &&
                    outgoing_heading == oppositeHeading(incoming_heading)) {
                    continue;
                }
                if (post_square_forbidden != HEADING_UNKNOWN &&
                    outgoing_heading == post_square_forbidden) {
                    continue;
                }

                road_type = 2;
                road_row = squareRoadIndex(next);
                dir = common::Direction::FORWARD;
                requires_green = true;

                if (next == common::SQUARE_A) {
                    light_index = 3;
                } else if (next == common::SQUARE_B) {
                    light_index = 2;
                } else if (next == common::SQUARE_C) {
                    light_index = 1;
                } else if (next == common::SQUARE_D) {
                    light_index = 0;
                } else {
                    continue;
                }
            } else {
                if (current.y == next.y && current.x != next.x) {
                    road_type = 1;
                    if (next.x > current.x) {
                        road_row = current.x;
                        road_col = current.y;
                        dir = common::Direction::FORWARD;
                        light_index = 2;
                    } else {
                        road_row = next.x;
                        road_col = current.y;
                        dir = common::Direction::BACKWARD;
                        light_index = 0;
                    }
                } else if (current.x == next.x && current.y != next.y) {
                    road_type = 0;
                    if (next.y > current.y) {
                        road_row = current.x;
                        road_col = current.y;
                        dir = common::Direction::FORWARD;
                        light_index = 1;
                    } else {
                        road_row = current.x;
                        road_col = next.y;
                        dir = common::Direction::BACKWARD;
                        light_index = 3;
                    }
                } else {
                    continue;
                }

                int outgoing_heading = headingFromIntersectionStep(current, next);
                if (outgoing_heading == HEADING_UNKNOWN) continue;
                if (incoming_heading != HEADING_UNKNOWN &&
                    outgoing_heading == oppositeHeading(incoming_heading)) {
                    continue;
                }
                if (post_square_forbidden != HEADING_UNKNOWN &&
                    outgoing_heading == post_square_forbidden) {
                    continue;
                }

                requires_green = true;
            }

            if (requires_green &&
                grid.getLight(current.x, current.y, light_index) != common::LightState::GREEN) {
                continue;
            }

            if (!grid.canMoveToSlot(vehicle_id, road_type, road_row, road_col, 0, dir)) {
                continue;
            }

            if (grid.moveVehicleToSlot(vehicle_id, road_type, road_row, road_col, 0, dir)) {
                clearPostSquareForbiddenHeading(vehicle_id);
                moved_this_step.insert(vehicle_id);
            }
        }

        // Phase 2: Process vehicles on roads — slot-by-slot movement
        for (int road_type = 0; road_type < 3; ++road_type) {
            int max_row = (road_type == 0) ? 3 : ((road_type == 1) ? 2 : 4);
            int max_col = (road_type == 0) ? 2 : ((road_type == 1) ? 3 : 1);

            for (int row = 0; row < max_row; ++row) {
                for (int col = 0; col < max_col; ++col) {
                    const common::Road* road = grid.getRoad(road_type, row, col);
                    if (!road) continue;

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
                            const int last_slot = road->slotCount() - 1;

                            if (hasVehicleAheadWithinVisibility(
                                    vehicle_id, road_type, row, col, current_slot, dir)) {
                                continue;
                            }

                            if (current_slot < last_slot) {
                                // Try to move to next slot
                                if (grid.canMoveToSlot(vehicle_id, road_type, row, col, current_slot + 1, dir)) {
                                    if (grid.moveVehicleToSlot(vehicle_id, road_type, row, col, current_slot + 1, dir)) {
                                        moved_this_step.insert(vehicle_id);
                                    }
                                }
                            } else if (current_slot == last_slot) {
                                common::Point destination;
                                bool destination_is_intersection = true;
                                int incoming_heading = HEADING_UNKNOWN;

                                if (road_type == 0) { // Horizontal
                                    if (dir == common::Direction::FORWARD) {
                                        destination = {row, col + 1};
                                    } else {
                                        destination = {row, col};
                                    }
                                    incoming_heading = headingFromRoadDirection(road_type, dir);
                                } else if (road_type == 1) { // Vertical
                                    if (dir == common::Direction::FORWARD) {
                                        destination = {row + 1, col};
                                    } else {
                                        destination = {row, col};
                                    }
                                    incoming_heading = headingFromRoadDirection(road_type, dir);
                                } else {
                                    const common::Point square =
                                        (row == 0) ? common::SQUARE_A :
                                        (row == 1) ? common::SQUARE_B :
                                        (row == 2) ? common::SQUARE_C :
                                                     common::SQUARE_D;

                                    if (dir == common::Direction::FORWARD) {
                                        destination = square;
                                        destination_is_intersection = false;
                                    } else {
                                        destination = adjacentIntersectionForSquare(square);
                                        incoming_heading = headingFromSquareToIntersection(square);
                                    }
                                }

                                if (destination_is_intersection &&
                                    grid.isIntersectionOccupiedThisStep(destination.x, destination.y)) {
                                    continue;
                                }

                                if (grid.moveVehicleToIntersection(vehicle_id, destination)) {
                                    if (destination_is_intersection) {
                                        grid.markIntersectionOccupied(destination.x, destination.y);
                                        setIncomingHeadingAtIntersection(vehicle_id, incoming_heading);
                                    } else {
                                        post_square_forbidden_heading[vehicle_id] =
                                            headingFromIntersectionToSquare(destination);
                                    }
                                    moved_this_step.insert(vehicle_id);

                                    auto route = vehicle_ptr->getRoute();
                                    if (!route.empty() && route.front() == destination) {
                                        route.erase(route.begin());
                                        grid.setRoute(vehicle_id, route);

                                        if (stats_ && destination == common::SQUARE_A && route.empty()) {
                                            stats_->recordCompletedTour();
                                            stats_->recordTravelTime(
                                                time_step - vehicle_start_step_[vehicle_id] + 1);
                                            completed_tours_by_vehicle_[vehicle_id]++;
                                            vehicle_start_step_[vehicle_id] = time_step + 1;
                                            vehicle_wait_steps_[vehicle_id] = 0;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        if (stats_) {
            for (const auto& kv : grid_vehicles) {
                int vehicle_id = kv.first;
                if (moved_this_step.find(vehicle_id) != moved_this_step.end()) {
                    continue;
                }

                const common::Vehicle& vehicle = kv.second;
                if (vehicle.getRoute().empty()) {
                    continue;
                }

                if (vehicle.getDetailedPosition().at_intersection) {
                    vehicle_wait_steps_[vehicle_id]++;
                    stats_->recordWaitTime(1);
                }
            }
        }
    }
}
