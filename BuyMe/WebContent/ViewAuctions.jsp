<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>BuyMe - Auctions</title>
	</head>
	
	<body>	
		
		<h2>All Ongoing Auctions</h2>
		
		 <% try{
			//get the connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String str = "SELECT * FROM auctioncontains";
			ResultSet result = stmt.executeQuery(str);
			%>
			
			<table>
				
				<%
				//parse out the results
				while (result.next()){ %>
					<tr>    
						<%out.println("Auction ID is: " + result.getString("auction_id"));%>
						<%out.println("Current Price is: " + result.getString("current_price"));%>
						<%out.println("End Time is: " + result.getString("end_time")); %>
						<%out.println("Bid Increment is: " + result.getString("bid_inc"));%>
						<%out.println("Minimum Price is: " + result.getString("min_price"));%>
						<%out.println("Item ID is: " + result.getString("item_id"));%>
						<br>
						<br>
					</tr>
				<%}
				//close the connection.
				db.closeConnection(con);
				%>
			</table>
			<%} catch (Exception e) {
			out.print(e);
			}%>
			
			<% out.println("<a href=\"PlaceBid.jsp\">Click Here to Place a Bid on an Auction"); %>
			
		
	</body>
</html>