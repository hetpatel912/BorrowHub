package com;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class ViewAvailableResources extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || !"RECEIVER".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        ArrayList<ArrayList<String>> resourceList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT RESOURCE_ID, RESOURCE_NAME, QUANTITY, DESCRIPTION " +
                         "FROM RESOURCES WHERE STATUS='AVAILABLE'";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ArrayList<String> row = new ArrayList<>();

                row.add(rs.getString("RESOURCE_ID"));
                row.add(rs.getString("RESOURCE_NAME"));
                row.add(rs.getString("QUANTITY"));
                row.add(rs.getString("DESCRIPTION"));

                resourceList.add(row);
            }

            request.setAttribute("resources", resourceList);
            RequestDispatcher rd = request.getRequestDispatcher("viewAvailableResources.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}