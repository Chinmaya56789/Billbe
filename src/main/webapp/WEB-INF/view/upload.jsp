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
<title>Upload</title>
<link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined" rel="stylesheet">
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<style type="text/css">
.form-field{width: 25%; box-sizing: border-box;}
.form-field>input{
 margin-left: 15px !important;
}
body {
user-select:none;
	right: 0;
	left: 0;
	top: 0;
	bottom: 0;
	position: absolute;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Courier New';
}
form ul { list-style-type: none; }

form ul li { display: inline-block }
* {
  box-sizing: border-box;
  font-size: inherit;
  font-family: inherit;
  color: inherit;
}
.signup-form {
  display: flex;
  height: 3.75rem;
  align-items: center;
  box-shadow: 
    0 0 40px rgba(0,0,0, .1),
    0 4px 8px -4px rgba(0,0,0, .2);
}

.form-field {
  margin: 1rem 1.25rem;
  position: relative;
  
  input {
    position: relative;
    background: none;
    top: .4rem;
    border: none;
    
    &:focus {
      outline: none;
    }
  }
  
  label {
    position: absolute;
    color: rgba(0,0,0, .5);
    transition: 200ms;
  }
  
  &.is-dirty, 
  &.has-focus {
    label {
      top: -.3rem;
      left: 0rem;
      font-size: .6rem; 
    }
  }
}

.submit {
  background: #239488;
  align-self: stretch;
  display: flex;
  align-items: center;
  color: white;
  padding: 0 2rem;
  border: none;
  cursor: pointer;
  
  &:focus {
    outline: none;
  }
}

.divider {
  background: rgba(0,0,0, .1);
  width: 2px;
  align-self: stretch;
  margin: .5rem 0;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#" style="color:#9867C5;font-weight: bolder; font-size: 25px;">BillBe</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="redirectToHome"><i class="fa fa-home" aria-hidden="true"></i>
        Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#"><i class="fa fa-upload" aria-hidden="true"></i>
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
    <form class="form-inline my-2 my-lg-0" action="#">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>
<div class="container-fluid content_body" style=" height: 86%; overflow: auto">
	<h4 style="text-align: center; font-weight: bolder;">Add new items</h4>
	
	<div class="upload-body" style="width:100%; border: 1px solid red;">
			<div class="signup-form">
				<div class="form-field">
					<label for="itemName">Name</label> <input type="text"  class="upload_itemName">
				</div>
				<div class="divider"></div>
				<div class="form-field">
					<label for="category">Category</label> <input type="text" class="upload_category">
				</div>
				<div class="divider"></div>
				<div class="form-field">
					<label for="itemPrice">Price</label> <input type="text" class="upload_itemPrice" >
				</div>
				<div class="divider"></div>
				<div class="form-field">
					<label for="estTime">Time	</label> <input type="text" class="upload_estTime">
				</div>
			</div>
			
		</div>
		<button class="submit" onclick="addNewItemsToMenu()" style="float: right; margin-top: 10px; margin-left:20px; height: 40px;">Submit</button>
		<button class="submit" onclick="addNewUploadItem()" style="float: right; margin-top: 10px; height: 40px;">Add New</button>
</div>
<footer class="page-footer font-small blue" style="border-top:2.5px solid #9867C5; box-sizing: border-box;height: 3%;">

  <!-- Copyright -->
  <div class="footer-copyright " style=" text-align: center; margin-top: 10px;">© 2023 Copyright:
    <a href="https://www.linkedin.com/in/chinmaya-behera/" target="_blank"> Chinmaya Behera</a>
    <p style="float: right;margin-right: 20px;font-weight: bold">Version : 1.1</p>

  </div>
  <!-- Copyright -->

</footer>
<script type="text/javascript">

function removeTheCurrentItem(){
	
}

function addNewItemsToMenu(){
	
	console.log('Adding new items to Menu')
	var newItems= document.getElementsByClassName('signup-form');
	for (var i = 0; i < newItems.length; i++) {
		var name=newItems[i].getElementsByClassName('upload_itemName')[0];
		var category=newItems[i].getElementsByClassName('upload_category')[0];
		var price=newItems[i].getElementsByClassName('upload_itemPrice')[0];
		var time=newItems[i].getElementsByClassName('upload_estTime')[0];
		
		var itemData=JSON.stringify({
				'category':category.value,
				'estTime_min':time.value,
				'name': name.value,
				'price':price.value
				})
		$.ajax({
			url:"addNewItemsToMenu",
			type: 'POST',
			data: itemData,
			success: function(data, textStatus,jqXHR) {
				console.log("Ajax successful");
			},
			error: function(jqSHR,textStatus,errThrown){
				console.log("Ajax Error" );
				console.log(errThrown);
			}
		})
		
		name.value="";
		category.value="";
		price.value="";
		time.value="";
		
	}
	
}

function addNewUploadItem(){
	
	console.log('Entered The add new ELemt fucntion')

	var node_1 = document.createElement('DIV');
	node_1.setAttribute('class', 'signup-form');

	var node_2 = document.createElement('DIV');
	node_2.setAttribute('class', 'form-field');
	node_1.appendChild(node_2);

	var node_3 = document.createElement('LABEL');
	node_3.setAttribute('for', 'itemName');
	node_2.appendChild(node_3);

	var node_4 = document.createTextNode((new String("Name")));
	node_3.appendChild(node_4);

	var node_5 = document.createElement('INPUT');
	node_5.setAttribute('type', 'text');
	node_5.setAttribute('class', 'upload_itemName');
	node_2.appendChild(node_5);

	var node_6 = document.createElement('DIV');
	node_6.setAttribute('class', 'divider');
	node_1.appendChild(node_6);

	var node_7 = document.createElement('DIV');
	node_7.setAttribute('class', 'form-field');
	node_1.appendChild(node_7);

	var node_8 = document.createElement('LABEL');
	node_8.setAttribute('for', 'category');
	node_7.appendChild(node_8);

	var node_9 = document.createTextNode((new String("Category")));
	node_8.appendChild(node_9);

	var node_10 = document.createElement('INPUT');
	node_10.setAttribute('type', 'text');
	node_10.setAttribute('class', 'upload_category');
	node_7.appendChild(node_10);

	var node_11 = document.createElement('DIV');
	node_11.setAttribute('class', 'divider');
	node_1.appendChild(node_11);

	var node_12 = document.createElement('DIV');
	node_12.setAttribute('class', 'form-field');
	node_1.appendChild(node_12);

	var node_13 = document.createElement('LABEL');
	node_13.setAttribute('for', 'itemPrice');
	node_12.appendChild(node_13);

	var node_14 = document.createTextNode((new String("Price")));
	node_13.appendChild(node_14);

	var node_15 = document.createElement('INPUT');
	node_15.setAttribute('type', 'text');
	node_15.setAttribute('class', 'upload_itemPrice');
	node_12.appendChild(node_15);

	var node_16 = document.createElement('DIV');
	node_16.setAttribute('class', 'divider');
	node_1.appendChild(node_16);

	var node_17 = document.createElement('DIV');
	node_17.setAttribute('class', 'form-field');
	node_1.appendChild(node_17);

	var node_18 = document.createElement('LABEL');
	node_18.setAttribute('for', 'estTime');
	node_17.appendChild(node_18);
	
	var node_i = document.createTextNode((new String("Time")));
	node_18.appendChild(node_i);

	var node_19 = document.createElement('INPUT');
	node_19.setAttribute('type', 'text');
	node_19.setAttribute('class', 'upload_estTime');
	node_17.appendChild(node_19);
	/*Fetch the main Div   */
	var uploadBody= document.getElementsByClassName('upload-body');
	uploadBody[0].appendChild(node_1);
}
/* ============================== */
const inputs = document.querySelectorAll(".form-field input")

inputs.forEach(input => {
  const formField = input.parentNode
  input.onfocus = () => {
    formField.classList.add("has-focus")
  }
  input.onblur = () => {
    formField.classList.remove("has-focus")
  }
  
  input.oninput = (event) => {
    if (event.target.value) {
      formField.classList.add("is-dirty")
    } else {
        formField.classList.remove("is-dirty")
    }
  }
})
</script>
</body>
</html>