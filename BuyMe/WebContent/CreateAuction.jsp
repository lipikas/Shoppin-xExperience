<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <title>BuyMe - Create Auction</title>
    <style>
      body {
      	margin:0;
        background-color: #00ffff2e;
        font-family: Arial, Helvetica, sans-serif;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        font-size: 15px;
      }
      .head {
        margin-left: -2rem;
        margin-top: 15vh;
        margin-bottom: 6vh;
        font-size: 25px;
      }
      div {
        width: 30rem;
        height: 36rem;
        background-color: white;
        border-radius: 10px;
        align-items: center;
      }
      form {
        margin: 2.5rem 3.8rem;
      }
      #submit {
        margin-top: 0.5rem;
        margin-left: 10rem;
        font-size: 15px;
        border-style: initial;
        text-decoration: none;
        background-color: rgb(46, 45, 45);
        color: rgb(241, 239, 239);
        border-radius: 15px;
        padding: 0.2rem 0.5rem;
      }
      #one {
        font-size: 14px;
        border-color: lightgrey;
        border-style: groove;
        border-radius: 6px;
      }
      
    </style>
  </head>

  <body>

    <p class="head">Create Auction</p>
    <div>
      <form method="POST" action="CreateAuctionValidate.jsp">
      	<p>Auction End Date: 
      		<input type="datetime-local" name="endtime" id = "one" required/>
      	</p>
      	<p>Initial Price: 
      		<input type="number" name="initialprice" step="0.01" min="0.00" id = "one" required/>
      	</p>
        <p>Minimum Price To Sell: 
        	<input type="number" name="minprice" step="0.01" min="0.00" id = "one" required/>
        </p>
        <p>Bid Increment Amount: 
        	<input type="number" name="bidinc" step="0.01" min="0.00" id = "one" required/>
        </p>
        <p>Item Category:</p>
        <input type="radio" name="category" id="shirt" value="Shirt"/>
        <label for="shirt">Shirt</label><br>
        <input type="radio" name="category" id="pants" value="Pants"/>
        <label for="pants">Pants</label><br>
        <input type="radio" name="category" id="shoes" value="Shoes"/>
        <label for="shoes">Shoes</label>
        <p> Item Color:
	        <select name="color" id = "one">
	        	<option value="Red">Red</option>
	        	<option value="Orange">Orange</option>
	        	<option value="Yellow">Yellow</option>
	        	<option value="Green">Green</option>
	        	<option value="Blue">Blue</option>
	        	<option value="Purple">Purple</option>
	        	<option value="White">White</option>
	        	<option value= "Black">Black</option>
	        	<option value="Gray">Gray</option>
	        </select>
        </p>
        <p> Item Size (1 - 20):
        	<input type="number" name="size" required min="1" max="20" id = "one" required>
        </p>
        <p>Item Description:</p>
        <textarea  name="description" rows="3" cols="38" placeholder="100 character limit" id = "one" required></textarea>
        <p>
          <input type="submit" value="Create" id="submit" />
        </p>
      </form>
    </div>
    <br> <br> <br>
  </body>
</html>
