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
		
			String cid = request.getParameter("Customer ID");
		
			
	 		 try {
	 			
	 			ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
 				
				
				/* PreparedStatement prep1 = con.prepareStatement("UPDATE customers SET login = NULL WHERE c_id='"+cid+"';");;
				prep1.executeUpdate(); */
				
				//see if they placed any bids
				Statement state = con.createStatement();
				String queryy = "SELECT COUNT(*) FROM bids WHERE creator_id = '" + cid+"'";
				ResultSet resultt = state.executeQuery(queryy);
				int count = 0;
				while(resultt.next()){
					String str = resultt.getString("COUNT(*)");
					count = Integer.parseInt(str);
				}
				
				 if(count > 0){ //if they have bids then delete / update prices
					Statement stt = con.createStatement();
					String que = "SELECT bid_id, auction_id, price FROM bids WHERE creator_id = '" +cid+"'";
					ResultSet re = stt.executeQuery(que);
					
					while(re.next()){
						String bidid = re.getString("bid_id");
						String aucid = re.getString("auction_id");
						String str = re.getString("price");
						double bidprice = Double.parseDouble(str);
						

						Statement bids = con.createStatement();
						String bidq = "SELECT COUNT(*) FROM auctioncontains WHERE active = 1 AND auction_id ='" +aucid+"'";
						ResultSet b_res = bids.executeQuery(bidq);
						int ac_count = 0;
						while(b_res.next()){
							String b = b_res.getString("COUNT(*)");
							ac_count = Integer.parseInt(b);
						}
						if(ac_count == 0){
							
							PreparedStatement ps1 = con.prepareStatement("DELETE FROM bids WHERE bid_id ='"+bidid+"' AND auction_id='"+aucid+"';");;
							ps1.executeUpdate();
							
							continue;
						}
						//get curr price of auction
						Statement st1 = con.createStatement();
						String query1 = "SELECT current_price FROM auctioncontains WHERE auction_id ='" + aucid + "'";
						ResultSet result1 = st1.executeQuery(query1);
						double currprice = 0;
						while(result1.next()){
							String str1 = result1.getString("current_price");
							currprice = Double.parseDouble(str1);
						}
					 
						//delete from bids
						PreparedStatement ps1 = con.prepareStatement("DELETE FROM bids WHERE bid_id ='"+bidid+"' AND auction_id='"+aucid+"';");;
						ps1.executeUpdate();
						
						//have to update the highest price
						if(bidprice >= currprice){
							
							//count if there are any bids on the auction left after deleting
							Statement stat = con.createStatement();
							String quer = "SELECT COUNT(*) FROM bids WHERE auction_id = '" + aucid+"'";
							ResultSet res = stat.executeQuery(quer);
							int counter = 0;
							while(res.next()){
								String strng = res.getString("COUNT(*)");
								counter = Integer.parseInt(strng);
							}
						
							
							if(counter > 0){
								//get the next highest bid
								Statement st2 = con.createStatement();
								String query2 = "SELECT max(price) FROM bids WHERE auction_id = '" + aucid +"'";
								ResultSet result2 = st2.executeQuery(query2);
								double maxprice = 0;
								while(result2.next()){
									String string = result2.getString("max(price)");
									maxprice = Double.parseDouble(string);
								}
								//get the bid creator id to update the highest bidder
								Statement st3 = con.createStatement();
								String query3 = "SELECT creator_id FROM bids WHERE price= '" + maxprice+"' AND auction_id='" + aucid+"'";
								ResultSet result3 = st3.executeQuery(query3);
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
								ResultSet result4 = st4.executeQuery(query4);
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
						
					}//done going through result set 
					
				}//done with bids 	
				 
 
					
				//maybe need to delete all bids placed by others for this auction? 
				//delete any auctions that are active created by this account
				Statement st = con.createStatement();
				String query = "SELECT COUNT(*) FROM auctioncontains WHERE active != 0 AND creator_id = '" +cid+"'";
				ResultSet result = st.executeQuery(query);
				int a_count = 0;
				while(result.next()){
					String str = result.getString("COUNT(*)");
					a_count = Integer.parseInt(str);
						
				}
				if(a_count >0){
					
					Statement statement = con.createStatement();
					String findaids = "SELECT auction_id FROM auctioncontains WHERE active = 1 AND creator_id = '" +cid+"'";
					ResultSet findres = statement.executeQuery(findaids);
					//delete all bids placed in auctions created by this cid
					while(findres.next()){
						String auctionids = findres.getString("auction_id");
						PreparedStatement pre = con.prepareStatement("DELETE FROM bids WHERE auction_id = '" +auctionids+"';");;
						pre.executeUpdate();
						
					}
					 PreparedStatement ps = con.prepareStatement("DELETE FROM auctioncontains WHERE active = 1 AND creator_id='"+cid+"';");;
					ps.executeUpdate();
				}	
				
				//delete from customers and setting other attributes to null
				PreparedStatement preps2 = con.prepareStatement("UPDATE alerts SET c_id = NULL WHERE c_id='"+ cid +"';");
				preps2.executeUpdate();	
				
				PreparedStatement preps3 = con.prepareStatement("UPDATE questions SET c_id = NULL WHERE c_id='"+ cid +"';");
				preps3.executeUpdate();	
				
				PreparedStatement preps4 = con.prepareStatement("UPDATE sells SET bc_id = NULL WHERE bc_id='"+ cid +"';");
				preps4.executeUpdate();
				
				PreparedStatement prep5 = con.prepareStatement("UPDATE sells SET sc_id = NULL WHERE sc_id='"+ cid +"';");
				prep5.executeUpdate();
				
				PreparedStatement preps7 = con.prepareStatement("UPDATE wanteditems SET c_id = NULL WHERE c_id='"+ cid +"';");
				preps7.executeUpdate();
			
				PreparedStatement preps8 = con.prepareStatement("UPDATE auctioncontains SET highest_bidder_id = NULL WHERE highest_bidder_id='"+ cid +"';");
				preps8.executeUpdate();
				
				PreparedStatement preps9 = con.prepareStatement("UPDATE auctioncontains SET creator_id = NULL WHERE creator_id='"+ cid +"';");
				preps9.executeUpdate();
				
				PreparedStatement preps10 = con.prepareStatement("UPDATE bids SET creator_id = NULL WHERE creator_id='"+ cid +"';");
				preps8.executeUpdate();
					
				
				
			   PreparedStatement ps6 = con.prepareStatement("DELETE FROM customers WHERE c_id='"+cid+"';");;
				ps6.executeUpdate();
				
				out.println("<p>Account Deleted</p>");
				con.close(); 
				
			 }catch (Exception e) {
				out.println("<p>Error Deleting Account</p>");
				e.printStackTrace();
			}  
	 		
		%>
		<br>
		<a href="CustomerRepHome.jsp">Back to Homepage</a>
	</body>
	
</html>
