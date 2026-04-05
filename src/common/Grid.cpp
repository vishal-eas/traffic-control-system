#include "common/Grid.h"
#include <unordered_map>

namespace common {
    Grid::Grid() {
        // Disable lights for directions where no road exists
        // Light indices: 0=North, 1=East, 2=South, 3=West
        for (int row = 0; row < 3; ++row) {
            for (int col = 0; col < 3; ++col) {
                if (row == 0) intersections[row][col].disableLight(0); // No road north
                if (row == 2) intersections[row][col].disableLight(2); // No road south
                if (col == 0) intersections[row][col].disableLight(3); // No road west
                if (col == 2) intersections[row][col].disableLight(1); // No road east
            }
        }

        // Re-enable lights toward square nodes at corner intersections
        // A is west of (0,0): enable West light at (0,0)
        intersections[0][0].enableLight(3);
        // B is south of (2,0): enable South light at (2,0)
        intersections[2][0].enableLight(2);
        // C is east of (2,2): enable East light at (2,2)
        intersections[2][2].enableLight(1);
        // D is north of (0,2): enable North light at (0,2)
        intersections[0][2].enableLight(0);
    }

    common::Intersection& Grid::getIntersection(int row, int col) {
        return intersections[row][col];
    }

    const common::Intersection& Grid::getIntersection(int row, int col) const {
        return intersections[row][col];
    }

    bool Grid::isValidPoint(const common::Point& point) const {
        // Valid if it's an intersection or a square node
        return isIntersection(point) || isSquareNode(point);
    }

    bool Grid::isIntersection(const common::Point& point) const {
        return point.x >= 0 && point.x < 3 && point.y >= 0 && point.y < 3;
    }

    bool Grid::isSquareNode(const common::Point& point) const {
        return point == SQUARE_A || point == SQUARE_B ||
               point == SQUARE_C || point == SQUARE_D;
    }

    int Grid::getSquareNodeIndex(const common::Point& point) const {
        if (point == SQUARE_A) return 0;
        if (point == SQUARE_B) return 1;
        if (point == SQUARE_C) return 2;
        if (point == SQUARE_D) return 3;
        return -1;
    }

    bool Grid::addVehicle(const common::Vehicle& vehicle) {
        if (!isValidPoint(vehicle.getPosition())) return false;
        vehicles.insert_or_assign(vehicle.getId(), vehicle);
        return true;
    }

    bool Grid::updateVehiclePosition(int vehicle_id, const common::Point& position) {
        if (!isValidPoint(position)) return false;

        auto it = vehicles.find(vehicle_id);
        if (it != vehicles.end()) {
            it->second.setPosition(position);
            return true;
        }
        return false;
    }

    common::Vehicle* Grid::getVehicle(int vehicle_id) {
        auto it = vehicles.find(vehicle_id);
        return it != vehicles.end() ? &it->second : nullptr;
    }

    const std::unordered_map<int, common::Vehicle>& Grid::getVehicles() const {
        return vehicles;
    }

    void Grid::setRoute(int vehicle_id, const std::vector<common::Point>& route) {
        auto it = vehicles.find(vehicle_id);
        if (it != vehicles.end()) {
            it->second.setRoute(route);
        }
    }

    const std::vector<common::Point>& Grid::getRoute(int vehicle_id) const {
        static const std::vector<common::Point> empty_route;
        auto it = vehicles.find(vehicle_id);
        return it != vehicles.end() ? it->second.getRoute() : empty_route;
    }

    void Grid::setLight(int row, int col, int light_index, common::LightState state) {
        if (row >= 0 && row < 3 && col >= 0 && col < 3) {
            if (state == common::LightState::GREEN) {
                intersections[row][col].setGreenLight(light_index);
            }
            // For RED, we rely on setGreenLight setting others to RED
        }
    }

    common::LightState Grid::getLight(int row, int col, int light_index) const {
        if (row >= 0 && row < 3 && col >= 0 && col < 3) {
            return intersections[row][col].isGreen(light_index) ? common::LightState::GREEN : common::LightState::RED;
        }
        return common::LightState::RED;
    }

    common::Road* Grid::getRoad(int road_type, int row, int col) {
        if (road_type == 0 && row >= 0 && row < 3 && col >= 0 && col < 2) {
            return &horizontal_roads[row][col];
        } else if (road_type == 1 && row >= 0 && row < 2 && col >= 0 && col < 3) {
            return &vertical_roads[row][col];
        }
        return nullptr;
    }

    const common::Road* Grid::getRoad(int road_type, int row, int col) const {
        if (road_type == 0 && row >= 0 && row < 3 && col >= 0 && col < 2) {
            return &horizontal_roads[row][col];
        } else if (road_type == 1 && row >= 0 && row < 2 && col >= 0 && col < 3) {
            return &vertical_roads[row][col];
        }
        return nullptr;
    }

    common::Road* Grid::getSquareNodeRoad(int index) {
        if (index >= 0 && index < 4) return &square_roads[index];
        return nullptr;
    }

    const common::Road* Grid::getSquareNodeRoad(int index) const {
        if (index >= 0 && index < 4) return &square_roads[index];
        return nullptr;
    }

    bool Grid::isRoadSlotOccupied(int road_type, int row, int col, int slot, Direction dir) const {
        const common::Road* road = getRoad(road_type, row, col);
        if (!road) return true;
        return road->isSlotOccupied(slot, dir);
    }

    bool Grid::canMoveToSlot(int vehicle_id, int road_type, int row, int col, int slot, Direction dir) const {
        const common::Road* road = getRoad(road_type, row, col);
        if (!road) return false;
        return slot >= 0 && slot < road->slotCount() && !road->isSlotOccupied(slot, dir);
    }

    bool Grid::moveVehicleToSlot(int vehicle_id, int road_type, int row, int col, int slot, Direction dir) {
        common::Road* road = getRoad(road_type, row, col);
        if (!road) return false;

        common::Vehicle* vehicle_ptr = getVehicle(vehicle_id);
        if (!vehicle_ptr) return false;

        // Check if destination slot is free
        if (road->isSlotOccupied(slot, dir)) return false;

        // Clear old slot if vehicle was on a road
        auto detailed_pos = vehicle_ptr->getDetailedPosition();
        if (!detailed_pos.at_intersection && detailed_pos.road_type >= 0) {
            common::Road* old_road = getRoad(detailed_pos.road_type, detailed_pos.road_row, detailed_pos.road_col);
            if (old_road) {
                Direction old_dir = static_cast<Direction>(detailed_pos.direction);
                old_road->clearSlot(detailed_pos.slot, old_dir);
            }
        }

        // Set vehicle in new slot
        if (!road->setSlot(slot, vehicle_id, dir)) return false;

        // Update vehicle position tracking
        common::Vehicle::DetailedPosition new_pos;
        new_pos.current_intersection = vehicle_ptr->getPosition();
        new_pos.road_type = road_type;
        new_pos.road_row = row;
        new_pos.road_col = col;
        new_pos.slot = slot;
        new_pos.direction = static_cast<int>(dir);
        new_pos.at_intersection = false;
        vehicle_ptr->setDetailedPosition(new_pos);

        return true;
    }

    bool Grid::moveVehicleToIntersection(int vehicle_id, const common::Point& intersection) {
        if (!isValidPoint(intersection)) return false;

        common::Vehicle* vehicle_ptr = getVehicle(vehicle_id);
        if (!vehicle_ptr) return false;

        // Clear old slot if vehicle was on a road
        auto detailed_pos = vehicle_ptr->getDetailedPosition();
        if (!detailed_pos.at_intersection && detailed_pos.road_type >= 0) {
            common::Road* old_road = getRoad(detailed_pos.road_type, detailed_pos.road_row, detailed_pos.road_col);
            if (old_road) {
                Direction old_dir = static_cast<Direction>(detailed_pos.direction);
                old_road->clearSlot(detailed_pos.slot, old_dir);
            }
        }

        // Update position to intersection
        vehicle_ptr->setPosition(intersection);

        // Mark as at intersection
        common::Vehicle::DetailedPosition new_pos;
        new_pos.current_intersection = intersection;
        new_pos.at_intersection = true;
        new_pos.road_type = -1;
        new_pos.road_row = -1;
        new_pos.road_col = -1;
        new_pos.slot = -1;
        new_pos.direction = -1;
        vehicle_ptr->setDetailedPosition(new_pos);

        return true;
    }

    std::vector<int> Grid::getVehiclesOnRoad(int road_type, int row, int col, Direction dir) const {
        std::vector<int> vehicles_on_road;
        int dir_int = static_cast<int>(dir);

        for (const auto& kv : vehicles) {
            const common::Vehicle& v = kv.second;
            auto pos = v.getDetailedPosition();
            if (!pos.at_intersection && pos.road_type == road_type &&
                pos.road_row == row && pos.road_col == col &&
                pos.direction == dir_int) {
                vehicles_on_road.push_back(v.getId());
            }
        }

        return vehicles_on_road;
    }

    // Intersection crossing constraint methods
    void Grid::resetAllIntersectionOccupancy() {
        for (int i = 0; i < 3; ++i) {
            for (int j = 0; j < 3; ++j) {
                intersections[i][j].resetStepOccupancy();
            }
        }
    }

    bool Grid::isIntersectionOccupiedThisStep(int row, int col) const {
        if (row < 0 || row >= 3 || col < 0 || col >= 3) return true;
        return intersections[row][col].isOccupiedThisStep();
    }

    void Grid::markIntersectionOccupied(int row, int col) {
        if (row >= 0 && row < 3 && col >= 0 && col < 3) {
            intersections[row][col].setOccupiedThisStep(true);
        }
    }

    int Grid::detectCollisions() const {
        // Build a map from (road_type, row, col, direction, slot) -> vehicle count.
        // Any entry with count > 1 is a collision.
        // Key packing: road_type*10000000 + row*1000000 + col*100000 + dir*10000 + slot
        std::unordered_map<long long, int> slot_occupancy;

        for (const auto& kv : vehicles) {
            const common::Vehicle& v = kv.second;
            auto pos = v.getDetailedPosition();
            if (pos.at_intersection || pos.road_type < 0 || pos.slot < 0) continue;

            long long key = static_cast<long long>(pos.road_type) * 10000000LL
                          + pos.road_row  * 1000000LL
                          + pos.road_col  * 100000LL
                          + pos.direction * 10000LL
                          + pos.slot;
            slot_occupancy[key]++;
        }

        int collisions = 0;
        for (const auto& entry : slot_occupancy) {
            if (entry.second > 1) collisions += (entry.second - 1);
        }
        return collisions;
    }
}  // namespace common
