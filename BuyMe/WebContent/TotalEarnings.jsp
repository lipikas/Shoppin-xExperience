<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Buy Me</title>
</head>
	<body>
	<%
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String str = "SELECT SUM(price) FROM sells;";
		ResultSet result = stmt.executeQuery(str);
		
	%>
	<h1> Total Earnings:</h1>
	 <% 
	 while(result.next()){
	 	out.println(result.getString("price")); 
	 }
	 	
		con.close();
	%>
	
	</body>
</html>