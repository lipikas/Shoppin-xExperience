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
	
	<body>
		<%	
			String username = request.getParameter("Username");
			String password = request.getParameter("Password");
			String name = request.getParameter("Name");
			String number = request.getParameter("Phone Number");
			String email = request.getParameter("Email");
			//out.println("<p>usr: " + username + " pass: " + password + "</p>");
			
		%>
	</body>
	
</html>