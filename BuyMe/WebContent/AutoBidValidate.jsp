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
			String id = session.getAttribute("id").toString();
			String auc_id = request.getParameter("Auction ID");	
			String amount = request.getParameter("Bid Amount");	
			String upper_limit = request.getParameter("Upper Limit");
			double price = Double.parseDouble(amount);
			try {
		 		    ApplicationDB db = new ApplicationDB();
				    Connection con = db.getConnection();
				    //compare curr price with bid
				    Statement st = con.createStatement();
					String query = "SELECT a.current_price FROM auctioncontains a WHERE a.auction_id ='" + auc_id + "'";
					ResultSet result = st.executeQuery(query);
					double currprice = 0;
					while(result.next()){
						String str = result.getString("a.current_price");
						currprice = Double.parseDouble(str);
					}
					//see if auction is still active and if bid is valid with bid increment
					Statement st1 = con.createStatement();
					String query1 = "SELECT a.active, a.bid_inc FROM auctioncontains a WHERE a.auction_id = '" + auc_id + "'";
					ResultSet result1 = st1.executeQuery(query1);
					int isactive = 0;
					double bidinc = 0;
					while(result1.next()){
						String str = result1.getString("a.active");
						String str1 = result1.getString("a.bid_inc");
						isactive = Integer.parseInt(str);
						bidinc = Double.parseDouble(str1);
					}
					if(isactive == 0){
						out.println("This auction is not active. Please bid on an ongoing auction");
						%><a href="AutoBid.jsp">Back to Place Bid</a><%
						
					}
					else if(currprice + bidinc > price){ //see if the bid is following bid_inc rules
						out.println("Bid amount does not follow bid increment rules. Please place higher bid");
						%><a href="AutoBid.jsp">Back to Place Bid</a><%
					}
					else if(price <= currprice){
				    	out.println("Bid Amount is Lower Than Current Price. Please Place a Higher Bid");
				    	%><a href="AutoBid.jsp">Back to Place Bid</a><%
				    	}
				    else{
				    	//Insert new bid into bids
						PreparedStatement ps = con.prepareStatement("INSERT INTO bids " +
								"(creator_id, auction_id, price, upper_limit) " +
								"VALUES ('"+ id +"','"+ auc_id +"','"+ amount +"', '"+upper_limit+"');");
						ps.executeUpdate();
						out.println("AutoBid has been placed for $" + amount +" on auction with auction ID " + auc_id);
						out.println("<br>");
						%><a href="CustomerHome.jsp">Back to Homepage</a><%
						//update new item price and highest bidder
						PreparedStatement preps = con.prepareStatement("UPDATE auctioncontains SET current_price = '"+ price +"' WHERE auction_id='"+ auc_id +"'");
						preps.executeUpdate();	
						PreparedStatement prep1 = con.prepareStatement("UPDATE auctioncontains SET highest_bidder_id = '" + id +"' WHERE auction_id='" + auc_id+"'");
						prep1.executeUpdate();
						//alert previous bidders of the auction that a higher bid has been placed
				    	Statement alert_statement = con.createStatement();
				    	ResultSet alert_rs = alert_statement.executeQuery("SELECT  DISTINCT creator_id FROM bids WHERE auction_id='"+auc_id+"';");
				    	while (alert_rs.next()) {
				    		String alert_id = alert_rs.getString("creator_id");
				    		String alert_str = "INSERT INTO alerts (c_id, message) VALUES ('"+alert_id+"', '"+"New highest bid " +
				    				"placed for auction: "+auc_id+" new price: "+price+"');";
				    		PreparedStatement alert_ps = con.prepareStatement(alert_str);
				    		alert_ps.executeUpdate();		
				    	}
				    	//AUTO BIDDING
				    	//check if there is another autobidder whos upper_limit has not been reached on this auction, there can only be one at a time
				    	System.out.println(1);
				    	Statement autobid_stmt = con.createStatement();
				    	ResultSet autobid_rs = autobid_stmt.executeQuery("SELECT DISTINCT creator_id, upper_limit FROM bids WHERE auction_id='"+auc_id
				    			+"' AND upper_limit > "+price+" AND creator_id <> '"+id+"' ;");
				    	String competitor_id = null;
				    	double competitor_upper_limit = 0f;
				    	double user_upper_limit = Float.parseFloat(upper_limit);
				    	System.out.println(2);
				    	while (autobid_rs.next()) {
				    		competitor_id = autobid_rs.getString("creator_id");
				    		competitor_upper_limit = autobid_rs.getFloat("upper_limit");
				    		if (competitor_id.compareTo(id) == 0) {
				    			competitor_id = null;
				    		}
				    		System.out.println("comp_id: "+competitor_id);
				    		System.out.println("comp_upper: "+competitor_upper_limit);
				    	}
				    	System.out.println(3);
				    	String winner_id = null;
				    	String loser_id = null;
				    	double loser_upper_limit = 0f;
				    	double winner_upper_limit = 0f;
				    	//make sure there is a competitor and that the difference of upperlimits can be surpassed by a single bid
				    	if (competitor_id != null && Math.abs(competitor_upper_limit - user_upper_limit) >= bidinc){
				    		System.out.println(4);
				    			if (competitor_upper_limit > user_upper_limit) {
				    				winner_id = competitor_id;
				    				loser_id = id;
				    				loser_upper_limit = user_upper_limit;
				    				winner_upper_limit = competitor_upper_limit;
				    			} else {
				    				winner_id = id;
				    				loser_id = competitor_id;
				    				loser_upper_limit = competitor_upper_limit;
				    				winner_upper_limit = user_upper_limit;
				    			}
				    			//calculate new highest bid by incrementing the current price by bid_inc until we pass the upper_limit of the loser
				    			double new_highest_bid = price;
				    			while (new_highest_bid <= loser_upper_limit){
				    				new_highest_bid += bidinc;
				    			}
				    			//update with the new highest bid
				    			PreparedStatement bidwar_ps = con.prepareStatement("UPDATE auctioncontains SET current_price = '"+
				    			new_highest_bid +"', highest_bidder_id='"+winner_id+"' WHERE auction_id='"+ auc_id +"'");
				    			bidwar_ps.executeUpdate();	
				    			bidwar_ps = con.prepareStatement("INSERT INTO bids " +
										"(creator_id, auction_id, price, upper_limit) " +
										"VALUES ('"+ winner_id +"','"+ auc_id +"','"+ new_highest_bid +"', '"+winner_upper_limit+"');");
				    			bidwar_ps.executeUpdate();
				    			//alert the loser that they have been out-bidded
				    			bidwar_ps = con.prepareStatement("INSERT INTO alerts (c_id, message) VALUES ('"+
				    				loser_id+"',  'New highest bid placed for auction: "+auc_id+" new price: "+new_highest_bid+"');");
				    			bidwar_ps.executeUpdate();
				    	}
				    	//END OF AUTO BIDDING
				    }
					con.close();
				} catch (Exception e) {
					out.println("Error placing bid!");
					%><a href="CustomerHome.jsp">Back to Homepage</a><%
					//e.printStackTrace();
				}	
		%>
	</body>
</html>
