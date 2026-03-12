package com;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class RequestResourceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String email = (String) session.getAttribute("email");
        String resourceId = request.getParameter("resourceId");

        try (Connection con = DBConnection.getConnection()) {

            String sql = "INSERT INTO REQUESTS (RESOURCE_ID, RECEIVER_EMAIL, STATUS) " +
                         "VALUES (?, ?, 'PENDING')";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, resourceId);
            ps.setString(2, email);

            ps.executeUpdate();

            response.sendRedirect("ViewAvailableResources?msg=requested");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}