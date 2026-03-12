<%
    String role = (String) session.getAttribute("role");
    String email = (String) session.getAttribute("email");

    if (role == null || !role.equals("LENDER")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Resource - BorrowHub</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            width: 100%;
            max-width: 500px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(135deg, #2e7d32 0%, #1b5e20 100%);
            padding: 30px;
            text-align: center;
            color: white;
        }
        
        .header h2 {
            font-size: 28px;
            margin-bottom: 5px;
        }
        
        .header p {
            opacity: 0.9;
            font-size: 14px;
        }
        
        .form-body {
            padding: 30px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        label {
            display: block;
            color: #2e7d32;
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
            border-color: #2e7d32;
            box-shadow: 0 0 0 3px rgba(46, 125, 50, 0.1);
        }
        
        textarea.input-field {
            resize: vertical;
            min-height: 100px;
        }
        
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .submit-btn {
            flex: 2;
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            background: linear-gradient(135deg, #2e7d32 0%, #1b5e20 100%);
            color: white;
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(46, 125, 50, 0.3);
        }
        
        .back-btn {
            flex: 1;
            padding: 14px;
            border: 2px solid #2e7d32;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            text-decoration: none;
            color: #2e7d32;
            background: white;
        }
        
        .back-btn:hover {
            background: #2e7d32;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(46, 125, 50, 0.2);
        }
        
        @media (max-width: 480px) {
            .button-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h2>Add New Resource</h2>
        <p>List an item to lend to others</p>
    </div>
    
    <div class="form-body">
        <form action="addResource" method="post">
            <div class="form-group">
                <label>RESOURCE NAME</label>
                <input type="text" name="resource_name" required class="input-field" placeholder="e.g., DSLR Camera, Projector, Laptop">
            </div>
            
            <div class="form-group">
                <label>QUANTITY</label>
                <input type="number" name="quantity" required class="input-field" placeholder="Enter quantity available" min="1">
            </div>
            
            <div class="form-group">
                <label>DESCRIPTION</label>
                <textarea name="description" class="input-field" placeholder="Provide details about the resource..."></textarea>
            </div>
            
            <div class="button-group">
                <input type="submit" value="Add Resource" class="submit-btn">
                <a href="lenderDashboard.jsp" class="back-btn">Back</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>