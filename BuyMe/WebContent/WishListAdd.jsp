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
			String category = request.getParameter("category");
			String color = request.getParameter("color");
			String size = request.getParameter("size");
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			//Insert new item into items
			PreparedStatement ps = con.prepareStatement("INSERT INTO wanteditems (c_id, category, color, size) VALUES ('"+ id +"','"+ category +"','"+ color +"','"+ size +"');");
	 		try {	 			
				ps.executeUpdate();
				out.println("<p>Item added</p>");
			} catch (Exception e) {
				out.println("<p>Item already in WishList</p>");
				//e.printStackTrace();
			}
	 		con.close();
		%>
		<br>
		<a href="WishList.jsp">Back to WishList</a>
	</body>
	
</html>





















