<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.text.ParseException,
java.text.DateFormat, java.text.SimpleDateFormat, java.util.Date"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Search Items</title>
	</head>
	<style>
      body{
		font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif; 
		font-size: 16px;
        color: rgb(46 45 45 / 85%);
        text-align: center;
        margin-top: 50px;
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
        text-align: center;
      }
      th{
      	font-weight: 490;
      }
      div{
      	display: flex;
      	flex-direction: row;
      	justify-content: center;
      	align-content: center;
      }
      
      a{
        border-style: initial;
        text-decoration: none;
	    background-color: rgb(230 230 230 / 87%);
	    color: #000000bd;
        border-radius: 15px;
        padding: 0.2rem 0.5rem;
        flex-direction: row; 
      }
      
      a:hover {
        background-color: #ddd;
        color: black;
      }

	</style>
	<body>	
			<h2>Search your Items</h2>
			
			<% 
			String category = request.getParameter("Category");
			String color = request.getParameter("Color");
			String size = request.getParameter("size");
			String sort = request.getParameter("Sort");
			String group = "";
			
	/* 		out.println("Category" + category);
			out.println("Color" + color); 
			out.println("size" + size); 
			*/
			if(sort.compareTo("inc_price")==0){
				group = group.concat("ASC");
			}
			else if(sort.compareTo("dec_price")==0){
				group = group.concat("DESC");
			}
			out.print(" <br>");
			
			  try {
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();	
					Statement stmt = con.createStatement();
					String str = "SELECT * FROM items it, auctioncontains auc WHERE auc.item_id = it.item_id";
					
					if(color.compareTo("any")==0 && size.compareTo("")==0){ // null size and color
						str = str.concat("AND it.category = '" + category + "' ORDER BY auc.current_price "+ group +";");
					}
					else if(color.compareTo("any")==0){ // null color
						str = str.concat("AND it.category = '" + category + "' AND it.size = '"+ size+ "' ORDER BY auc.current_price "+ group +";");
					}
					else if(size.compareTo("")==0){// null size
						str = str.concat("AND it.category = '" + category + "' AND it.color = '"+ color + "' ORDER BY auc.current_price "+ group +";");
					}
					else{
						str = str.concat(" AND it.category = '" + category +"' AND it.color = '"+ color + "' AND it.size = '"+ size+ "' ORDER BY auc.current_price "+ group +";");
					}
					ResultSet result = stmt.executeQuery(str);
			
					
					if (result.next()){
						//Valid query - user inputted data
						
						out.print("<div><table>");
						out.print("<tr>");   
							out.print("<th> Auction_id </th>"); 
							out.print("<th> Item_id </th>");  
							out.print("<th> Item Name </th>"); // same as Item Description?
							out.print("<th> Item Category </th>"); 
							out.print("<th> Item Color </th>"); 
							out.print("<th> Item Size </th>"); 
							out.print("<th> Current Bid Price </th>"); 
							out.print("<th> Seller Id </th>");  
							out.print("<th> Current Highest Bidder Id </th>");  
						out.print("</tr>");  
						
						out.print("<tr>");    
						out.print("<td>" + result.getString("auction_id") +"</td>");
						out.print("<td>" + result.getString("item_id") +"</td>");
						out.print("<td>" + result.getString("description") +"</td>");
						out.print("<td>" + result.getString("category") +"</td>");
						out.print("<td>" + result.getString("color") +"</td>");
						out.print("<td>" + result.getString("size") +"</td>");
						out.print("<td>" + result.getString("current_price") +"</td>");
						out.print("<td>" + result.getString("creator_id") +"</td>");
						out.print("<td>" + result.getString("highest_bidder_id") +"</td>");
						out.print("</tr>"); 
						
						while (result.next()) { 
							out.print("<tr>");    
							out.print("<td>" + result.getString("auction_id") +"</td>");
							out.print("<td>" + result.getString("item_id") +"</td>");
							out.print("<td>" + result.getString("description") +"</td>");
							out.print("<td>" + result.getString("category") +"</td>");
							out.print("<td>" + result.getString("color") +"</td>");
							out.print("<td>" + result.getString("size") +"</td>");
							out.print("<td>" + result.getString("current_price") +"</td>");
							out.print("<td>" + result.getString("creator_id") +"</td>");
							out.print("<td>" + result.getString("highest_bidder_id") +"</td>");
							out.print("</tr>"); 			
						}
						
						out.print("</table></div> <br>");
					
					} else {
						//InValid query
						out.println("We have no items available at this time with the matching search requirements.");
						out.println("<br><br><br>");
					}
					con.close();
				} catch (Exception e) {
					out.println("<br><br>" + e);
					e.printStackTrace();
				}
			  

			  
 	    out.println("<br><br>");
		out.println("<a href=\"AdminHome.jsp\"> Back to Home Page");
		%>
		
	    </body>
	   </html>
	   
	


