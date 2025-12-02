package com.example.auth;

/**
 * Simple POJO for parking entries.
 * Provides two constructors to support both usages in your code:
 *  - 6-arg constructor: ownerName, ownerPhone, vehicleType, vehicleNumber, date, timeSlot
 *  - 7-arg constructor: ownerName, ownerPhone, vehicleType, vehicleNumber, date, duration, charge
 */
public class ParkingEntry {
    private String ownerName;
    private String ownerPhone;
    private String vehicleType;
    private String vehicleNumber;
    private String date;

    // use either timeSlot OR duration/charge fields depending on flow
    private String timeSlot;   // for the JSP flow
    private String duration;   // for alternative flow
    private String charge;     // for alternative flow

    // 6-arg constructor (matches parking.jsp usage)
    public ParkingEntry(String ownerName, String ownerPhone, String vehicleType,
                        String vehicleNumber, String date, String timeSlot) {
        this.ownerName = ownerName;
        this.ownerPhone = ownerPhone;
        this.vehicleType = vehicleType;
        this.vehicleNumber = vehicleNumber;
        this.date = date;
        this.timeSlot = timeSlot;
    }

    // 7-arg constructor (matches ParkingServlet previous code that used duration & charge)
    public ParkingEntry(String ownerName, String ownerPhone, String vehicleType,
                        String vehicleNumber, String date, String duration, String charge) {
        this.ownerName = ownerName;
        this.ownerPhone = ownerPhone;
        this.vehicleType = vehicleType;
        this.vehicleNumber = vehicleNumber;
        this.date = date;
        this.duration = duration;
        this.charge = charge;
    }

    // Getters (used by viewRecords.jsp)
    public String getOwnerName() { return ownerName; }
    public String getOwnerPhone() { return ownerPhone; }
    public String getVehicleType() { return vehicleType; }
    public String getVehicleNumber() { return vehicleNumber; }
    public String getDate() { return date; }
    public String getTimeSlot() { return timeSlot; }
    public String getDuration() { return duration; }
    public String getCharge() { return charge; }

    // Optional setters (if later needed)
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }
    public void setOwnerPhone(String ownerPhone) { this.ownerPhone = ownerPhone; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }
    public void setVehicleNumber(String vehicleNumber) { this.vehicleNumber = vehicleNumber; }
    public void setDate(String date) { this.date = date; }
    public void setTimeSlot(String timeSlot) { this.timeSlot = timeSlot; }
    public void setDuration(String duration) { this.duration = duration; }
    public void setCharge(String charge) { this.charge = charge; }
}
