package com;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class ViewMyResourcesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || !"LENDER".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String email = (String) session.getAttribute("email");

        List<String[]> resources = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT resource_id, resource_name, quantity, description, status "
                       + "FROM HET.resources WHERE lender_email=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String[] row = new String[5];
                row[0] = rs.getString("resource_id");
                row[1] = rs.getString("resource_name");
              
                row[2] = rs.getString("quantity");
                row[3] = rs.getString("description");
                row[4] = rs.getString("status");

                resources.add(row);
            }

            request.setAttribute("resources", resources);
            RequestDispatcher rd = request.getRequestDispatcher("viewMyResources.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}