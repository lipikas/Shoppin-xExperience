<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>

	<head>
	<meta charset="ISO-8859-1">
	<title>BuyMe</title>
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
		  background-color: #2196F3;
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
		    border: 1px solid ##000000;
		  }
		}
		body,
		html {
		     height: 100%; 
		
		}
		
		.fullwidth {
		  display: flex;
		  flex-direction: column;
		  height: 100%;
		}
		
		.row {
		  flex:1;
		  background-size: cover;
		  background-repeat:no-repeat;
		  background-position:center center;
		}
		body, html {
		  width: 100%;
		  height: 100%;
		  margin: 0;
		}
		
		.container {
		  width: 100%;
		  height: 100%;
		}
		
		.leftpane {
		    width: 33.33%;
		    height: 100%;
		    float: left;
		    border-collapse: collapse;
		}
		
		.middlepane {
		    width: 33.33%;
		    height: 100%;
		    float: left;
		    border-collapse: collapse;
		}
		
		.rightpane {
		  width: 33.33%;
		  height: 100%;
		  position: relative;
		  float: right;
		  border-collapse: collapse;
		}
				
	</style>
	</head>
	
	<body>
		<div class="topnav">
		  <a class="active" href="#home">Home</a>
		  <a href="CreateAuction.jsp">Create Auction</a>
		  <a href="Alerts.jsp">Alerts</a>
		  <a href="ViewAuctions.jsp"> View Available Auctions</a>
		  <input type="text" placeholder="Search..">
		  <a href="Logout.jsp">Logout</a>
		</div>
		<div class="container">
		  <div class="leftpane">
		    <h1>My Auctions</h1>
		  </div>
		  <div class="middlepane">
		  	<h1>Current Bids</h1>
		  </div>
		  <div class="rightpane">
		    <h1>Bid History</h1></div>
		</div>

	</body>
	
</html>
