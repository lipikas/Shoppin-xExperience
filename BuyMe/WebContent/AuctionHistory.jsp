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
	  body{
		font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
		font-size:16px;
	  }
	  table,
      th,
      td {
        padding: 6px;
        border: 2px solid lightgrey;
        border-collapse: collapse;
      }
      th{
      	font-weight: 520;
      }
      h2{
      	font-weight: 500;
      }
	</style>
	<body>	
	
			<h2>Bid History</h2>
			<% 
			
			String auction_history = request.getParameter("auction_history");
			String id = request.getParameter("c_id");
/* 			out.println(auction_history+ "\n");
			out.println(id); */
				
			
			  try {
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();	
					Statement stmt = con.createStatement();
					String str = "SELECT * FROM sells WHERE '" + auction_history + " = '" + id + "';";
					/* out.println("Hello"); */
					ResultSet result = stmt.executeQuery(str);
					/* out.println("00"); */
					
					if (result.next()){
						//Valid buyer/seller id
						String str2 = "SELECT * FROM sells, auctioncontains auc WHERE sells.item_id = auc.item_id AND sells.'" + auction_history + " = '" + id + "';";
						/* out.println("Hello"); */
						ResultSet result2 = stmt.executeQuery(str2); 
						/* out.println("Hi"); */
						out.print("<table>");
						out.print("<tr>");    
							out.print("<th> Auction_id </th>");  
							out.print("<th> Current Bid Price </th>");  
							out.print("<th> End Date </th>");  
							out.print("<th> End Time </th>"); 
							out.print("<th> Item_id </th>");
							out.print("<th> Highest Bidder_id </th>");
						out.print("</tr>"); 
						
						out.print("<tr>");    
						out.print("<td>" + result.getString("bid_id") +"</td>");
						out.print("<td>" + result.getString("current_price") +"</td>");
						out.print("<td>" + result.getString("end_time").split(" ")[0] +"</td>");
						out.print("<td>" + result.getString("end_time").split(" ")[1] +"</td>");
						out.print("<td>" + result.getString("item_id") +"</td>");
						out.print("<td>" + result.getString("creator_id") +"</td>");
						out.print("</tr>");  
						
						 
						while (result.next()) { 
								out.print("<tr>");    
								out.print("<td>" + result.getString("bid_id") +"</td>");
								out.print("<td>" + result.getString("current_price") +"</td>");
								out.print("<td>" + result.getString("end_time").split(" ")[0] +"</td>");
								out.print("<td>" + result.getString("end_time").split(" ")[1] +"</td>");
								out.print("<td>" + result.getString("item_id") +"</td>");
								out.print("<td>" + result.getString("creator_id") +"</td>");
								out.print("</tr>");  
							
						}
						out.print("</table>");
						
					} else {
						//Invalid auction_id
						out.println("Invalid buyer/seller id. Please try again!");
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
