<%@ page import="java.sql.*" %>
<%@ page import="java.util.concurrent.atomic.AtomicInteger" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Time Piece Vault Order</title>
</head>
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
        .container {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
        }
        
    </style>
    <link href="https://fonts.googleapis.com/css2?family=EB+Garamond&display=swap" rel="stylesheet">
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
        <a href="showcart.jsp">View Cart</a>
    </nav>

<% 

// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
if (custId == null || custId.isEmpty()) {
    response.sendRedirect("checkout.jsp?error=Empty");
} else if (!custId.matches("\\d+")) { // d+ checks if input is only numbers
    response.sendRedirect("checkout.jsp?error=InvalidId");
} else if (productList == null || productList.isEmpty()) {
    response.sendRedirect("checkout.jsp?error=Empty_Cart");
} else {
    boolean isValidId = true;

// Make connection
 	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String user = "sa";
    String password = "304#sa#pw";
	
	try(Connection con = DriverManager.getConnection(url, user, password)){
		String sql_checkCustId = "SELECT * FROM customer WHERE customerId = ?"; 
		int custId_INT = Integer.parseInt(custId); 
		PreparedStatement custIdCheck = con.prepareStatement(sql_checkCustId); 
		custIdCheck.setInt(1, custId_INT);
		ResultSet custIdResult = custIdCheck.executeQuery();

		if (custIdResult.next()) {
			
			//No Action here as the customerID exists in DataBase 
		
		} else {
			//If CustId is not in DataBase 
			response.sendRedirect("checkout.jsp?error=InvalidId");
			isValidId = false; 
			

		}

		if(isValidId){ //Only run following code if custId is valid

		String sql = "INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (?, ?, ?)";
		
		PreparedStatement pst = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

		java.util.Date currentDate = new java.util.Date();
		java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(currentDate.getTime());


		pst.setInt(1, Integer.parseInt(custId));
		pst.setTimestamp(2, currentTimestamp);
		pst.setDouble(3, 0);
		int affectedRows = pst.executeUpdate();
		
        if (affectedRows > 0) {
            ResultSet generatedKeys = pst.getGeneratedKeys();
            int orderId = -1;
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            }


		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
		String insertP = "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";

		double totalAmount = 0.0;

		while (iterator.hasNext()) { 
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();

			PreparedStatement p = con.prepareStatement(insertP);

			String productId = (String) product.get(0);
			String price = (String) product.get(2);
			double pr = Double.parseDouble(price);
			int qty = ( (Integer)product.get(3)).intValue();
			
			p.setInt(1, orderId);
			p.setString(2, productId);
			p.setInt(3, qty);           
			p.setDouble(4, pr);        
			
			double subtotal = pr * qty;
			totalAmount += subtotal;

			p.executeUpdate();
			String updateTotalAmountSql = "UPDATE ordersummary SET totalAmount = ? WHERE orderId = ?";
			PreparedStatement updateTotalAmountStmt = con.prepareStatement(updateTotalAmountSql);
			updateTotalAmountStmt.setDouble(1, totalAmount);
        	updateTotalAmountStmt.setInt(2, orderId);
        	updateTotalAmountStmt.executeUpdate();

			session.removeAttribute("productList");

		}
	}


// Summary page
if (!response.isCommitted()) {

	// display
    out.println("<h1>Your Order Summary</h1>");
    out.println("<table border='0'>");
    out.println("<tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

    Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
    double orderTotal = 0.0;

    while (iterator.hasNext()) {
        Map.Entry<String, ArrayList<Object>> entry = iterator.next();
        ArrayList<Object> product = entry.getValue();

        String productId = (String) product.get(0);
        String productName = (String) product.get(1);
        String price = (String) product.get(2);
        int quantity = (Integer) product.get(3);
        double pr = Double.parseDouble(price);
        double subtotal = pr * quantity;

        out.println("<tr>");
        out.println("<td>" + productId + "</td>");
        out.println("<td>" + productName + "</td>");
        out.println("<td>" + quantity + "</td>");
        out.println("<td>$" + price + "</td>");
        out.println("<td>$" + String.format("%.2f", subtotal) + "</td>");
        out.println("</tr>");

        orderTotal += subtotal;
    }

    out.println("<tr><td colspan='4'>Order Total</td><td>$" + String.format("%.2f", orderTotal) + "</td></tr>");
    out.println("</table>");
    out.println("<p><h1>Order completed. Will be shipped soon...</h1></p>");

	int orderId = 0;
	try (ResultSet generatedKeys = pst.getGeneratedKeys()) {
		if (generatedKeys.next()) {
			orderId = generatedKeys.getInt(1);
		}
	}

	AtomicInteger orderCounter = (AtomicInteger) application.getAttribute("orderCounter");
        if (orderCounter == null) {
            orderCounter = new AtomicInteger(0);
            application.setAttribute("orderCounter", orderCounter);
        }

        // Increment the order number and format it as a 4-digit string
        int orderNumber = orderCounter.incrementAndGet();
        String reference = String.format("%04d", orderNumber);

		
		out.println("<p><h1>Your order reference number is: " + reference + "</h1></p>");



int customerId = Integer.parseInt(custId);
String firstName = "";
String lastName = "";


String sqlGetCustomerName = "SELECT firstname, lastname FROM customer WHERE customerId = ?";
try (PreparedStatement stmt = con.prepareStatement(sqlGetCustomerName)) {
    stmt.setInt(1, customerId);
    ResultSet rs = stmt.executeQuery();

    if (rs.next()) {
        firstName = rs.getString("firstname");
        lastName = rs.getString("lastname");
	}
} catch (SQLException e) {
    e.printStackTrace();
}

String customerName = firstName + " " + lastName;
String customerInfo = "Shipping to customer: " + customerId + " Name: " + customerName;


    out.println("<p><h1>" + customerInfo + "</h1></p>");

    out.println("</body>");
    out.println("</html>");

    session.removeAttribute("productList");
}
}
}catch(SQLException e){
	e.printStackTrace();
}
}
	
%>
<footer>
        <div class="copyright">
            <p>&copy; 2023 Time Piece Vault. All rights reserved.</p>
        </div>
    </footer>
</BODY>
</HTML>