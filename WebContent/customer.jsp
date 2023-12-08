<!DOCTYPE html>
<html>
<head>
<title>Time Piece Vault Customer</title>
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
        margin-top: auto;
        }

		footer .copyright {
			font-size: 14px;
		}
        .container {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
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

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	
%>

<%

// TODO: Print Customer information

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String user = "sa";
String password = "304#sa#pw";

String sql = "SELECT * FROM customer WHERE userid = '" + userName + "'";
Connection con = null; 
try{
	con = DriverManager.getConnection(url, user, password);
	Statement statement = con.createStatement();
	
	ResultSet resultSet = statement.executeQuery(sql); 
	
	
    ResultSetMetaData metaData = resultSet.getMetaData();
    int columnCount = metaData.getColumnCount();

    out.println("<table border='1'>");

    
    out.println("<tr>");
    for (int i = 1; i <= columnCount; i++) {
        String columnName = metaData.getColumnName(i);
        out.println("<th>" + columnName + "</th>");
    }
    out.println("</tr>");

    // Iterate through ResultSet to display column values
    while (resultSet.next()) {
        out.println("<tr>");
        for (int i = 1; i <= columnCount; i++) {
            String columnValue = resultSet.getString(i);
            out.println("<td>" + columnValue + "</td>");
        }
        out.println("</tr>");
    }

    out.println("</table>");

}catch(SQLException e){
	out.println("Sql Exception");
}finally{
	con.close(); 
}
// Make sure to close connection
%>

    <footer>
        <div class="copyright">
            <p>&copy; 2023 Time Piece Vault. All rights reserved.</p>
        </div>
    </footer>
    </div>
</body>
</html>