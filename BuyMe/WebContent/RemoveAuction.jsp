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
    <p>Remove Bid</p>
    <div>
      <form method="POST" action="RemoveAuctionValidate.jsp">
        <p >Auction ID you wish to remove: <input type="text" name="Auction ID" id="auc_id" required /></p>
        <p>
          <input type="submit" value="Remove Auction" id="submit" />
        </p>
      </form>
    </div>
  </body>
</html>
