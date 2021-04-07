<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>BuyMe</title>
	</head>
	<body>
	
		<%	
		
		    
			String id = session.getAttribute("id").toString();
			String qid = request.getParameter("QID");	
			String ans = request.getParameter("Answer");
			
			try {
		 		    ApplicationDB db = new ApplicationDB();
				    Connection con = db.getConnection();
				    
				    //update answer into the questions table. 
				    PreparedStatement preps = con.prepareStatement("UPDATE questions SET staff_id = '"+ id +"',answer = '"+ans+"', answered = 1  WHERE q_id='"+ qid +"'");
					preps.executeUpdate();	
				    out.println("Question " +qid+ " has been answered.");
				    out.println("<br>");
					%><a href="CustomerRepHome.jsp">Back to Homepage</a><%
					
					con.close();
					
				} catch (Exception e) {
					out.println("Error posting answer!");
					%><a href="CustomerRepHome.jsp">Back to Homepage</a><%
					e.printStackTrace();
				}	
	
			
		%>
		
	</body>
</html>