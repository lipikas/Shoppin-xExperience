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
	<style>
	body{
		font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; 
		font-size: 16px;
        color: rgb(46 45 45 / 85%);
        text-align: center;
        margin-top: 50px;
	  }
	  div{
      	display: flex;
      	flex-direction: row;
      	justify-content: center;
      	align-content: center;
      }
	  h2{
      	font-size: 20px;
        font-weight: 500;
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
      }
	
	
	</style>
	<body>
    <p>Remove Auctions</p>
    <div>
      <form method="POST" action="RemoveAuctionValidate.jsp">
        <p >Auction ID you wish to remove: <input type="text" name="Auction ID" id="auc_id" required /></p>
        <p>
          <input type="submit" value="Remove Auction" id="submit" />
        </p>
      </form>
    </div>
    
     <% try{
			 
			//get the connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String str = "SELECT auction_id, creator_id FROM auctioncontains WHERE active = 1";
			ResultSet result = stmt.executeQuery(str);
			%>
			<div>
			<table>
				<tr>
					<th>Auction ID </th> <th>Auction Creator ID</th>
				</tr>
				<%
				//parse out the results
				while (result.next()){ 
					//getting item data
					String aid = result.getString("auction_id");
					String cid = result.getString("creator_id");
					
					
					
					//filling out table row
				%>
					<tr>
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
