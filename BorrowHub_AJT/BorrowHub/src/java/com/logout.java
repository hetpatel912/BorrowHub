package com;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class logout extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // Get current session

        if (session != null) {
            session.invalidate(); // Destroy session
        }

        // Redirect to login page
        response.sendRedirect("login.jsp");
    }
}