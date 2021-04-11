<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>BuyMe - Auctions</title>
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
        margin-bottom: 30px;
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
	
		<h2>Questions</h2>
		
		
		<p>Enter Keyword to Search Questions</p>
		<form method="POST" action="SearchQuestions.jsp">
  			<input type="text" placeholder="Search.." name="search">
  			
		</form>
		<br>
		<% out.println("<a href=\"PostQuestions.jsp\">Click Here to Post a Question</a>"); %>
		<br> <br>
		<br>
		 <% try{
			 
			//get the connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String str = "SELECT message, answer FROM questions";
			ResultSet result = stmt.executeQuery(str);
			%>
			<div>
			<table>
				<tr>
					<th>Question</th>	<th>Answer</th> 
				</tr>
				<%
				//parse out the results
				while (result.next()){ 
					//getting item data
					String question = result.getString("message");
					String answer = result.getString("answer");
					
					if(answer == null){
						answer = "Not yet answered. A customer Rep will answer this question soon.";
					}
					
					//filling out table row
				%>
					<tr>
						<td><%out.print(question);%></td>
						<td><%out.print(answer);%></td>
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
