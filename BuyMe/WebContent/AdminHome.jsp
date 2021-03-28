<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>

	<head>
	<meta charset="ISO-8859-1">
	<title>BuyMe</title>
	</head>
	 <style>
	      .topnav {
	        overflow: hidden;
	        background-color: white;
	      }
	      /* Style the links inside the navigation bar */
	      .topnav a {
	        float: left;
	        display: block;
	        color: black;
	        text-align: center;
	        padding: 14px 16px;
	        text-decoration: none;
	        font-size: 17px;
	      }
	      /* Change the color of links on hover */
	      .topnav a:hover {
	        background-color: #ddd;
	        color: black;
	      }
	      /* Style the "active" element to highlight the current page */
	      .topnav a.active {
	        background-color: #2196f3;
	        color: white;
	      }
	      .head {
	        margin-left: -2rem;
	        margin-top: 15vh;
	        margin-bottom: 6vh;
	        font-size: 25px;
	      }
	  
	      form {
	        margin: 2.5rem 2.6rem;
	      }
	      #submit {
	        margin-top: 1rem;
	        margin-left: 2.5rem;
	        font-size: 15px;
	        border-style: initial;
	        text-decoration: none;
	        background-color: rgb(46, 45, 45);
	        color: rgb(241, 239, 239);
	        border-radius: 15px;
	        padding: 0.2rem 0.5rem;
	      }
	      #name,
	      #phone,
	      #email,
	      #username,
	      #password {
	        font-size: 14px;
	        border-color: lightgrey;
	        border-style: groove;
	        border-radius: 6px;
	      }
		      
		
      </style>
	<body>

		<div class="topnav">
	      <a href="CreateRepAccount.jsp">Create Account</a>
	      <a href="SalesReports.jsp">View Sales Reports</a>
	      <a href="Logout.jsp">Logout</a>	      
	    </div>
	   
	    <div>
	      <form method="POST" action="CustomerRepValidate.jsp">
	        <p >Name:<input type="text" name="Name" id="name" required  /></p>
	        <p >Phone no: <input type="text" name="Phone Number" id="phone" required /></p>
	        <p >Email: <input type="text" name="Email" id="email" required  /></p>
	        <p >Username <input type="text" name="Username" id="username" required /></p>
	        <p>Password: <input type="password" name="Password" id="password" required /></p>
	        <p>
	          <input type="submit" value="Create Account" id="submit" />
	        </p>
	      </form>
	    </div>

	</body>
	
</html>


