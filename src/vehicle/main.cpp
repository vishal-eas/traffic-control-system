#include <iostream>
#include "common/Grid.h"
#include "vehicle/VehicleAgent.h"
#include "infrastructure/InfrastructureAgent.h"

void print_position(const common::Point& position) {
    // Print named square nodes
    if (position == common::SQUARE_A) { std::cout << "A"; return; }
    if (position == common::SQUARE_B) { std::cout << "B"; return; }
    if (position == common::SQUARE_C) { std::cout << "C"; return; }
    if (position == common::SQUARE_D) { std::cout << "D"; return; }
    std::cout << "(" << position.x << "," << position.y << ")";
}

void print_vehicle_status(const common::Vehicle& vehicle) {
    auto pos = vehicle.getDetailedPosition();
    std::cout << "V" << vehicle.getId() << ": ";
    if (pos.at_intersection) {
        print_position(vehicle.getPosition());
    } else {
        std::cout << (pos.road_type == 0 ? "H" : "V")
                  << "[" << pos.road_row << "," << pos.road_col << "]"
                  << (pos.direction == 0 ? "F" : "B")
                  << " slot=" << pos.slot;
    }
    std::cout << " ";
}

int main() {
    common::Grid grid;
    vehicle::VehicleAgent vehicle_agent(grid);
    infrastructure::InfrastructureAgent infra_agent(grid);

    // Create vehicles starting at square node A
    vehicle_agent.addVehicle(1, common::SQUARE_A);
    vehicle_agent.addVehicle(2, common::SQUARE_A);
    vehicle_agent.addVehicle(3, common::SQUARE_A);

    // Hardcoded destination goals (square nodes only).
    // VehicleAgent computes shortest waypoint paths between these goals.
    common::Vehicle* v1 = vehicle_agent.getVehicleById(1);
    if (v1) {
        // A -> B -> C -> D -> A
        std::vector<common::Point> route = {
            common::SQUARE_B,
            common::SQUARE_C,
            common::SQUARE_D,
            common::SQUARE_A
        };
        v1->setRoute(route);
    }

    common::Vehicle* v2 = vehicle_agent.getVehicleById(2);
    if (v2) {
        // A -> C -> B -> D -> A
        std::vector<common::Point> route = {
            common::SQUARE_C,
            common::SQUARE_B,
            common::SQUARE_D,
            common::SQUARE_A
        };
        v2->setRoute(route);
    }

    common::Vehicle* v3 = vehicle_agent.getVehicleById(3);
    if (v3) {
        // A -> D -> B -> C -> A
        std::vector<common::Point> route = {
            common::SQUARE_D,
            common::SQUARE_B,
            common::SQUARE_C,
            common::SQUARE_A
        };
        v3->setRoute(route);
    }

    // Simulation loop
    int total_steps = 1500;
    for (int t = 0; t < total_steps; ++t) {
        std::cout << "T=" << t << ": ";
        for (const auto& kv : grid.getVehicles()) {
            print_vehicle_status(kv.second);
        }
        std::cout << std::endl;

        // Update infrastructure first, then vehicles
        infra_agent.step();
        vehicle_agent.step();
    }

    std::cout << "\nSimulation complete (" << total_steps << " time steps)." << std::endl;

    // Print final positions
    std::cout << "Final positions:" << std::endl;
    for (const auto& kv : grid.getVehicles()) {
        std::cout << "  ";
        print_vehicle_status(kv.second);
        auto route = kv.second.getRoute();
        std::cout << " (remaining waypoints: " << route.size() << ")" << std::endl;
    }

    return 0;
}
