package com;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class CancelRequestServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || !"RECEIVER".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String requestId = request.getParameter("requestId");

        try (Connection con = DBConnection.getConnection()) {

            // Delete only if status is PENDING
            String sql = "DELETE FROM REQUESTS WHERE REQUEST_ID=? AND STATUS='PENDING'";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, requestId);

            ps.executeUpdate();

            response.sendRedirect("MyRequestsServlet?msg=cancelled");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}