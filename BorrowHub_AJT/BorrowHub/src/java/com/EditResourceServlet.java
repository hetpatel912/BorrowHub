package com;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class EditResourceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || !"LENDER".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        int resourceId = Integer.parseInt(request.getParameter("resource_id"));

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT * FROM HET.resources WHERE resource_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, resourceId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("id", rs.getInt("resource_id"));
                request.setAttribute("name", rs.getString("resource_name"));
              
                request.setAttribute("quantity", rs.getInt("quantity"));
                request.setAttribute("description", rs.getString("description"));

                RequestDispatcher rd = request.getRequestDispatcher("EditResource.jsp");
                rd.forward(request, response);
            } else {
                response.sendRedirect("viewMyResources");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}