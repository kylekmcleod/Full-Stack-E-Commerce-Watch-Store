<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
</head>
<body>
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
        position: absolute;
        bottom: 0;
        width: 100%;
        background-color: #000;
        color: #fff;
        text-align: center;
        padding: 20px 0;
        }

		footer .copyright {
			font-size: 14px;
		}
		.login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            margin-top: 50px;
        }
        .login-container h3 {
            margin-bottom: 20px;
            font-size: 24px;
        }
        .login-form {
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 300px;
            margin-top: 20px;
        }
        .login-form input[type="text"],
        .login-form input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .login-form input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #000;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .login-form input[type="submit"]:hover {
            background-color: #363636;
        }
	</style>
	<link href="https://fonts.googleapis.com/css2?family=EB+Garamond&display=swap" rel="stylesheet">
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

<div style="margin:0 auto;text-align:center;display:inline">

<div class="login-container">
        <h3>Login</h3>
        <%
        if (session.getAttribute("loginMessage") != null)
            out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
        %>
        <div class="login-form">
            <form name="MyForm" method="post" action="validateLogin.jsp">
                <input type="text" name="username" placeholder="Username" maxlength="10">
                <input type="password" name="password" placeholder="Password" maxlength="10">
                <input class="submit" type="submit" name="Submit2" value="Log In">
            </form>
        </div>
    </div>
<footer>
        <div class="copyright">
            <p>&copy; 2023 Time Piece Vault. All rights reserved.</p>
        </div>
	</footer>
</body>
</html>

