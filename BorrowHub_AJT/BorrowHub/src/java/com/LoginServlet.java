package com;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT role FROM HET.register_user WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String role = rs.getString("role");

                HttpSession session = request.getSession();
                session.setAttribute("email", email);
                session.setAttribute("role", role);

                switch (role) {
                    case "ADMIN":
                        response.sendRedirect("adminDashboard.jsp");
                        break;
                    case "LENDER":
                        response.sendRedirect("lenderDashboard.jsp");
                        break;
                    default:
                        response.sendRedirect("receiverDashboard.jsp");
                        break;
                }

            } else {
                response.sendRedirect("login.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}