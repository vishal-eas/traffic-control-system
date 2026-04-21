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
        int road_type;
        int road_row;
        int road_col;
        int slot;
        int direction;
        bool at_intersection;
    };

    // Message from infrastructure to vehicle
    struct TrafficLightState {
        Point intersection_id;
        std::vector<LightState> light_states;
        int stopped_vehicle_count;
    };

}

#endif // PROTOCOL_H
