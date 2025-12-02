package com.example.auth;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet(value="/parkingInit", loadOnStartup=1)
public class ParkingInitServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    public void init() throws ServletException {
        ParkingStore store = new ParkingStore();
        getServletContext().setAttribute("parkingStore", store);
    }
}
