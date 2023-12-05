<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'EB Garamond', serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #000;
        }
        header {
            background-color: #000;
            color: white;
            padding: 10px 0;
            text-align: center;
            margin-bottom: 20px;
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
            padding: 10px 0;
            text-align: center;
        }
        header a {
            margin-right: 10px;
            text-decoration: none;
            color: white;
        }
    </style>
</head>
<body>
<header>
    <a href="index.jsp">Home</a>
    <a href="showcart.jsp">Cart</a>
    <a href="login.jsp">Login</a>
    <a href="logout.jsp">Logout</a>
</header>

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
    <div class="product-info">
        <h2><%= productName %></h2>
        <% if (productImageURL != null && !productImageURL.isEmpty()) { %>
            <img src="<%= productImageURL %>" alt="Product Image">
        <% } %>
        <% if (rs.getString("productImage") != null) { %>
            <img src="displayImage.jsp?id=<%= productId %>" alt="Product Image">
        <% } %>
        <h4><b>Id:</b> <%= productId %></h4>
        <h4><b>Price:</b> $<%= String.format("%.2f", productPrice) %></h4>
        <h4><b>Description:</b> <%= productDesc %></h4>
        <a href="addcart.jsp?id=<%= productId %>&name=<%= URLEncoder.encode(productName, "UTF-8") %>&price=<%= String.format("%.2f", productPrice) %>">Add to Cart</a>
        <a href="listprod.jsp">Continue Shopping</a>
    </div>
    <%
    }
    %>
</div>

</body>
</html>
