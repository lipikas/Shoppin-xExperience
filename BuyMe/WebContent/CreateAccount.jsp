<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>

	<head>
	<meta charset="ISO-8859-1">
	<title>BuyMe - Create Account</title>
	</head>
	
	<body>
		<h2>Create Account</h2>
		<form method="POST" action="Login.jsp">
			<table>
				<tr>
					<td><input type="text" name="name"  placeholder="Name"></td>
				</tr>
				<tr>
					<td><input type="text" name="number" placeholder="Phone Number"></td>
				</tr>
				<tr>
				    <td><input type="text" name="email" placeholder="Email"></td>
				</tr>
				<tr>
					<td><input type="text" name="username" placeholder="Username"></td>
				</tr>
				<tr>
					<td><input type="password" name="password" placeholder="Password"></td>
				</tr>
				<tr>
					<td><input type="submit" value="Sign Up"></td>
				</tr>
			</table>
        </form>
	</body>
	
</html>