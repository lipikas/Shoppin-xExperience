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
			String bidid = request.getParameter("Bid ID");	
			
			
			
			try {
		 		ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				
				//get the curr price of auction 
				Statement st = con.createStatement();
				String query = "SELECT a.current_price FROM auctioncontains a WHERE a.auction_id ='" + aucid + "'";
				ResultSet result = st.executeQuery(query);
				double currprice = 0;
				while(result.next()){
					String str = result.getString("a.current_price");
					currprice = Double.parseDouble(str);
				}
				
				//get the bid amount
				Statement st1 = con.createStatement();
				String query1 = "SELECT price FROM bids WHERE bid_id = '" + bidid +"'";
				ResultSet result1 = st1.executeQuery(query1);
				double bidprice = 0;
				while(result1.next()){
					String str = result1.getString("price");
					bidprice = Double.parseDouble(str);
				}
				
				
				//delete from bids
				PreparedStatement ps = con.prepareStatement("DELETE FROM bids WHERE bid_id ='"+bidid+"' AND auction_id='"+aucid+"';");;
				ps.executeUpdate();
				
				//compare bid amount and curr price and update the curr price if needed
				if(bidprice >= currprice){
					
					//count if there are any bids on the auction left after deleting
					
					Statement state = con.createStatement();
					String queryy = "SELECT COUNT(*) FROM bids WHERE auction_id = '" + aucid+"'";
					ResultSet resultt = state.executeQuery(queryy);
					int count = 0;
					while(resultt.next()){
						String str = resultt.getString("COUNT(*)");
						count = Integer.parseInt(str);
					}
					
					if(count > 0){
						//get the next highest bid
						Statement st2 = con.createStatement();
						String query2 = "SELECT max(price) FROM bids WHERE auction_id = '" + aucid +"'";
						ResultSet result2 = st.executeQuery(query2);
						double maxprice = 0;
						while(result2.next()){
							String str = result2.getString("max(price)");
							maxprice = Double.parseDouble(str);
						}
						//get the bid creator id to update the highest bidder
						Statement st3 = con.createStatement();
						String query3 = "SELECT creator_id FROM bids WHERE price= '" + maxprice+"' AND auction_id='" + aucid+"'";
						ResultSet result3 = st.executeQuery(query3);
						String highestid = "";
						while(result3.next()){
							highestid = result3.getString("creator_id");
						}
						
						//update price and highest bidder id
						PreparedStatement preps = con.prepareStatement("UPDATE auctioncontains SET current_price = '"+ maxprice +"' WHERE auction_id='"+ aucid +"'");
						preps.executeUpdate();	
						PreparedStatement preps1 = con.prepareStatement("UPDATE auctioncontains SET highest_bidder_id = '"+ highestid +"' WHERE auction_id='"+ aucid +"'");
						preps1.executeUpdate();
						
					}
	
					//have to change price to initial price
					else{
						
						//get initial price because there are no bids anymore
						Statement st4 = con.createStatement();
						String query4 = "SELECT initial_price FROM auctioncontains WHERE auction_id='" + aucid+"'";
						ResultSet result4 = st.executeQuery(query4);
						String pstring = "";
						double initprice = 0;
						while(result4.next()){
							pstring = result4.getString("initial_price");
							initprice = Double.parseDouble(pstring);
							
						}
						
						//update price and highest bidder id
						PreparedStatement preps = con.prepareStatement("UPDATE auctioncontains SET current_price = '"+ initprice +"' WHERE auction_id='"+ aucid +"'");
						preps.executeUpdate();	
						PreparedStatement preps1 = con.prepareStatement("UPDATE auctioncontains SET highest_bidder_id = NULL WHERE auction_id='"+ aucid +"'");
						preps1.executeUpdate();
						
						
					}
					
				}

					out.println("Bid has been removed");
					%><a href="CustomerRepHome.jsp">Back to Homepage</a><%
					con.close();
					
				} catch (Exception e) {
					out.println("Error removing bid!");
					%><a href="CustomerRepHome.jsp">Back to Homepage</a><%
					e.printStackTrace();
				}	
	
			
		%>
		
	</body>
</html>
