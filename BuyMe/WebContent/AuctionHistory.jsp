<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Auction History</title>
	</head>
	<style>
      body{
		font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; 
		font-size: 16px;
        color: rgb(46 45 45 / 85%);
        text-align: center;
        margin-top: 50px;
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
        text-align: center;
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
      div{
      	display: flex;
      	flex-direction: row;
      	justify-content: center;
      	align-content: center;
      }
	</style>
	<body>	
	
			<h2>Auction History</h2>
			<% 
			
			String auction_history = request.getParameter("auction_history");
			String id = request.getParameter("c_id");
	
			  try {
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();	
					Statement stmt = con.createStatement();
					String str;
				
					if(auction_history.compareTo("bc_id")==0){
						//out.print("Buyer"+id);
						str = "SELECT * FROM auctioncontains auc WHERE auc.creator_id != '" + id +"' AND auc.auction_id = ( SELECT DISTINCT bids.auction_id FROM bids, auctioncontains au WHERE bids.creator_id = '" + id +"' AND bids.auction_id = auc.auction_id);";
					}
					else {
						//out.print("Seller"+id);
						str = "SELECT * FROM auctioncontains auc WHERE auc.creator_id = '" + id + "';";
					}

					ResultSet result = stmt.executeQuery(str);
					
					if (result.next()){
						//Valid buyer/seller id
					
						
						 out.print("<div> <table>");
							out.print("<tr>");    
								out.print("<th> Auction_id </th>");  
								out.print("<th> Current Bid Price </th>");  
								out.print("<th> End Date </th>");  
								out.print("<th> End Time </th>"); 
								out.print("<th> Item_id </th>");
								out.print("<th> Seller_id </th>");
								out.print("<th> Highest Bidder_id </th>");
							out.print("</tr>"); 
							out.print("<tr>");    
							out.print("<td>" + result.getString("auction_id") +"</td>");
							out.print("<td>" + result.getString("current_price") +"</td>");
							out.print("<td>" + result.getString("end_time").split(" ")[0] +"</td>");
							out.print("<td>" + result.getString("end_time").split(" ")[1] +"</td>");
							out.print("<td>" + result.getString("item_id") +"</td>");
							out.print("<td>" + result.getString("creator_id") +"</td>");
							out.print("<td>" + result.getString("highest_bidder_id") +"</td>");
							out.print("</tr>");  
						while (result.next()) { 
								
								out.print("<tr>");    
								out.print("<td>" + result.getString("auction_id") +"</td>");
								out.print("<td>" + result.getString("current_price") +"</td>");
								out.print("<td>" + result.getString("end_time").split(" ")[0] +"</td>");
								out.print("<td>" + result.getString("end_time").split(" ")[1] +"</td>");
								out.print("<td>" + result.getString("item_id") +"</td>");
								out.print("<td>" + result.getString("creator_id") +"</td>");
								out.print("<td>" + result.getString("highest_bidder_id") +"</td>");
								out.print("</tr>");  
							
						}
						out.print("</table> </div>");
						
					} else {
						//Invalid auction_id
						out.println("Invalid buyer/seller id or buyer/seller hasn't participated in an auction. Please try again!");
						out.println("<br>");
					}
					con.close();
				} catch (Exception e) {
					out.println(e);
					e.printStackTrace();
				}
	    out.println("<br><br>");
		out.println("<a href=\"CustomerHome.jsp\"> Back to Home Page");
		%>
	    </body>
	   </html>
