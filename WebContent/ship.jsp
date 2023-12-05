<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDate" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Kyle and Justin's Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
	String orderId = request.getParameter("orderId");

          
	// TODO: Check if valid order id in database
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String user = "sa";
	String password = "304#sa#pw";	

	String sql = "SELECT * FROM ordersummary WHERE orderId = ?"; 
	Connection con = null; 
	try{
		con = DriverManager.getConnection(url, user, password);
		PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, orderId);
        ResultSet rs = pstmt.executeQuery();
		

		if (rs.next()) {
            // Order ID exists in the database
            
        } else {
            // Order ID doesn't exist in the database
            out.println("Order ID " + orderId + " does not exist in the database.");
        }
		rs.close();
        pstmt.close();
	}catch (SQLException e) {
        out.println("Error: Unable to validate Order ID");
    }

	
	// TODO: Start a transaction (turn-off auto-commit)
	// TODO: Retrieve all items in order with given id
	try{
		con.setAutoCommit(false);
		String retrieveItemsQuery = "select productId,quantity from ordersummary join orderproduct on ordersummary.orderid = orderproduct.orderid where ordersummary.orderid = ?";
		PreparedStatement retrieveItemsStmt = con.prepareStatement(retrieveItemsQuery);
		retrieveItemsStmt.setInt(1, Integer.parseInt(orderId));
		ResultSet orderItemsResult = retrieveItemsStmt.executeQuery();
		
		while (orderItemsResult.next()) {
			int productId = orderItemsResult.getInt("productId");
			int quantity = orderItemsResult.getInt("quantity");
			// code for warehouse quantity
			String retrieveQuantityQuery = "SELECT quantity FROM productInventory WHERE productId = ?";
			PreparedStatement retrieveQuantityStmt = con.prepareStatement(retrieveQuantityQuery);
			retrieveQuantityStmt.setInt(1,productId);
			ResultSet resSet = retrieveQuantityStmt.executeQuery();
			int wQuantity = 0; 
			int newInventory = 0;
			if (resSet.next()) {
				 wQuantity= resSet.getInt("quantity");

				 if(wQuantity < quantity){
					out.println("Shipment not done. Insufficent inventory for productID: " + productId);
					con.rollback(); 
					break;
				 }else{
					newInventory = wQuantity - quantity;

				 }
			} else {
				out.println("Product ID " + productId + " not found in inventory.");
			}


			out.println("<p>Ordered Product: " + productId + " Quantity: " + quantity + " Previous inventory: " + wQuantity + " New Inventory: " + newInventory + " </p>");
		}
		LocalDate currentDate = LocalDate.now();
		String desc = "Default Desc";
		String date = currentDate.toString();
		int warehouseNum = 1; 
		
		// TODO: Create a new shipment record.

		String insertShipmentQuery = "INSERT INTO shipment (shipmentDate, shipmentDesc, warehouseId) VALUES (?, ?, ?)";
		PreparedStatement insertShipmentStmt = con.prepareStatement(insertShipmentQuery, Statement.RETURN_GENERATED_KEYS);

		insertShipmentStmt.setDate(1, java.sql.Date.valueOf(date));
    	insertShipmentStmt.setString(2, desc);
    	insertShipmentStmt.setInt(3, warehouseNum);	
		
		int rowsAffected = insertShipmentStmt.executeUpdate();

		if(rowsAffected > 0){
			
		}else{
			con.rollback();
			out.println("Shipment Failed");
		}

		con.commit();
    	con.setAutoCommit(true); 
    	con.close(); 

	}catch (SQLException e) {
		out.println("Sql Exception"); 
	}
	
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>