<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Alerts</title>
</head>
<body>
	<a href=CustomerHome.jsp>Home</a>
	<%
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String id = session.getAttribute("id").toString();
			ResultSet rs = stmt.executeQuery("SELECT * FROM Alerts WHERE c_id='"+ id +"'");
			while (rs.next()){
				out.println("<p>"+rs.getString("message")+"</p>");
			}
		    con.close();
		} 
		catch (Exception e) {
		    e.printStackTrace();
		    out.println("ERROR");
		}
	%>
</body>
</html>