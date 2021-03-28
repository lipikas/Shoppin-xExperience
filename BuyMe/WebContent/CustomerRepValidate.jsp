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
			String username = request.getParameter("Username");
			String password = request.getParameter("Password");
			String name = request.getParameter("Name");
			String number = request.getParameter("Phone Number");
			String email = request.getParameter("Email");
			
			try{
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				Statement stmt = con.createStatement();
				String str = "SELECT * FROM staff WHERE login='" + username + "'AND password='" + password + "';";
				ResultSet result = stmt.executeQuery(str);
				if (result.next()){
					//user already exist
					//Invalid username / password
					out.println("This Customer Rep Already Has An Account");
					out.println("<br>");
					out.println("<a href=\"AdminHome.jsp\">Go Back");
				} else {
					//Else start the session	
					PreparedStatement ps = con.prepareStatement("INSERT INTO staff "+
						"(name, phone, login, email, password, isCustomerRep) VALUES ('" + name + "','" + number + "','" + username + "','" + email + "','" + password + "','" + 1 + "');");
					ps.executeUpdate();	
					out.println("<a href=\"AdminHome.jsp\">Account Created");
				}
			con.close();
		} catch (Exception e) {
			out.println("Error!");
			e.printStackTrace();
		}
		%>
	</body>
	
</html>