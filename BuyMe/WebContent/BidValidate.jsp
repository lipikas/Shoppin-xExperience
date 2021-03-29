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
			String auc_id = request.getParameter("Auction ID");	
			String amount = request.getParameter("Bid Amount");	
			String max = request.getParameter("Upper Limit");
			
			double price = Double.parseDouble(amount);
			double upprice = Double.parseDouble(max);
			
			if(upprice < price){
				out.println("Please Enter an Upper Limit Greater Than or Equal to Bid Amount");
				%><a href="PlaceBid.jsp">Back to Place Bid</a><%
				
			}
			else{
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
					
				    if(price <= currprice){
				    	out.println("Bid Amount is Lower Than Current Price. Please Place a Higher Bid");
				    	%><a href="PlaceBid.jsp">Back to Place Bid</a><%
				    }
				    else{
				    	
				    	//Insert new bid into bids
				    	Statement state = con.createStatement();
				    	String qu = "SELECT a.creator_id FROM auctioncontains a WHERE a.auction_id ='" + auc_id +"'";
				    	ResultSet res = state.executeQuery(qu);
				     	String cid = "";
				    	while(res.next()){
				    		cid = res.getString("a.creator_id");
				    	}
						PreparedStatement ps = con.prepareStatement("INSERT INTO bids " +
								"(creator_id, auction_id, price, upper_limit) " +
								"VALUES ('"+ cid +"','"+ auc_id +"','"+ amount +"','"+ max +"');");
						ps.executeUpdate();
						out.println("Bid has been placed for $" + amount +" on auction with auction ID " + auc_id);
						out.println("<br>");
						%><a href="CustomerHome.jsp">Back to Homepage</a><%
						
						
						//update new item price  
						
						PreparedStatement preps = con.prepareStatement("UPDATE auctioncontains SET current_price = '"+ price +"' WHERE auction_id='"+ auc_id +"'");
						preps.executeUpdate();	
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
