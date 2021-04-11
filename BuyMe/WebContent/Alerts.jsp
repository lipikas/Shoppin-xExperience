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
<style>
	body{
		font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; 
		font-size: 16px;
	    color: rgb(46 45 45 / 85%);
	    text-align: center;
	    margin-top: 50px;
	}
	a{
        border-style: initial;
        text-decoration: none;
	    background-color: rgb(230 230 230 / 87%);
	    color: #000000bd;
        border-radius: 15px;
        padding: 0.2rem 0.5rem;
        flex-direction: row; 
     }
      
     a:hover {
        background-color: #ddd;
        color: black;
     }
</style>
</head>
<body>
	<a href=CustomerHome.jsp>Back to Home page</a>
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