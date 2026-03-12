<%
    String role = (String) session.getAttribute("role");
    String email = (String) session.getAttribute("email");

    if (role == null || !role.equals("ADMIN")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - BorrowHub</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body { 
            font-family: 'Arial', sans-serif; 
            background: linear-gradient(135deg, #fff5f5 0%, #ffebee 100%);
            min-height: 100vh;
        }
        
        /* Sidebar */
        .sidebar {
            width: 250px;
            background: linear-gradient(135deg, #c62828 0%, #B71C1C 100%);
            color: white;
            position: fixed;
            height: 100vh;
            padding: 20px 0;
            box-shadow: 5px 0 15px rgba(0,0,0,0.1);
            z-index: 100;
        }
        
        .logo {
            text-align: center;
            padding: 20px;
            font-size: 24px;
            font-weight: bold;
            color: white;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 30px;
        }
        
        .logo span {
            color: #FFCDD2;
        }
        
        .sidebar-nav {
            list-style: none;
        }
        
        .sidebar-nav li {
            padding: 15px 25px;
            margin: 5px 10px;
            border-radius: 10px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .sidebar-nav li:hover {
            background: rgba(255,255,255,0.1);
            transform: translateX(5px);
        }
        
        .sidebar-nav li.active {
            background: rgba(255,255,255,0.15);
            border-left: 4px solid #FFCDD2;
        }
        
        .sidebar-nav a {
            color: white;
            text-decoration: none;
            display: block;
            width: 100%;
            height: 100%;
        }
        
        /* Main Content */
        .main-content {
            margin-left: 250px;
            padding: 30px;
        }
        
        .header {
            background: white;
            padding: 20px 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .welcome-text h1 {
            color: #c62828;
            font-size: 28px;
            margin-bottom: 5px;
        }
        
        .welcome-text p {
            color: #666;
            font-size: 14px;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .user-avatar {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #f44336, #c62828);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: white;
            font-weight: bold;
        }
        
        /* Dashboard Grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }
        
        .card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border: 1px solid rgba(0,0,0,0.05);
        }
        
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.12);
        }
        
        .card-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #FFEBEE, #FFCDD2);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: #c62828;
            margin-bottom: 20px;
        }
        
        .card h3 {
            color: #c62828;
            margin-bottom: 15px;
            font-size: 20px;
        }
        
        .card p {
            color: #666;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        
        .card-btn {
            background: linear-gradient(135deg, #f44336 0%, #c62828 100%);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }
        
        .card-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(244, 67, 54, 0.3);
        }
        
        /* Logout button */
        .logout-container {
            margin-top: 40px;
            text-align: right;
        }
        
        .logout-btn {
            background: linear-gradient(135deg, #f44336 0%, #c62828 100%);
            color: white;
            padding: 12px 30px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            display: inline-block;
            transition: all 0.3s ease;
        }
        
        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(244, 67, 54, 0.3);
        }
        
        /* Responsive */
        @media (max-width: 1024px) {
            .sidebar {
                width: 200px;
            }
            
            .main-content {
                margin-left: 200px;
            }
        }
        
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }
        .menu-item {
    display: flex;
    align-items: center;
    gap: 15px;                /* space between icon & text */
    padding: 15px 20px;
    text-decoration: none;
    color: white;
    border-radius: 12px;
}

/* Active background */
li.active .menu-item {
    background: rgba(255, 255, 255, 0.15);
}

/* Icon */
.menu-icon {
    width: 40px;
    height: 40px;
}

/* Text */
.menu-item span {
    font-size: 18px;
    font-weight: 500;
}
    </style>
</head>
<body>

<div class="sidebar">
    <div class="logo">Borrow<span>Hub</span></div>
    <ul class="sidebar-nav">
<li class="active">
    <a href="adminDashboard.jsp" class="menu-item">
        <img src="image/dashboard.png" class="menu-icon">
        <span>Dashboard</span>
    </a>
</li>     </ul>
</div>

<div class="main-content">
    <div class="header">
        <div class="welcome-text">
            <h1>Welcome back, Administrator! </h1>
            <p>Monitor and manage the entire BorrowHub system</p>
        </div>
        <div class="user-info">
            <div class="user-avatar"><%= email.charAt(0) %></div>
            <div>
                <h3><%= email %></h3>
                <p>Administrator</p>
            </div>
        </div>
    </div>
    
    <div class="dashboard-grid">
        <!-- Profile Options -->
        <div class="card">
            <div class="card-icon"><img src="image/user.png" alt="User Icon" width="50px"></div>
            <h3>View Profile</h3>
            <p>Check your personal information and account details.</p>
            <a href="viewProfile"><button class="card-btn">View Profile </button></a>
        </div>
        
        <div class="card">
            <div class="card-icon"><img src="image/people.png" alt="User Icon" width="40px"></div>
            <h3>Edit Profile</h3>
            <p>Update your information and manage account settings.</p>
            <a href="editProfile"><button class="card-btn">Edit Profile </button></a>
        </div>
        
        <!-- Management Options -->
        <div class="card">
            <div class="card-icon"><img src="image/view.png" alt="User Icon" width="40px"></div>
            <h3>View All Users</h3>
            <p>View and manage all users in the system.</p>
            <a href="ViewAllUsers"><button class="card-btn">View Users </button></a>
        </div>
        
        <div class="card">
            <div class="card-icon"><img src="image/list-view.png" alt="User Icon" width="40px"></div>
            <h3>View All Resources</h3>
            <p>Monitor all resources listed in the system.</p>
            <a href="ViewAllResourceAdmin"><button class="card-btn">View Resources </button></a>
        </div>
        
        <div class="card">
            <div class="card-icon"><img src="image/interview.png" alt="User Icon" width="40px"></div>
            <h3>View All Requests</h3>
            <p>Track all borrowing requests in the system.</p>
            <a href="ViewAllRequestsAdmin"><button class="card-btn">View Requests </button></a>
        </div>
    </div>
    
    <div class="logout-container">
        <a href="logout" class="logout-btn"><img src="image/logout.png" alt="User Icon" width="40px"></a>
    </div>
</div>

</body>
</html>