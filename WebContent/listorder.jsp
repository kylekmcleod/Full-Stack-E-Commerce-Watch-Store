<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Kyle and Justin Grocery Order List</title>
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
        
    </style>
    <link href="https://fonts.googleapis.com/css2?family=EB+Garamond&display=swap" rel="stylesheet">
</head>
<body>

<!-- Header Section -->
<div class="container">
<header>
        <div class="logo">
            <img src="img\logowhitecrop.jpg" alt="Logo">
        </div>
    </header>

    <nav>
        <a href="index.jsp">Home</a>
        <a href="listprod.jsp">Shop</a>
        <a href="listorder.jsp">List All Orders</a>
        <a href="customer.jsp">Customer Info</a>
        <a href="admin.jsp">Administrators</a>
        <a href="login.jsp">Login</a>
        <a href="logout.jsp">Log out</a>
        <a href="showcart.jsp">View Cart</a>
    </nav>

<table border="1">
    <tr>
        <th>Order Id</th>
        <th>Order Date</th>
        <th>Customer Id</th>
        <th>Customer Name</th>
        <th>Total Amount</th>
    </tr>
    <%
    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    } catch (java.lang.ClassNotFoundException e) {
        out.println("ClassNotFoundException: " + e);
    }

    NumberFormat currFormat = NumberFormat.getCurrencyInstance();


    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String user = "sa";
    String password = "304#sa#pw";


    String s = "SELECT orderId, orderDate, customer.customerId, firstName + ' ' + lastName as 'Customer Name', totalAmount "
            + "FROM orderSummary "
            + "JOIN customer on orderSummary.customerId = customer.customerId";

    String s2 = "SELECT productId, quantity, price " +
                "FROM ordersummary " +
                "JOIN orderproduct ON ordersummary.orderId = orderproduct.orderId " +
                "WHERE ordersummary.orderId = ?";

    try (Connection con = DriverManager.getConnection(url, user, password);
         Statement stmt = con.createStatement();) {
        ResultSet rst = stmt.executeQuery(s);
        while (rst.next()) {
            int orderId = rst.getInt("orderId");
            %>
            <tr>
                <td><%= orderId %></td>
                <td><%= rst.getString("orderDate") %></td>
                <td><%= rst.getString("customerId") %></td>
                <td><%= rst.getString("Customer Name") %></td>
                <td><%= currFormat.format(rst.getDouble("totalAmount")) %></td>
            </tr>
            <tr>
                <td colspan="5">
                    <table border="1" width="100%">
                        <tr>
                            <th>Product Id</th>
                            <th>Quantity</th>
                            <th>Price</th>
                        </tr>
                        <%
                        PreparedStatement pst2 = con.prepareStatement(s2);
                        pst2.setInt(1, orderId);
                        ResultSet rst2 = pst2.executeQuery();
                        while (rst2.next()) {
                            %>
                            <tr>
                                <td><%= rst2.getInt("productId") %></td>
                                <td><%= rst2.getInt("quantity") %></td>
                                <td><%= rst2.getDouble("price") %></td>
                            </tr>
                            <%
                        }
                        rst2.close();
                        %>
                    </table>
                </td>
            </tr>
            <%
        }
        rst.close();
    } catch (SQLException ex) {
        System.err.println("SQLException: " + ex);
    }
    %>
</table>

    <footer>
        <div class="copyright">
            <p>&copy; 2023 Time Piece Vault. All rights reserved.</p>
        </div>
    </footer>
    </div>
</body>
</html>
