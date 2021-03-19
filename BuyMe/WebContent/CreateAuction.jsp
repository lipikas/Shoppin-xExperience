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
        background-color: #0000000;
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
        width: 16rem;
        height: 25rem;
        background-color: white;
        border-radius: 10px;
        align-items: center;
      }
      form {
        margin: 2.5rem 2.6rem;
      }
      #submit {
        margin-top: 1rem;
        margin-left: 2.5rem;
        font-size: 15px;
        border-style: initial;
        text-decoration: none;
        background-color: rgb(46, 45, 45);
        color: rgb(241, 239, 239);
        border-radius: 15px;
        padding: 0.2rem 0.5rem;
      }
      #name,
      #phone,
      #email,
      #username,
      #password {
        font-size: 14px;
        border-color: lightgrey;
        border-style: groove;
        border-radius: 6px;
      }
    </style>
  </head>

  <body>
  	<a href="CustomerHome.jsp">Back to Homepage</a>
    <p class="head">Create Auction</p>
    <div>
      <form method="POST" action="CreateAuctionValidate.jsp">
      	<p>Auction End Time: <input type="datetime-local" name="endtime" id="password" required/></p>
      	<p>Initial Price: <input type="text" name="initialprice" id="password" required/></p>
        <p>Minimum Price To Sell: <input type=text name="minprice" id="password" required/></p>
        <p>Bid Increment Amount: <input type="text" name="bidinc" id="password" required/></p>
        <p>Item Category:</p>
        <input type="radio" name="category" id="shirt" value="shirt"/>
        <label for="shirt">Shirt</label><br>
        <input type="radio" name="category" id="pants" value="pants"/>
        <label for="pants">Pants</label><br>
        <input type="radio" name="category" id="shoes" value="shoes"/>
        <label for="shoes">Shoes</label>
        <p>Item Color: <input type="text" name="color" id="phone" required/></p>
        <p>Item Size: <input type="text" name="size" id="email" required/></p>
        <p>Item Description:</p>
        <textarea id="description" name="description" rows="2" cols="50" placeholder="100 character limit"></textarea>
        <p>
          <input type="submit" value="Create" id="submit" />
        </p>
      </form>
    </div>
  </body>
</html>