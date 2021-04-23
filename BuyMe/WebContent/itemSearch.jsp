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
	<style>
      body{
		font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; 
		font-size: 16px;
        color: rgb(46 45 45 / 85%);
        text-align: center;
        margin-top: 50px;
	  }
	  h2{
      	font-size: 20px;
        font-weight: 500;
      }
	  table,
      th,
      td {
        padding: 6px;
        border: 2px solid lightgrey;
        border-collapse: collapse;
        text-align: center;
      }
      th{
      	font-weight: 490;
      }
      div{
      	display: flex;
      	flex-direction: row;
      	justify-content: center;
      	align-content: center;
      }
      
      a{
        border-style: initial;
        text-decoration: none;
	    background-color: rgb(230 230 230 / 87%);
	    color: #000000bd;
        border-radius: 15px;
        padding: 0.2rem 0.5rem;
        flex-direction: row; 
      }
      
      a:hover {
        background-color: #ddd;
        color: black;
      }

	</style>
	<body>
		<%
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String id = request.getParameter("item_id");
		String str = "SELECT * FROM sells WHERE item_id ='" + id + "';";
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
		out.print("Highest Bidder ID");
		out.print("</td>");
		out.print("<td>");
		out.print("Seller ID");
		out.print("</td>");
		out.print("<td>");
		out.print("Total made");
		out.print("</td>");
		out.print("</tr>");	
		while(result.next()){
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(result.getString("item_id"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("bc_id"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("sc_id"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("price"));
			out.print("</td>");
			out.print("</tr>");
		}
		out.print("</table>");
		out.println("<a href=\"AdminHome.jsp\"> Back to Home Page");
		con.close();
	%>
	
	</body>
</html>