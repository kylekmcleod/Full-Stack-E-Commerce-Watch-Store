<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

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
    <h4>Administrator Sales Report by Day</h4>
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

