#include "common/Vehicle.h"

namespace common {
    Vehicle::Vehicle(int id, Point start_pos) : id(id), position(start_pos), speed(0) {}

    void Vehicle::setRoute(const std::vector<Point>& new_route) {
        route = new_route;
    }

    void Vehicle::move() {
        if (!route.empty()) {
            position = route.front();
            route.erase(route.begin());
        }
    }

    Point Vehicle::getPosition() const {
        return position;
    }
}
