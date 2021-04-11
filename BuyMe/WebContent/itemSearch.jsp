<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%> <%@ page
import="java.io.*,java.util.*,java.sql.*"%> <%@ page
import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Buy Me</title>
<head>
	<body>
		<%
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String id = request.getParameter("id");
		String str = "SELECT * FROM items WHERE item_id" + id + ";";
		ResultSet result = stmt.executeQuery(str);
		%>
		<h1> Item: <% out.println(result.next()); %></h1>
	<% 
		con.close();
	%>
	
	</body>
</html>