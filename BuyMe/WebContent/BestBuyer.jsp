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
		String str = "select Sum(price) total, bc_id from sells group by(bc_id) order by total desc limit 3;";
		ResultSet result = stmt.executeQuery(str);
		
	%>
	<h1> Best Sellers:</h1>
	<% 
		out.print("<table>");
	
		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("price total");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("customer id");
		out.print("</td>");
		out.print("</tr>");	
		while (result.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//Print out current bar name:
			out.print(result.getString("price"));
			out.print("</td>");
			out.print("<td>");
			//Print out current beer name:
			out.print(result.getString("bc_id"));
			out.print("</td>");
			out.print("<td>");
			out.print("</tr>");

		}
		out.print("</table>");
	
		con.close();
	%>
	
	</body>
</html>