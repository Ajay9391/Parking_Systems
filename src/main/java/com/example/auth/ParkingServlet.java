package com.example.auth;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/parking")
public class ParkingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        ParkingStore store = (ParkingStore) getServletContext().getAttribute("parkingStore");
        if (store == null) {
            store = new ParkingStore();
            getServletContext().setAttribute("parkingStore", store);
        }

        // This servlet used duration & charge (7-arg). That constructor now exists.
        ParkingEntry entry = new ParkingEntry(
                req.getParameter("ownerName"),
                req.getParameter("ownerPhone"),
                req.getParameter("vehicleType"),
                req.getParameter("vehicleNumber"),
                req.getParameter("date"),
                req.getParameter("duration"),
                req.getParameter("charge")
        );

        store.add(entry);

        req.setAttribute("success", "Parking Entry Added Successfully!");
        req.getRequestDispatcher("index.jsp").forward(req, res);
    }
}
