package com;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ViewAllUsers extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<String[]> users = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT    name, email, role FROM HET.REGISTER_USER";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String[] user = new String[4];
                user[0] = rs.getString("name");
                user[1] = rs.getString("email");
                user[2] = rs.getString("role");
                users.add(user);
            }

            request.setAttribute("usersList", users);
            RequestDispatcher rd = request.getRequestDispatcher("viewAllUsers.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}