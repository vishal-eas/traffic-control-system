#include "common/Road.h"

namespace common {
    Road::Road() {
        forward_slots.fill(0);
        backward_slots.fill(0);
    }

    int Road::getSlot(int index, Direction dir) const {
        if (index < 0 || index >= 30) return -1;
        return (dir == Direction::FORWARD) ? forward_slots[index] : backward_slots[index];
    }

    bool Road::setSlot(int index, int vehicle_id, Direction dir) {
        if (index < 0 || index >= 30) return false;
        auto& slots = (dir == Direction::FORWARD) ? forward_slots : backward_slots;
        if (slots[index] != 0) return false;
        slots[index] = vehicle_id;
        return true;
    }

    bool Road::clearSlot(int index, Direction dir) {
        if (index < 0 || index >= 30) return false;
        auto& slots = (dir == Direction::FORWARD) ? forward_slots : backward_slots;
        slots[index] = 0;
        return true;
    }

    int Road::slotCount() const {
        return 30;
    }

    bool Road::isSlotOccupied(int index, Direction dir) const {
        if (index < 0 || index >= 30) return false;
        const auto& slots = (dir == Direction::FORWARD) ? forward_slots : backward_slots;
        return slots[index] != 0;
    }

    bool Road::hasVehicleAhead(int current_slot, Direction dir) const {
        const auto& slots = (dir == Direction::FORWARD) ? forward_slots : backward_slots;
        for (int i = current_slot + 1; i < 30; ++i) {
            if (slots[i] != 0) return true;
        }
        return false;
    }
}
