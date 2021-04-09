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
    <p>Delete Account </p>
    <div>
      <form method="POST" action="DeleteAccountValidate.jsp">
        <p >Customer ID you wish to Delete <input type="text" name="Customer ID" id="c_id" required /></p>
        <input type="submit" value="Delete" id="submit" />
       
        <p>
      </form>
    </div>
  </body>
</html>
