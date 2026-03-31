#include "infrastructure/InfrastructureAgent.h"

namespace infrastructure {
    InfrastructureAgent::InfrastructureAgent(common::Grid& grid) 
        : grid(grid), time_step(0) {}

    void InfrastructureAgent::updateLights() {
        simpleCycleStrategy();
    }

    void InfrastructureAgent::step() {
        updateLights();
        time_step++;
    }

    void InfrastructureAgent::simpleCycleStrategy() {
        // Agent reads Grid state and makes traffic light decisions
        // Simple strategy: cycle through enabled light phases for all intersections
        
        for (int i = 0; i < 3; ++i) {
            for (int j = 0; j < 3; ++j) {
                common::Intersection& intersection = grid.getIntersection(i, j);
                
                // Read state: find enabled lights
                std::vector<int> enabled_lights;
                for (int k = 0; k < 4; ++k) {
                    if (intersection.isLightEnabled(k)) {
                        enabled_lights.push_back(k);
                    }
                }
                
                if (!enabled_lights.empty()) {
                    // Agent decision: rotate which light is green
                    int cycle_index = (time_step / 2) % enabled_lights.size();
                    
                    // Mutate state: set green light using Grid interface
                    grid.setLight(i, j, enabled_lights[cycle_index], common::LightState::GREEN);
                }
            }
        }
    }
}
