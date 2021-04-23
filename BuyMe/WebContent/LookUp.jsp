<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Buy Me</title>
	</head>
		<style>
	      body{
			font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; 
			font-size: 16px;
	        color: rgb(46 45 45 / 85%);
	        margin-top: 50px;
		  }
		  h2{
	      	font-size: 20px;
	        font-weight: 500;
	        text-align: center;
	      }
		 .container {
			  display: flex;
			  flex-direction: row;
			  justify-content:center;
			  align-content: center;
			  gap: 5rem;
	      }
	      .level{
	      	  padding: 1rem 3rem;
			  /* rgb(196 104 104 / 42%); */
			  border-radius: 10px;
			  width: 25%;
			  height: 18rem;
			  overflow: auto;
	      }
		  .auction{
	      	display: flex;
	      	flex-direction: column;
	      	justify-content: center;
	      	align-content: center;
	      }
		  table,
	      th,
	      td {
	        padding: 6px;
	        border: 2px solid lightgrey;
	        border-collapse: collapse;
	      }
	      th{
	      	font-weight: 490;
	      }
      #submit {
        font-size: 12.2px;
        border-style: initial;
        text-decoration: none;
        background-color: rgb(46, 45, 45);
        color: rgb(241, 239, 239);
        border-radius: 15px;
        padding: 0.15rem 0.25rem;
        margin: 0.5rem 5rem;
        align-content: center;
        justify-content: center;
        text-align: center;
      }
      .info{
      	margin: 0rem 14rem;
      	text-align: center;
      }
      
     
	</style>	      
	<body>
	<div class = "container">
        
 		<div class = "level">
 		<h2>Item ID</h2>
         <form method="POST" action="itemSearch.jsp">
          <p>
            Enter Item ID:
            <input type="number" name="item_id" id="item_id" required min="1" />
          </p>
          <input type="submit" value="Submit" id="submit" />
        </form>
      </div>
   
        
		<div class = "level">
		<h2>Item Type</h2>
        <form id = "search" method="POST" action="SearchItemsAdmin.jsp"> <!-- //Search by functionality -->
		<p>
			Select Category:
	       	<select name="Category" id="category">
	       	    <option value="shirt">Shirts</option>
	   			<option value="pant">Pants</option>
	   			<option value="shoe">Shoes</option>
	   		</select>
   		</p>
   		<p>
   			Select Color:
	   		<select name="Color" id="color">
	   				<option value="any">Any Color</option>
		        	<option value="red">Red</option>
		        	<option value="orange">Orange</option>
		        	<option value="yellow">Yellow</option>
		        	<option value="green">Green</option>
		        	<option value="blue">Blue</option>
		        	<option value="purple">Purple</option>
		        	<option value="white">White</option>
		        	<option value="black">Black</option>
		        	<option value="gray">Gray</option>
	   		</select>
	   	</p>
   		<label id = "sizeName"> Size</label>
   		<input type="number" name="size" min="1" max="20" id = "one">
   		<p>
   			Sort By:
			<select name="Sort" id="sort">
			    	<option value="dec_price">Decreasing price</option>
			   		<option value="inc_pric">Increasing price</option>
			   		<!-- 	<option value="auction">Soonest Auction Closing</option> -->
			</select>
			
	   </p>

	        <input type="submit" value="Submit" id="submit" />
       </form>
        </div>
        
		<div class = "level">
		<h2>Bidder ID</h2>
        <form method="POST" action="SearchUser.jsp">
          <p>
          	Enter Bidder id:
            <input type="number" name="user_id" id="user_id" required min="1" />
          </p>
          <!-- <p>
          	Enter Bidder username:
            <input type="text" name="user_name" id="user_name" />
          </p> -->
          <input type="submit" value="Submit" id="submit" />
        </form>
        </div>
    </div>
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
    <div class = "auction">
    <div class = "info">
    <h2>Auction History</h2>
		<br>
		 <% try{
			//get the connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String str = "SELECT * FROM items it, auctioncontains auc WHERE auc.item_id = it.item_id AND auc.active=false ";
			ResultSet result = stmt.executeQuery(str);
			
			if (result.next()){
			%>
			
		
			<table>
				<tr>
					<th>Auction ID</th>	<th>Current Bid</th> <th>Highest Bidder Id</th> <th>Item Id</th> <th>End Date</th> <th>End Time</th>
					<th>Item Category</th> <th>Item Color</th> <th>Item Size</th> <th>Item Description</th>
				</tr>
				
				<!-- parse out the results -->
					<!-- //getting item data -->
					<tr>
						<td><%out.print(result.getString("auction_id"));%></td>
						<td><%out.print(result.getString("current_price"));%></td>
						<td><%out.print(result.getString("highest_bidder_id"));%></td>
						<td><%out.print(result.getString("item_id"));%></td>
						<td><%out.print(result.getString("end_time").split(" ")[0]); %></td>
						<td><%out.print(result.getString("end_time").split(" ")[1]); %></td>
						<td><%out.print(result.getString("category"));%></td>
						<td><%out.print(result.getString("color"));%></td>
						<td><%out.print(result.getString("size"));%></td>
						<td><%out.print(result.getString("description"));%></td>
					</tr><%
					while(result.next()){
					//filling out table row
				%>
					<tr>
						<td><%out.print(result.getString("auction_id"));%></td>
						<td><%out.print(result.getString("current_price"));%></td>
						<td><%out.print(result.getString("highest_bidder_id"));%></td>
						<td><%out.print(result.getString("item_id"));%></td>
						<td><%out.print(result.getString("end_time").split(" ")[0]); %></td>
						<td><%out.print(result.getString("end_time").split(" ")[1]); %></td>
						<td><%out.print(result.getString("category"));%></td>
						<td><%out.print(result.getString("color"));%></td>
						<td><%out.print(result.getString("size"));%></td>
						<td><%out.print(result.getString("description"));%></td>
					</tr>
				<%}
				//close the connection.
			
				db.closeConnection(con);
				%>
			</table> 
			<%}
			else{
				out.println("No auctions present at this time.<br>");
			}
			} catch (Exception e) {
			out.print(e);
			}%>
    </div>
    <br> <br><br>
    <div class="info">
        <h2>Bid History</h2>

        <form method="POST" action="BidHistory.jsp">
          <p>
            Sort by Auction id:
            <input type="number" name="auction" id="auction" required min="1" />
          	<input type="submit" value="Submit" id="submit" />
          </p>
        </form>
      </div>
      </div>
      <br><br><br>
	</body>
</html>