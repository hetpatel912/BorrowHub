<%@ page import="java.util.*" %>

<%
    String role = (String) session.getAttribute("role");

    if (role == null || !role.equals("LENDER")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Resource Requests - BorrowHub</title>
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
            margin-bottom: 5px;
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
        
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        
        .approve-form, .reject-form {
            display: inline-block;
        }
        
        .approve-btn, .reject-btn {
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .approve-btn {
            background: #e8f5e9;
            color: #2e7d32;
        }
        
        .approve-btn:hover {
            background: #2e7d32;
            color: white;
        }
        
        .reject-btn {
            background: #ffebee;
            color: #c62828;
        }
        
        .reject-btn:hover {
            background: #c62828;
            color: white;
        }
        
        .no-data {
            text-align: center;
            padding: 40px;
            color: #999;
            font-size: 16px;
        }
        
        hr {
            display: none;
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
            
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <div>
            <h2>Resource Requests</h2>
            <p>Manage requests for your resources</p>
        </div>
        <a href="lenderDashboard.jsp" class="back-btn">? Back to Dashboard</a>
    </div>
    
    <div class="table-container">
        <%
        ArrayList<ArrayList<String>> requests =
            (ArrayList<ArrayList<String>>) request.getAttribute("requests");

        if (requests == null || requests.isEmpty()) {
        %>
            <div class="no-data">No requests found for your resources.</div>
        <%
        } else {
        %>
            <table>
                <thead>
                    <tr>
                        <th>Request ID</th>
                        <th>Resource Name</th>
                        <th>Receiver Email</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                for (ArrayList<String> row : requests) {
                    String status = row.get(3);
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
                        <td><strong>#<%= row.get(0) %></strong></td>
                        <td><%= row.get(1) %></td>
                        <td><%= row.get(2) %></td>
                        <td>
                            <span class="status-badge <%= statusClass %>"><%= status %></span>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <%
                                    if ("PENDING".equals(row.get(3))) {
                                %>
                                    <form action="ApproveRejectServlet" method="post" class="approve-form">
                                        <input type="hidden" name="requestId" value="<%= row.get(0) %>">
                                        <input type="hidden" name="action" value="APPROVED">
                                        <input type="submit" value="? Approve" class="approve-btn">
                                    </form>

                                    <form action="ApproveRejectServlet" method="post" class="reject-form">
                                        <input type="hidden" name="requestId" value="<%= row.get(0) %>">
                                        <input type="hidden" name="action" value="REJECTED">
                                        <input type="submit" value="? Reject" class="reject-btn">
                                    </form>
                                <%
                                    } else {
                                %>
                                    <span style="color: #999;">No action needed</span>
                                <%
                                    }
                                %>
                            </div>
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