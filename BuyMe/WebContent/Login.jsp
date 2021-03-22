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
      }
      .head {
        margin-top: 15vh;
        margin-bottom: 6vh;
        font-size: 25px;
      }
      div {
        width: 18rem;
        height: 17rem;
        background-color: white;
        border-radius: 10px;
        align-items: center;
      }
      form {
        margin: 2rem 3.5rem;
      }
      #username,
      #password {
        margin-bottom: 0.5rem;
        border-color: lightgrey;
        border-style: groove;
        border-radius: 6px;
        font-size: 15px;
      }
      .staff {
        margin-top: 0;
        margin-bottom: 1.5rem;
        font-size: 15px;
      }
      #submit {
        margin-right: 1rem;
      }
      #submit,
      #hi {
        font-size: 15px;
        border-style: initial;
        text-decoration: none;
        background-color: rgb(46, 45, 45);
        color: rgb(241, 239, 239);
        border-radius: 15px;
        padding: 0.2rem 0.5rem;
      }
    </style>
  </head>

  <body>
    <p class="head">Welcome to BuyMe!</p>
    <div>
      <form method="POST" action="LoginValidate.jsp">
        <p class="us">
          Username:<input type="text" name="username" id="username" required />
        </p>
        <p class="pd">
          Password: <input type="password" name="password" id="password" required  />
        </p>
        <p class="staff">
          Staff <input type="checkbox" name="staff" id="staff" required />
        </p>

        <p>
          <input type="submit" value="Signin" id="submit" />

          <a id="hi" href="CreateAccount.jsp">SignUp</a>
        </p>
      </form>
    </div>
  </body>
</html>
