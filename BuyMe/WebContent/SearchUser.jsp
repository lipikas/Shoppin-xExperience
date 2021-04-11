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
		String id = request.getParameter("user_id");
		String name = request.getParameter("user_name");
		String str = "select Sum(price) total, bc_id from sells, customers WHERE bc_id=" +id+ "AND name =" + name + "group by(bc_id) order by total desc limit 3;";
		ResultSet result = stmt.executeQuery(str);
		%>
		<h1> User Report: <% out.println(result.next()); %></h1>
	<% 
		con.close();
	%>
	
	</body>
</html>