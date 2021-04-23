<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>BuyMe</title>
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
	</head>
	<body>
	
		<%	
		
		%><a href="EditInfo.jsp">Edit Customer Account Details</a><%
			
		out.println("<br><br> <br>");
		
		%><a href="DeleteAccount.jsp"> Delete Customer Account</a><%
				
		out.println("<br> <br><br> <br>");
			
		%>
		
		 <% try{
			 
			//get the connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String str = "SELECT c_id, name, login FROM customers WHERE login != 'NULL'";
			ResultSet result = stmt.executeQuery(str);
			%>
			<div>
			<table>
				<tr>
					<th>Customer ID </th> <th>Name</th>	<th>Login</th> 
				</tr>
				<%
				//parse out the results
				while (result.next()){ 
					//getting item data
					String cid = result.getString("c_id");
					String name = result.getString("name");
					String login = result.getString("login");
					
					
					
					//filling out table row
				%>
					<tr>
						<td><%out.print(cid);%></td>
						<td><%out.print(name);%></td>
						<td><%out.print(login);%></td>
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
