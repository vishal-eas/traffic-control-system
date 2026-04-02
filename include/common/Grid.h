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
        bool isSquareNode(const common::Point& point) const;

        bool addVehicle(const common::Vehicle& vehicle);
        bool updateVehiclePosition(int vehicle_id, const common::Point& position);
        common::Vehicle* getVehicle(int vehicle_id);
        const std::unordered_map<int, common::Vehicle>& getVehicles() const;

        // Road and inventory queries
        common::Road* getRoad(int road_type, int row, int col);
        const common::Road* getRoad(int road_type, int row, int col) const;

        // Square node roads (index: 0=A, 1=B, 2=C, 3=D)
        common::Road* getSquareNodeRoad(int index);
        const common::Road* getSquareNodeRoad(int index) const;
        int getSquareNodeIndex(const common::Point& point) const;

        // Route management
        void setRoute(int vehicle_id, const std::vector<common::Point>& route);
        const std::vector<common::Point>& getRoute(int vehicle_id) const;

        // Traffic light management
        void setLight(int row, int col, int light_index, common::LightState state);
        common::LightState getLight(int row, int col, int light_index) const;

        // State mutation methods for agents (now with direction)
        bool canMoveToSlot(int vehicle_id, int road_type, int row, int col, int slot, Direction dir) const;
        bool moveVehicleToSlot(int vehicle_id, int road_type, int row, int col, int slot, Direction dir);
        bool moveVehicleToIntersection(int vehicle_id, const common::Point& intersection);
        std::vector<int> getVehiclesOnRoad(int road_type, int row, int col, Direction dir) const;
        bool isRoadSlotOccupied(int road_type, int row, int col, int slot, Direction dir) const;

        // Intersection crossing constraint
        void resetAllIntersectionOccupancy();
        bool isIntersectionOccupiedThisStep(int row, int col) const;
        void markIntersectionOccupied(int row, int col);

    private:
        // 3x3 grid of intersections
        std::array<std::array<common::Intersection,3>,3> intersections;
        // Roads connecting the intersections
        std::array<std::array<common::Road,2>,3> horizontal_roads;  // [row][col]: 3 rows, 2 cols
        std::array<std::array<common::Road,3>,2> vertical_roads;  // [row][col]: 2 rows, 3 cols

        // Square node roads (1-slot roads connecting A,B,C,D to grid corners)
        // Index: 0=A, 1=B, 2=C, 3=D
        std::array<common::Road, 4> square_roads;

        // Vehicle registry (shared state)
        std::unordered_map<int, common::Vehicle> vehicles;
    };
}

#endif // GRID_H
