<!DOCTYPE html>
<html>
<head>
    <title>Kyle and Justin's Grocery Main Page</title>
    <style>
        body {
            font-family: 'EB Garamond', serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5; /* Very light grey */
            color: #000; /* Black text */
        }
        header {
            background-color: #000; /* Black header */
            color: #fff; /* White text */
            padding: 20px 0;
            text-align: center;
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
        nav a:hover {
            background-color: #000; /* Black hover background */
            color: #fff; /* White hover text */
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=EB+Garamond&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <h1>Welcome to Time Piece Vault</h1>
    </header>

    <nav>
        <a href="listprod.jsp">Shop</a>
        <a href="listorder.jsp">List All Orders</a>
        <a href="customer.jsp">Customer Info</a>
        <a href="admin.jsp">Administrators</a>
		<a href="login.jsp">Login</a>
        <a href="logout.jsp">Log out</a>
    </nav>

    <%
        String userName = (String) session.getAttribute("authenticatedUser");
        if (userName != null)
            out.println("<p align=\"center\">Signed in as: " + userName + "</p>");
    %>
</body>
</html>
