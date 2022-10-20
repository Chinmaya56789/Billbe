<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee Log In</title>
<link rel="icon" type="image" href="icon.png">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<style><%@include file="CSS/Style.css"%></style>
</head>
<body>
	
	<div class="main_div">
		
		<div class="form">
		<div >
			<h3 class="text-center title">BillBe</h3>
		</div>
			<form action="login" method="post">
				<h4 style="text-align: center;">Log In</h4>
				<table id="regform">
					<tr>
						<td>UserName</td>
						<td><input name="username" type="text"></td>
					</tr>
					<tr>
						<td>Password</td>
						<td><input name="password" type="password"></td>
					</tr>
				</table>
				<input type="submit" value="Log in"><br> 
				
				<a href="forgotpassword">Forgot Password ?</a> <br>
				<a href="redirectToSignup">Dont have account.</a>
			</form>
		</div>
	</div>
</body>