#include "infrastructure/InfrastructureAgent.h"

namespace infrastructure {
    InfrastructureAgent::InfrastructureAgent(common::Grid& grid)
        : grid(grid), time_step(0) {
        // Initialize all red streaks to 0
        for (auto& row : red_streak) {
            row.fill(0);
        }
    }

    void InfrastructureAgent::updateLights() {
        congestionAwareStrategy();
    }

    void InfrastructureAgent::step() {
        updateLights();
        ++time_step;
    }

    int InfrastructureAgent::countApproachingVehicles(int row, int col, int direction) const {
        // Count vehicles on the road segment approaching this intersection
        // from the given direction.
        //
        // Direction 0 (North): vehicles coming from north = on vertical road above,
        //   traveling FORWARD (southbound), approaching slot 29
        // Direction 1 (East): vehicles coming from east = on horizontal road to the right,
        //   traveling BACKWARD (westbound), approaching slot 29
        // Direction 2 (South): vehicles coming from south = on vertical road below,
        //   traveling BACKWARD (northbound), approaching slot 29
        // Direction 3 (West): vehicles coming from west = on horizontal road to the left,
        //   traveling FORWARD (eastbound), approaching slot 29

        int count = 0;
        const common::Road* road = nullptr;
        common::Direction dir;

        switch (direction) {
            case 0: // North approach: vertical_roads[row-1][col], FORWARD
                if (row > 0) {
                    road = grid.getRoad(1, row - 1, col);
                    dir = common::Direction::FORWARD;
                }
                break;
            case 1: // East approach: horizontal_roads[row][col], BACKWARD
                if (col < 2) {
                    road = grid.getRoad(0, row, col);
                    dir = common::Direction::BACKWARD;
                }
                break;
            case 2: // South approach: vertical_roads[row][col], BACKWARD
                if (row < 2) {
                    road = grid.getRoad(1, row, col);
                    dir = common::Direction::BACKWARD;
                }
                break;
            case 3: // West approach: horizontal_roads[row][col-1], FORWARD
                if (col > 0) {
                    road = grid.getRoad(0, row, col - 1);
                    dir = common::Direction::FORWARD;
                }
                break;
        }

        if (road) {
            for (int slot = 0; slot < road->slotCount(); ++slot) {
                if (road->isSlotOccupied(slot, dir)) {
                    ++count;
                }
            }
        }

        // Count vehicles waiting at SQUARE_A, which approach (0,0) from West.
        if (row == 0 && col == 0 && direction == 3) {
            for (const auto& kv : grid.getVehicles()) {
                if (kv.second.getPosition() == common::SQUARE_A) {
                    ++count;
                }
            }
            const common::Road* square_road = grid.getRoad(2, 0, 0);
            if (square_road) {
                for (int slot = 0; slot < square_road->slotCount(); ++slot) {
                    if (square_road->isSlotOccupied(slot, common::Direction::BACKWARD)) {
                        ++count;
                    }
                }
            }
        }

        return count;
    }

    int InfrastructureAgent::approachPriorityScore(int row, int col, int direction) const {
        int score = 0;
        const common::Road* road = nullptr;
        common::Direction dir = common::Direction::FORWARD;

        switch (direction) {
            case 0:
                if (row > 0) {
                    road = grid.getRoad(1, row - 1, col);
                    dir = common::Direction::FORWARD;
                }
                break;
            case 1:
                if (col < 2) {
                    road = grid.getRoad(0, row, col);
                    dir = common::Direction::BACKWARD;
                }
                break;
            case 2:
                if (row < 2) {
                    road = grid.getRoad(1, row, col);
                    dir = common::Direction::BACKWARD;
                }
                break;
            case 3:
                if (col > 0) {
                    road = grid.getRoad(0, row, col - 1);
                    dir = common::Direction::FORWARD;
                }
                break;
        }

        if (road) {
            const int last_slot = road->slotCount() - 1;
            for (int slot = 0; slot < road->slotCount(); ++slot) {
                if (!road->isSlotOccupied(slot, dir)) {
                    continue;
                }

                score += 1;
                if (slot >= last_slot - 2) {
                    score += 8;
                } else if (slot >= last_slot - 5) {
                    score += 4;
                } else {
                    score += slot / 8;
                }
            }
        }

        // Count SQUARE_A vehicles approaching (0,0) from West.
        if (row == 0 && col == 0 && direction == 3) {
            for (const auto& kv : grid.getVehicles()) {
                if (kv.second.getPosition() == common::SQUARE_A) {
                    score += 10;
                }
            }
            const common::Road* square_road = grid.getRoad(2, 0, 0);
            if (square_road) {
                for (int slot = 0; slot < square_road->slotCount(); ++slot) {
                    if (square_road->isSlotOccupied(slot, common::Direction::BACKWARD)) {
                        score += 12 + (slot * 2);
                    }
                }
            }
        }

        return score;
    }

    void InfrastructureAgent::congestionAwareStrategy() {
        // Congestion-aware light switching: Longest-Queue-First with Starvation Prevention
        //
        // For each intersection:
        //   1. Count vehicles approaching from each enabled direction
        //   2. If any direction has been red >= MAX_RED_WAIT ticks, force green for it
        //   3. Otherwise, give green to the direction with the most approaching vehicles
        //   4. Ties broken by lowest direction index (deterministic in C++, nondeterministic in SPIN)

        for (int row = 0; row < 3; ++row) {
            for (int col = 0; col < 3; ++col) {
                common::Intersection& intersection = grid.getIntersection(row, col);
                int intersection_id = row * 3 + col;

                // Collect enabled directions
                std::vector<int> enabled_dirs;
                for (int d = 0; d < 4; ++d) {
                    if (intersection.isLightEnabled(d)) {
                        enabled_dirs.push_back(d);
                    }
                }
                if (enabled_dirs.empty()) continue;

                // Step 1: Check starvation — any direction red too long?
                int starved_dir = -1;
                for (int d : enabled_dirs) {
                    if (red_streak[intersection_id][d] >= MAX_RED_WAIT) {
                        starved_dir = d;
                        break;  // Give green to the first starved direction found
                    }
                }

                std::array<int, 4> priority{};
                for (int d : enabled_dirs) {
                    priority[d] = approachPriorityScore(row, col, d);
                }

                int chosen_dir;
                if (starved_dir >= 0) {
                    // Starvation prevention: force green
                    chosen_dir = starved_dir;
                } else {
                    // Step 2: Pressure-aware selection with a small amount of green holding.
                    int best_dir = enabled_dirs[0];
                    int best_count = priority[enabled_dirs[0]];

                    for (size_t i = 1; i < enabled_dirs.size(); ++i) {
                        int d = enabled_dirs[i];
                        int cnt = priority[d];
                        if (cnt > best_count) {
                            best_count = cnt;
                            best_dir = d;
                        }
                    }

                    int current_green = intersection.getGreenLight();
                    if (current_green >= 0 && intersection.isLightEnabled(current_green) &&
                        priority[current_green] > 0 && priority[current_green] + 3 >= best_count) {
                        chosen_dir = current_green;
                    } else {
                        chosen_dir = best_dir;
                    }
                }

                // Set the chosen direction green (setGreenLight sets all others red)
                grid.setLight(row, col, chosen_dir, common::LightState::GREEN);

                // Step 3: Update red streaks
                for (int d : enabled_dirs) {
                    if (d == chosen_dir) {
                        red_streak[intersection_id][d] = 0;
                    } else {
                        red_streak[intersection_id][d]++;
                    }
                }
            }
        }
    }

    void InfrastructureAgent::simpleCycleStrategy() {
        // Original fixed-cycle strategy (kept for reference/comparison)
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
