package com;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class viewProfile extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String email = (String) session.getAttribute("email");

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT name, email, role FROM HET.register_user WHERE email=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("email", rs.getString("email"));
                request.setAttribute("role", rs.getString("role"));

                RequestDispatcher rd = request.getRequestDispatcher("viewProfile.jsp");
                rd.forward(request, response);

            } else {
                response.sendRedirect("userDashboard.jsp");
            }

        } catch (Exception e) {
        }
    }
}