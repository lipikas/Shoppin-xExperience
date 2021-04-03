<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%> <%@ page
import="java.io.*,java.util.*,java.sql.*"%> <%@ page
import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="ISO-8859-1" />
    <title>BuyMe</title>
    <style>
      body{
		font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; 
		font-size: 16px;
        color: rgb(46 45 45 / 85%);
	  }
	  h2{
      	font-size: 20px;
        font-weight: 400;
        color: rgb(46 45 45 / 85%);
      }
      .topnav {
        overflow: hidden;
        background-color: white;
      }
      /* Style the links inside the navigation bar */
      .topnav a {
        float: left;
        display: block;
        color: black;
        text-align: center;
        padding: 14px 16px;
        text-decoration: none;
        color: rgb(46 45 45 / 85%);
      }
      /* Change the color of links on hover */
      .topnav a:hover {
        background-color: #ddd;
        color: black;
      }
      /* Style the "active" element to highlight the current page */
      .topnav a.active {
        background-color: #2196f3;
        color: white;
      }
      /* Style the search box inside the navigation bar */
      #search {
        float: right;
        padding: 6px 0.5rem;
        border: none;
        margin-top: 8px;
        margin-right: 0.5rem;
      }
      #category, #color, #sizeName, #size{
      margin-left: 6px;
      }
      
      /* When the screen is less than 600px wide, stack the links and the search field vertically instead of horizontally */
      @media screen and (max-width: 600px) {
        .topnav a,
        #search {
          float: none;
          display: block;
          text-align: left;
          width: 100%;
          margin: 0;
          padding: 14px;
        }
        #search {
          border: 1px solid ##000000;
        }
      }
      body,
      html {
        height: 100%;
        width: 100%;
        margin:0;
      }
      
      .fullwidth {
        display: flex;
        flex-direction: column;
        height: 100%;
      }
      .row {
        flex: 1;
        background-size: cover;
        background-repeat: no-repeat;
        background-position: center center;
      }
		#size{
			width: 3rem;
		}    
      .container {
        width: 100%;
        height: 100%;
        margin-left: 20px;
      }
      .toppane {
        height: 33.33%;
        width: 100%;
        float: left;
        border-collapse: collapse;
      }
      .middlepane {
        height: 33.33%;
        width: 100%;
        float: left;
        border-collapse: collapse;
      }
      .bottompane {
        height: 33.33%;
        width: 100%;
        position: relative;
        float: right;
        border-collapse: collapse;
      }

      #submit {
        border-style: initial;
        text-decoration: none;
        background-color: rgb(46, 45, 45);
        color: rgb(241, 239, 239);
        border-radius: 15px;
  		margin-left: 10px;
        padding: 0.2rem 0.5rem;
      }
    </style>
  </head>

  <body>
    <div class="topnav">
      <a class="active" href="#home">Home</a>
      <a href="CreateAuction.jsp">Create Auction</a>
      <a href="Alerts.jsp">Alerts</a>
      <a href="ViewAuctions.jsp"> Ongoing Auctions</a>
      <a href="Questions.jsp"> FAQs</a>
      <a href="WishList.jsp">WishList</a>
      <a href="Logout.jsp">Logout</a>
      <form id = "search" method="POST" action="SearchItems.jsp"> <!-- //Search by functionality -->
      	<label>Search by </label>
       	<select name="Category" id="category">
       	    <option value="shirt">Shirts</option>
   			<option value="pant">Pants</option>
   			<option value="shoe">Shoes</option>
   		</select>
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
   		<label id = "sizeName"> Size</label>
   		<input type="number" name="size" min="1" max="20" id = "one">
   		<label>Sort by </label>
		<select name="Sort" id="sort">
		    	<option value="dec_price">Decreasing price</option>
		   		<option value="inc_pric">Increasing price</option>
		   		<!-- 	<option value="auction">Soonest Auction Closing</option> -->
		</select>
        <input type="submit" value="Submit" id="submit" />
       </form>
      
    </div>
    <div class="container">
      <div class="toppane">
        <h2>My Auctions</h2>
      </div>
      <div class="middlepane">
        <h2>Auction History</h2>
        <form method="POST" action="AuctionHistory.jsp">
          <label>Sort by </label>
          <select name = "auction_history">
          	    <option value="bc_id">Buyer id</option>
   				<option value="sc_id">Seller id</option>
   		  </select>
 
            <input type="number" name="c_id" id="c_id" required min="1" />
          	<input type="submit" value="Submit" id="submit" />
        </form>
        
      </div>
      <div class="bottompane">
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
  </body>
</html>
