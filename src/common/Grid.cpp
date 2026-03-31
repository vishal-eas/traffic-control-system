#include "common/Grid.h"

namespace common {
    Grid::Grid() {}

    common::Intersection& Grid::getIntersection(int row, int col) {
        return intersections[row][col];
    }

    const common::Intersection& Grid::getIntersection(int row, int col) const {
        return intersections[row][col];
    }

    bool Grid::isValidPoint(const common::Point& point) const {
        return point.x >= 0 && point.x < 3 && point.y >= 0 && point.y < 3;
    }

    bool Grid::isIntersection(const common::Point& point) const {
        return isValidPoint(point);
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
        if (road_type == 0 && row >= 0 && row < 3 && col >= 0 && col < 2) {  // Horizontal
            return &horizontal_roads[row][col];
        } else if (road_type == 1 && row >= 0 && row < 3 && col >= 0 && col < 2) {  // Vertical
            return &vertical_roads[row][col];
        }
        return nullptr;
    }

    const common::Road* Grid::getRoad(int road_type, int row, int col) const {
        if (road_type == 0 && row >= 0 && row < 3 && col >= 0 && col < 2) {  // Horizontal
            return &horizontal_roads[row][col];
        } else if (road_type == 1 && row >= 0 && row < 3 && col >= 0 && col < 2) {  // Vertical
            return &vertical_roads[row][col];
        }
        return nullptr;
    }

    bool Grid::isRoadSlotOccupied(int road_type, int row, int col, int slot) const {
        const common::Road* road = getRoad(road_type, row, col);
        if (!road) return true;  // Non-existent roads are considered occupied
        return road->isSlotOccupied(slot);
    }

    bool Grid::canMoveToSlot(int vehicle_id, int road_type, int row, int col, int slot) const {
        const common::Road* road = getRoad(road_type, row, col);
        if (!road) return false;
        
        // Check if slot is within bounds and empty
        return slot >= 0 && slot < road->slotCount() && !road->isSlotOccupied(slot);
    }

    bool Grid::moveVehicleToSlot(int vehicle_id, int road_type, int row, int col, int slot) {
        common::Road* road = getRoad(road_type, row, col);
        if (!road) return false;
        
        common::Vehicle* vehicle_ptr = getVehicle(vehicle_id);
        if (!vehicle_ptr) return false;
        
        // Check if destination slot is free
        if (road->isSlotOccupied(slot)) return false;
        
        // Clear old slot if vehicle was on a road
        auto detailed_pos = vehicle_ptr->getDetailedPosition();
        if (!detailed_pos.at_intersection && detailed_pos.road_type >= 0) {
            common::Road* old_road = getRoad(detailed_pos.road_type, detailed_pos.road_row, detailed_pos.road_col);
            if (old_road) {
                old_road->clearSlot(detailed_pos.slot);
            }
        }
        
        // Set vehicle in new slot
        if (!road->setSlot(slot, vehicle_id)) return false;
        
        // Update vehicle position tracking
        common::Vehicle::DetailedPosition new_pos;
        new_pos.current_intersection = vehicle_ptr->getPosition();
        new_pos.road_type = road_type;
        new_pos.road_row = row;
        new_pos.road_col = col;
        new_pos.slot = slot;
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
                old_road->clearSlot(detailed_pos.slot);
            }
        }
        
        // Update position to intersection
        vehicle_ptr->setPosition(intersection);
        
        // Mark as at intersection
        common::Vehicle::DetailedPosition new_pos = detailed_pos;
        new_pos.current_intersection = intersection;
        new_pos.at_intersection = true;
        new_pos.road_type = -1;
        new_pos.slot = -1;
        vehicle_ptr->setDetailedPosition(new_pos);
        
        return true;
    }

    std::vector<int> Grid::getVehiclesOnRoad(int road_type, int row, int col) const {
        std::vector<int> vehicles_on_road;
        
        for (const auto& kv : vehicles) {
            const common::Vehicle& v = kv.second;
            auto pos = v.getDetailedPosition();
            if (!pos.at_intersection && pos.road_type == road_type && 
                pos.road_row == row && pos.road_col == col) {
                vehicles_on_road.push_back(v.getId());
            }
        }
        
        return vehicles_on_road;
    }
}  // namespace common
