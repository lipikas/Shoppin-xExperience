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
			out.println("Home page of: " + session.getAttribute("username") + "<br>");
			out.println("<a href=\"ViewAuctions.jsp\"> View Available Auctions");
			out.println("<br>"); 
			out.println("<a href=\"Logout.jsp\">Logout");
		%>
	</body>
	
</html>