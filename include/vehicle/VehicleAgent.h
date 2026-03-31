#ifndef VEHICLE_AGENT_H
#define VEHICLE_AGENT_H

#include <vector>
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
        
        // Decision making
        void updateRoutePlanning();
        void updateMovement();
    };
}

#endif // VEHICLE_AGENT_H
