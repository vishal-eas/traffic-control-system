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

    // Call when a vehicle runs in the opposite direction on a road.
    void recordOppositeDirectionViolation() { ++opposite_direction_violations_; }

    // Call when a vehicle makes a U-turn.
    void recordUTurnViolation() { ++u_turn_violations_; }

    // Call when a vehicle completes a full A -> {B,C,D} -> A tour.
    void recordCompletedTour() { ++completed_tours_; }

    // Call once per simulation step to advance time.
    void tick() { ++total_steps_; }

    // Record travel time for a completed tour (in time steps).
    void recordTravelTime(int time_steps) { total_travel_time_ += time_steps; }

    // Record wait time at an intersection (incremented when vehicle doesn't move).
    void recordWaitTime(int time_steps) { total_wait_time_ += time_steps; }

    // --- Queries ---

    int getCollisions()          const { return collisions_; }
    int getRedLightViolations()  const { return red_light_violations_; }
    int getOppositeDirectionViolations() const { return opposite_direction_violations_; }
    int getUTurnViolations()     const { return u_turn_violations_; }
    int getCompletedTours()      const { return completed_tours_; }
    int getTotalSteps()          const { return total_steps_; }
    int getTotalTravelTime()     const { return total_travel_time_; }
    int getTotalWaitTime()       const { return total_wait_time_; }

    // Calculate average travel time per tour (in time steps).
    double getAverageTravelTime() const {
        if (completed_tours_ == 0) return 0.0;
        return static_cast<double>(total_travel_time_) / static_cast<double>(completed_tours_);
    }

    // Calculate average wait time per tour (in time steps).
    double getAverageWaitTime() const {
        if (completed_tours_ == 0) return 0.0;
        return static_cast<double>(total_wait_time_) / static_cast<double>(completed_tours_);
    }

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
        std::cout << "  Avg travel time    : " << std::fixed << std::setprecision(1)
                  << getAverageTravelTime() << " steps (" << getAverageTravelTime() * 2.0 << " sec)" << std::endl;
        std::cout << "  Avg wait time      : " << std::fixed << std::setprecision(1)
                  << getAverageWaitTime() << " steps (" << getAverageWaitTime() * 2.0 << " sec)" << std::endl;
        std::cout << "  Collisions         : " << collisions_
                  << (collisions_ == 0 ? "  (OK)" : "  (VIOLATIONS DETECTED)") << std::endl;
        std::cout << "  Red-light violations: " << red_light_violations_
                  << (red_light_violations_ == 0 ? "  (OK)" : "  (VIOLATIONS DETECTED)") << std::endl;
        std::cout << "  Opposite direction violations: " << opposite_direction_violations_
                  << (opposite_direction_violations_ == 0 ? "  (OK)" : "  (VIOLATIONS DETECTED)") << std::endl;
        std::cout << "  U-turn violations  : " << u_turn_violations_
                  << (u_turn_violations_ == 0 ? "  (OK)" : "  (VIOLATIONS DETECTED)") << std::endl;
        std::cout << "==============================" << std::endl;
    }

private:
    int collisions_          = 0;
    int red_light_violations_= 0;
    int opposite_direction_violations_ = 0;
    int u_turn_violations_   = 0;
    int completed_tours_     = 0;
    int total_steps_         = 0;
    int total_travel_time_   = 0;  // Accumulated time steps for all completed tours
    int total_wait_time_     = 0;  // Accumulated wait time at intersections
};

} // namespace common

#endif // SIMULATION_STATS_H
