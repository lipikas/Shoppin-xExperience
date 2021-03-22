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
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			Boolean isStaff = request.getParameter("staff") == null ? false : true;
	 		try {
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				Statement stmt = con.createStatement();
				String str;
				if (isStaff){
					str = "SELECT * FROM Staff WHERE login='" + username + "' AND password='" + password + "';";
				} else {
					str = "SELECT * FROM Customers WHERE login='" + username + "' AND password='" + password + "';";;
				}
				ResultSet result = stmt.executeQuery(str);
				
				if (result.next()){
					//Valid username and password
					session.setAttribute("username", username);
					//get cid
					if (isStaff){
						session.setAttribute("id", result.getString("staff_id"));
					} else {
						session.setAttribute("id", result.getString("c_id"));
					}
					out.println("Welcome " + username);
					out.println("<br>");
					if (isStaff){
						out.println("<a href=\"StaffHome.jsp\">Continue to Home Page");
					} else {
						out.println("<a href=\"CustomerHome.jsp\">Continue to Home Page");
					}
				} else {
					//Invalid username / password
					out.println("Invalid username / password combination");
					out.println("<br>");
					out.println("<a href=\"Login.jsp\">Back to Login Page");
				}
				con.close();
			} catch (Exception e) {
				out.println("Error!");
				e.printStackTrace();
			}
		%>
	</body>
	
</html>