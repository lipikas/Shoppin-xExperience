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

		</style>
	<body>
	<%
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String str = "SELECT SUM(price) total FROM sells;";
		ResultSet result = stmt.executeQuery(str);
		
	%>
	<h2> Total Earnings:</h2>
	 <% 
	 while(result.next()){
	 	out.println(result.getString("total")); 
	 }
	 	
		con.close();
	%>
	
	</body>
</html>