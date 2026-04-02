#ifndef VEHICLE_AGENT_H
#define VEHICLE_AGENT_H

#include <vector>
#include <unordered_map>
#include "common/Vehicle.h"
#include "common/Grid.h"

namespace vehicle {
    class VehicleAgent {
    public:
        VehicleAgent(common::Grid& grid);
        
        // Create vehicles in the system
        void addVehicle(int vehicle_id, common::Point start_pos);
        
        // Update vehicle decisions (routing, movement)
        void updateVehicles();
        
        // Simulate one time step
        void step();
        
        // Get all vehicles
        const std::unordered_map<int, common::Vehicle>& getVehicles() const { return grid.getVehicles(); }
        common::Vehicle* getVehicleById(int vehicle_id);

    private:
        common::Grid& grid;
        int time_step;
        // Incoming heading at the current intersection for each vehicle.
        // -1 = unknown, 0 = north, 1 = east, 2 = south, 3 = west.
        std::unordered_map<int, int> intersection_incoming_heading;
        // One-step restriction after returning from a square node:
        // forbid taking this heading for the first exit from the corner intersection.
        std::unordered_map<int, int> post_square_forbidden_heading;
        
        // Decision making
        void updateRoutePlanning();
        void updateMovement();

        std::vector<common::Point> computeShortestPathNoUTurn(
            int vehicle_id,
            const common::Point& start,
            const common::Point& goal) const;
        int getIncomingHeadingAtIntersection(int vehicle_id) const;
        void setIncomingHeadingAtIntersection(int vehicle_id, int heading);
        int getPostSquareForbiddenHeading(int vehicle_id) const;
        void clearPostSquareForbiddenHeading(int vehicle_id);
    };
}

#endif // VEHICLE_AGENT_H
