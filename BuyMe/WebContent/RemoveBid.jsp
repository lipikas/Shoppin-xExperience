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
      <form method="POST" action="RemoveBidValidate.jsp">
        <p >Auction ID you wish to remove bid from: <input type="text" name="Auction ID" id="auc_id" required /></p>
        <p >Bid ID you wish to remove: <input type="text" name="Bid ID" id="bid_id" required  /></p>
        <p>
          <input type="submit" value="Remove Bid" id="submit" />
        </p>
      </form>
    </div>
    
    <% try{
			 
			//get the connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String str = "SELECT bid_id, auction_id, creator_id FROM bids";
			ResultSet result = stmt.executeQuery(str);
			%>
			<div>
			<table>
				<tr>
					<th>Bid ID </th> <th>Auction ID</th>	<th>Bid Creator ID</th> 
				</tr>
				<%
				//parse out the results
				while (result.next()){ 
					//getting item data
					String bid = result.getString("bid_id");
					String aid = result.getString("auction_id");
					String cid = result.getString("creator_id");
					
					
					
					//filling out table row
				%>
					<tr>
						<td><%out.print(bid);%></td>
						<td><%out.print(aid);%></td>
						<td><%out.print(cid);%></td>
					</tr>
				<%}
				//close the connection.
				db.closeConnection(con);
				%>
			</table></div>
			<%} catch (Exception e) {
			out.print(e);
			}%>
		
  </body>
</html>
