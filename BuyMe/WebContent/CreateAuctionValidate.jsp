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
			String username = session.getAttribute("username").toString();
			String endtime = request.getParameter("endtime");
			String initialprice = request.getParameter("initialprice");
			String minprice = request.getParameter("minprice");
			String bidinc = request.getParameter("bidinc");
			String category = request.getParameter("category");
			String color = request.getParameter("color");
			String size = request.getParameter("size");
			String description = request.getParameter("description");
	 		try {
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
				//System.out.println(newItemId);
				//Insert new auction into auctioncontains				
 				ps = con.prepareStatement("INSERT INTO AuctionContains " +
 						"(current_price, end_time, bid_inc, min_price, item_id) " +
 						"VALUES ('"+ initialprice +"','"+ endtime +"','"+ bidinc +"','"+ minprice +"','"+ newItemId +"');");
 				ps.executeUpdate();				
				con.close();
			} catch (Exception e) {
				out.println("Error creating auction!");
				%><a href="CustomerHome.jsp">Back to Homepage</a><%
				e.printStackTrace();
			}
		%>
		<h3>Auction created</h3>
		<a href="CustomerHome.jsp">Back to Homepage</a>
	</body>
	
</html>





















