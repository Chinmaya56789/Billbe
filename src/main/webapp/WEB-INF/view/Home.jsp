<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="com.billbe.Model.User"%>
<%@page import="com.billbe.Model.Menu"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<style type="text/css">
	<%@include file="CSS/Home_Style.css"%>
</style>
<title>Billebe - Home</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> <!--  Google icons link -->

</head>
<body onload="ldr()">

<div id="loader">
	<div class="spinner-3"></div>
</div>
	
	<%-- <p> Hello <%=user.getName() %>  </p> <br>
	<p> Address: <%= user.getAddress() %></p>
	<a href="logout"> LogOut</a> --%>
<div class="container-fluid main">
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#" style="color:#9867C5;font-weight: bolder; font-size: 25px;">BillBe</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="#"><i class="fa fa-home" aria-hidden="true"></i>
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
    <form class="form-inline my-2 my-lg-0" action="javascript:itemSearch(search_text)">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" autofocus="autofocus" aria-label="Search" id="search_text" name="search_text">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>
   	<!-- End Of NAV Bar -->
   	<!-- ---------------------------------------------------->
<div class="container-fluid content_body">
	<div class="row" style="border:2px solid #9867C5;box-sizing: border-box; height: 6%;">
		<div class="col-lg-2" style="">
			<div class="container-fluid text-center">
				<h4 style="" class="user_name"><%=user.getName() %></h4>
			</div>
		</div>
		<div class=" col-lg-7">
			<div class="container-fluid text-center">
				<h4 style="font-weight:;">DashBoard</h4>
			</div>
		</div>
		<div class="col-lg-3 item_customer">
			<div class="text-center" id="item_customer_tab" style="height: 100%;">
				<a href="#" class="item active" onclick="switch_item_customer(0)" style="height: 100%;">Items</a>
				<a href="#" class="customer" onclick="switch_item_customer(1)" style="height: 100%;"> Customer</a>
			</div>
		</div>
	</div>
	<div class="row" style="height: 94%;">
		<div class="col-lg-2" id="categ" style="padding:0;border-right:2.5px solid #9867C5; overflow: auto; max-height: 100%;">
		<input type="hidden" class="menu_cat active"> <!--purpose: Hidden input for the highlighted of category tab-->
			<c:forEach items="${Category}" var="cat">
			
				 <div class="menu_cat ${cat}" onclick="items('${cat}')">${cat}</div><br>
			</c:forEach> 
		</div>
		<div class="col-lg-7 mnu" id="mnu" style="padding:0; overflow: auto;  max-height: 100%;">
			<c:forEach items="${Menu}" var="mn">
			
				 <div class="cat_items ${mn.getCategory()}" style="display: inline-block;" onclick="addToBill('${mn.getItemId()}','${mn.getName() }','${mn.getPrice() }','${mn.getEstTime_min() }')"><p>${mn.getName()}</p></div>
			</c:forEach> 
		</div>
		<div class="border col-lg-3 right_bill" id="right_bill" style="padding-top: 15px; max-height: 100%; position: relative;">
			
				<div class="bill_screen" >
			<table id="bill_screen" style=" border-collapse: separate; border-spacing: 0 4px;">
			<thead> <tr>
			<th style="text-align: center; border-bottom: 1px solid black">Item</th>
			<th></th>
			<th style="text-align: center; border-bottom: 1px solid black">Count</th>
			<th></th>
			<th style="text-align: center; border-bottom: 1px solid black">Price</th>
			</tr></thead>
			
			</table>
			
			</div>
			<div class="bill_screen" id="customer_detail" style="display: none">
					<input id="customer_Detail_name" type="text" name="customer_name" placeholder="Customer Name" >
					
					<input id="customer_Detail_contact" type="text" name="customer_contact" placeholder="Contact">
					
					<input id="customer_Detail_address" type="text" name="customer_address" placeholder="Address">  

			</div>
			
			
			<div class="bill_total">
			 
				<div><span class="span-center" style="">  Total :</span></div>
				<div><span class="span-center" id="total_span"> 0</span></div>
				<div onclick="clearBill()"><i class="material-icons span-center" >&#xe872;</i></div>
			</div>
			
			<div class="payment_send">
				<div class="payment_method" id="payment_method" >
					<div class="payment_option active">cash</div>
					<div class="payment_option">card</div>
					<div class="payment_option">UPI</div>
					<div class="payment_option">Other</div>
				</div>
				<div class="payment_buttons" style="height: 75%;">
					<button style="border-right:1px solid black;" id="save" onclick="save(false)"> Save</button>
					<button id="saven" onclick="save(true)"> Save & eBill</button>
				</div>
				<div></div>
			</div>
			
		</div>
	</div>
</div>
<!-- Footer -->
<footer class="page-footer font-small blue" style="border-top:2.5px solid #9867C5; box-sizing: border-box;">

  <!-- Copyright -->
  <div class="footer-copyright " style=" text-align: center; margin-top: 10px;">© 2023 Copyright:
    <a href="https://www.linkedin.com/in/chinmaya-behera/" target="_blank"> Chinmaya Behera</a>
    <p style="float: right;margin-right: 20px;font-weight: bold">Version : 1.1</p>

  </div>
  <!-- Copyright -->

</footer>
<!-- Footer -->	
</div>
<!-- javascript start -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
 <script type="text/javascript"><%@include file="JS/home.js"%></script> 
 <script >
// 	$("#save").on("click",savebill);
	
 	function save(e) {
 			//getting cutomer detail 
 			//var customer_detail_header=document.getElementById('customer_detail');
 			var cust_name=document.getElementById('customer_Detail_name');
 			var cust_contact=document.getElementById('customer_Detail_contact');
 			var cust_address=document.getElementById('customer_Detail_address');
 			//getting bill details
 			var sd=bill;
 			var userId='<%=user.getUserId()%>';
 			var totalPrice=0;
 			var item='';
 			//var customerId=Math.random() * 100000
 			for (var i in bill) {
				totalPrice+=parseInt(bill[i]['price'])*parseInt(bill[i]['count']);
			}
 			console.log(totalPrice);
 			for ( var j in itemId) {
				item+=itemId[j]+',';
			}
 			var ajaxData=JSON.stringify({
 				'userId':userId,
 				'itemList':item,
 				'totalPrice': totalPrice,
 				'est':estTime,
 				'paymentMode':paymentMode,
 				'ebill':e,
 				'name':cust_name.value,
 				'contact':cust_contact.value,
 				'address':cust_address.value
 				})
		$.ajax({
			url:"billsave",
			type: 'POST',
			data: ajaxData,
			success: function(data, textStatus,jqXHR) {
				console.log("Ajax successful");
			},
			error: function(jqSHR,textStatus,errThrown){
				console.log("Ajax Error" );
				console.log(errThrown);
			}
		})
		bill=[];
		itemId=[];
		estTime=0;
		billUpdater();
		cust_name.value='';
		cust_contact.value='';
		cust_address.value='';
	}
 </script>
 
</body>
</html>