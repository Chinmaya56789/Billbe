<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.billbe.Model.User"%>
    <% 
	User user= (User)session.getAttribute("user");
    String[] cmrResponse= (String[])session.getAttribute("cmrResponse");
    String[] piechartItemName= (String[])session.getAttribute("piechartItemName");
    int[] piechartItemCount= (int[])session.getAttribute("piechartItemCount");
    int totalct= (int)session.getAttribute("totalct");
    int[] barchartorders= (int[])session.getAttribute("barchartorders");
    int[] barchartsale= (int[])session.getAttribute("barchartsale");
    String[] barchartdate= (String[])session.getAttribute("barchartdate");
	if(user==null){
	response.sendRedirect("redirectToLogin"); 
	}
	%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<style type="text/css">
	<%@include file="CSS/Home_Style.css"%>

.row {
	width: 100%;
	height: 50%;
	
	margin: 0;
}

.row>div {
	height: 100%;
	width: 50%;
	padding: 25px;
	overflow: auto;
	border-radius: 20px;
	
}
#massCommunication{
display:block;
margin: 0 auto;
}
#sendMassCommunication{
display:block;
margin: 20px auto;
}
#sendMassCommunication:active{
background-color: white;
color:black
}
#piechart-1,barchart-1{
display: block;
margin: 0 auto;
width: 300px;
font-family: inherit !important;
}
</style>
<title>Billebe - CMR</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> <!--  Google icons link -->
</head>
<body>
<div class="container-fluid main" style="overflow: auto;"> 
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
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
    <form class="form-inline my-2 my-lg-0" action="javascript:itemSearch(search_text)">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" autofocus="autofocus" aria-label="Search" id="search_text" name="search_text">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>
   	<!-- End Of NAV Bar -->
<div class="container-fluid content_body">
	<div class="row">
		<div style="border-bottom: 1px solid green; border-right: 1px solid green;box-shadow: rgba(0, 0, 0, 0.1) 0px 4px 12px;"> 
			<p class="text-center" style="font-weight: bolder">Statistics</p>
					<table class="table">
							<tr>
								<td style="text-align: center;">Most Sold items :</td>
								<td style="text-align: center;"><%=cmrResponse[0] %></td>
							</tr>
							<tr>
								<td style="text-align: center;">Most Visited Customer :</td>
								<td style="text-align: center;"><%=cmrResponse[1] %> </td>
							</tr>
							<tr>
								<td style="text-align: center;">No of messages sent :</td>
								<td style="text-align: center;"><%=cmrResponse[2] %></td>
							</tr>
							<tr>
								<td style="text-align: center;">Sales Last Month :</td>
								<td style="text-align: center;"><%=cmrResponse[3] %></td>
							</tr>
					</table>

				</div>
		<div>
			<p class="text-center" style="font-weight: bolder">Customer Communication</p>
			<textarea rows="5" cols=" 40" name="massCommunication" id="massCommunication" placeholder="Word limit: 150 Letters."></textarea>
			<button id="sendMassCommunication" class="btn btn-secondary" onclick="massCommunication()"> Send to all Customer</button>
		</div>
	</div>
	<div class="row">
		<div>
			<div id="piechart-1" ></div>
		</div>
		<div style="border-top: 1px solid green; border-left: 1px solid green;box-shadow: rgba(0, 0, 0, 0.1) 0px 4px 12px;">
			<div id="barchart-1" ></div>
			<div id="barchart-2" ></div>
		</div>
	</div>
</div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Date', 'OrderCount'],
          ['Today', <%=barchartorders[0] %>],
          ['Yesterday', <%=barchartorders[1] %>],
          ['<%=barchartdate[0] %>', <%=barchartorders[2] %>],
          ['<%=barchartdate[1] %>',<%=barchartorders[3] %>]
        ]);

        var options = {
          chart: {
            title: 'Order Count',
            subtitle: 'Total order received in last 4 days',
          },
          bars: 'horizontal' // Required for Material Bar Charts.
        };

        var chart = new google.charts.Bar(document.getElementById('barchart-1'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
    </script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Date', 'Total Sale'],
          ['Today', <%=barchartsale[0] %>],
          ['Yesterday', <%=barchartsale[1] %>],
          ['<%=barchartdate[0] %>', <%=barchartsale[2] %>],
          ['<%=barchartdate[1] %>', <%=barchartsale[3] %>]
        ]);

        var options = {
          chart: {
            title: 'Total Sale',
            subtitle: 'Totsl Sales made in last 4 days',
          },
          bars: 'horizontal' // Required for Material Bar Charts.
        };

        var chart = new google.charts.Bar(document.getElementById('barchart-2'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
    </script>
<script type="text/javascript">

//Piechart for order

google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

// Draw the chart and set the chart values
function drawChart() {
  var data = google.visualization.arrayToDataTable([
  ['Item', 'Order Count'],
  ['<%=piechartItemName[0] %>', <%=piechartItemCount[0] %>],
  ['<%=piechartItemName[1] %>', <%=piechartItemCount[1] %>],
  ['<%=piechartItemName[2] %>', <%=piechartItemCount[2] %>],
  ['<%=piechartItemName[3] %>', <%=piechartItemCount[3] %>],
  ['<%=piechartItemName[4] %>', <%=piechartItemCount[4] %>],
  ['Other', <%=totalct %>],

]);

  // Optional; add a title and set the width and height of the chart
  var options = {'title':'Favorite Items', 'width':400, 'height':250};

  // Display the chart inside the <div> element with id="piechart"
  var chart = new google.visualization.PieChart(document.getElementById('piechart-1'));
  chart.draw(data, options);
  
  ////////////////////////////////////////////BAR CHART///////////////
  ///////////////////////////////////////////////////////////////////
}
//Calling servlet for Mass Communication

function massCommunication() {
	var message= document.getElementById("massCommunication");
	console.log(message.value);
	$.ajax({
		url:"massCommunication",
		type: 'POST',
		data: message.value,
		success: function(data, textStatus,jqXHR) {
			console.log("Ajax successful");
			message.value="";
			swal("Success", "The Message Was Sent Successfully !", "success");
		},
		error: function(jqSHR,textStatus,errThrown){
			console.log("Ajax Error" );
			console.log(errThrown);
			swal("Error", "The Message Was Sent Successfully !", "error");
		}
	})
}

</script>

</body>
</html>