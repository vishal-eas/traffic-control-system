#ifndef TRAFFICLIGHT_H
#define TRAFFICLIGHT_H

namespace common {
    enum class LightState {
        RED,
        GREEN
    };

    class TrafficLight {
    public:
        TrafficLight();
        LightState getState() const;
        void setState(LightState new_state);

    private:
        LightState state;
    };
}

#endif // TRAFFICLIGHT_H
