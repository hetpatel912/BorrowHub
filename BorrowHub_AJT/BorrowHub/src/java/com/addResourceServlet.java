package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class addResourceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || !"LENDER".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String lenderEmail = (String) session.getAttribute("email");
        String resourceName = request.getParameter("resource_name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String description = request.getParameter("description");

        try (Connection con = DBConnection.getConnection()) {

            String sql = "INSERT INTO HET.resources "
                    + "(resource_name, quantity, description, lender_email) "
                    + "VALUES (?, ?,  ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, resourceName);
         
            ps.setInt(2, quantity);
            ps.setString(3, description);
            ps.setString(4, lenderEmail);

            ps.executeUpdate();

            response.sendRedirect("lenderDashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}