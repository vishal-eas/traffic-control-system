#include "infrastructure/InfrastructureAgent.h"

namespace infrastructure {
    InfrastructureAgent::InfrastructureAgent(common::Grid& grid)
        : grid(grid), time_step(0) {}

    void InfrastructureAgent::updateLights() {
        simpleCycleStrategy();
    }

    void InfrastructureAgent::step() {
        updateLights();
        ++time_step;
    }

    void InfrastructureAgent::simpleCycleStrategy() {
        // Read the shared Grid state and rotate the green light over the
        // directions that are actually enabled at each intersection.
        for (int row = 0; row < 3; ++row) {
            for (int col = 0; col < 3; ++col) {
                common::Intersection& intersection = grid.getIntersection(row, col);

                std::vector<int> enabled_lights;
                for (int light = 0; light < 4; ++light) {
                    if (intersection.isLightEnabled(light)) {
                        enabled_lights.push_back(light);
                    }
                }

                if (enabled_lights.empty()) {
                    continue;
                }

                const int phase_index = (time_step / 2) % static_cast<int>(enabled_lights.size());
                const int green_light = enabled_lights[phase_index];
                grid.setLight(row, col, green_light, common::LightState::GREEN);
            }
        }
    }
}
