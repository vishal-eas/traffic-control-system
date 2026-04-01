#include "common/Vehicle.h"

namespace common {
    Vehicle::Vehicle(int id, Point start_pos) : id(id), position(start_pos), speed(0) {
        detailed_pos.current_intersection = start_pos;
        detailed_pos.road_type = -1;
        detailed_pos.road_row = -1;
        detailed_pos.road_col = -1;
        detailed_pos.slot = -1;
        detailed_pos.at_intersection = true;
    }

    void Vehicle::setRoute(const std::vector<Point>& new_route) {
        route = new_route;
    }

    const std::vector<Point>& Vehicle::getRoute() const {
        return route;
    }

    void Vehicle::move() {
        // TODO: Implement slot-by-slot movement logic
        // For now, keep simple Point-to-Point movement
        if (!route.empty()) {
            position = route.front();
            route.erase(route.begin());
        }
    }

    Point Vehicle::getPosition() const {
        return position;
    }

    void Vehicle::setPosition(const Point& pos) {
        position = pos;
        detailed_pos.current_intersection = pos;
        detailed_pos.at_intersection = true;
        detailed_pos.road_type = -1;
        detailed_pos.road_row = -1;
        detailed_pos.road_col = -1;
        detailed_pos.slot = -1;
    }

    Vehicle::DetailedPosition Vehicle::getDetailedPosition() const {
        return detailed_pos;
    }

    void Vehicle::setDetailedPosition(const DetailedPosition& pos) {
        detailed_pos = pos;
        position = pos.current_intersection;
    }
}
