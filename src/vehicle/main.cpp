#include <iostream>
#include "common/Grid.h"
#include "vehicle/VehicleAgent.h"
#include "infrastructure/InfrastructureAgent.h"

void print_position(const common::Point& position) {
    std::cout << "(" << position.x << ", " << position.y << ")";
}

void print_vehicle_positions(const vehicle::VehicleAgent& agent) {
    auto& vehicles = agent.getVehicles();
    for (const auto& kv : vehicles) {
        const auto& vehicle = kv.second;
        std::cout << "V" << vehicle.getId() << ": ";
        print_position(vehicle.getPosition());
        std::cout << " ";
    }
    std::cout << std::endl;
}

int main() {
    common::Grid grid;
    vehicle::VehicleAgent vehicle_agent(grid);
    infrastructure::InfrastructureAgent infra_agent(grid);

    // Create multiple vehicles
    vehicle_agent.addVehicle(1, {0, 0});
    vehicle_agent.addVehicle(2, {0, 0});
    vehicle_agent.addVehicle(3, {0, 0});

    // Set routes for vehicles
    common::Vehicle* vehicle_ptr1 = vehicle_agent.getVehicleById(1);
    if (vehicle_ptr1) {
        std::vector<common::Point> route = {{0, 1}, {0, 2}, {1, 2}, {2, 2}};
        vehicle_ptr1->setRoute(route);
    }
    
    common::Vehicle* vehicle_ptr2 = vehicle_agent.getVehicleById(2);
    if (vehicle_ptr2) {
        std::vector<common::Point> route = {{0, 1}, {0, 2}, {1, 2}, {2, 2}};
        vehicle_ptr2->setRoute(route);
    }
    
    common::Vehicle* vehicle_ptr3 = vehicle_agent.getVehicleById(3);
    if (vehicle_ptr3) {
        std::vector<common::Point> route = {{0, 1}, {0, 2}, {1, 2}, {2, 2}};
        vehicle_ptr3->setRoute(route);
    }

    // Simulation loop
    for (int time_step = 0; time_step < 70; ++time_step) {
        if (time_step <= 5 || (time_step >= 30 && time_step <= 40) || time_step >= 65) {
            std::cout << "Time Step " << time_step << ": ";
            print_vehicle_positions(vehicle_agent);
        }
        
        // Update infrastructure first
        infra_agent.step();
        
        // Then update vehicles
        vehicle_agent.step();
    }

    return 0;
}
