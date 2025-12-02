package com.example.auth;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ParkingStore {
    // thread-safe list wrapper
    private final List<ParkingEntry> entries = Collections.synchronizedList(new ArrayList<>());

    public void add(ParkingEntry entry) {
        entries.add(entry);
    }

    // defensive copy to callers
    public List<ParkingEntry> getAll() {
        return new ArrayList<>(entries);
    }

    // remove by index (used by viewRecords.jsp)
    public void remove(int index) {
        synchronized (entries) {
            if (index >= 0 && index < entries.size()) {
                entries.remove(index);
            } else {
                throw new IndexOutOfBoundsException("Invalid index: " + index);
            }
        }
    }

    // convenience: remove by vehicle number (case-insensitive)
    public boolean removeByVehicleNumber(String vehicleNumber) {
        if (vehicleNumber == null) return false;
        synchronized (entries) {
            for (int i = 0; i < entries.size(); i++) {
                ParkingEntry e = entries.get(i);
                if (vehicleNumber.equalsIgnoreCase(e.getVehicleNumber())) {
                    entries.remove(i);
                    return true;
                }
            }
        }
        return false;
    }

    public ParkingEntry getByVehicleNumber(String vehicleNumber) {
        if (vehicleNumber == null) return null;
        synchronized (entries) {
            for (ParkingEntry e : entries) {
                if (vehicleNumber.equalsIgnoreCase(e.getVehicleNumber())) {
                    return e;
                }
            }
        }
        return null;
    }
}
