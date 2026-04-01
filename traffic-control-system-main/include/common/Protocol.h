#ifndef PROTOCOL_H
#define PROTOCOL_H

#include "common/Point.h"
#include "common/TrafficLight.h"
#include <vector>

namespace common {

    // Message from vehicle to infrastructure
    struct VehicleState {
        int vehicle_id;
        Point position;
        int speed;
    };

    // Message from infrastructure to vehicle
    struct TrafficLightState {
        Point intersection_id;
        std::vector<LightState> light_states;
    };

}

#endif // PROTOCOL_H
