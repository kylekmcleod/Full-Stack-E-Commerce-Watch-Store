<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Time Piece Vault Shop</title>
    <style>
        body {
            font-family: 'EB Garamond', serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5; /* Very light grey */
            color: #000; /* Black text */
        }
        h1, h2 {
            text-align: center;
        }
        form {
            text-align: center;
            margin-bottom: 20px;
        }
        table { 
            width: 80%;
            margin: 0 auto;
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
        td a {
            text-decoration: none;
            color: #000;
        }
        td a:hover {
            text-decoration: underline;
        }
        input[type="text"],
        input[type="submit"],
        input[type="reset"] {
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        input[type="submit"],
        input[type="reset"] {
            margin-left: 10px;
        }
        /* Updated header styles */
        header {
            background-color: #000; /* Black header */
            padding: 20px 0;
            text-align: center;
        }
        header a {
            margin-right: 10px;
            text-decoration: none;
            color: white;
        }
		.add-to-cart-btn {
            padding: 8px 15px;
            border: none;
            background-color: #363636; /* Blue color, can be adjusted */
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        .add-to-cart-btn:hover {
            background-color: #171717; /* Darker shade of blue on hover */
        }
		.logo img {
            max-width: 300px; /* Adjust the width as needed */
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
		footer {
			background-color: #000;
			color: #fff;
			text-align: center;
			padding: 20px 0;
		}

		footer .copyright {
			font-size: 14px;
		}
        nav a:hover {
            background-color: #000; /* Black hover background */
            color: #fff; /* White hover text */
        }
        .brand-btn-container {
        text-align: center;
        margin-bottom: 20px;
        }

        /* Styles for the brand buttons */
        .brand-btn {
            display: inline-block;
            margin: 5px;
            padding: 10px 20px;
            background-color: #363636; /* Blue color, adjust as needed */
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .brand-btn:hover {
            background-color: #171717; /* Darker shade of blue on hover */
        }
        .reset-btn {
        background-color: #8B0000; /* Dark red color */
        }

        .reset-btn:hover {
        background-color: #640000; /* Darker shade of red on hover */
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

<h1>Search:</h1>

<form method="get" action="listprod.jsp">
    <input type="text" name="productName" size="50">
    <input type="submit" value="Submit"><input type="reset" value="Reset">
</form>
<div class="brand-btn-container">
<h1>Filter by Brand:</h1>
<a href="listprod.jsp?category=1" class="brand-btn">Rolex</a>
<a href="listprod.jsp?category=2" class="brand-btn">Patek Philippe</a>
<a href="listprod.jsp?category=3" class="brand-btn">Audemars Piguet</a>
<a href="listprod.jsp?category=4" class="brand-btn">Omega</a>
<a href="listprod.jsp?category=5" class="brand-btn">Grand Seiko</a>
<a href="listprod.jsp?category=6" class="brand-btn">Cartier</a>
<a href="listprod.jsp?" class="brand-btn reset-btn">Reset</a>
</div>

<table border="0">
    <tr>
        <th>Image</th>
        <th>Product Name</th>
        <th>Price</th>
		<th></th> <!-- New column for the Add to Cart button -->
    </tr>
    <%
        // Get product name to search for
        String name = request.getParameter("productName");
        String category = request.getParameter("category");

        
        if(name == null || name.isEmpty()){
    %>
        <h2>All Products</h2>
    <%
        } else {
    %>
        <h2>Products containing '<%= name %>'</h2>
    <%
        }
        // Note: Forces loading of SQL Server driver
        try {
            // Load driver class
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (java.lang.ClassNotFoundException e) {
            out.println("ClassNotFoundException: " +e);
        }

        // Variable name now contains the search string the user entered
        // Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

        // Make the connection
        NumberFormat currFormat = NumberFormat.getCurrencyInstance();

        String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
        String user = "sa";
        String password = "304#sa#pw";

        String s = "SELECT productName, productPrice, productId, productImageURL FROM product WHERE productName LIKE ?";
        if (category != null && !category.isEmpty()) {
            s += " AND categoryId = ?";
        }

        try (Connection con = DriverManager.getConnection(url, user, password);
             PreparedStatement pst = con.prepareStatement(s);) {
                if (category != null && !category.isEmpty()) {
                    pst.setInt(2, Integer.parseInt(category));
                }
                if(name == null || name.isEmpty()) {
                    pst.setString(1, "%");
                } else {
                    pst.setString(1, "%" + name + "%");
                }
                ResultSet rst = pst.executeQuery();

                while (rst.next()) {
                    int productId = rst.getInt("productId");
					String productImageURL = rst.getString("productImageURL");
    %>
                    <tr>
                        <td>
                             <img src="<%= productImageURL %>" alt="Product Image" style="max-width: 100x; max-height: 100px;">
                        </td>
                        <td>
                            <a href="product.jsp?id=<%= productId %>"><%= rst.getString("productName") %></a>
                        </td>
                        <td>
                            <%= currFormat.format(rst.getDouble("productPrice")) %>
                        </td>
						<td>
							<form method="post" action="addcart.jsp">
                            <input type="hidden" name="id" value="<%= productId %>">
                            <input type="hidden" name="name" value="<%= URLEncoder.encode(rst.getString("productName"), "UTF-8") %>">
                            <input type="hidden" name="price" value="<%= rst.getDouble("productPrice") %>">
                            <input type="submit" class="add-to-cart-btn" value="Add to Cart">
                            </form>
						</td>
                    </tr>
    <%
                }
             }
    %>

	
</table>
</body>

<footer>
        <div class="copyright">
            <p>&copy; 2023 Time Piece Vault. All rights reserved.</p>
        </div>
</footer>
</html>

