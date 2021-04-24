<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.text.ParseException,
java.text.DateFormat, java.text.SimpleDateFormat, java.util.Date"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Search Items</title>
	</head>
	<style>
      body{
		font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; 
		font-size: 16px;
        color: rgb(46 45 45 / 85%);
        text-align: center;
        margin-top: 50px;
	  }
	  h2{
      	font-size: 20px;
        font-weight: 500;
      }
	  table,
      th,
      td {
        padding: 6px;
        border: 2px solid lightgrey;
        border-collapse: collapse;
        text-align: center;
      }
      th{
      	font-weight: 490;
      }
      div{
      	display: flex;
      	flex-direction: row;
      	justify-content: center;
      	align-content: center;
      }
      
      a{
        border-style: initial;
        text-decoration: none;
	    background-color: rgb(230 230 230 / 87%);
	    color: #000000bd;
        border-radius: 15px;
        padding: 0.2rem 0.5rem;
        flex-direction: row; 
      }
      
      a:hover {
        background-color: #ddd;
        color: black;
      }

	</style>
	<body>	
	<%//START OF AUCTION UPDATING
			//close old auctions
			long currTime = new Date().getTime();
			ApplicationDB db0 = new ApplicationDB();
			Connection con0 = db0.getConnection();
			Statement stmt0 = con0.createStatement();
			String q = "SELECT * FROM AuctionContains WHERE active IS NULL OR active=true";
			ResultSet rs0 = stmt0.executeQuery(q);
			while (rs0.next()){
				String cur = rs0.getString("end_time");
				SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", java.util.Locale.getDefault());
				Date date = fmt.parse(cur);
				long endms = date.getTime();
				if (endms < currTime) {
					//close the expired auction
					String curId = rs0.getString("auction_id");
					PreparedStatement ps = con0.prepareStatement("UPDATE AuctionContains SET active=false WHERE auction_id='"+ curId +"'");
					ps.executeUpdate();
					//add sold item to Sells table
					String minPrice = rs0.getString("min_price");
					String bc_id = rs0.getString("highest_bidder_id");
					String sc_id = rs0.getString("creator_id");
					String item_id = rs0.getString("item_id");
					String finalPrice = rs0.getString("current_price");
					String endDate = rs0.getString("end_time");
					//only add item if the highest bid > min price to be sold at and someone actually bidded on it
					if (Float.valueOf(finalPrice) >= Float.valueOf(minPrice) && bc_id != null) {
						PreparedStatement sellsPS = con0.prepareStatement("INSERT INTO Sells (bc_id, sc_id, date, item_id, price) VALUES"
								+ "('"+bc_id+"','"+sc_id+"','"+endDate+"','"+item_id+"','"+finalPrice+"');");
						sellsPS.executeUpdate();
						//Alert the winner that they won the auction
						String winmsg = "You won auction:" + curId + " for item:" + item_id;
						sellsPS = con0.prepareStatement("INSERT INTO Alerts (c_id, message) VALUES ('"+ bc_id +"', '"+ winmsg +"');");
						sellsPS.executeUpdate();
					}
				}
			}
			con0.close();
		//END OF AUCTION UPDATING%>
			<h2>Search your Items</h2>
			
			<% 
			String category = request.getParameter("Category");
			String color = request.getParameter("Color");
			String size = request.getParameter("size");
			String sort = request.getParameter("Sort");
			String group = "";
			
	/* 		out.println("Category" + category);
			out.println("Color" + color); 
			out.println("size" + size); 
			*/
			if(sort.compareTo("inc_price")==0){
				group = group.concat("ASC");
			}
			else if(sort.compareTo("dec_price")==0){
				group = group.concat("DESC");
			}
			out.print(" <br>");
			
			  try {
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();	
					Statement stmt = con.createStatement();
					String str = "SELECT * FROM items it, auctioncontains auc WHERE auc.item_id = it.item_id AND (auc.active IS NULL OR auc.active=true) ";
					
					if(color.compareTo("any")==0 && size.compareTo("")==0){ // null size and color
						str = str.concat("AND it.category = '" + category + "' ORDER BY auc.current_price "+ group +";");
					}
					else if(color.compareTo("any")==0){ // null color
						str = str.concat("AND it.category = '" + category + "' AND it.size = '"+ size+ "' ORDER BY auc.current_price "+ group +";");
					}
					else if(size.compareTo("")==0){// null size
						str = str.concat("AND it.category = '" + category + "' AND it.color = '"+ color + "' ORDER BY auc.current_price "+ group +";");
					}
					else{
						str = str.concat(" AND it.category = '" + category +"' AND it.color = '"+ color + "' AND it.size = '"+ size+ "' ORDER BY auc.current_price "+ group +";");
					}
					ResultSet result = stmt.executeQuery(str);
			
					
					if (result.next()){
						//Valid query - user inputted data
						
						out.print("<div><table>");
						out.print("<tr>");   
							out.print("<th> Auction_id </th>"); 
							out.print("<th> Item_id </th>");  
							out.print("<th> Item Name </th>"); // same as Item Description?
							out.print("<th> Item Category </th>"); 
							out.print("<th> Item Color </th>"); 
							out.print("<th> Item Size </th>"); 
							out.print("<th> Current Bid Price </th>"); 
							out.print("<th> Seller Id </th>");  
							out.print("<th> Current Highest Bidder Id </th>");  
						out.print("</tr>");  
						
						out.print("<tr>");    
						out.print("<td>" + result.getString("auction_id") +"</td>");
						out.print("<td>" + result.getString("item_id") +"</td>");
						out.print("<td>" + result.getString("description") +"</td>");
						out.print("<td>" + result.getString("category") +"</td>");
						out.print("<td>" + result.getString("color") +"</td>");
						out.print("<td>" + result.getString("size") +"</td>");
						out.print("<td>" + result.getString("current_price") +"</td>");
						out.print("<td>" + result.getString("creator_id") +"</td>");
						out.print("<td>" + result.getString("highest_bidder_id") +"</td>");
						out.print("</tr>"); 
						
						while (result.next()) { 
							out.print("<tr>");    
							out.print("<td>" + result.getString("auction_id") +"</td>");
							out.print("<td>" + result.getString("item_id") +"</td>");
							out.print("<td>" + result.getString("description") +"</td>");
							out.print("<td>" + result.getString("category") +"</td>");
							out.print("<td>" + result.getString("color") +"</td>");
							out.print("<td>" + result.getString("size") +"</td>");
							out.print("<td>" + result.getString("current_price") +"</td>");
							out.print("<td>" + result.getString("creator_id") +"</td>");
							out.print("<td>" + result.getString("highest_bidder_id") +"</td>");
							out.print("</tr>"); 			
						}
						
						out.print("</table></div> <br>");
					
					} else {
						//InValid query
						out.println("We have no items available at this time with the matching search requirements.");
						out.println("<br><br><br>");
					}
					con.close();
				} catch (Exception e) {
					out.println("<br><br>" + e);
					e.printStackTrace();
				}
			  
			  try {
						ApplicationDB db = new ApplicationDB();	
						Connection con = db.getConnection();	
						Statement stmt = con.createStatement(); 
						LocalDateTime now = LocalDateTime.now(); 
					    String curTime = now.toString().split("T")[0];
					    LocalDateTime day = now.minusMonths(1);
					    String lastmonth = (day.plusDays(1)).toString().split("T")[0];
						String str = "SELECT * FROM items it, auctioncontains auc WHERE auc.item_id = it.item_id AND it.category = '" + category +"' AND auc.startdate <= '" + curTime + "' and auc.startdate >='"+ lastmonth +"';";
					
						out.println("<h2>Similar Items in Preceding Month</h2>");
					  
						ResultSet result2 = stmt.executeQuery(str);	
						
						if (result2.next()){
						out.print("<br><div><table>");
						out.print("<tr>");   
							out.print("<th> Auction_id </th>"); 
							out.print("<th> Item_id </th>");  
							out.print("<th> Item Name </th>"); // same as Item Description?
							out.print("<th> Item Category </th>"); 
							out.print("<th> Item Color </th>"); 
							out.print("<th> Item Size </th>"); 
							out.print("<th> Current Bid Price </th>"); 
							out.print("<th> Seller Id </th>");  
							out.print("<th> Current Highest Bidder Id </th>");  
						out.print("</tr>");  
						
						out.print("<tr>");    
						out.print("<td>" + result2.getString("auction_id") +"</td>");
						out.print("<td>" + result2.getString("item_id") +"</td>");
						out.print("<td>" + result2.getString("description") +"</td>");
						out.print("<td>" + result2.getString("category") +"</td>");
						out.print("<td>" + result2.getString("color") +"</td>");
						out.print("<td>" + result2.getString("size") +"</td>");
						out.print("<td>" + result2.getString("current_price") +"</td>");
						out.print("<td>" + result2.getString("creator_id") +"</td>");
						out.print("<td>" + result2.getString("highest_bidder_id") +"</td>");
						out.print("</tr>"); 
						
						while (result2.next()) { 
							out.print("<tr>");    
							out.print("<td>" + result2.getString("auction_id") +"</td>");
							out.print("<td>" + result2.getString("item_id") +"</td>");
							out.print("<td>" + result2.getString("description") +"</td>");
							out.print("<td>" + result2.getString("category") +"</td>");
							out.print("<td>" + result2.getString("color") +"</td>");
							out.print("<td>" + result2.getString("size") +"</td>");
							out.print("<td>" + result2.getString("current_price") +"</td>");
							out.print("<td>" + result2.getString("creator_id") +"</td>");
							out.print("<td>" + result2.getString("highest_bidder_id") +"</td>");
							out.print("</tr>"); 			
						}
						out.print("</table></div>");
						}
						else out.println("</br>No similar items exists in the past month.<br>");
			
						con.close();
				} catch (Exception e) {
						out.println("<br> <br>" + e);
						e.printStackTrace();
				}
			  
			  
 	    out.println("<br><br>");
		out.println("<a href=\"CustomerHome.jsp\"> Back to Home Page");
		%>
		
	    </body>
	   </html>
	   
	


