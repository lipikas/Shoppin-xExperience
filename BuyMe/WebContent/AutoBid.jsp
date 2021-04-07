<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Place AutoBids</title>
	</head>
	
	<body>
    <h3>Place AutoBid</h3>
    <p>AutoBids place new bids when someone out-bids you</p>
    <div>
      <form method="POST" action="AutoBidValidate.jsp">
        <p >Auction ID: <input type="text" name="Auction ID" id="auc_id" required /></p>
        <p >Bid Amount: <input type="text" name="Bid Amount" id="amnt" required  /></p>
        <p >Upper Limit: <input type="text" name="Upper Limit" id="upper" required  /></p>
	<p >Increment AutoBid by: <input type="text" name="Auto Inc" id="autoinc" required  /></p>
        <p>
          <input type="submit" value="Place AutoBid" id="submit" />
        </p>
      </form>
    </div>
  </body>
  
</html>
