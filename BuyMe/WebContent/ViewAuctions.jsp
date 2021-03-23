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
		<% out.println("<a href=\"PlaceBid.jsp\">Click Here to Place a Bid on an Auction</a>"); %>
		<br>
		 <% try{
			//get the connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String str = "SELECT * FROM auctioncontains";
			ResultSet result = stmt.executeQuery(str);
			%>
			
			<table border="1">
				<tr>
					<td>Auction ID</td>	<td>Current Bid</td> <td>End Date</td> <td>End Time</td> <td>Bid Increment</td>
					<td>Item Category</td> <td>Item Color</td> <td>Item Size</td> <td>Item Description</td>
				</tr>
				<%
				//parse out the results
				while (result.next()){ 
					//getting item data
					String color = "";
					String size = "";
					String category = "";
					String description = "";
					String itemid = result.getString("item_id");
					Statement st2 = con.createStatement();
					String query = "SELECT category, color, size, description FROM Items WHERE item_id='"+ itemid +"';";
					ResultSet rs = st2.executeQuery(query);
					while(rs.next()){
						category = rs.getString("category");
						color = rs.getString("color");
						size = rs.getString("size");
						description = rs.getString("description");
					}
					//filling out table row
				%>
					<tr>
						<td><%out.print(result.getString("auction_id"));%></td>
						<td><%out.print(result.getString("current_price"));%></td>
						<td><%out.print(result.getString("end_time").split(" ")[0]); %></td>
						<td><%out.print(result.getString("end_time").split(" ")[1]); %></td>
						<td><%out.print(result.getString("bid_inc"));%></td>
						<td><%=category%></td>
						<td><%=color%></td>
						<td><%=size%></td>
						<td><%=description%></td>
					</tr>
				<%}
				//close the connection.
				db.closeConnection(con);
				%>
			</table>
			<%} catch (Exception e) {
			out.print(e);
			}%>
			
			
			
		
	</body>
</html>