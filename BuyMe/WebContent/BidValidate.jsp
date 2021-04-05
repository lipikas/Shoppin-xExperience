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
						%><a href="PlaceBid.jsp">Back to Place Bid</a><%
						
					}
					
					else if(currprice + bidinc > price){ //see if the bid is following bid_inc rules
						out.println("Bid amount does not follow bid increment rules. Please place higher bid");
						%><a href="PlaceBid.jsp">Back to Place Bid</a><%
					}
					
					else if(price <= currprice){
				    	out.println("Bid Amount is Lower Than Current Price. Please Place a Higher Bid");
				    	%><a href="PlaceBid.jsp">Back to Place Bid</a><%
				    	}
				    
				    	else{
				    	
				    	//Insert new bid into bids
						PreparedStatement ps = con.prepareStatement("INSERT INTO bids " +
								"(creator_id, auction_id, price) " +
								"VALUES ('"+ id +"','"+ auc_id +"','"+ amount +"');");
						ps.executeUpdate();
						out.println("Bid has been placed for $" + amount +" on auction with auction ID " + auc_id);
						out.println("<br>");
						%><a href="CustomerHome.jsp">Back to Homepage</a><%
						
						
						//update new item price and highest bidder
						PreparedStatement preps = con.prepareStatement("UPDATE auctioncontains SET current_price = '"+ price +"' WHERE auction_id='"+ auc_id +"'");
						preps.executeUpdate();	
						PreparedStatement prep1 = con.prepareStatement("UPDATE auctioncontains SET highest_bidder_id = '" + id +"' WHERE auction_id='" + auc_id+"'");
						prep1.executeUpdate();
				    }
					
					con.close();
					
				} catch (Exception e) {
					out.println("Error placing bid!");
					%><a href="CustomerHome.jsp">Back to Homepage</a><%
					e.printStackTrace();
				}	
			}
			
		%>
		
	</body>
</html>
