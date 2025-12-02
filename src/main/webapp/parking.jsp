<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.auth.ParkingEntry, com.example.auth.ParkingStore, java.util.List" %>
<%
    // ensure ParkingStore in ServletContext
    ParkingStore store = (ParkingStore) application.getAttribute("parkingStore");
    if (store == null) {
        store = new ParkingStore();
        application.setAttribute("parkingStore", store);
    }

    String successMessage = null;
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String ownerName = request.getParameter("ownerName");
        String ownerPhone = request.getParameter("ownerPhone");
        String vehicleType = request.getParameter("vehicleType");
        String vehicleNumber = request.getParameter("vehicleNumber");
        String date = request.getParameter("date");
        String timeSlot = request.getParameter("timeSlot");

        // basic null/empty validation
        if (ownerName != null && ownerPhone != null && vehicleType != null &&
            vehicleNumber != null && date != null && timeSlot != null &&
            !ownerName.trim().isEmpty() && !ownerPhone.trim().isEmpty()) {

            ParkingEntry entry = new ParkingEntry(ownerName.trim(), ownerPhone.trim(), vehicleType.trim(),
                                                  vehicleNumber.trim(), date.trim(), timeSlot.trim());
            store.add(entry);
            successMessage = "Vehicle parked successfully!";
            // optionally clear form fields by redirecting (PRG). For simplicity we stay on page.
        } else {
            successMessage = "Please fill all fields correctly.";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Park Vehicle</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f4f6f8; padding:30px; }
        .card { width:460px; margin:30px auto; background:white; border-radius:8px; padding:20px; box-shadow:0 6px 18px rgba(0,0,0,0.08); }
        input, select { width:100%; padding:10px; margin:8px 0; border-radius:4px; border:1px solid #ccc; box-sizing:border-box; }
        .btn { width:100%; padding:12px; border:none; border-radius:6px; cursor:pointer; color:white; font-weight:600; }
        .btn-submit { background:#007BFF; }
        .btn-view { background:#28a745; margin-top:10px; }
        .btn-home { background:#6c757d; margin-bottom:12px; width:auto; padding:8px 14px; color:white; border-radius:5px; text-decoration:none; display:inline-block; }
        .success { color:green; text-align:center; font-weight:600; margin-bottom:10px; }
        .error { color:red; text-align:center; margin-bottom:10px; }
    </style>
</head>
<body>
<div class="card">
    <div style="text-align:right;">
        <form action="index.jsp" method="get" style="display:inline;">
            <button class="btn-home" type="submit">Home</button>
        </form>
    </div>

    <h2 style="text-align:center; margin-top:0;">Add Parking Entry</h2>

    <div class="<%= (successMessage != null && successMessage.startsWith("Vehicle")) ? "success" : (successMessage!=null ? "error" : "") %>">
        <%= successMessage != null ? successMessage : "" %>
    </div>

    <form method="post" action="parking.jsp" autocomplete="off">
        <input name="ownerName" placeholder="Owner Name" required pattern="[A-Za-z\\s]{2,50}" title="Only letters and spaces">
        <input name="ownerPhone" placeholder="Owner Phone Number" required pattern="\d{10}" title="10 digit phone">

        <select name="vehicleType" required>
            <option value="">Select Vehicle Type</option>
            <option>Car</option>
            <option>Bike</option>
            <option>Truck</option>
            <option>Van</option>
            <option>Bus</option>
            <option>Scooter</option>
            <option>Jeep</option>
            <option>Auto</option>
        </select>

        <input name="vehicleNumber" placeholder="Vehicle Number (e.g. AB-1234)" required pattern="[A-Za-z0-9\\-]{3,10}">
        <input type="date" name="date" required min="<%= java.time.LocalDate.now() %>">

        <select name="timeSlot" required>
            <option value="">Select Time Slot</option>
            <option>08:00-10:00</option>
            <option>10:00-12:00</option>
            <option>12:00-14:00</option>
            <option>14:00-16:00</option>
            <option>16:00-18:00</option>
            <option>18:00-20:00</option>
        </select>

        <button type="submit" class="btn btn-submit">Add Entry</button>
    </form>

    <form method="get" action="viewRecords.jsp">
        <button type="submit" class="btn btn-view">View Records</button>
    </form>
</div>
</body>
</html>
