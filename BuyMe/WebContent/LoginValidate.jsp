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
				String str1;
				String str2;
				String str3;
				if (isStaff){
					str1 = "SELECT * FROM Staff WHERE isAdmin='" + "1" + "' AND login='" + username + "' AND password='" + password + "';";
					ResultSet resulta = stmt.executeQuery(str1);
					if(resulta.next()){
						String id = resulta.getString("staff_id");
						session.setAttribute("id", id);
						out.println("Welcome " + username);
						out.println("<br>");
						out.println("<a href=\"AdminHome.jsp\">Continue to Home Page");
					}
					else{
						str2 = "SELECT * FROM Staff WHERE isCustomerRep='" + "1" + "' AND login='" + username +"' AND password='" + password +"';";
						ResultSet resultb = stmt.executeQuery(str2);
						if(resultb.next()){
							String id = resultb.getString("staff_id");
							session.setAttribute("id", id);
							out.println("Welcome " + username);
							out.println("<br>");
							out.println("<a href=\"CustomerRepHome.jsp\">Continue to Home Page");
						}
						else {
							//Invalid username / password
							out.println("Invalid username / password combination");
							out.println("<br>");
							out.println("<a href=\"Login.jsp\">Back to Login Page");
						}
					}
				} 
				else {
					str3 = "SELECT * FROM Customers WHERE login='" + username + "' AND password='" + password + "';";;
					ResultSet resultc = stmt.executeQuery(str3);
					
					if (resultc.next()){
						//Valid username and password
						session.setAttribute("username", username);
						//get cid
						String id = resultc.getString("c_id");
						session.setAttribute("id", id);
						
						out.println("Welcome " + username);
						out.println("<br>");
						out.println("<a href=\"CustomerHome.jsp\">Continue to Home Page");						
						
					} 
					else {
						//Invalid username / password
						out.println("Invalid username / password combination");
						out.println("<br>");
						out.println("<a href=\"Login.jsp\">Back to Login Page");
					}
				}
				con.close();
			} catch (Exception e) {
				out.println("Error!");
				e.printStackTrace();
			}
		%>
	</body>
	
</html>