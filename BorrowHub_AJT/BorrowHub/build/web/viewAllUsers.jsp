<%@ page import="java.util.*" %>

<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("ADMIN")) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<String[]> users = (List<String[]>) request.getAttribute("usersList");
%>

<!DOCTYPE html>
<html>
<head>
    <title>All Users - BorrowHub Admin</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #fff5f5 0%, #ffebee 100%);
            padding: 30px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .header {
            background: white;
            border-radius: 15px;
            padding: 25px 30px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .header h2 {
            color: #c62828;
            font-size: 28px;
            margin-bottom: 5px;
        }
        
        .header p {
            color: #666;
            font-size: 14px;
        }
        
        .back-btn {
            padding: 10px 20px;
            background: linear-gradient(135deg, #c62828 0%, #B71C1C 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(198, 40, 40, 0.3);
        }
        
        .table-container {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th {
            background: #ffebee;
            color: #c62828;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        td {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
            color: #444;
        }
        
        tr:hover {
            background: #f5f5f5;
        }
        
        .role-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
        
        .role-admin {
            background: #ffebee;
            color: #c62828;
        }
        
        .role-lender {
            background: #e8f5e9;
            color: #2e7d32;
        }
        
        .role-receiver {
            background: #e3f2fd;
            color: #1565c0;
        }
        
        .delete-btn {
            padding: 8px 20px;
            background: #ffebee;
            color: #c62828;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        
        .delete-btn:hover {
            background: #c62828;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(198, 40, 40, 0.2);
        }
        
        .disabled-text {
            color: #999;
            font-style: italic;
            font-size: 14px;
        }
        
        .no-data {
            text-align: center;
            padding: 50px;
            color: #999;
            font-size: 16px;
        }
        
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            table {
                font-size: 14px;
            }
            
            td, th {
                padding: 10px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <div>
            <h2>? All Registered Users</h2>
            <p>Manage users across the platform</p>
        </div>
        <a href="adminDashboard.jsp" class="back-btn">? Back to Dashboard</a>
    </div>
    
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (users != null && !users.isEmpty()) {
                        for(String[] user : users) {
                            String userRole = user[2];
                            String roleClass = "";
                            if ("ADMIN".equals(userRole)) {
                                roleClass = "role-admin";
                            } else if ("LENDER".equals(userRole)) {
                                roleClass = "role-lender";
                            } else if ("RECEIVER".equals(userRole)) {
                                roleClass = "role-receiver";
                            }
                %>
                <tr>
                    <td><strong><%= user[0] %></strong></td>
                    <td><%= user[1] %></td>
                    <td>
                        <span class="role-badge <%= roleClass %>"><%= userRole %></span>
                    </td>
                    <td>
                        <% if(!userRole.equals("ADMIN")) { %>
                            <a href="DeleteUserServlet?email=<%= user[1] %>" 
                               class="delete-btn"
                               onclick="return confirm('Are you sure you want to delete this user?');">
                                ?? Delete
                            </a>
                        <% } else { %>
                            <span class="disabled-text">? Cannot Delete Admin</span>
                        <% } %>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="4" class="no-data">No users found in the system.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>