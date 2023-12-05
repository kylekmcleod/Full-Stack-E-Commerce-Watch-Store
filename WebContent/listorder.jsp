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
        /* Header styles */
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
    <link href="https://fonts.googleapis.com/css2?family=EB+Garamond&display=swap" rel="stylesheet">
</head>
<body>

<!-- Header Section -->
<header>
    <a href="index.jsp">Home</a>
    <a href="showcart.jsp">Cart</a>
    <a href="login.jsp">Login</a>
    <a href="logout.jsp">Logout</a>
</header>

<h1>Order List</h1>
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

</body>
</html>
