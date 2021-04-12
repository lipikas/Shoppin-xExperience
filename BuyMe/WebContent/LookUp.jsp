<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Buy Me</title>
	</head>
		<style>
		.container {
	        width: 100%;
	        height: 100%;
	        margin-left: 20px;
	      }
	      .leftpane {
	        height: 100%;
	        width: 33.33%;
	        float: left;
	        border-collapse: collapse;
	      }
	      .middlepane {
	        height: 100%;
	        width: 33.33%;
	        float: left;
	        border-collapse: collapse;
	      }
	      .rightpane {
	        height: 100%;
	        width: 33.33%;
	        position: relative;
	        float: right;
	        border-collapse: collapse;
	      }
	</style>	      
	<body>
	<div class="container">
      <div class="leftpane">
        <h2>Search Item</h2>
         <form method="POST" action="itemSearch.jsp">
          <p>
            Enter Item ID:
            <input type="number" name="item_id" id="item_id" required min="1" />
          	<input type="submit" value="Submit" id="submit" />
          </p>
        </form>
      </div>
      <div class="middlepane">
        <h2>Search Item Type</h2>
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
	        <input type="submit" value="Submit" id="submit" />
	   </p>
       </form>
        
      </div>
      <div class="rightpane">
        <h2>Search User</h2>

        <form method="POST" action="SearchUser.jsp">
          <p>
          	Enter User id:
            <input type="number" name="user_id" id="user_id" required min="1" />
          </p>
          <p>
          	Enter Username:
            <input type="text" name="user_name" id="user_name" required min="1" />
          </p>
          <input type="submit" value="Submit" id="submit" />
        </form>
      </div>
    </div>
	</body>
</html>