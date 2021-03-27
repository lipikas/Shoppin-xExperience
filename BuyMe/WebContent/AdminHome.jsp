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
	      
		
      </style>
	<body>

		<div class="topnav">
	      <a href="CreateAccount.jsp">Create Account</a>
	      <a href="SalesReports.jsp">View Sales Reports</a>
	      <a href="Logout.jsp">Logout</a>	      
	    </div>

	</body>
	
</html>