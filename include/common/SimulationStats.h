#ifndef SIMULATION_STATS_H
#define SIMULATION_STATS_H

#include <iostream>
#include <iomanip>

namespace common {

// Tracks and reports simulation-level metrics for verification.
// Passed to VehicleAgent, which records events during movement.
class SimulationStats {
public:
    SimulationStats() = default;

    // --- Recording ---

    // Call when a collision is detected (two vehicles in same lane/slot).
    void recordCollision() { ++collisions_; }

    // Call when a vehicle enters a road while the light for its direction is RED.
    void recordRedLightViolation() { ++red_light_violations_; }

    // Call when a vehicle completes a full A -> {B,C,D} -> A tour.
    void recordCompletedTour() { ++completed_tours_; }

    // Call once per simulation step to advance time.
    void tick() { ++total_steps_; }

    // --- Queries ---

    int getCollisions()          const { return collisions_; }
    int getRedLightViolations()  const { return red_light_violations_; }
    int getCompletedTours()      const { return completed_tours_; }
    int getTotalSteps()          const { return total_steps_; }

    // Throughput: tours completed per simulated hour.
    // Each time step = 2 seconds, so total time = steps * 2s.
    double getThroughputPerHour() const {
        if (total_steps_ == 0) return 0.0;
        double total_seconds = static_cast<double>(total_steps_) * 2.0;
        return (static_cast<double>(completed_tours_) / total_seconds) * 3600.0;
    }

    void printReport() const {
        std::cout << "\n=== Simulation Statistics ===" << std::endl;
        std::cout << "  Total time steps   : " << total_steps_
                  << " (" << total_steps_ * 2 << " simulated seconds)" << std::endl;
        std::cout << "  Completed tours    : " << completed_tours_ << std::endl;
        std::cout << "  Throughput         : " << std::fixed << std::setprecision(2)
                  << getThroughputPerHour() << " tours/hour" << std::endl;
        std::cout << "  Collisions         : " << collisions_
                  << (collisions_ == 0 ? "  (OK)" : "  (VIOLATIONS DETECTED)") << std::endl;
        std::cout << "  Red-light violations: " << red_light_violations_
                  << (red_light_violations_ == 0 ? "  (OK)" : "  (VIOLATIONS DETECTED)") << std::endl;
        std::cout << "==============================" << std::endl;
    }

private:
    int collisions_          = 0;
    int red_light_violations_= 0;
    int completed_tours_     = 0;
    int total_steps_         = 0;
};

} // namespace common

#endif // SIMULATION_STATS_H
