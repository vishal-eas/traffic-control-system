#include "common/Intersection.h"

namespace common {
    Intersection::Intersection() : green_light_index(-1) {
        for (auto& light : traffic_lights) {
            light.setState(LightState::RED);
        }
        light_enabled.fill(true);
    }

    void Intersection::setGreenLight(int light_index) {
        // Only allow setting green if light is enabled and index is valid
        if (light_index < 0 || light_index >= 4 || !light_enabled[light_index]) {
            green_light_index = -1;
            return;
        }

        green_light_index = -1;
        for (int i = 0; i < 4; ++i) {
            if (light_enabled[i]) {
                traffic_lights[i].setState(LightState::RED);
            }
        }

        traffic_lights[light_index].setState(LightState::GREEN);
        green_light_index = light_index;
    }

    int Intersection::getGreenLight() const {
        return green_light_index;
    }

    bool Intersection::isGreen(int light_index) const {
        return green_light_index == light_index && light_enabled[light_index];
    }

    bool Intersection::isLightEnabled(int light_index) const {
        if (light_index < 0 || light_index >= 4) return false;
        return light_enabled[light_index];
    }

    void Intersection::enableLight(int light_index) {
        if (light_index >= 0 && light_index < 4) {
            light_enabled[light_index] = true;
            traffic_lights[light_index].setState(LightState::RED); // Start red
        }
    }

    void Intersection::disableLight(int light_index) {
        if (light_index >= 0 && light_index < 4) {
            light_enabled[light_index] = false;
            traffic_lights[light_index].setState(LightState::RED);
            if (green_light_index == light_index) {
                green_light_index = -1;
            }
        }
    }

    const std::array<common::TrafficLight,4>& Intersection::getTrafficLights() const {
        return traffic_lights;
    }
}
