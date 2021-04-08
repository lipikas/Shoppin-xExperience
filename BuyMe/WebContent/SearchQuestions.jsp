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
		
		    
			
			String searched = request.getParameter("search");	
			searched = searched.replaceAll("\\p{Punct}", "").toLowerCase();
			
			try {
		 		    ApplicationDB db = new ApplicationDB();
				    Connection con = db.getConnection();
				    
				    //compare curr price with bid
				    Statement st = con.createStatement();
					String query = "SELECT message, answer FROM questions";
					ResultSet result = st.executeQuery(query);
					int count = 0;
					boolean printed = false;
					while(result.next()){
						String message = result.getString("message");
						String [] words = message.split("\\s+");
						for(String word: words){
							word = word.replaceAll("\\p{Punct}", "").toLowerCase();
							if(searched.equals(word)){
								count++;
								String answer = result.getString("answer");
								if(printed == false){
									out.println("Match Found!");
									out.println("<br>");
									printed = true;
								}
								out.println("Q: " + message);
								out.println("A: " + answer);
								out.println("<br>");
								
							}
						}
					}
					
					if(count == 0){
						out.println("Could Not Find A Match");
					}
					con.close();
					
				} catch (Exception e) {
					out.println("Error Searching!");
					%><a href="CustomerHome.jsp">Back to Homepage</a><%
					//e.printStackTrace();
				}	
			
			
		%>
		
	</body>
</html>
