package com;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {
                response.getWriter().println("Database Connection Failed!");
                return;
            }

            String sql = "INSERT INTO HET.register_user(name,email,password,role) VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role);

            int i = ps.executeUpdate();

            if (i > 0) {
                response.sendRedirect("register.jsp?msg=success");
            } else {
                response.sendRedirect("register.jsp?msg=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}