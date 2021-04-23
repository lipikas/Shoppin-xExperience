<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.text.ParseException,
java.text.DateFormat, java.text.SimpleDateFormat, java.util.Date"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Search Items</title>
	</head>
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
		String c = request.getParameter("category");
		String str = "select Sum(price) total, category from sells s, items it WHERE  it.item_id = s.item_id  AND category='" + c +"';";
		ResultSet result = stmt.executeQuery(str);
		%>
		<h1> Results: </h1>
		<% 
			out.print("<table>");
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Category");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Total Amount Made");
			out.print("</td>");
			out.print("</tr>");	
			while(result.next()){
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("category"));
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
	   
	


