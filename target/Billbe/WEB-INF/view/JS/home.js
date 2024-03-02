/**
 * 
 */
 
 

var bill=[];
var itemId=[];
var estTime=0;
var paymentMode="cash";

//clearing the bill items 

function clearBill(){
	
	bill.length=0;
	billUpdater();
}
/* Plus and minus of items */
function addItem(index) {
  	bill[index]['count']+=1;
  	billUpdater();
}
function removeItem(index) {
	if(bill[index]['count']==1)
		bill.splice(index,1);
	else
  	bill[index]['count']-=1;
  	billUpdater();
}

 

	/* Add to bill list */
	function checkOrderList(itemName) {
		for (i in bill)
			{
			if(bill[i]['name']==itemName){
				bill[i]['count']+=1;
				return true;
			}
				
			}
	}
	function addToBill(id,name,price,time){
		if(checkOrderList(name)){}
		else{
		bill.push({
			'name':name,
			'plus':"-",
			'count':1,
			'minus':"+",
			'price':price
		});	
			if(estTime<parseInt(time))
			estTime=parseInt(time);
		}
		itemId.push(id);
		billUpdater();
		
	}

	
	/* Bill count updater  */
	
	function billUpdater(){
		var total=0;
		var del=document.getElementsByClassName('tb_row');
		var ln=del.length;
		for (var k =0; k<ln;k++)
			del[0].remove();
		for (i in bill){
			var table= document.getElementById("bill_screen");
			var t_row=document.createElement("tr");
			t_row.className="tb_row";
			for( j in bill[i]){
				var value= bill[i][j];
				var col_1=document.createElement("td");
				if(j=='price'){
					value=bill[i]['count']*value;
					total+=value;
				}
					
				var node=document.createTextNode(value);
				col_1.appendChild(node);
				t_row.appendChild(col_1);
				if(value=='+')
					{
					col_1.setAttribute("onclick","addItem("+i+")");
					}
					col_1.setAttribute("onclick","addItem("+i+")");
				if(value=='-')
					col_1.setAttribute("onclick","removeItem("+i+")");
				
				table.appendChild(t_row);
			}
		}
		document.getElementById("total_span").innerHTML=total;
		
	}
	/* Function for Loader */
	function ldr (){
		var laoder= document.getElementById("loader");
		loader.style.display="none";
	}
	
	/* Category wise items sort  */
	function items(event) {
		var header= document.getElementById("mnu");
		var child= header.childNodes;
		for (var i = 1; i < child.length; i=i+2) {
			if(child[i].className.includes(event))
				child[i].style.display = "inline-block";	
			else
				child[i].style.display = "none";				
		}
		
	}
	
	/* Search bar  */
	function itemSearch(search){
		var header= document.getElementById("mnu");
		var child= header.childNodes;
		for (var i = 1; i < child.length; i=i+2) {
			if(child[i].textContent.toLowerCase().includes(search.value.toLowerCase().trim()))
				{
				child[i].style.display = "inline-block";
				}
				
			else
				child[i].style.display = "none";				
		}
	}
	

//<!-- Active Button Script -->
// Add active class to the current button (highlight it)
var cat_header = document.getElementById("categ");
var btns_1 = cat_header.getElementsByClassName("menu_cat");

for (var i = 0; i < btns_1.length; i++) {
  btns_1[i].addEventListener("click", function() {
  var current = cat_header.getElementsByClassName("active");
  current[0].className = current[0].className.replace(" active", "");
  this.className += " active";
  });
}

//Highlighting code for the payment option
var payment_header = document.getElementById("payment_method");
var btns = payment_header.getElementsByClassName("payment_option");

for (var i = 0; i < btns.length; i++) {
  btns[i].addEventListener("click", function() {
  var current= payment_header.getElementsByClassName("active");
  current[0].className = current[0].className.replace(" active", "");
  this.className += " active";
  paymentMode=this.innerHTML;
  });
}

//Highlighting code for the item_customer tab

function switch_item_customer(a){
	var header= document.getElementById("right_bill");
	var screens = header.getElementsByClassName("bill_screen");
	if(a==0){
		screens[0].style.display="block";
		screens[1].style.display="none";
	}
	else{
		screens[1].style.display="block";
		screens[0].style.display="none";
	}
}
var a = document.getElementById("item_customer_tab");
var b = a.getElementsByTagName("a");

for (var i = 0; i < b.length; i++) {
  b[i].addEventListener("click", function() {
  var current= a.getElementsByClassName("active");
  current[0].className = current[0].className.replace(" active", "");
  this.className += " active";
  });
}

//<!-- End_Active Button Script -->	