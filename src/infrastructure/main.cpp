#include <iostream>
#include "common/Grid.h"
#include "infrastructure/InfrastructureAgent.h"

void print_intersection_state(const common::Intersection& intersection) {
    const auto& lights = intersection.getTrafficLights();
    for (size_t i = 0; i < lights.size(); ++i) {
        std::cout << "  Light " << i << ": " 
                  << (lights[i].getState() == common::LightState::GREEN ? "GREEN" : "RED") 
                  << std::endl;
    }
}

int main() {
    common::Grid grid;
    infrastructure::InfrastructureAgent agent(grid);

    // Simulation loop
    for (int time_step = 0; time_step < 10; ++time_step) {
        std::cout << "Time Step " << time_step << std::endl;

        // Update infrastructure
        agent.step();

        // Print the state of intersection (0,0)
        std::cout << "Intersection (0,0) state:" << std::endl;
        print_intersection_state(grid.getIntersection(0, 0));

        std::cout << std::endl;
    }

    return 0;
}
