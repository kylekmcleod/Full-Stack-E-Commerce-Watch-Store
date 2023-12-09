<!DOCTYPE html>
<html>
<head>
    <title>Time Piece Vault Home</title>
    <style>
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
        nav a:hover {
            background-color: #000; /* Black hover background */
            color: #fff; /* White hover text */
        }
        .logo img {
            max-width: 300px; /* Adjust the width as needed */
        }
        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            padding: 60px;
            background-image: url('img/back.jpg'); /* Add your background image URL */
            background-size: cover; /* Adjust background size */
            background-position: center; /* Center the background */
        }
        .card {
            width: 400px;
            margin: 5px; /* Adjusted margin */
            padding: 15px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            display: flex; /* Use flexbox */
            flex-direction: column; /* Set flex direction to column */
            justify-content: space-between; /* Distribute space between items */
        }
        .card img {
            max-width: 100%;
            border-radius: 5px;
            margin-bottom: 0px;
        }
        .card h3 {
            margin-bottom: 10px;
            font-weight: 300; /* Thin font weight */
            font-size: 24px; /* Bigger font size */
        }
        .card p {
            font-size: 16px;
            line-height: 0s;
            flex-grow: 1; /* Allow the paragraph to grow to fill space */
        }
        .card-button {
            padding: 8px 15px;
            border: none;
            background-color: #363636;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none; /* Ensure the button text isn't underlined */
            width: 80%; /* Set button width */
            max-width: 150px; /* Limit maximum width */
            align-self: center; /* Center button horizontally */
            margin-top: auto; /* Push the button to the bottom */
        }
        .card-button:hover {
            background-color: #171717;
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
		.image-text-container {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 40px;
            margin-bottom: 40px;
        }

        .image-text-container img {
            max-width: 20%;
            margin-right: 20px;
            border: 1px solid #1c1c1c; /* Added border around the image */
            padding: 5px; /* Added padding inside the border */
        }

        .image-text-container p {
            max-width: 30%;
            font-size: 18px; /* Increased font size */
        }

        .image-text-container h3 {
            font-size: 22px; /* Title font size */
            margin-bottom: 10px;
            text-align: left; /* Align the title to the left */
        }
        .user-info {
            display: flex;
            align-items: center;
        }

        .user-info p {
            margin-left: 20px;
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
    <% } %>
    <a href="showcart.jsp">View Cart</a>
</nav>

    
	<!-- Card section -->
    <div class="card-container">
        <div class="card">
            <img src="img\rolex.jpg" alt="Rolex">
            <h3>Rolex</h3>
            <a href="listprod.jsp?productName=Rolex" class="card-button">Shop Now</a>
        </div>
        <div class="card">
            <img src="img\ap.jpg" alt="Audemars Piguet">
            <h3>Audemars Piguet</h3>
            <a href="listprod.jsp?productName=Audemars%20Piguet" class="card-button">Shop Now</a>
        </div>
        <div class="card">
            <img src="img\gs.jpg" alt="Grand Seiko">
            <h3>Grand Seiko</h3>
            <a href="listprod.jsp?productName=Grand%20Seiko" class="card-button">Shop Now</a>
        </div>
    </div>

	<!-- About us -->
	<div class="line"></div>
	<div class="about-us">
        <h2>About Us</h2>
        <p>Time Piece vault is dedicated to offering elegant, high-quality watches that enhance personal style and represent excellence in craftsmanship. 
		We aim to be a trusted symbol of sophistication, curating a diverse range of designs and manufacturers to cater to every watch enthusiast.</p>
    </div>
	<br></br>
	<div class="line"></div>

	<div class="image-text-container">
	
            <img src="img\rolex1.jpg" alt="Image Description">
            <p>
                We are proud to offer Rolex watches to our customers. Since its start in 1905, Rolex has symbolized innovation and quality in watchmaking. Over the years, it's become a beacon of precision and luxury, 
				adorning the wrists of pioneers and icons. Rolex's legacy is built on a commitment to exquisite craftsmanship and timeless elegance.
            </p>
    </div>

	<footer>
        <div class="copyright">
            <p>&copy; 2023 Time Piece Vault. All rights reserved.</p>
        </div>
    </footer>


</body>
</html>
