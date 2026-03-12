package com;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class ViewAllRequestsAdmin extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 🔐 Check Admin Role
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<String[]> requestList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT * FROM HET.REQUESTS";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                String[] row = new String[4];
                row[0] = rs.getString("REQUEST_ID");
                row[1] = rs.getString("RESOURCE_ID");
                row[2] = rs.getString("RECEIVER_EMAIL");
                row[3] = rs.getString("STATUS");

                requestList.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("requestList", requestList);
        RequestDispatcher rd = request.getRequestDispatcher("viewAllRequestsAdmin.jsp");
        rd.forward(request, response);
    }
}