<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <title>BuyMe - Login</title>
    <style>
      body {
        background-color: #00ffff2e;
        font-family: Arial, Helvetica, sans-serif;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        font-size: 15px;
      }
      .head {
        margin-left: -2rem;
        margin-top: 15vh;
        margin-bottom: 6vh;
        font-size: 25px;
      }
      div {
        width: 16rem;
        height: 25rem;
        background-color: white;
        border-radius: 10px;
        align-items: center;
      }
      form {
        margin: 2.5rem 2.6rem;
      }
      #submit {
        margin-top: 1rem;
        margin-left: 2.5rem;
        font-size: 15px;
        border-style: initial;
        text-decoration: none;
        background-color: rgb(46, 45, 45);
        color: rgb(241, 239, 239);
        border-radius: 15px;
        padding: 0.2rem 0.5rem;
      }
      #name,
      #phone,
      #email,
      #username,
      #password {
        font-size: 14px;
        border-color: lightgrey;
        border-style: groove;
        border-radius: 6px;
      }
    </style>
  </head>

  <body>
    <p class="head">Sign Up</p>
    <div>
      <form method="POST" action="AccountValidate.jsp">
        <p >Name:<input type="text" name="Name" id="name" /></p>
        <p >Phone no: <input type="text" name="Phone Number" id="phone" /></p>
        <p >Email: <input type="text" name="Email" id="email" /></p>
        <p >Username <input type="text" name="Username" id="username" /></p>
        <p>Password: <input type="text" name="Password" id="password" /></p>
        <p>
          <input type="submit" value="Signup" id="submit" />
        </p>
      </form>
    </div>
  </body>
</html>
