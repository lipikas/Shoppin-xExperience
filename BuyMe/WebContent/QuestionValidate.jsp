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
			String question = request.getParameter("Question");	
			
			try {
		 		    ApplicationDB db = new ApplicationDB();
				    Connection con = db.getConnection();
				    
				    //insert question into the questions table. 
				    PreparedStatement ps = con.prepareStatement("INSERT INTO questions " + "(c_id, message, answered)" + "VALUES('" +id+ "','" +question+ "', 0);");
				    ps.executeUpdate();
				    out.println("Question has been posted. A customer representative will answer shortly");
				    out.println("<br>");
					%><a href="CustomerHome.jsp">Back to Homepage</a><%
					
					con.close();
					
				} catch (Exception e) {
					out.println("Error posting question!");
					%><a href="CustomerHome.jsp">Back to Homepage</a><%
					e.printStackTrace();
				}	
	
			
		%>
		
	</body>
</html>