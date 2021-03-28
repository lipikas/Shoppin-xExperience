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
			//out.println(auc_id);
			String date = request.getParameter("Date");
			//out.println(date);
			String amount = request.getParameter("Bid Amount");
			//out.println(amount);
			String max = request.getParameter("Upper Limit");
			//out.println(max);
			
	 		try {
	 			ApplicationDB db = new ApplicationDB();
			    Connection con = db.getConnection();
				//Insert new bid into bids
				PreparedStatement ps = con.prepareStatement("INSERT INTO bids " +
						"(auction_id, date, price, upper_limit) " +
						"VALUES ('"+ auc_id +"','"+ date +"','"+ amount +"','"+ max +"');");
				out.println("Bid has been placed for $" + amount +" on auction with auction ID " + auc_id);
				out.println("<br>");
				%><a href="CustomerHome.jsp">Back to Homepage</a><%
				ps.executeUpdate();
				
				//update new item price if bid is higher than previous price. 
				Statement st = con.createStatement();
				String query = "SELECT a.current_price FROM auctioncontains a WHERE a.auction_id ='" + auc_id + "'";
				ResultSet result = st.executeQuery(query);
				int currprice = 0;
				while(result.next()){
					String str = result.getString("a.current_price");
					currprice = Integer.parseInt(str);
				}
				
				int price = Integer.parseInt(amount);
				if(price > currprice){
					PreparedStatement preps = con.prepareStatement("UPDATE auctioncontains SET current_price = '"+ price +"' WHERE auction_id='"+ auc_id +"'");
					preps.executeUpdate();
				}
				con.close();
				
			} catch (Exception e) {
				out.println("Error placing bid!");
				%><a href="CustomerHome.jsp">Back to Homepage</a><%
				e.printStackTrace();
			}
	 		
		%>
		
	</body>
</html>
