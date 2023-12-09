<!DOCTYPE html>
<html>
<head>

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

        #editProdButton {
    background-color: black; /* Button background color */
    color: white;           /* Text color */
    border: none;           /* No border */
    padding: 10px 20px;     /* Top/bottom and left/right padding */
    text-align: center;     /* Center the text inside the button */
    text-decoration: none;  /* No underline on the text */
    display: inline-block;  /* Allows setting width and height */
    font-size: 16px;        /* Text size */
    margin: 4px 2px;        /* Margin around the button */
    cursor: pointer;        /* Cursor to indicate it's clickable */
    border-radius: 8px;     /* Rounded corners */
    transition: background-color 0.3s; /* Smooth transition for hover effect */
}

    #deleteProdButton {
        background-color: black; /* Button background color */
        color: white;           /* Text color */
        border: none;           /* No border */
        padding: 10px 20px;     /* Top/bottom and left/right padding */
        text-align: center;     /* Center the text inside the button */
        text-decoration: none;  /* No underline on the text */
        display: inline-block;  /* Allows setting width and height */
        font-size: 16px;        /* Text size */
        margin: 4px 2px;        /* Margin around the button */
        cursor: pointer;        /* Cursor to indicate it's clickable */
        border-radius: 8px;     /* Rounded corners */
        transition: background-color 0.3s; /* Smooth transition for hover effect */
    }

    </style>
    <link href="https://fonts.googleapis.com/css2?family=EB+Garamond&display=swap" rel="stylesheet">
     <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
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

<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="auth.jsp" %>
<%@ include file="jdbc.jsp" %>
<h1>Sales Table</h1>
<br>
<%
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
String sql = "SELECT DATEPART(year, orderDate) AS year, DATEPART(month, orderDate) AS month, DATEPART(day, orderDate) AS day, SUM(totalAmount) AS total "
            + "FROM orderSummary GROUP BY DATEPART(year, orderDate), DATEPART(month, orderDate), DATEPART(day, orderDate) ORDER BY year, month, day ASC;";

ArrayList<String> dateList = new ArrayList<>(); 
ArrayList<Double> salesList = new ArrayList<>();
  
try {
    getConnection();
    PreparedStatement stmt = con.prepareStatement(sql);
    ResultSet rst = stmt.executeQuery();
    %>
    <table border="1">
        <tr>
            <th>Date</th>
            <th>Total Sales</th>
        </tr>

        <% while(rst.next()) { %>
        <tr>
            <td><%= rst.getInt("year") %>-<%= rst.getInt("month")%>-<%= rst.getInt("day") %></td>
            <%
            String s = ""; 
            s += rst.getInt("year"); 
            s += "-";
            s += rst.getInt("month"); 
            s += "-";
            s += rst.getInt("day"); 
            dateList.add(s);
             %> 
            <td><%= currFormat.format(rst.getDouble("total")) %></td>
            <%
            salesList.add(rst.getDouble("total")); 
            %> 
        </tr>
        <% } 
        

    request.setAttribute("dateList", dateList);
    request.setAttribute("salesList", salesList);
    rst.close();
    stmt.close();
    %>
    </table>
    <%
} catch(SQLException e){
     e.printStackTrace();
}
 %>
 <h1>Sales report<h1>
<canvas id="myChart" width="100" height="15"></canvas>

<a id = "editProdButton" href = "addProd.jsp" >Add Product(s)</a>
<br>
<a id = "deleteProdButton" href = "deleteProd.jsp" >Delete Product(s)</a>
<br>
<br>
<br>
<br>
<script> 
var dates = [
        <% 
        ArrayList<String> dateList2 = (ArrayList<String>) request.getAttribute("dateList");
        if (dateList2 != null) {
            for (int i = 0; i < dateList2.size(); i++) {
                out.print("'" + dateList2.get(i) + "'");
                if (i < dateList2.size() - 1) {
                    out.print(", ");
                }
            }
        }
        %>
    ];


    var sales = [
        <% 
        ArrayList<Double> salesList2 = (ArrayList<Double>) request.getAttribute("salesList");
        if (salesList2 != null) {
            for (int i = 0; i < salesList2.size(); i++) {
                out.print(salesList2.get(i));
                if (i < salesList2.size() - 1) {
                    out.print(", ");
                }
            }
        }
        %>
    ];

    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: dates,
            datasets: [{
                label: 'Sales',
                data: sales,
                backgroundColor: 'rgba(0, 123, 255, 0.5)'
            }]
        }
    });
    
</script> 


</body>
</html>