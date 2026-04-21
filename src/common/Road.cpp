#include "common/Road.h"

namespace common {
    Road::Road() : active_slots(30) {
        forward_slots.fill(0);
        backward_slots.fill(0);
    }

    int Road::getSlot(int index, Direction dir) const {
        if (index < 0 || index >= active_slots) return -1;
        return (dir == Direction::FORWARD) ? forward_slots[index] : backward_slots[index];
    }

    bool Road::setSlot(int index, int vehicle_id, Direction dir) {
        if (index < 0 || index >= active_slots) return false;
        auto& slots = (dir == Direction::FORWARD) ? forward_slots : backward_slots;
        if (slots[index] != 0) return false;
        slots[index] = vehicle_id;
        return true;
    }

    bool Road::clearSlot(int index, Direction dir) {
        if (index < 0 || index >= active_slots) return false;
        auto& slots = (dir == Direction::FORWARD) ? forward_slots : backward_slots;
        slots[index] = 0;
        return true;
    }

    int Road::slotCount() const {
        return active_slots;
    }

    void Road::setSlotCount(int count) {
        if (count < 1) {
            active_slots = 1;
        } else if (count > 30) {
            active_slots = 30;
        } else {
            active_slots = count;
        }

        for (int i = active_slots; i < 30; ++i) {
            forward_slots[i] = 0;
            backward_slots[i] = 0;
        }
    }

    bool Road::isSlotOccupied(int index, Direction dir) const {
        if (index < 0 || index >= active_slots) return false;
        const auto& slots = (dir == Direction::FORWARD) ? forward_slots : backward_slots;
        return slots[index] != 0;
    }

    bool Road::hasVehicleAhead(int current_slot, Direction dir) const {
        const auto& slots = (dir == Direction::FORWARD) ? forward_slots : backward_slots;
        for (int i = current_slot + 1; i < active_slots; ++i) {
            if (slots[i] != 0) return true;
        }
        return false;
    }

    int Road::distanceToFirstVehicleAhead(int current_slot, Direction dir) const {
        const auto& slots = (dir == Direction::FORWARD) ? forward_slots : backward_slots;
        for (int i = current_slot + 1; i < active_slots; ++i) {
            if (slots[i] != 0) {
                return i - current_slot;
            }
        }
        return -1; // no vehicle ahead
    }
}
