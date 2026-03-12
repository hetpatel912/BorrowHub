<!-- index.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>BorrowHub - Home</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            min-height: 100vh;
            position: relative;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }
        
        /* Single BorrowHub text in background exactly like the image */
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
            text-align: center;
            z-index: 1;
            position: relative;
            width: 100%;
            max-width: 600px;
            padding: 40px 20px;
        }
        
        .title {
            color: white;
            font-size: 56px;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            letter-spacing: 2px;
        }
        
        .title span {
            color: #ffeb3b;
            font-weight: bold;
        }
        
        .subtitle {
            color: white;
            font-size: 24px;
            margin-bottom: 40px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
        }
        
        hr {
            border: none;
            height: 2px;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.5), transparent);
            margin: 30px auto;
            width: 80%;
        }
        
        .button-container {
            display: flex;
            flex-direction: column;
            gap: 25px;
            align-items: center;
            margin-top: 40px;
        }
        
        .action-button {
            padding: 20px 60px;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            font-size: 24px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
            min-width: 300px;
            text-decoration: none;
            display: block;
            text-align: center;
            position: relative;
            overflow: hidden;
            color: white;
        }
        
        .action-button:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.3);
        }
        
        .action-button:active {
            transform: translateY(-2px);
        }
        
        /* Button specific styles */
        .login-button { 
            background: linear-gradient(135deg, #2196F3, #0D47A1);
        }
        
        .login-button:hover {
            background: linear-gradient(135deg, #1E88E5, #0D47A1);
        }
        
        .register-button { 
            background: linear-gradient(135deg, #4CAF50, #2E7D32);
        }
        
        .register-button:hover {
            background: linear-gradient(135deg, #43A047, #1B5E20);
        }
        
        /* Description text */
        .button-description {
            color: rgba(255, 255, 255, 0.9);
            font-size: 16px;
            margin-top: 8px;
            opacity: 0.8;
            transition: opacity 0.3s ease;
            font-weight: normal;
        }
        
        .action-button:hover .button-description {
            opacity: 1;
        }
        
        /* Decorative elements */
        .main-container {
            position: relative;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(8px);
            border-radius: 20px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            border: 1px solid rgba(255, 255, 255, 0.18);
        }
        
        /* Responsive design */
        @media (max-width: 768px) {
            .title {
                font-size: 42px;
            }
            
            .subtitle {
                font-size: 20px;
            }
            
            .action-button {
                min-width: 250px;
                padding: 18px 40px;
                font-size: 22px;
            }
            
            body::before {
                font-size: 30vw;
                letter-spacing: 10px;
            }
        }
        
        @media (max-width: 480px) {
            .title {
                font-size: 32px;
            }
            
            .subtitle {
                font-size: 18px;
            }
            
            .action-button {
                min-width: 200px;
                padding: 15px 30px;
                font-size: 20px;
            }
            
            .button-description {
                font-size: 14px;
            }
            
            body::before {
                font-size: 35vw;
                letter-spacing: 5px;
            }
            
            hr {
                width: 90%;
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
    <h1 class="title">Welcome to <span>BorrowHub</span></h1>
    
    <div class="subtitle">Your Premier Borrowing Platform</div>
    
    <hr>
    
    <h3 class="subtitle" style="font-size: 20px; margin-bottom: 20px;">Please Choose an Option:</h3>
    
    <div class="button-container">
        <!-- Login Button -->
        <a href="login.jsp" class="action-button login-button">
            Login
            <div class="button-description">Access your account</div>
        </a>
        
        <!-- Register Button -->
        <a href="register.jsp" class="action-button register-button">
            Register
            <div class="button-description">Create a new account</div>
        </a>
    </div>
</div>

<!-- No JavaScript - pure CSS solution -->

</body>
</html>