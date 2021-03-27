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
	      /* Style the search box inside the navigation bar */
		.topnav input[type=text] {
		  float: right;
		  padding: 6px;
		  border: none;
		  margin-top: 8px;
		  margin-right: 16px;
		  font-size: 17px;
		}
		
		/* When the screen is less than 600px wide, stack the links and the search field vertically instead of horizontally */
		@media screen and (max-width: 600px) {
		  .topnav a, .topnav input[type=text] {
		    float: none;
		    display: block;
		    text-align: left;
		    width: 100%;
		    margin: 0;
		    padding: 14px;
		  }
		  .topnav input[type=text] {
		    border: 1px solid #ccc;
		  }
      </style>
	<body>

		<div class="topnav">
	      <a href="Messages.jsp">Messages</a>
	      <a href="ManageAcoounts.jsp">Manage User Accounts</a>
	      <a href="ManageAcoounts.jsp">Manage Auctions</a>
	      <input type="text" placeholder="Search..">
	      <a href="Logout.jsp">Logout</a>	      
	    </div>

	</body>
	
</html>