package com;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class editProfile extends HttpServlet {

    // 🔹 Load profile data
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String email = (String) session.getAttribute("email");

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT name, email FROM HET.register_user WHERE email=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("email", rs.getString("email"));

                RequestDispatcher rd = request.getRequestDispatcher("editProfile.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
        }
    }

    // 🔹 Update profile
   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession(false);

    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");
    String newName = request.getParameter("name");

    try (Connection con = DBConnection.getConnection()) {

        String sql = "UPDATE HET.register_user SET name=? WHERE email=?";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, newName);
        ps.setString(2, email);

        ps.executeUpdate();

if (    null == role) {
    // Default → ADMIN
    response.sendRedirect("adminDashboard.jsp?msg=updated");
} else  // 🔥 Dynamic Redirect Based on Role
        // 🔥 Role Based Redirect
        switch (role) {
            case "LENDER" -> response.sendRedirect("lenderDashboard.jsp?msg=updated");
            case "RECEIVER" -> response.sendRedirect("receiverDashboard.jsp?msg=updated");
            default -> // Default → ADMIN
                response.sendRedirect("adminDashboard.jsp?msg=updated");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
}
}