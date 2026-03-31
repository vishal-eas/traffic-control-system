#ifndef GRID_H
#define GRID_H

#include <array>
#include <unordered_map>
#include "common/Intersection.h"
#include "common/Road.h"
#include "common/Vehicle.h"

namespace common {
    class Grid {
    public:
        Grid();

        common::Intersection& getIntersection(int row, int col);
        const common::Intersection& getIntersection(int row, int col) const;

        // Vehicle state management
        bool isValidPoint(const common::Point& point) const;
        bool isIntersection(const common::Point& point) const;

        bool addVehicle(const common::Vehicle& vehicle);
        bool updateVehiclePosition(int vehicle_id, const common::Point& position);
        common::Vehicle* getVehicle(int vehicle_id);
        const std::unordered_map<int, common::Vehicle>& getVehicles() const;

        // Road and inventory queries
        common::Road* getRoad(int road_type, int row, int col);
        const common::Road* getRoad(int road_type, int row, int col) const;

        // Route management
        void setRoute(int vehicle_id, const std::vector<common::Point>& route);
        const std::vector<common::Point>& getRoute(int vehicle_id) const;
        
        // Traffic light management
        void setLight(int row, int col, int light_index, common::LightState state);
        common::LightState getLight(int row, int col, int light_index) const;

        // State mutation methods for agents
        bool canMoveToSlot(int vehicle_id, int road_type, int row, int col, int slot) const;
        bool moveVehicleToSlot(int vehicle_id, int road_type, int row, int col, int slot);
        bool moveVehicleToIntersection(int vehicle_id, const common::Point& intersection);
        std::vector<int> getVehiclesOnRoad(int road_type, int row, int col) const;
        bool isRoadSlotOccupied(int road_type, int row, int col, int slot) const;

    private:
        // 3x3 grid of intersections
        std::array<std::array<common::Intersection,3>,3> intersections;
        // Roads connecting the intersections
        std::array<std::array<common::Road,2>,3> horizontal_roads;
        std::array<std::array<common::Road,2>,3> vertical_roads;

        // Vehicle registry (shared state)
        std::unordered_map<int, common::Vehicle> vehicles;
    };
}

#endif // GRID_H
