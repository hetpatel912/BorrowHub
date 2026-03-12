package com;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class ApproveRejectServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || !"LENDER".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String requestId = request.getParameter("requestId");
        String action = request.getParameter("action"); // APPROVED or REJECTED

        try (Connection con = DBConnection.getConnection()) {

            String sql = "UPDATE REQUESTS SET STATUS=? WHERE REQUEST_ID=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, action);
            ps.setString(2, requestId);

            ps.executeUpdate();

            response.sendRedirect("ViewResourceRequests");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}