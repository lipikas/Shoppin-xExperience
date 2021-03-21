<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Alerts</title>
</head>
<body>

	<%
	
	//issue how to match endtime wth respective auction i.e auction 1 ends but auction 2 hasn't
		try {
			//connect to database
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			//Get endtime and parse it 
			String endtime = request.getParameter("endtime");
			SimpleDateFormat expired = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", java.util.Locale.getDefault());
		    Date date = new Date(expired.parse(endtime).getTime());
		    
		    //Get current time 
		    Date currTime = new Date();
		    Timestamp curr = new Timestamp(currTime.getTime());
		    
		    //set boolean variable to tell us if acution has ended
		    boolean auctionEnd = false;
		    
		    //Create arraylist to hold alerts
		    List<String> win_loss = new ArrayList<>();
		    List<String> similar_item = new ArrayList<>();
		    
		    //if statement to check if the auction has ended
		    if(curr.after(date)){
		    	auctionEnd = true;
		    }
		    
		    
		    //This if statement will find the winner of the auction and post an alert in their alerts page
		    if(auctionEnd = true){
		    	
		    	//select the winner --> bunch of sql statement not an issue
		    	//delete winner on cascade 
		    }
		    
		} 
		catch (ParseException e) {
		    e.printStackTrace();
		}
		
	%>

</body>
</html>