#include <iostream>
#include "common/Grid.h"
#include "infrastructure/InfrastructureAgent.h"

const char* light_name(int index) {
    switch (index) {
        case 0: return "North";
        case 1: return "East";
        case 2: return "South";
        case 3: return "West";
        default: return "?";
    }
}

void print_intersection_state(const common::Intersection& intersection, int row, int col) {
    std::cout << "Intersection (" << row << "," << col << "):" << std::endl;
    const auto& lights = intersection.getTrafficLights();
    for (size_t i = 0; i < lights.size(); ++i) {
        if (!intersection.isLightEnabled(static_cast<int>(i))) {
            std::cout << "  Light " << i << ": DISABLED" << std::endl;
        } else {
            std::cout << "  " << light_name(static_cast<int>(i)) << ": "
                      << (lights[i].getState() == common::LightState::GREEN ? "GREEN" : "RED")
                      << std::endl;
        }
    }
}

int main() {
    common::Grid grid;
    infrastructure::InfrastructureAgent agent(grid);

    std::cout << "=== Traffic Light Topology ===" << std::endl;
    std::cout << "Enabled lights per intersection:" << std::endl;
    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j < 3; ++j) {
            const auto& intersection = grid.getIntersection(i, j);
            std::cout << "  (" << i << "," << j << "): ";
            for (int k = 0; k < 4; ++k) {
                if (intersection.isLightEnabled(k)) {
                    std::cout << light_name(k) << " ";
                }
            }
            std::cout << std::endl;
        }
    }
    std::cout << std::endl;

    // Simulation loop
    for (int time_step = 0; time_step < 10; ++time_step) {
        std::cout << "Time Step " << time_step << std::endl;
        agent.step();

        // Print state of a few intersections
        print_intersection_state(grid.getIntersection(0, 0), 0, 0);
        print_intersection_state(grid.getIntersection(1, 1), 1, 1);
        std::cout << std::endl;
    }

    return 0;
}
