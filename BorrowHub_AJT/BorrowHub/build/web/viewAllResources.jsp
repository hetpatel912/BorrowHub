<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.util.Map" %>

<%
    // 🔐 Admin Session Protection
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("ADMIN")) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Map<String, Object>> resources =
            (List<Map<String, Object>>) request.getAttribute("resources");
%>

<html>
<head>
    <title>All Resources - BorrowHub Admin</title>
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
            max-width: 1400px;
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
        
        .header-actions {
            display: flex;
            gap: 15px;
            align-items: center;
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
        
        .logout-btn {
            padding: 10px 20px;
            background: #ffebee;
            color: #c62828;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .logout-btn:hover {
            background: #c62828;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(198, 40, 40, 0.2);
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
        
        .status-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
        
        .status-available {
            background: #e8f5e9;
            color: #2e7d32;
        }
        
        .status-borrowed {
            background: #ffebee;
            color: #c62828;
        }
        
        .id-badge {
            display: inline-block;
            padding: 3px 8px;
            background: #f5f5f5;
            border-radius: 4px;
            font-weight: 600;
            color: #c62828;
        }
        
        .quantity-badge {
            display: inline-block;
            padding: 3px 10px;
            background: #e3f2fd;
            color: #1565c0;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 600;
        }
        
        .lender-info {
            font-size: 14px;
        }
        
        .lender-name {
            font-weight: 600;
            color: #c62828;
        }
        
        .lender-email {
            color: #666;
            font-size: 13px;
        }
        
        .no-data {
            text-align: center;
            padding: 50px;
            color: #999;
            font-size: 16px;
        }
        
        @media (max-width: 1024px) {
            .table-container {
                padding: 15px;
            }
            
            table {
                font-size: 14px;
            }
            
            td, th {
                padding: 10px;
            }
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
            
            .header-actions {
                flex-direction: column;
                width: 100%;
            }
            
            .back-btn, .logout-btn {
                width: 100%;
                text-align: center;
                justify-content: center;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <div>
            <h2>📚 All Resources</h2>
            <p>Monitor all resources across the platform</p>
        </div>
        <div class="header-actions">
            <a href="adminDashboard.jsp" class="back-btn">← Back to Dashboard</a>
            <a href="logout" class="logout-btn">🚪 Logout</a>
        </div>
    </div>
    
    <div class="table-container">
        <%
            if (resources == null || resources.isEmpty()) {
        %>
                <div class="no-data">No resources found in the system.</div>
        <%
            } else {
        %>
                <table>
                    <thead>
                        <tr>
                            <th>Resource ID</th>
                            <th>Resource Name</th>
                            <th>Quantity</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Lender</th>
                            <th>Lender Email</th>
                        </tr>
                    </thead>
                    <tbody>
        <%
                for (Map<String, Object> r : resources) {
                    String status = (String) r.get("status");
                    String statusClass = "status-available";
                    if ("BORROWED".equals(status)) {
                        statusClass = "status-borrowed";
                    }
        %>
                        <tr>
                            <td><span class="id-badge">#<%= r.get("resourceId") %></span></td>
                            <td><strong><%= r.get("resourceName") %></strong></td>
                            <td><span class="quantity-badge"><%= r.get("quantity") %> left</span></td>
                            <td><%= r.get("description") %></td>
                            <td>
                                <span class="status-badge <%= statusClass %>"><%= status %></span>
                            </td>
                            <td class="lender-info">
                                <div class="lender-name"><%= r.get("lenderName") %></div>
                            </td>
                            <td class="lender-info">
                                <div class="lender-email"><%= r.get("lenderEmail") %></div>
                            </td>
                        </tr>
        <%
                }
        %>
                    </tbody>
                </table>
        <%
            }
        %>
    </div>
</div>

</body>
</html>