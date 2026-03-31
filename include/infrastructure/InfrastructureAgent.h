#ifndef INFRASTRUCTURE_AGENT_H
#define INFRASTRUCTURE_AGENT_H

#include <vector>
#include "common/Grid.h"

namespace infrastructure {
    class InfrastructureAgent {
    public:
        InfrastructureAgent(common::Grid& grid);
        
        // Control traffic lights based on current state
        void updateLights();
        
        // Simulate one time step
        void step();

    private:
        common::Grid& grid;
        int time_step;
        
        // Light control strategies
        void simpleCycleStrategy();
    };
}

#endif // INFRASTRUCTURE_AGENT_H
