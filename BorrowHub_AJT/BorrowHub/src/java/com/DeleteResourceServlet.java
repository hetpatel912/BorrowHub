package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class DeleteResourceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || !"LENDER".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        int resourceId = Integer.parseInt(request.getParameter("resource_id"));
        String lenderEmail = (String) session.getAttribute("email");

       try (Connection con = DBConnection.getConnection()) {

                // 1️⃣ Delete related requests first
                String deleteRequests = "DELETE FROM HET.requests WHERE resource_id=?";
                PreparedStatement ps1 = con.prepareStatement(deleteRequests);
                ps1.setInt(1, resourceId);
                ps1.executeUpdate();

                // 2️⃣ Then delete resource
                String deleteResource = 
                    "DELETE FROM HET.resources WHERE resource_id=? AND lender_email=?";
                PreparedStatement ps2 = con.prepareStatement(deleteResource);
                ps2.setInt(1, resourceId);
                ps2.setString(2, lenderEmail);
                ps2.executeUpdate();

                response.sendRedirect("viewMyResources");
            }
        catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error deleting resource: " + e.getMessage());
        }
    }
}