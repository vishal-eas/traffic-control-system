#include "common/TrafficLight.h"

namespace common {
    TrafficLight::TrafficLight() : state(LightState::RED) {}

    LightState TrafficLight::getState() const {
        return state;
    }

    void TrafficLight::setState(LightState new_state) {
        state = new_state;
    }
}
