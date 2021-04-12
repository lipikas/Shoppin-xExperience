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
		String id = request.getParameter("item_id");
		String str = "SELECT * FROM items it, auctioncontains au WHERE it.item_id ='" + id + "'AND au.item_id ='" + id + "';";
		ResultSet result = stmt.executeQuery(str);
		%>
		<h1> Item: </h1>
		<% 
		out.print("<table>");
		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("item_id");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("category");
		out.print("</td>");
		out.print("<td>");
		out.print("color");
		out.print("</td>");
		out.print("<td>");
		out.print("size");
		out.print("</td>");
		out.print("<td>");
		out.print("description");
		out.print("</td>");
		out.print("<td>");
		out.print("Current Price");
		out.print("</td>");
		out.print("</tr>");	
		while(result.next()){
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//Print out current bar name:
			out.print(result.getString("item_id"));
			out.print("</td>");
			out.print("<td>");
			//Print out current beer name:
			out.print(result.getString("category"));
			out.print("</td>");
			out.print("<td>");
			//Print out current beer name:
			out.print(result.getString("color"));
			out.print("</td>");
			out.print("<td>");
			//Print out current beer name:
			out.print(result.getString("size"));
			out.print("</td>");
			out.print("<td>");
			//Print out current beer name:
			out.print(result.getString("description"));
			out.print("</td>");
			out.print("<td>");
			out.print("current_price");
			out.print("</td>");
			out.print("</tr>");
		}
		out.print("</table>");
		con.close();
	%>
	
	</body>
</html>