<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Post A Question</title>
	</head>
	
	<body>
    <p>Post A Question</p>
    <div>
      <form method="POST" action="QuestionValidate.jsp">
        <p >Question: <input type="text" name="Question" id="question" required /></p>
        <p>
          <input type="submit" value="Post Question" id="submit" />
        </p>
      </form>
    </div>
  </body>
  
</html>