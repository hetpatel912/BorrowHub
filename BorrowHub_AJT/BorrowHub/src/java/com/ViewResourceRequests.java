package com;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class ViewResourceRequests extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || !"LENDER".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String lenderEmail = (String) session.getAttribute("email");

        ArrayList<ArrayList<String>> requestList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT r.REQUEST_ID, res.RESOURCE_NAME, r.RECEIVER_EMAIL, r.STATUS " +
                         "FROM REQUESTS r " +
                         "JOIN RESOURCES res ON r.RESOURCE_ID = res.RESOURCE_ID " +
                         "WHERE res.LENDER_EMAIL = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, lenderEmail);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                ArrayList<String> row = new ArrayList<>();
                row.add(rs.getString("REQUEST_ID"));
                row.add(rs.getString("RESOURCE_NAME"));
                row.add(rs.getString("RECEIVER_EMAIL"));
                row.add(rs.getString("STATUS"));

                requestList.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("requests", requestList);
        RequestDispatcher rd = request.getRequestDispatcher("lenderRequests.jsp");
        rd.forward(request, response);
    }
}