<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page import="java.util.*" %>
 <%@page errorPage="error.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<meta charset="ISO-8859-1">
<title>Forgot Password</title>
<link rel="icon" type="image" href="icon.png">
<style><%@include file="CSS/Style.css"%></style>
</head>
<body>
	<div class="main_div">
		<div class="form">
		<div >
			<h3 class="text-center title">BillBe</h3>
		</div>
		<form action="<%= request.getContextPath() %>/forgetservlet" method="post">
			<h4 style="text-align:center;">Password Retrieve</h4>
			
			<table id="regform">			
				<tr>
				<td>Email </td>
				<td><input name="username" type="text"> </td>
				</tr>
			</table>
			<input type="submit" value="Send OTP" ><br>
		</form>
		</div>
	</div>
</body>
