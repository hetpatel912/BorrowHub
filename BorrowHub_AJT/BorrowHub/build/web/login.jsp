<!-- login.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>BorrowHub - Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        
        body {
            min-height: 100vh;
            position: relative;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }
        
        /* Single BorrowHub text in background */
        body::before {
            content: "BORROWHUB";
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) rotate(-10deg);
            font-size: 25vw;
            font-weight: 900;
            color: rgba(255, 255, 255, 0.12);
            white-space: nowrap;
            z-index: 0;
            pointer-events: none;
            letter-spacing: 15px;
            text-transform: uppercase;
            font-family: 'Arial Black', sans-serif;
            text-shadow: 0 0 30px rgba(255,255,255,0.1);
        }
        
        .main-container {
            width: 100%;
            max-width: 450px;
            padding: 30px;
            z-index: 1;
            position: relative;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(8px);
            border-radius: 20px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            border: 1px solid rgba(255, 255, 255, 0.18);
        }
        
        h2 {
            color: white;
            font-size: 36px;
            margin-bottom: 30px;
            text-align: center;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            letter-spacing: 2px;
        }
        
        h2 span {
            color: #ffeb3b;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            color: white;
            font-size: 16px;
            font-weight: 500;
            display: block;
            margin-bottom: 8px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
        }
        
        input[type="email"],
        input[type="password"],
        input[type="text"],
        select {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            font-size: 16px;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        input[type="email"]:focus,
        input[type="password"]:focus,
        input[type="text"]:focus,
        select:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.3);
            border-color: rgba(255, 255, 255, 0.8);
            box-shadow: 0 0 15px rgba(255,255,255,0.3);
        }
        
        input[type="email"]::placeholder,
        input[type="password"]::placeholder,
        input[type="text"]::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }
        
        select {
            cursor: pointer;
            color: white;
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 20px;
        }
        
        select option {
            background: #764ba2;
            color: white;
        }
        
        input[type="submit"] {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg, #2196F3, #0D47A1);
            color: white;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            margin-top: 10px;
        }
        
        input[type="submit"]:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.3);
            background: linear-gradient(135deg, #1E88E5, #0D47A1);
        }
        
        input[type="submit"]:active {
            transform: translateY(-1px);
        }
        
        .secondary-button {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg, #4CAF50, #2E7D32);
            color: white;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            margin-top: 15px;
        }
        
        .secondary-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.3);
            background: linear-gradient(135deg, #43A047, #1B5E20);
        }
        
        .secondary-button:active {
            transform: translateY(-1px);
        }
        
        .message {
            text-align: center;
            padding: 12px;
            border-radius: 8px;
            margin-top: 20px;
            font-weight: 500;
        }
        
        .error-message {
            background: rgba(244, 67, 54, 0.2);
            border: 1px solid rgba(244, 67, 54, 0.5);
            color: #ff8a80;
        }
        
        .success-message {
            background: rgba(76, 175, 80, 0.2);
            border: 1px solid rgba(76, 175, 80, 0.5);
            color: #a5d6a7;
        }
        
        .link-container {
            text-align: center;
            margin-top: 20px;
        }
        
        .link-container a {
            color: white;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s ease;
            opacity: 0.8;
        }
        
        .link-container a:hover {
            opacity: 1;
            text-decoration: underline;
        }
        
        hr {
            border: none;
            height: 1px;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            margin: 25px 0;
        }
        
        /* Responsive design */
        @media (max-width: 768px) {
            .main-container {
                max-width: 90%;
                padding: 25px;
            }
            
            h2 {
                font-size: 30px;
            }
            
            body::before {
                font-size: 30vw;
                letter-spacing: 10px;
            }
        }
        
        @media (max-width: 480px) {
            h2 {
                font-size: 26px;
            }
            
            input[type="submit"],
            .secondary-button {
                font-size: 16px;
                padding: 12px;
            }
            
            body::before {
                font-size: 35vw;
                letter-spacing: 5px;
            }
        }
        
        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 10px;
        }
        
        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
        }
        
        ::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.3);
            border-radius: 5px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: rgba(255, 255, 255, 0.5);
        }
    </style>
</head>
<body>

<div class="main-container">
    <h2><span>BorrowHub</span> Login</h2>
    
    <form action="LoginServlet" method="post">
        <div class="form-group">
            <label>Email:</label>
            <input type="email" name="email" placeholder="Enter your email" required>
        </div>
        
        <div class="form-group">
            <label>Password:</label>
            <input type="password" name="password" placeholder="Enter your password" required>
        </div>
        
        <input type="submit" value="Login">
    </form>
    
    <hr>
    
    <form action="register.jsp" method="get">
        <input type="submit" value="Create New Account" class="secondary-button">
    </form>
    
    <div class="link-container">
        <a href="index.jsp">← Back to Home</a>
    </div>
    
    <% 
        String error = request.getParameter("error");
        if(error != null){
    %>
        <div class="message error-message">
            ⚠️ Invalid Email or Password!
        </div>
    <% } %>
</div>

</body>
</html>