#ifndef INTERSECTION_H
#define INTERSECTION_H

#include <array>
#include "common/TrafficLight.h"

namespace common {
    class Intersection {
    public:
        Intersection();

        void setGreenLight(int light_index);
        int getGreenLight() const;
        bool isGreen(int light_index) const;
        bool isLightEnabled(int light_index) const;
        void enableLight(int light_index);
        void disableLight(int light_index);
        const std::array<common::TrafficLight,4>& getTrafficLights() const;

        // Intersection crossing constraint: at most 1 car per time step
        bool isOccupiedThisStep() const;
        void setOccupiedThisStep(bool occupied);
        void resetStepOccupancy();

    private:
        // Every intersection has 4 traffic light slots (0-3)
        // Some may be disabled if not needed
        std::array<common::TrafficLight,4> traffic_lights;
        std::array<bool,4> light_enabled;
        int green_light_index;
        bool occupied_this_step;
    };
}

#endif // INTERSECTION_H
