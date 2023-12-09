<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            font-family: 'EB Garamond', serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #000;
        }
        .product-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        .product-info {
            text-align: center;
            margin-bottom: 20px;
        }
        .product-info img {
            max-width: 100%;
            max-height: 300px;
            margin-bottom: 20px;
        }
        .product-info h2 {
            margin-bottom: 10px;
        }
        .product-info h4 {
            margin-bottom: 5px;
        }
        .product-info a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            text-decoration: none;
            color: #fff;
            background-color: #000;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .product-info a:hover {
            background-color: #333;
        }
        header {
            background-color: #000; /* Black */
            color: white;
            padding: 20px 0;
            text-align: center;
        }
        header a {
            margin-right: 20px;
            text-decoration: none;
            color: white;
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
        nav a:hover {
            background-color: #000; /* Black hover background */
            color: #fff; /* White hover text */
        }
        .product-container {
        display: flex;
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .product-image {
            flex: 1;
        }
        .product-image img {
        max-width: 100%;
        max-height: 500px; /* Adjust height as needed */
        }

        .product-details {
            flex: 1;
            padding-left: 20px; 
        }

        .product-details h2 {
        margin-bottom: 10px;
        font-size: 34px; /* Adjust the font size as needed */
        font-weight: 300;
        }   
        .product-details h4 {
            margin-bottom: 10px;
            font-weight: 300;
            font-size: 20px;
        }

        .product-details form {
            margin-top: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .product-details form input[type="number"] {
            padding: 8px;
            width: 60px;
        }

        .product-details form input[type="submit"] {
            padding: 8px 20px;
            border: none;
            background-color: #000;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .product-details form input[type="submit"]:hover {
            background-color: #333;
        }
        .product-details a.continue-shopping {
    display: inline-block;
    margin-top: 10px;
    padding: 10px 20px;
    text-decoration: none;
    color: #000;
    background-color: #ccc;
    border-radius: 5px;
    transition: background-color 0.3s;
}

.product-details a.continue-shopping:hover {
    background-color: #999;
}
    </style>
    <link href="https://fonts.googleapis.com/css2?family=EB+Garamond&display=swap" rel="stylesheet">
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

<div class="product-container">
    <%
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String user = "sa";
    String password = "304#sa#pw";

    String productId = request.getParameter("id");
    String productName = "";
    double productPrice = 0.00;
    String productImageURL = "";
    String productDesc = "";

    String sql = "SELECT productName, productPrice, productImageURL, productImage, productDesc FROM product WHERE productId = ?;";

    try (Connection con = DriverManager.getConnection(url, user, password);
         PreparedStatement pst = con.prepareStatement(sql);) {

        pst.setString(1, productId);
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            productName = rs.getString("productName");
            productPrice = rs.getDouble("productPrice");
            productImageURL = rs.getString("productImageURL");
            productDesc = rs.getString("productDesc");
        }
    %>
    <div class="product-image">
        <% if (productImageURL != null && !productImageURL.isEmpty()) { %>
            <img src="<%= productImageURL %>" alt="Product Image">
        <% } %>
        <% if (rs.getString("productImage") != null) { %>
            <img src="displayImage.jsp?id=<%= productId %>" alt="Product Image">
        <% } %>
    </div>
    <div class="product-details">
        <h2><%= productName %></h2>
        <h4><b>Id:</b> <%= productId %></h4>
        <h4><b>Price:</b> $<%= String.format("%.2f", productPrice) %></h4>
        <h4><b>Description:</b> <%= productDesc %></h4>
        <form action="addcart.jsp">
            <input type="hidden" name="id" value="<%= productId %>">
            <input type="hidden" name="name" value="<%= URLEncoder.encode(productName, "UTF-8") %>">
            <input type="hidden" name="price" value="<%= String.format("%.2f", productPrice) %>">
            <input type="number" name="quantity" value="1" min="1">
            <input type="submit" value="Add to Cart">
        </form>
        <a href="listprod.jsp" class="continue-shopping">Continue Shopping</a>
    </div>
</div>
    <%
    }
    %>
</div>

</body>
</html>
