#include <iostream>
#include "common/Grid.h"
#include "infrastructure/InfrastructureAgent.h"

void print_intersection_state(const common::Intersection& intersection) {
    const auto& lights = intersection.getTrafficLights();
    for (size_t i = 0; i < lights.size(); ++i) {
        if (!intersection.isLightEnabled(static_cast<int>(i))) {
            std::cout << "  Light " << i << ": DISABLED" << std::endl;
        } else {
            std::cout << "  Light " << i << ": "
                      << (lights[i].getState() == common::LightState::GREEN ? "GREEN" : "RED")
                      << std::endl;
        }
    }
}

int main() {
    common::Grid grid;
    infrastructure::InfrastructureAgent agent(grid);

    for (int time_step = 0; time_step < 6; ++time_step) {
        std::cout << "Time Step " << time_step << std::endl;
        agent.step();

        std::cout << "Intersection (0,0) state:" << std::endl;
        print_intersection_state(grid.getIntersection(0, 0));
        std::cout << "Intersection (1,1) state:" << std::endl;
        print_intersection_state(grid.getIntersection(1, 1));
        std::cout << std::endl;
    }

    return 0;
}
