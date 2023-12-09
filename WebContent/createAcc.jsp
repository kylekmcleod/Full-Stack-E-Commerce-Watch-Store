<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Create Account</title>
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


        input[type=submit]:hover {
    background-color: #0056b3;
        }

    input[type=text], input[type=email], input[type=password] {
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        width: calc(100% - 22px); /* Adjust width to account for padding and border */
        box-sizing: border-box; /* Include padding and border in width calculation */
    }

    input[type=submit] {
    padding: 10px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    box-sizing: border-box; /* Include padding and border in width calculation */
    text-align: center; /* Center the text inside the button */
    margin-top: 10px; /* Add margin for spacing from the last input field */
    margin-left: -30px;
}


    

.submit-container {
    display: flex;
    justify-content: center; /* Center the button horizontally */
    width: 100%; /* Full width to ensure it aligns with other inputs */
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

        .form-container {
            background-color: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        width: 300px;
        margin: auto; /* Centers the container horizontally */
        display: flex; /* Enables flexbox for this container */
        flex-direction: column; /* Stacks children elements vertically */
        align-items: center; /* Centers children elements horizontally */
            }

            form {
            display: flex;
            flex-direction: column;
            gap: 10px;
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

<h1>Create Account</h1> 


<% 
boolean success = false;
  String formSubmitted = request.getParameter("formSubmitted");
    if ("true".equals(formSubmitted)) {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phonenum = request.getParameter("phonenum");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postalCode = request.getParameter("postalCode");
        String country = request.getParameter("country");
        String userid = request.getParameter("userid");
        String userPassword = request.getParameter("password");
    


    
    try {
            getConnection(); 
            String sql = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, "firstName");
            statement.setString(2, "lastName");
            statement.setString(3, "email");
            statement.setString(4, "phonenum");
            statement.setString(5, "address");
            statement.setString(6, "city");
            statement.setString(7, "state");
            statement.setString(8, "postalCode");
            statement.setString(9, "country");
            statement.setString(10, "userid");
            statement.setString(11, "userPassword");

            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    
%>

<% if (success) { %>
    <p>Account created successfully!</p>
<% }else{ %> 
    <p>Error creating account!</p> 

<% }
} %>  

<div class = "form-container">
<form method="post">
    <input type="hidden" name="formSubmitted" value="true" />
    <input type="text" name="firstName" placeholder="First Name" required />
    <input type="text" name="lastName" placeholder="Last Name" required />
    <input type="text" name="email" placeholder="Email" required />
    <input type="text" name="phonenum" placeholder="Phone Number" />
    <input type="text" name="address" placeholder="Address" required />
    <input type="text" name="city" placeholder="City" required />
    <input type="text" name="state" placeholder="State" required />
    <input type="text" name="postalCode" placeholder="Postal Code" required />
    <input type="text" name="country" placeholder="Country" required />
    <input type="text" name="userid" placeholder="User ID" required />
    <input id = "password" type="password" name="password" placeholder="Password" required />
    <div class="submit-container">
    <input type="submit" value="Create Account" />
    </div>
</form>

</div> 



</body> 
</html> 
