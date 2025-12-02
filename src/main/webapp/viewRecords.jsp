<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.example.auth.ParkingEntry, com.example.auth.ParkingStore" %>

<%
    ParkingStore store = (ParkingStore) application.getAttribute("parkingStore");
    if (store == null) {
        store = new ParkingStore();
        application.setAttribute("parkingStore", store);
    }

    // Handle delete request
    String removeIndex = request.getParameter("remove");
    if (removeIndex != null) {
        try {
            int idx = Integer.parseInt(removeIndex);
            store.remove(idx);
            request.setAttribute("msg", "Record removed successfully!");
        } catch (Exception e) {
            request.setAttribute("msg", "Error removing record!");
        }
    }

    List<ParkingEntry> list = store.getAll();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Parking Records</title>
    <style>
        body { font-family: Arial; background:#eef2f3; padding:30px; }
        .container { width:1000px; margin:auto; background:white; padding:20px; border-radius:10px; box-shadow:0 4px 15px rgba(0,0,0,0.2); }
        table { width:100%; border-collapse:collapse; margin-top:20px; }
        th, td { padding:10px; border:1px solid #aaa; text-align:center; }
        th { background:#007BFF; color:white; }
        .btn { padding:10px 20px; margin-top:12px; background:#007BFF; color:white; border:none; border-radius:5px; cursor:pointer; }
        .delete-btn { background:#dc3545; color:white; border:none; padding:7px 12px; border-radius:5px; cursor:pointer; }
        .no-record { text-align:center; color:#c00; font-weight:bold; padding:20px; }
        .msg { text-align:center; color:green; font-weight:bold; }
    </style>
</head>
<body>

<div class="container">
    <h2 style="text-align:center;">All Parking Records</h2>

    <div class="msg"><%= request.getAttribute("msg") != null ? request.getAttribute("msg") : "" %></div>

    <div style="text-align:center; margin-bottom:10px;">
        <form action="index.jsp" method="get" style="display:inline;">
            <button class="btn">Home</button>
        </form>
        <form action="parking.jsp" method="get" style="display:inline;">
            <button class="btn" style="background:#28a745;">Add New Entry</button>
        </form>
    </div>

    <%
        if (list == null || list.isEmpty()) {
    %>
        <div class="no-record">No parking records found.</div>
    <%
        } else {
    %>
    <table>
        <tr>
            <th>Owner</th>
            <th>Phone</th>
            <th>Vehicle Type</th>
            <th>Vehicle Number</th>
            <th>Date</th>
            <th>Time Slot</th>
            <th>Duration</th>
            <th>Charge</th>
            <th>Action</th>
        </tr>

        <%
            int i = 0;
            for (ParkingEntry p : list) {
        %>
        <tr>
            <td><%= p.getOwnerName() %></td>
            <td><%= p.getOwnerPhone() %></td>
            <td><%= p.getVehicleType() %></td>
            <td><%= p.getVehicleNumber() %></td>
            <td><%= p.getDate() %></td>
            <td><%= p.getTimeSlot() %></td>
            <td><%= p.getDuration() %></td>
            <td><%= p.getCharge() %></td>
            <td>
                <form method="post" action="viewRecords.jsp">
                    <input type="hidden" name="remove" value="<%= i %>">
                    <button class="delete-btn" onclick="return confirm('Delete this record?')">Remove</button>
                </form>
            </td>
        </tr>
        <%
            i++;
            }
        %>
    </table>
    <%
        }
    %>
</div>

</body>
</html>
