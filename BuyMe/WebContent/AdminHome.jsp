<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<style>
		body {
		  font-family: Arial, Helvetica, sans-serif;
		  margin: 0;
		}
		
		.navbar {
		  overflow: hidden;
		  background-color: #333; 
		}
		
		.navbar a {
		  float: left;
		  font-size: 16px;
		  color: white;
		  text-align: center;
		  padding: 14px 16px;
		  text-decoration: none;
		}
		
		.subnav {
		  float: left;
		  overflow: hidden;
		}
		
		.subnav .subnavbtn {
		  font-size: 16px;  
		  border: none;
		  outline: none;
		  color: white;
		  padding: 14px 16px;
		  background-color: inherit;
		  font-family: inherit;
		  margin: 0;
		}
		
		.navbar a:hover, .subnav:hover .subnavbtn {
		  background-color: red;
		}
		
		.subnav-content {
		  display: none;
		  position: absolute;
		  left: 0;
		  background-color: red;
		  width: 100%;
		  z-index: 1;
		}
		
		.subnav-content a {
		  float: left;
		  color: black;
		  text-decoration: none;
		}
		
		.subnav-content a:hover {
		  background-color: #eee;
		  color: white;
		}
		
		.subnav:hover .subnav-content {
		  display: block;
		}
		</style>
		</head>
		<body>
		
		<div class="navbar">
		  <a href="#home">Create Customer Representative</a>
		  <div class="subnav">
		    <button class="subnavbtn">View Sales Report <i class="fa fa-caret-down"></i></button>
		    <div class="subnav-content">
		      <a href="#??">Total Earnings</a>
		      <a href="#??">Look Up</a>
		      <a href="#??">Best Sellers</a>
		      <a href="#??">Best Buyers</a>
		    </div>
		  </div>
		  <a href="Logout.jsp">Logout</a> 
		</div>
	<div>
      <form method="POST" action="AccountValidate.jsp">
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
