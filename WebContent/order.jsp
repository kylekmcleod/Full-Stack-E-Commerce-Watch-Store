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
<title>Kyle & Justin Grocery Order Processing</title>
</head>
<body>

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
</BODY>
</HTML>