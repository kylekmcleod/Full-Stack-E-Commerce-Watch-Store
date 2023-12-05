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
    </style>
    <link href="https://fonts.googleapis.com/css2?family=EB+Garamond&display=swap" rel="stylesheet">
</head>
<body>

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
    </nav>

<%@ page import="java.text.NumberFormat" %>
<%@ include file="auth.jsp" %>
<%@ include file="jdbc.jsp" %>

<%
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
String sql = "SELECT DATEPART(year, orderDate) AS year, DATEPART(month, orderDate) AS month, DATEPART(day, orderDate) AS day, SUM(totalAmount) AS total "
            + "FROM orderSummary GROUP BY DATEPART(year, orderDate), DATEPART(month, orderDate), DATEPART(day, orderDate) ORDER BY year, month, day ASC;";


try {
    getConnection();
    PreparedStatement stmt = con.prepareStatement(sql);
    ResultSet rst = stmt.executeQuery();
    %>
    <table border="1">
        <tr>
            <th>Order Date</th>
            <th>Total Amount</th>
        </tr>

        <% while(rst.next()) { %>
        <tr>
            <td><%= rst.getInt("year") %>-<%= rst.getInt("month")%>-<%= rst.getInt("day") %></td>
            <td><%= currFormat.format(rst.getDouble("total")) %></td>
        </tr>
        <% } %>
    </table>
    <%
} catch(SQLException e){
     e.printStackTrace();
}
 %>

</body>
</html>

