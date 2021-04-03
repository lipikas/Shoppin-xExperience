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
			String aucid = request.getParameter("Auction ID");	
		
			
			
			try {
		 		ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				
				//get item id to delete from item
				
				Statement st = con.createStatement();
				String query = "SELECT item_id FROM auctioncontains WHERE auction_id ='" + aucid + "'";
				ResultSet result = st.executeQuery(query);
				int itemid = 0;
				while(result.next()){
					String str = result.getString("item_id");
					itemid = Integer.parseInt(str);
				}
				
				//delete from auctioncontains
				PreparedStatement ps = con.prepareStatement("DELETE FROM auctioncontains WHERE auction_id='"+aucid+"';");;
				ps.executeUpdate();
				
				//delete all bids pertaining to this auction
				PreparedStatement ps1 = con.prepareStatement("DELETE FROM bids WHERE auction_id = '" + aucid + "';");;
				ps1.executeUpdate();
				
				//delete item from items
				PreparedStatement ps2 = con.prepareStatement("DELETE FROM items WHERE item_id = '" + itemid + "';");;
				ps2.executeUpdate();
				
			
				out.println("Auction and all pertaining bids have been removed");
					%><a href="CustomerRepHome.jsp">Back to Homepage</a><%
					con.close();
					
				} catch (Exception e) {
					out.println("Error removing Auction!");
					%><a href="CustomerRepHome.jsp">Back to Homepage</a><%
					e.printStackTrace();
				}	
	
			
		%>
		
	</body>
</html>
