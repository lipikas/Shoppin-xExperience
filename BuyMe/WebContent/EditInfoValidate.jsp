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
				//see if this is a valid customer
				Statement s = con.createStatement();
			    String q = "SELECT COUNT(*) FROM customers WHERE c_id = '" +cid+"'";
			    ResultSet r = s.executeQuery(q);
			    String count = "";
			    while(r.next()){
			    	count = r.getString("COUNT(*)");   	
			    }
			    int id = Integer.parseInt(count);
			    if(id == 0){
			    	out.println("Invalid Customer ID");
			    }
			    else{
			    	PreparedStatement preps = con.prepareStatement("UPDATE customers SET "+ category + " = '"+ newinfo +"' WHERE c_id = '"+ cid +"'");
					preps.executeUpdate();	
					out.println("<p>Information Updated</p>");
			    }
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
