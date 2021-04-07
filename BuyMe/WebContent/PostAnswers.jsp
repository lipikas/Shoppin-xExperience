<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="ISO-8859-1">
	<title>Answer A Question</title>
	</head>
	
	<body>
    <p>Answer A Question</p>
    <div>
      <form method="POST" action="AnswerValidate.jsp">
      	<p >Question ID: <input type="text" name="QID" id="qid" required /></p>
        <p >Answer: <input type="text" name="Answer" id="answer" required /></p>
        <p>
          <input type="submit" value="Answer Question" id="submit" />
        </p>
      </form>
    </div>
  </body>
  
</html>