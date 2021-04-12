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
		String str = "select Sum(price) total, bc_id from sells, customers WHERE bc_id='" +id+ "'AND name ='" + name + "';";
		ResultSet result = stmt.executeQuery(str);
		%>
		<h1> User Report: </h1>
	<% 
		out.print("<table>");
		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("Customer ID");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Total Amount Spent");
		out.print("</td>");
		out.print("</tr>");	
		while(result.next()){
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//Print out current bar name:
			out.print(result.getString("bc_id"));
			out.print("</td>");
			out.print("<td>");
			//Print out current beer name:
			out.print(result.getString("total"));
			out.print("</td>");
			out.print("<td>");
			out.print("</tr>");
		}
		out.print("<table>");
		con.close();
	%>
	
	</body>
</html>