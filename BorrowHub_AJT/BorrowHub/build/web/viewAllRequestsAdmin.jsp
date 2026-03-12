<%@ page import="java.util.*" %>

<%
    String role = (String) session.getAttribute("role");

    if (role == null || !role.equals("ADMIN")) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<String[]> requestList = (List<String[]>) request.getAttribute("requestList");
%>

<!DOCTYPE html>
<html>
<head>
    <title>All Requests - BorrowHub Admin</title>
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
        
        .status-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
        
        .status-pending {
            background: #fff3e0;
            color: #f57c00;
        }
        
        .status-approved {
            background: #e8f5e9;
            color: #2e7d32;
        }
        
        .status-rejected {
            background: #ffebee;
            color: #c62828;
        }
        
        .no-data {
            text-align: center;
            padding: 50px;
            color: #999;
            font-size: 16px;
        }
        
        .id-badge {
            display: inline-block;
            padding: 3px 8px;
            background: #f5f5f5;
            border-radius: 4px;
            font-weight: 600;
            color: #c62828;
        }
        
        hr {
            display: none;
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
            <h2>? All Borrowing Requests</h2>
            <p>Monitor all requests across the platform</p>
        </div>
        <a href="adminDashboard.jsp" class="back-btn">? Back to Dashboard</a>
    </div>
    
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Request ID</th>
                    <th>Resource ID</th>
                    <th>Receiver Email</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (requestList != null && !requestList.isEmpty()) {
                        for (String[] row : requestList) {
                            String status = row[3];
                            String statusClass = "";
                            if ("PENDING".equals(status)) {
                                statusClass = "status-pending";
                            } else if ("APPROVED".equals(status)) {
                                statusClass = "status-approved";
                            } else if ("REJECTED".equals(status)) {
                                statusClass = "status-rejected";
                            }
                %>
                    <tr>
                        <td><span class="id-badge">#<%= row[0] %></span></td>
                        <td><span class="id-badge">#<%= row[1] %></span></td>
                        <td><strong><%= row[2] %></strong></td>
                        <td>
                            <span class="status-badge <%= statusClass %>"><%= status %></span>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="4" class="no-data">No requests found in the system.</td>
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