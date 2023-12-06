<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Clear the cart by setting the productList to null
if (productList != null) {
    productList.clear();
}

// Set or update the productList in the session
session.setAttribute("productList", productList);

// Redirect to showcart.jsp after clearing the cart
response.sendRedirect("showcart.jsp");
%>
