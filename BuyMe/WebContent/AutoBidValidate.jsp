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
			String bid_inc = request.getParameter("Auto Inc");
			double oldPrice = 0f;
			double price = Double.parseDouble(amount);
			try {
		 		    ApplicationDB db = new ApplicationDB();
				    Connection con = db.getConnection();
				    //compare curr price with bid
				    Statement s = con.createStatement();
				    String q = "SELECT creator_id FROM auctioncontains WHERE auction_id = '" +auc_id+"'";
				    ResultSet r = s.executeQuery(q);
				    String creator = "";
				    while(r.next()){
				    	creator = r.getString("creator_id");   	
				    }
				    if(id.equals(creator)){
				    	out.println("Auction Creator Cannot Bid on This Auction");
				    	%><a href="PlaceBid.jsp">Back to Place Bid</a><%
				    }
				    else{
				    Statement st = con.createStatement();
					String query = "SELECT a.current_price FROM auctioncontains a WHERE a.auction_id ='" + auc_id + "'";
					ResultSet result = st.executeQuery(query);
					double currprice = 0;
					while(result.next()){
						String str = result.getString("a.current_price");
						currprice = Double.parseDouble(str);
						oldPrice = currprice;
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
					} else if (Float.parseFloat(bid_inc) < bidinc){
						out.println("AutoBid increment is lower than the bid increment of the auction");
						%><a href="AutoBid.jsp">Back to Place Bid</a><%
					}
					else if(price <= currprice){
				    	out.println("Bid Amount is Lower Than Current Price. Please Place a Higher Bid");
				    	%><a href="AutoBid.jsp">Back to Place Bid</a><%
				    	}
				    else{
				    	//Insert new bid into bids
						PreparedStatement ps = con.prepareStatement("INSERT INTO bids " +
								"(creator_id, auction_id, price, upper_limit, auto_inc) " +
								"VALUES ('"+ id +"','"+ auc_id +"','"+ amount +"', '"+upper_limit+"', '"+bid_inc+"');");
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
				    	Statement autobid_stmt = con.createStatement();
				    	ResultSet autobid_rs = autobid_stmt.executeQuery("SELECT DISTINCT creator_id, upper_limit, auto_inc FROM bids WHERE auction_id='"+auc_id
				    			+"' AND upper_limit > "+price+" AND creator_id <> '"+id+"' ;");
				    	String competitor_id = null;
				    	double competitor_upper_limit = 0f;
				    	double competitor_inc = 0f;
				    	double user_upper_limit = Float.parseFloat(upper_limit);
				    	double user_inc = Float.parseFloat(bid_inc);
				    	while (autobid_rs.next()) {
				    		competitor_id = autobid_rs.getString("creator_id");
				    		competitor_upper_limit = autobid_rs.getFloat("upper_limit");
				    		competitor_inc = autobid_rs.getFloat("auto_inc");
				    		if (competitor_id.compareTo(id) == 0) {
				    			competitor_id = null;
				    		}
				    		System.out.println("comp_id: "+competitor_id);
				    		System.out.println("comp_upper: "+competitor_upper_limit);
				    		System.out.println("comp_inc: "+competitor_inc);
				    	}
				    	String winner_id = null;
				    	String loser_id = null;
				    	double loser_upper_limit = 0f;
				    	double winner_upper_limit = 0f;
				    	double winner_inc = 0f;
				    	double winner_cur = 0f;
				    	double cur = oldPrice;
				    	//make sure there is a competitor
				    	if (competitor_id != null ){
				    		double competitor_curr = oldPrice;
				    		short lastBidder = 0;//0 for user, 1 for competitor
				    		while (true) {
				    			if (lastBidder == 0) {
				    				if (cur + competitor_inc <= competitor_upper_limit) {
				    					//competitor places bid
				    					cur += competitor_inc;
				    					System.out.println("comp bid: " + cur);
				    					lastBidder = 1;
				    					continue;
				    				} else {
				    					//user could not bid once more, so the competitor wins
				    					System.out.println("user won");
				    					winner_id = id;
				    					loser_id = competitor_id;
					    				loser_upper_limit = competitor_upper_limit;
					    				winner_upper_limit = user_upper_limit;
					    				winner_inc = user_inc;
					    				winner_cur = cur;
					    				break;
				    				}
				    			}
			    				if (lastBidder == 1) {
				    				if (cur + user_inc <= user_upper_limit) {
				    					//user places bid
				    					cur += user_inc;
				    					System.out.println("user bid: " + cur);
				    					lastBidder = 0;
				    					continue;
				    				} else {
				    					//competitor is the winner
				    					System.out.println("comp won");
				    					winner_id = competitor_id;
					    				loser_id = id;
					    				loser_upper_limit = user_upper_limit;
					    				winner_upper_limit = competitor_upper_limit;
					    				winner_inc = competitor_inc;
					    				winner_cur = cur;
					    				break;
				    				}
				    			}
				    		}
				    			//update with the new highest bid
				    			PreparedStatement bidwar_ps = con.prepareStatement("UPDATE auctioncontains SET current_price = '"+
				    			cur +"', highest_bidder_id='"+winner_id+"' WHERE auction_id='"+ auc_id +"'");
				    			bidwar_ps.executeUpdate();	
				    			bidwar_ps = con.prepareStatement("INSERT INTO bids " +
										"(creator_id, auction_id, price, upper_limit, auto_inc) " +
										"VALUES ('"+ winner_id +"','"+ auc_id +"','"+ cur +"', '"+winner_upper_limit+"', '"+winner_inc+"');");
				    			bidwar_ps.executeUpdate();
				    			//alert previous bidders of the new highest bid
				    			alert_rs = alert_statement.executeQuery("SELECT  DISTINCT creator_id FROM bids WHERE auction_id='"+auc_id+"';");
						    	while (alert_rs.next()) {
						    		String alert_id = alert_rs.getString("creator_id");
						    		String alert_str = "INSERT INTO alerts (c_id, message) VALUES ('"+alert_id+"', '"+"New highest bid " +
						    				"placed for auction: "+auc_id+" new price: "+cur+"');";
						    		PreparedStatement alert_ps = con.prepareStatement(alert_str);
						    		alert_ps.executeUpdate();		
						    	}
				    	}
				    	//END OF AUTO BIDDING
				    }
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
