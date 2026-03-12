package com;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class DeleteUserServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

String email = request.getParameter("email");
String loggedInEmail = (String) session.getAttribute("email");

if (email.equals(loggedInEmail)) {
    response.getWriter().println("You cannot delete your own admin account!");
    return;
}
try (Connection con = DBConnection.getConnection()) {

    // 1️⃣ Delete requests related to resources of this lender
    PreparedStatement ps0 = con.prepareStatement(
        "DELETE FROM HET.REQUESTS WHERE resource_id IN " +
        "(SELECT resource_id FROM HET.RESOURCES WHERE lender_email=?)");
    ps0.setString(1, email);
    ps0.executeUpdate();

    // 2️⃣ Delete requests where user is borrower
    PreparedStatement ps1 = con.prepareStatement(
        "DELETE FROM HET.REQUESTS WHERE receiver_email=?");
    ps1.setString(1, email);
    ps1.executeUpdate();

    // 3️⃣ Delete resources
    PreparedStatement ps2 = con.prepareStatement(
        "DELETE FROM HET.RESOURCES WHERE lender_email=?");
    ps2.setString(1, email);
    ps2.executeUpdate();

    // 4️⃣ Delete user
    PreparedStatement ps3 = con.prepareStatement(
        "DELETE FROM HET.REGISTER_USER WHERE email=?");
    ps3.setString(1, email);
    ps3.executeUpdate();

    response.sendRedirect("ViewAllUsers");

} catch (Exception e) {
    response.setContentType("text/html");
    e.printStackTrace(response.getWriter());
}
    }
}