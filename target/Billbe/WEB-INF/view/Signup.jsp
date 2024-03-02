<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee Registration</title>
<link rel="icon" type="image" href="icon.png">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
	<%@include file="CSS/Style.css"%>
</style>
</head>
<body onload="javascript:onload()">
	<script type="text/javascript">
	function onload() {
		if (${sweetAlertCode}==789) {
			swal({
				  title: "Email Already Registered !",
				  text: "Please use different email",
				  icon: "error",
				  button: "Sign Up",
				});
		}
	}
		function formValidator() {
			var Name= document.signUpForm.name.value;
			var Email= document.signUpForm.email.value;
			var Password= document.signUpForm.password.value;
			var Contact= document.signUpForm.contact.value;
			var Address= document.signUpForm.address.value;
			
			if(Name==""||Email==""||Password=="" ||Contact=="" ||Address=="" ){
				swal("Field Missing", "Please fill all the fields!", "warning");
				return false;
			}
			else if (Email.indexOf("@")<=0) {
				swal("Incorrect Email", "Kindly provide the Correct Email !", "warning");
				return false;
			}
			else if (Contact.length<10) {
				swal("Incorrect Contact", "Contact Should have atleast 10 digit !", "warning");
				return false;
			}
			else if (Password.length<8) {
				swal("Incorrect Password", "Contact Should have atleast 8 digit !", "warning");
				return false;
			}
			else{
				//swal("Congratulations !", "Registration Complete", "success");
				return true;
			}
			
		}
	</script>
	<div class="main_div">
		<div class="form">
		<div >
			<h3 class="text-center title">BillBe</h3>
		</div>
		<form action="signup" method="post" onsubmit="return formValidator()" name="signUpForm">
		
			<h4 style="text-align:center;">Registration</h4>
			<table id="regform">			
				<tr>
				<td>Name </td>
				<td><input name="name" type="text" required="required"> </td>
				</tr>
				<tr>
				<td>Email </td>
				<td><input name="email" type="text" required="required"> </td>
				</tr>
				<tr>
				<td>Password </td>
				<td><input name="password" type="password" required="required" > </td>
				</tr>
				<tr>
				<td>Contact </td>
				<td><input name="contact" type="text" required="required"> </td>
				</tr>
				<tr>
				<td>Address </td>
				<td><input name="address" type="text" required="required"> </td>
				</tr>
				
				
			</table>
			<input type="submit" value="Register" >
		</form>
		</div>
	</div>
</body>
</html>