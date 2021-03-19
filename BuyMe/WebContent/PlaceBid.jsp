<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Place Bids</title>
	</head>
	<body>
		
		<form method="POST" action="BidValidate.jsp">
		
			<label for="AucID">Auction ID:</label><br>
			<input type="text" id="AucID" name="AucID"><br>
			<label for="Amnt">Bid Amount:</label><br>
			<input type="text" id="Amnt" name="Amnt"><br>
			<input type="submit" value="Submit" id="submit" />
		
		
		</form>
		
		
		
	</body>
</html>