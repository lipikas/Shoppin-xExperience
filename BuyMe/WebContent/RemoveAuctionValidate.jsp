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
			String aucid = request.getParameter("Auction ID");	
		
			
			
			try {
		 		ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				
				
				//delete from auctioncontains
				PreparedStatement ps = con.prepareStatement("DELETE FROM auctioncontains WHERE auction_id='"+aucid+"';");;
				ps.executeUpdate();
				
				//delete all bids pertaining to this auction
				PreparedStatement ps1 = con.prepareStatement("DELETE FROM bids WHERE auction_id = '" + aucid + "';");;
				ps1.executeUpdate();
				
			
				out.println("Auction and all pertaining bids have been removed");
					%><a href="CustomerRepHome.jsp">Back to Homepage</a><%
					con.close();
					
				} catch (Exception e) {
					out.println("Error removing Auction!");
					%><a href="CustomerRepHome.jsp">Back to Homepage</a><%
					e.printStackTrace();
				}	
	
			
		%>
		
	</body>
</html>