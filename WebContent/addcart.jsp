<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null) {
    // No products currently in list.  Create a list.
    productList = new HashMap<String, ArrayList<Object>>();
}

// Add new product selected
// Get product information
String id = request.getParameter("id");
String name = request.getParameter("name");
String price = request.getParameter("price");
String quantity = request.getParameter("quantity");

Integer quantity2;
if(quantity == null || quantity.isEmpty()){
    quantity2 = 1;
} else {
quantity2 = Integer.parseInt(quantity);    
}


// Store product information in an ArrayList
ArrayList<Object> product = new ArrayList<Object>();
product.add(id);
product.add(name);
product.add(price);

// Fetch the quantity from the existing product list or use 0 if not present
int curAmount = productList.containsKey(id) ? (Integer) productList.get(id).get(3) : 0;
product.add(curAmount + quantity2);

// Update or add the product to the productList
productList.put(id, product);
session.setAttribute("productList", productList);

// Redirect to showcart.jsp after updating the cart
response.sendRedirect("showcart.jsp");
%>
