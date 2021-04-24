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
		String id = request.getParameter("user_id");
		/* String name = request.getParameter("user_name"); */
		String str = "select sum(price) as total, sc_id from sells Group By sc_id;";
		ResultSet result = stmt.executeQuery(str);
		%>
		<h2> User Report: </h2>
	<% 
		out.print("<div><table>");
		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("Customer ID");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Total Amount Earned");
		out.print("</td>");
		out.print("</tr>");	
		while(result.next()){
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//Print out current bar name:
			out.print(result.getString("sc_id"));
			out.print("</td>");
			out.print("<td>");
			//Print out current beer name:
			out.print(result.getString("total"));
			out.print("</td>");
			out.print("</tr>");
		}
		out.print("</table></div><br><br>");
		out.println("<a href=\"AdminHome.jsp\"> Back to Home Page");
		con.close();
	%>
	
	</body>
</html>
