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
		font-size: 16px;
        color: rgb(46 45 45 / 85%);
        text-align: center;
        margin-top: 50px;
	  }
	  div{
      	display: flex;
      	flex-direction: row;
      	justify-content: center;
      	align-content: center;
      }
	  h2{
      	font-size: 20px;
        font-weight: 500;
      }
	  table,
      th,
      td {
        padding: 6px;
        border: 2px solid lightgrey;
        border-collapse: collapse;
      }
      th{
      	font-weight: 490;
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
	<body>	
	
			<h2>Bid History</h2>
			<% 
			String auction = request.getParameter("auction");
			  try {
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();	
					Statement stmt = con.createStatement();
					String str = "SELECT * FROM Bids WHERE auction_id='" + auction + "';";
					
					ResultSet result = stmt.executeQuery(str);
					
					
					if (result.next()){
						//Valid auction_id
						/* String str2 = "SELECT * FROM Bids WHERE auction_id='" + auction + "' ORDER BY date DESC;";
						ResultSet result2 = stmt.executeQuery(str2); */
						
						out.print("<div> <table>");
						out.print("<tr>");    
							out.print("<th> Bid_id </th>");  
							out.print("<th> Bid Price </th>");  
							out.print("<th> Bidder Id </th>");
						out.print("</tr>"); 
						
						out.print("<tr>");    
						out.print("<td>");
						out.print(result.getString("bid_id"));
						out.print("</td>");
						out.print("<td>");
						out.print(result.getString("price"));
						out.print("</td>");
						out.print("<td>");
						out.print(result.getString("creator_id"));
						out.print("</td>");
						out.print("</tr>"); 
						
						 
						while (result.next()) { 
								out.print("<tr>");    
								out.print("<td>");
								out.print(result.getString("bid_id"));
								out.print("</td>");
								out.print("<td>");
								out.print(result.getString("price"));
								out.print("</td>");
								out.print("<td>");
								out.print(result.getString("creator_id"));
								out.print("</td>");
	 
							out.print("</tr>");  
							
						}
						out.print("</table> </div>");
						
						
					} else {
						//Invalid auction_id
						out.println("Invalid auction_id or No bids have been placed at this time.");
						out.println("<br>");
					}
					con.close();
				} catch (Exception e) {
					out.println("Error!");
					e.printStackTrace();
				}
		out.println("<br><br>");
		out.println("<a href=\"CustomerHome.jsp\"> Back to Home Page");
		%>
	    </body>
	   </html>
