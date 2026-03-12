<%@ page import="java.util.List" %>
<%
    String role = (String) session.getAttribute("role");

    if (role == null || !role.equals("LENDER")) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<String[]> resources = (List<String[]>) request.getAttribute("resources");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Resources - BorrowHub</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #f1f8e9 0%, #dcedc8 100%);
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
            color: #2e7d32;
            font-size: 28px;
        }
        
        .header p {
            color: #666;
        }
        
        .back-btn {
            padding: 10px 20px;
            background: linear-gradient(135deg, #2e7d32 0%, #1b5e20 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(46, 125, 50, 0.3);
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
            background: #e8f5e9;
            color: #2e7d32;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
        }
        
        td {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
            color: #444;
        }
        
        tr:hover {
            background: #f9f9f9;
        }
        
        .status-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .status-available {
            background: #e8f5e9;
            color: #2e7d32;
        }
        
        .action-links {
            display: flex;
            gap: 10px;
        }
        
        .action-link {
            padding: 6px 12px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .edit-link {
            background: #e8f5e9;
            color: #2e7d32;
        }
        
        .edit-link:hover {
            background: #2e7d32;
            color: white;
        }
        
        .delete-link {
            background: #ffebee;
            color: #c62828;
        }
        
        .delete-link:hover {
            background: #c62828;
            color: white;
        }
        
        .no-data {
            text-align: center;
            padding: 40px;
            color: #999;
            font-size: 16px;
        }
        
        @media (max-width: 768px) {
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
            
            .action-links {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <div>
            <h2>My Resources</h2>
            <p>Manage your listed resources</p>
        </div>
        <a href="lenderDashboard.jsp" class="back-btn">? Back to Dashboard</a>
    </div>
    
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Resource Name</th>
                    <th>Quantity</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                if (resources != null && !resources.isEmpty()) {
                    for (String[] r : resources) {
                        String status = r[4];
                        String statusClass = "status-available";
                        if ("BORROWED".equals(status)) {
                            statusClass = "status-borrowed";
                        }
            %>
                <tr>
                    <td><%= r[0] %></td>
                    <td><strong><%= r[1] %></strong></td>
                    <td><%= r[2] %></td>
                    <td><%= r[3] %></td>
                    <td>
                        <span class="status-badge <%= statusClass %>"><%= status %></span>
                    </td>
                    <td>
                        <div class="action-links">
                            <a href="EditResourceServlet?resource_id=<%= r[0] %>" class="action-link edit-link">?? Edit</a>
                            <a href="DeleteResourceServlet?resource_id=<%= r[0] %>" 
                               class="action-link delete-link" 
                               onclick="return confirm('Are you sure you want to delete this resource?');">?? Delete</a>
                        </div>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="6" class="no-data">No resources added yet. <a href="addResource.jsp" style="color: #2e7d32;">Add your first resource!</a></td>
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