<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

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

</body>
</html>