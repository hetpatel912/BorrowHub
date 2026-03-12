<%
    String role = (String) session.getAttribute("role");

    if (role == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile - BorrowHub</title>
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
        
        .edit-container {
            width: 100%;
            max-width: 450px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .edit-header {
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
        
        .edit-header h2 {
            font-size: 28px;
            margin-bottom: 5px;
        }
        
        .edit-header p {
            opacity: 0.9;
            font-size: 14px;
        }
        
        .edit-body {
            padding: 30px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        label {
            display: block;
            color: #666;
            font-size: 14px;
            margin-bottom: 8px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        
        .input-field {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        .input-field:focus {
            outline: none;
            <% if ("ADMIN".equals(role)) { %>
                border-color: #c62828;
                box-shadow: 0 0 0 3px rgba(198, 40, 40, 0.1);
            <% } else if ("LENDER".equals(role)) { %>
                border-color: #2e7d32;
                box-shadow: 0 0 0 3px rgba(46, 125, 50, 0.1);
            <% } else { %>
                border-color: #1565c0;
                box-shadow: 0 0 0 3px rgba(21, 101, 192, 0.1);
            <% } %>
        }
        
        .readonly-field {
            width: 100%;
            padding: 12px 15px;
            background: #f5f5f5;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 16px;
            color: #666;
        }
        
        .button-container {
            margin-top: 30px;
            display: flex;
            gap: 15px;
        }
        
        .update-btn {
            flex: 1;
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            <% if ("ADMIN".equals(role)) { %>
                background: linear-gradient(135deg, #c62828 0%, #B71C1C 100%);
            <% } else if ("LENDER".equals(role)) { %>
                background: linear-gradient(135deg, #2e7d32 0%, #1b5e20 100%);
            <% } else { %>
                background: linear-gradient(135deg, #1565c0 0%, #0d47a1 100%);
            <% } %>
            color: white;
        }
        
        .update-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .back-btn {
            flex: 1;
            padding: 14px;
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
        
        .back-btn:hover {
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
        
        .info-note {
            text-align: center;
            margin-top: 20px;
            color: #999;
            font-size: 13px;
        }
        
        @media (max-width: 480px) {
            .edit-container {
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
        request.getAttribute("name").toString() : "";
    String displayEmail = request.getAttribute("email") != null ? 
        request.getAttribute("email").toString() : "";
    
    String dashboardPage = "login.jsp";
    if ("ADMIN".equals(role)) {
        dashboardPage = "adminDashboard.jsp";
    } else if ("LENDER".equals(role)) {
        dashboardPage = "lenderDashboard.jsp";
    } else if ("RECEIVER".equals(role)) {
        dashboardPage = "receiverDashboard.jsp";
    }
%>

<div class="edit-container">
    <div class="edit-header">
        <h2>Edit Profile</h2>
        <p>Update your personal information</p>
    </div>
    
    <div class="edit-body">
        <form action="editProfile" method="post">
            <div class="form-group">
                <label>FULL NAME</label>
                <input type="text" name="name" value="<%= displayName %>" required class="input-field" placeholder="Enter your full name">
            </div>
            
            <div class="form-group">
                <label>EMAIL ADDRESS</label>
                <input type="text" value="<%= displayEmail %>" readonly class="readonly-field">
                <small style="color: #999; display: block; margin-top: 5px;">Email cannot be changed</small>
            </div>
            
            <div class="button-container">
                <input type="submit" value="Update Profile" class="update-btn">
                <a href="<%= dashboardPage %>" class="back-btn">Cancel</a>
            </div>
        </form>
        
        <div class="info-note">
            Your role: <strong><%= role %></strong>
        </div>
    </div>
</div>

</body>
</html>