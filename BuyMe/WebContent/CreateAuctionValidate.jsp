<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>
<!DOCTYPE html>
<html>

	<head>
	<meta charset="ISO-8859-1">
	<title>BuyMe</title>
	</head>
	
	<body>
		<%	
			LocalDateTime now = LocalDateTime.now(); 
		    String curTime = now.toString().split("T")[0];
			String endtime = request.getParameter("endtime");
			
			String time = endtime.split("T")[0];
		    String nextday = (now.plusDays(1)).toString().split("T")[0];
			
			String initialprice = request.getParameter("initialprice");
			String minprice = request.getParameter("minprice");
			String bidinc = request.getParameter("bidinc");
			String category = request.getParameter("category");
			String color = request.getParameter("color");
			String size = request.getParameter("size");
			String description = request.getParameter("description");
			
			
	 		try {
	 			/* if ((now.isAfter(date2))){ */
	 				
	 			if (Double.parseDouble(initialprice) <  Double.parseDouble(minprice) && time.compareTo(nextday) >=0){
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				//Insert new item into items
				PreparedStatement ps = con.prepareStatement("INSERT INTO Items " +
						"(category, color, size, description) " +
						"VALUES ('"+ category +"','"+ color +"','"+ size +"','"+ description +"');");
				ps.executeUpdate();
				//Get new item id
				String newItemId = "";
				Statement stmt = con.createStatement();
				String str = "SELECT max(item_id) FROM Items WHERE category='"+ category +"' AND color='"+ color +"' AND description='"+ description +"';";
				ResultSet result = stmt.executeQuery(str);
				while (result.next()){
					newItemId = (result.getString("max(item_id)"));					
				}
				//Insert new auction into auctioncontains
				String id = session.getAttribute("id").toString();
 				ps = con.prepareStatement("INSERT INTO AuctionContains " +
 						"(initial_price, current_price, startdate, end_time, bid_inc, min_price, item_id, creator_id, active) " +
 						"VALUES ('"+ initialprice +"','" + initialprice+"', '"+curTime+"' ,'"+ endtime +"','"+ bidinc +"','"+ minprice +"','"+ newItemId +"','"+ id +"',TRUE);");
 				ps.executeUpdate();
 				//Alert users who have the new item as a WishListed item
 				Statement alertstmt = con.createStatement();
 				ResultSet alertrs = alertstmt.executeQuery("SELECT c_id FROM wanteditems WHERE category='"+category+"' AND color='"+color+"' AND size='"+size+"';");
 				while (alertrs.next()){
 					PreparedStatement newalertstmt = con.prepareStatement("INSERT INTO alerts (c_id, message) VALUES ('"+alertrs.getString("c_id")+"', '"+
 						"New auction opened with WishListed item [ "+category+", "+color+", "+size+" ]');");
 					 newalertstmt.executeUpdate();
 				}
				con.close();
				out.println("Auction created");
	 			}
	 			else{
	 				out.println("Insert an auction end date later than today's date or insert intital price < min price");
	 			} 
			} catch (Exception e) {
				out.println("Error creating auction!");
				//e.printStackTrace();
			}
		%>
		
		<a href="CustomerHome.jsp">Back to Homepage</a>
	</body>
	
</html>