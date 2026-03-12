<%
    String role = (String) session.getAttribute("role");

    if (role == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>
<head>
    <title>My Profile - BorrowHub</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        
        body {
            min-height: 100vh;
            <% if ("ADMIN".equals(role)) { %>
                background: linear-gradient(135deg, #fff5f5 0%, #ffebee 100%);
            <% } else if ("LENDER".equals(role)) { %>
                background: linear-gradient(135deg, #f1f8e9 0%, #dcedc8 100%);
            <% } else { %>
                background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            <% } %>
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .profile-container {
            width: 100%;
            max-width: 450px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .profile-header {
            <% if ("ADMIN".equals(role)) { %>
                background: linear-gradient(135deg, #c62828 0%, #B71C1C 100%);
            <% } else if ("LENDER".equals(role)) { %>
                background: linear-gradient(135deg, #2e7d32 0%, #1b5e20 100%);
            <% } else { %>
                background: linear-gradient(135deg, #1565c0 0%, #0d47a1 100%);
            <% } %>
            padding: 30px;
            text-align: center;
            color: white;
        }
        
        .profile-avatar {
            width: 100px;
            height: 100px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            font-weight: bold;
            margin: 0 auto 15px;
            border: 4px solid rgba(255,255,255,0.3);
        }
        
        .profile-header h2 {
            font-size: 28px;
            margin-bottom: 5px;
        }
        
        .role-badge {
            display: inline-block;
            padding: 5px 15px;
            background: rgba(255,255,255,0.2);
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            letter-spacing: 1px;
        }
        
        .profile-body {
            padding: 30px;
        }
        
        .info-group {
            margin-bottom: 20px;
        }
        
        .info-label {
            color: #666;
            font-size: 14px;
            margin-bottom: 5px;
            letter-spacing: 0.5px;
        }
        
        .info-value {
            <% if ("ADMIN".equals(role)) { %>
                color: #c62828;
            <% } else if ("LENDER".equals(role)) { %>
                color: #2e7d32;
            <% } else { %>
                color: #1565c0;
            <% } %>
            font-size: 20px;
            font-weight: 600;
            padding: 10px 15px;
            background: #f5f5f5;
            border-radius: 10px;
            border-left: 4px solid;
            <% if ("ADMIN".equals(role)) { %>
                border-left-color: #c62828;
            <% } else if ("LENDER".equals(role)) { %>
                border-left-color: #2e7d32;
            <% } else { %>
                border-left-color: #1565c0;
            <% } %>
        }
        
        .button-container {
            margin-top: 30px;
            display: flex;
            gap: 15px;
        }
        
        .back-btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            text-decoration: none;
            <% if ("ADMIN".equals(role)) { %>
                background: #c62828;
            <% } else if ("LENDER".equals(role)) { %>
                background: #2e7d32;
            <% } else { %>
                background: #1565c0;
            <% } %>
            color: white;
            display: inline-block;
        }
        
        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            <% if ("ADMIN".equals(role)) { %>
                background: #B71C1C;
            <% } else if ("LENDER".equals(role)) { %>
                background: #1b5e20;
            <% } else { %>
                background: #0d47a1;
            <% } %>
        }
        
        .edit-btn {
            flex: 1;
            padding: 12px;
            border: 2px solid;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            text-decoration: none;
            <% if ("ADMIN".equals(role)) { %>
                border-color: #c62828;
                color: #c62828;
            <% } else if ("LENDER".equals(role)) { %>
                border-color: #2e7d32;
                color: #2e7d32;
            <% } else { %>
                border-color: #1565c0;
                color: #1565c0;
            <% } %>
            background: white;
        }
        
        .edit-btn:hover {
            <% if ("ADMIN".equals(role)) { %>
                background: #c62828;
            <% } else if ("LENDER".equals(role)) { %>
                background: #2e7d32;
            <% } else { %>
                background: #1565c0;
            <% } %>
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        @media (max-width: 480px) {
            .profile-container {
                max-width: 100%;
            }
            
            .button-container {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<%
    String displayName = request.getAttribute("name") != null ? 
        request.getAttribute("name").toString() : "User";
    String displayEmail = request.getAttribute("email") != null ? 
        request.getAttribute("email").toString() : "email@example.com";
    
    String dashboardPage = "login.jsp";
    if ("ADMIN".equals(role)) {
        dashboardPage = "adminDashboard.jsp";
    } else if ("LENDER".equals(role)) {
        dashboardPage = "lenderDashboard.jsp";
    } else if ("RECEIVER".equals(role)) {
        dashboardPage = "receiverDashboard.jsp";
    }
%>

<div class="profile-container">
    <div class="profile-header">
        <div class="profile-avatar">
            <%= displayName.charAt(0) %>
        </div>
        <h2>My Profile</h2>
        <span class="role-badge"><%= role %></span>
    </div>
    
    <div class="profile-body">
        <div class="info-group">
            <div class="info-label">FULL NAME</div>
            <div class="info-value"><%= displayName %></div>
        </div>
        
        <div class="info-group">
            <div class="info-label">EMAIL ADDRESS</div>
            <div class="info-value"><%= displayEmail %></div>
        </div>
        
        <div class="button-container">
            <a href="editProfile" class="edit-btn">Edit Profile</a>
            <a href="<%= dashboardPage %>" class="back-btn">Back to Dashboard</a>
        </div>
    </div>
</div>

</body>
</html>