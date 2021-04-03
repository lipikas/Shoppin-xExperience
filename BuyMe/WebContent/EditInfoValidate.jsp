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
			String cid = request.getParameter("Customer ID");
			String category = request.getParameter("category");
			String newinfo = request.getParameter("Updated");
			
			if(category.equals("Username")){
				category = "login";
			}
			
			
	 		try {	
	 			
	 			ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				PreparedStatement preps = con.prepareStatement("UPDATE customers SET "+ category + " = '"+ newinfo +"' WHERE c_id = '"+ cid +"'");
				preps.executeUpdate();	
				out.println("<p>Information Updated</p>");
				con.close();
			} catch (Exception e) {
				out.println("<p>Error Updating Information</p>");
				e.printStackTrace();
			}
	 		
		%>
		<br>
		<a href="CustomerRepHome.jsp">Back to Homepage</a>
	</body>
	
</html>





















