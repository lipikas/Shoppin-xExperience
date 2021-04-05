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
		String str = "select description, price from sells s, items it where it.item_id = s.item_id order by price DESC limit 3;";
		ResultSet result = stmt.executeQuery(str);
		
	%>
	<h1> Best Sellers:</h1>
	<% out.println(result.next()); %>
	<% 
		con.close();
	%>
	
	</body>
</html>