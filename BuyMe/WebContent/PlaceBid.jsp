<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Place Bids</title>
	</head>
	
	<body>
    <p>Place Bid</p>
    <div>
      <form method="POST" action="BidValidate.jsp">
        <p >Auction ID: <input type="text" name="Auction ID" id="auc_id" required /></p>
        <p >Bid Amount: <input type="text" name="Bid Amount" id="amnt" required  /></p>
        <p>
          <input type="submit" value="Place Bid" id="submit" />
        </p>
      </form>
    </div>
  </body>
  
</html>
