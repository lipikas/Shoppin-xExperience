<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>WishList</title>
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
      }
	  table,
      th,
      td {
        padding: 10px;
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
</head>
<body>
	<h2> My WishList</h2>
	<br>
	<a href=CustomerHome.jsp>Back to Home Page</a>
	<br> <br>
	<br>
	
	<div>
	<table border="1"><tr>
	<td>
	<h2>Add Item</h2>
	<form method=POST action=WishListAdd.jsp>
		 <p>Item Category:</p>
        <input type="radio" name="category" id="shirt" value="shirt"/>
        <label for="shirt">Shirt</label><br>
        <input type="radio" name="category" id="pants" value="pants"/>
        <label for="pants">Pants</label><br>
        <input type="radio" name="category" id="shoes" value="shoes"/>
        <label for="shoes">Shoes</label>
        <p> Item Color:
	        <select name="color" id = "one">
	        	<option value="red">Red</option>
	        	<option value="orange">Orange</option>
	        	<option value="yellow">Yellow</option>
	        	<option value="green">Green</option>
	        	<option value="blue">Blue</option>
	        	<option value="purple">Purple</option>
	        	<option value="white">White</option>
	        	<option value="black">Black</option>
	        	<option value="gray">Gray</option>
	        </select>
        </p>
        <p> Item Size (1 - 20):
        	<input type="number" name="size" required min="1" max="20" id = "one" required>
        </p>
        <input type="submit" value="Add">
	</form>
	</td>
	<td>
	<h2>Remove Item</h2>
	<form method=POST action=WishListRemove.jsp>
		 <p>Item Category:</p>
        <input type="radio" name="category" id="shirt" value="shirt"/>
        <label for="shirt">Shirt</label><br>
        <input type="radio" name="category" id="pants" value="pants"/>
        <label for="pants">Pants</label><br>
        <input type="radio" name="category" id="shoes" value="shoes"/>
        <label for="shoes">Shoes</label>
        <p> Item Color:
	        <select name="color" id = "one">
	        	<option value="red">Red</option>
	        	<option value="orange">Orange</option>
	        	<option value="yellow">Yellow</option>
	        	<option value="green">Green</option>
	        	<option value="blue">Blue</option>
	        	<option value="purple">Purple</option>
	        	<option value="white">White</option>
	        	<option value="black">Black</option>
	        	<option value="gray">Gray</option>
	        </select>
        </p>
        <p> Item Size (1 - 20):
        	<input type="number" name="size" required min="1" max="20" id = "one" required>
        </p>
        <input type="submit" value="Remove">
	</form>
	</td>
	</tr></table> </div>
	<br>
	<h2>WishList</h2>
	<div><table>
			<tr>
				<td>Category</td>	<td>Color</td> <td>Size</td>
			</tr>
	<%
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String id = session.getAttribute("id").toString();
			ResultSet rs = stmt.executeQuery("SELECT * FROM WantedItems WHERE c_id='"+ id +"';");
			while (rs.next()){
				%>
				<tr>
						<td><%out.print(rs.getString("category"));%></td>
						<td><%out.print(rs.getString("color"));%></td>
						<td><%out.print(rs.getString("size"));%></td>
					</tr>
				<%
			}
			%>
			</table></div><%
			con.close();
		} 
		catch (Exception e) {
		    e.printStackTrace();
		    out.println("ERROR");
		}
	%>
</body>
</html>