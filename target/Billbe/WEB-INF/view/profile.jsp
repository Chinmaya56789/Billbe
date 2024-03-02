<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.billbe.Model.User"%>
    <% 
	User user= (User)session.getAttribute("user");
	if(user==null){
	response.sendRedirect("redirectToLogin"); 
	}
	%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile - <%=user.getName() %></title>
   <style>
     <%@include file="CSS/Profile_Style.css"%>
     a{
     font-weight: bold;
     }
    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body style="font-family: 'Courier New';">
	<nav class="navbar navbar-expand-lg navbar-light bg-light" style="font-family: 'Courier New';">
  <a class="navbar-brand" href="#" style="color:#9867C5;font-weight: bolder; font-size: 25px;">BillBe</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="redirectToHome"><i class="fa fa-home" aria-hidden="true"></i>
        Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="upload"><i class="fa fa-upload" aria-hidden="true"></i>
        Upload</a>
      </li>	
   		 <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fa fa-power-off fa-lg" aria-hidden="true"></i>
          Profile
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="userProfile">Account</a>
          <a class="dropdown-item" href="cmr">Customer Relation</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="logout">LogOut</a>
        </div>	
      </li> 

    </ul>
  </div>
</nav>
    <div class="container">
      <div id="logo"><h1 class="logo">Billbe</h1>
      </div>
      <div class="leftbox">
      </div>
      <div class="rightbox">
        <div class="profile">
          <h1>Personal Info</h1>
          <h2>Full Name</h2>
          <p><%=user.getName() %></p>
          <h2>Email</h2>
          <p><%=user.getEmail() %> </p>
          <h2>Contact</h2>
          <p><%=user.getContact() %></p>
          <h2>Address</h2>
          <p><%=user.getAddress() %></p>
          <h2>UserId </h2>
          <p><%=user.getUserId() %></p>
        </div>
        
       
        
      </div>
    </div>
  <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>