#ifndef INFRASTRUCTURE_AGENT_H
#define INFRASTRUCTURE_AGENT_H

#include <vector>
#include <array>
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

        // Per-intersection, per-direction: consecutive ticks that direction has been red
        // Direction index: 0=North, 1=East, 2=South, 3=West
        std::array<std::array<int, 4>, 9> red_streak;  // [intersection_id][direction]

        static constexpr int MAX_RED_WAIT = 4;

        // Light control strategies
        void simpleCycleStrategy();
        void congestionAwareStrategy();

        // Count vehicles approaching an intersection from a given direction
        int countApproachingVehicles(int row, int col, int direction) const;
        int approachPriorityScore(int row, int col, int direction) const;
    };
}

#endif // INFRASTRUCTURE_AGENT_H
