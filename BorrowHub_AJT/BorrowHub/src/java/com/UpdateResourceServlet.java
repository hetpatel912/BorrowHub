package com;



import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class UpdateResourceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || !"LENDER".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("resource_id"));
        String name = request.getParameter("resource_name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String description = request.getParameter("description");

        try (Connection con = DBConnection.getConnection()) {

            String sql = "UPDATE HET.resources SET resource_name=?,  quantity=?, description=? WHERE resource_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            
            ps.setInt(2, quantity);
            ps.setString(3, description);
            ps.setInt(4, id);

            ps.executeUpdate();

            response.sendRedirect("viewMyResources");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}