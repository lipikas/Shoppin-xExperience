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
    <p>Edit Account Information</p>
    <div>
      <form method="POST" action="EditInfoValidate.jsp">
        <p >Customer ID you wish to edit <input type="text" name="Customer ID" id="c_id" required /></p>
        <p >Which Field Would you Like to Edit?</p>
        	<input type="radio" name="category" id="Name" value="Name"/>
        	<label for="name">Name</label><br>
        	<input type="radio" name="category" id="Phone" value="Phone"/>
        	<label for="phone">Phone</label><br>
        	<input type="radio" name="category" id="Username" value="Username"/>
        	<label for="user">Username</label><br>
        	<input type="radio" name="category" id="Email" value="Email"/>
        	<label for="email">Email</label><br>
        	<input type="radio" name="category" id="Password" value="Password"/>
        	<label for="password">Password</label>
        <p>
        
        <p >Update Field To: <input type="text" name="Updated" id="update" required /></p>
          <input type="submit" value="Edit" id="submit" />
        </p>
      </form>
    </div>
  </body>
</html>
