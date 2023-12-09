<!DOCTYPE html>
<html>
<head>
    <style>
    body {
            font-family: 'EB Garamond', serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
            color: #000;
        }
        h1 {
            text-align: center;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }
        th {
            background-color: #000;
            color: #fff;
        }
        nav {
            background-color: #fff; /* White navigation */
            padding: 10px 0;
            text-align: center;
        }
        nav a {
            display: inline-block;
            margin: 0 10px;
            text-decoration: none;
            color: #000; /* Black link text */
            padding: 5px 10px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .logo img {
            max-width: 300px; /* Adjust the width as needed */
        }
        body {
            font-family: 'EB Garamond', serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5; /* Very light grey */
            color: #000; /* Black text */
        }
        header {
            background-color: #000; /* Black header */
            padding: 20px 0;
            text-align: center;
        }
        nav a:hover {
            background-color: #000; /* Black hover background */
            color: #fff; /* White hover text */
        }
        .logo img {
            max-width: 300px; /* Adjust the width as needed */
        }
		.about-us {
            max-width: 800px; /* Set a maximum width */
            margin: 0 auto; /* Center align the element */
            text-align: center;
            margin-top: 40px;
            padding: 0 20px;
        }
		.line {
            width: 100%; /* Set the width to 100% */
            height: 1px; /* Set the height */
            background-color: #ccc; /* Color of the line */
            margin: 20px auto; /* Adjust the margins to center the line */
            max-width: 1200px; /* Set a maximum width */
        }
		footer {
			background-color: #000;
			color: #fff;
			text-align: center;
			padding: 20px 0;
		}

		footer .copyright {
			font-size: 14px;
		}
        .container {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
        }

        .form-container {
    position: relative;
    left: 41%;
    background-color: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 300px;
}

    .form-group input[type="text"],
    .form-group input[type="number"],
    .form-group input[type="url"],
    .form-group textarea {
        width: 100%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box; /* So that width includes padding */
    }

    button {
    width: 100%;
    padding: 10px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.product-container {
            display: inline-block;
            text-align: left;
            margin: 20px;
            padding: 10px;
            border: 1px solid #ccc;
        }

        form {
            display: inline-block;
            margin-top: 10px;
        }

        .content {
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .content p {
            background-color: #fff;
            padding: 10px;
            border: 1px solid #ddd;
            margin-bottom: 10px;
        }
        .content form {
            margin-top: 10px;
        }
        input[type="submit"] {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #d32f2f;
        }

    </style>
    <link href="https://fonts.googleapis.com/css2?family=EB+Garamond&display=swap" rel="stylesheet">
     <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
</head>
<body>

    <header>
        <div class="logo">
            <img src="img\logowhitecrop.jpg" alt="Logo">
        </div>
    </header>

<% String authenticatedUser = (String) session.getAttribute("authenticatedUser"); %>
<nav>
    <a href="index.jsp">Home</a>
    <a href="listprod.jsp">Shop</a>
    <a href="listorder.jsp">List All Orders</a>
    <a href="customer.jsp">Customer Info</a>
    <a href="admin.jsp">Administrators</a>
    <% if (authenticatedUser != null && !authenticatedUser.isEmpty()) { %>
        <a href="logout.jsp">Log Out ( <%= authenticatedUser %> )</a>
    <% } else { %>
        <a href="login.jsp">Login</a>
        <a href="createAcc.jsp">Create Account</a>
    <% } %>
    <a href="showcart.jsp">View Cart</a>
</nav>
</head>

<%@ include file="auth.jsp" %>
<%@ include file="jdbc.jsp" %>

<div class="content">
<h1>Delete Product:</h1>

    <%@ page import="java.sql.*" %>
    <%

        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("productId") != null) {
                String productId = request.getParameter("productId");
                try {
                    getConnection();
                    String deleteSql = "DELETE FROM product WHERE productId = ?";
                   PreparedStatement pstmt = con.prepareStatement(deleteSql);
                    pstmt.setInt(1, Integer.parseInt(productId));
                    pstmt.executeUpdate();
                } catch (SQLException e) {
                    out.println("Error during deletion: " + e.getMessage());
                }
        }
    
        try{
            getConnection();
            String sql = "Select productName, productId  from product";   
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rst = pstmt.executeQuery();
            


                while(rst.next()){
                    String productName = rst.getString("productName");
                    int productId = rst.getInt("productId");

    // Generate HTML for each product
    out.println("<p>Product Name: " + productName + " (ID: " + productId + ")</p>");
    out.println("<form action='' method='post'>");
    out.println("<input type='hidden' name='productId' value='" + productId + "'>");
    out.println("<input type='submit' value='Delete'>");
    out.println("</form>");
                }

        }catch(SQLException e) {
            out.println(e);
           
        }



  

    %> 
</div> 


</body>

</html>

