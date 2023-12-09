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
    <% } %>
    <a href="showcart.jsp">View Cart</a>
</nav>
</head>

<%@ include file="auth.jsp" %>
<%@ include file="jdbc.jsp" %>
<h1>Add Product:</h1>

<div class="form-container">
        <form method="post">
            <h2>Product Details</h2>

            <div class="form-group">
                <label for="productName">Product Name:</label>
                <input type="text" id="productName" name="productName" required>
            </div>

            <div class="form-group">
                <label for="productPrice">Product Price:</label>
                <input type="number" id="productPrice" name="productPrice" step="0.01" required>
            </div>

            <div class="form-group">
                <label for="productImageURL">Product Image URL:</label>
                <input type="text" id="productImageURL" name="productImageURL">
            </div>

            <div class="form-group">
                <label for="productDescription">Product Description:</label>
                <textarea id="productDescription" name="productDescription" rows="4"></textarea>
            </div>

            <div class="form-group">
                <label for="categoryId">Category ID:</label>
                <input type="number" id="categoryId" name="categoryId">
            </div>

            <button type="submit">Submit</button>
        </form>
    </div>

    <%@ page import="java.sql.*" %>
    <%
    String productName = request.getParameter("productName");
     double productPrice = 0; 
    if(request.getParameter("productPrice") != null){
     productPrice = Double.parseDouble(request.getParameter("productPrice"));
    }
    String productImageURL = request.getParameter("productImageURL");
    String productDescription = request.getParameter("productDescription");
    int categoryId = 0; 
    if(request.getParameter("categoryId") != null){
    categoryId = Integer.parseInt(request.getParameter("categoryId"));
    }
    
    if (productName != null && productPrice != 0 && categoryId != 0) {
        
        try{
            getConnection();
            String sql = "INSERT INTO product (productName, productPrice, productImageURL, productDesc, categoryId) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, productName);
            pstmt.setDouble(2, productPrice);
            pstmt.setString(3, productImageURL);
            pstmt.setString(4, productDescription);
            pstmt.setInt(5, categoryId);
            pstmt.executeUpdate();
            out.println("Product added successfully.");
            pstmt.close();
            con.close(); 
        }catch(SQLException e) {
            out.println(e);
           
        }



    }

    %> 



</body>

</html>

