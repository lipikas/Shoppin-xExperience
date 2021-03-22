<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Bid History</title>
	</head>
	<style>
	  table,
      th,
      td {
        padding: 6px;
        border: 2px solid lightgrey;
        border-collapse: collapse;
      }
	</style>
	<body>	
	
			<h2>Bid History</h2>
			<% 
			String auction = request.getParameter("auction");
			  try {
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();	
					Statement stmt = con.createStatement();
					String str = "SELECT bid_id FROM bidon WHERE auction_id='" + auction + "';";
					
					ResultSet result = stmt.executeQuery(str);
					
					if (result.next()){
						//Valid auction_id
						String str2 = "SELECT * FROM Bidon b, Bids bs WHERE b.auction_id='" + auction + "' AND b.bid_id = bs.bid_id;";
						ResultSet result2 = stmt.executeQuery(str2);
						
						out.print("<table>");
						out.print("<tr>");    
							out.print("<th> Bid_id </th>");  
							out.print("<th> Price </th>");  
						out.print("<tr>");  
						
						while (result2.next()) { 
							out.print("<tr>");    
							
								out.print("<td>");
								out.print(result2.getString("bid_id"));
								out.print("</td>");
								
								out.print("<td>");
								out.print(result2.getString("price"));
								out.print("</td>");
	 
							out.print("<tr>");  
							
						}
						out.print("</table>");
						
						
					} else {
						//Invalid auction_id
						out.println("Invalid auction_id");
						out.println("<br>");
					}
					con.close();
				} catch (Exception e) {
					out.println("Error!");
					e.printStackTrace();
				}
	    out.println("<br>");
		out.println("<a href=\"CustomerHome.jsp\"> Back to Home Page");
		%>
	    </body>
	   </html>
	    