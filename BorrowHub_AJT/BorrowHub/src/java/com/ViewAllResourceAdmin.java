package com;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class ViewAllResourceAdmin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔐 Admin Session Protection
        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Map<String, Object>> resources = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT r.RESOURCE_ID, r.RESOURCE_NAME, r.QUANTITY, " +
                         "r.DESCRIPTION, r.STATUS, r.LENDER_EMAIL, u.NAME " +
                         "FROM HET.RESOURCES r " +
                         "LEFT JOIN HET.REGISTER_USER u " +
                         "ON r.LENDER_EMAIL = u.EMAIL";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Map<String, Object> row = new HashMap<>();

                row.put("resourceId", rs.getInt("RESOURCE_ID"));
                row.put("resourceName", rs.getString("RESOURCE_NAME"));
                row.put("quantity", rs.getInt("QUANTITY"));
                row.put("description", rs.getString("DESCRIPTION"));
                row.put("status", rs.getString("STATUS"));
                row.put("lenderEmail", rs.getString("LENDER_EMAIL"));
                row.put("lenderName", rs.getString("NAME"));

                resources.add(row);
            }

            // Debug print
            System.out.println("Total Resources Found: " + resources.size());

            request.setAttribute("resources", resources);
            request.getRequestDispatcher("viewAllResources.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}