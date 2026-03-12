<%@ page import="java.util.*" %>

<%
    String role = (String) session.getAttribute("role");

    if (role == null || !role.equals("RECEIVER")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Requests - BorrowHub</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
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
            color: #1565c0;
            font-size: 28px;
            margin-bottom: 5px;
        }
        
        .header p {
            color: #666;
            font-size: 14px;
        }
        
        .back-btn {
            padding: 10px 20px;
            background: linear-gradient(135deg, #1565c0 0%, #0d47a1 100%);
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
            box-shadow: 0 5px 15px rgba(21, 101, 192, 0.3);
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
            background: #e3f2fd;
            color: #1565c0;
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
        
        .cancel-btn {
            padding: 8px 20px;
            background: #ffebee;
            color: #c62828;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .cancel-btn:hover {
            background: #c62828;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(198, 40, 40, 0.2);
        }
        
        .no-data {
            text-align: center;
            padding: 50px;
            color: #999;
            font-size: 16px;
        }
        
        .no-data a {
            color: #1565c0;
            text-decoration: none;
            font-weight: 600;
        }
        
        .no-data a:hover {
            text-decoration: underline;
        }
        
        .dash-text {
            color: #999;
            font-size: 14px;
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
            <h2>? My Borrowing Requests</h2>
            <p>Track the status of your requests</p>
        </div>
        <a href="receiverDashboard.jsp" class="back-btn">? Back to Dashboard</a>
    </div>
    
    <div class="table-container">
        <%
        ArrayList<ArrayList<String>> requests =
            (ArrayList<ArrayList<String>>) request.getAttribute("requests");

        if (requests == null || requests.isEmpty()) {
        %>
            <div class="no-data">
                <p>? You haven't made any requests yet.</p>
                <p><a href="ViewAvailableResources">Browse Available Resources</a></p>
            </div>
        <%
        } else {
        %>
            <table>
                <thead>
                    <tr>
                        <th>Request ID</th>
                        <th>Resource Name</th>
                        <th>Quantity</th>
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
                        <td><strong><%= row.get(1) %></strong></td>
                        <td><%= row.get(2) %></td>
                        <td>
                            <span class="status-badge <%= statusClass %>"><%= status %></span>
                        </td>
                        <td>
                            <%
                                if ("PENDING".equals(row.get(3))) {
                            %>
                                <form action="CancelRequestServlet" method="post">
                                    <input type="hidden" name="requestId" value="<%= row.get(0) %>">
                                    <input type="submit" value="Cancel Request" class="cancel-btn">
                                </form>
                            <%
                                } else {
                            %>
                                <span class="dash-text">?</span>
                            <%
                                }
                            %>
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