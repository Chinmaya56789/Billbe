package com.billbe.Model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Dborder {
	
	private int est;
	@Id
	private String orderId;
	private String customerId;
	private String userId;
	private String itemList;
	private int totalPrice;
	private Date orderTimeStamp;
	private String paymentMode;
	private boolean ebill;
	
	public boolean isEbill() {
		return ebill;
	}
	public void setEbill(boolean ebill) {
		this.ebill = ebill;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPaymentMode() {
		return paymentMode;
	}
	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}
	public Date getOrderTimeStamp() {
		return orderTimeStamp;
	}
	public void setOrderTimeStamp(Date orderTimeStamp) {
		this.orderTimeStamp = orderTimeStamp;
	}
	public Dborder(int est, String orderId, String customerId, String itemList, int totalPrice, Date orderTimeStamp, String paymentMode, String userId, boolean ebill) {
		super();
		this.est = est;
		this.orderId = orderId;
		this.customerId = customerId;
		this.itemList = itemList;
		this.totalPrice = totalPrice;
		this.orderTimeStamp= orderTimeStamp;
		this.paymentMode=paymentMode;
		this.userId=userId;
		this.ebill=ebill;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public int[] getItemList() {
		
		String[] lst= itemList.split(",");
		int [] arr = new int [lst.length];
	      for(int i=0; i<lst.length; i++) {
	    	  if(!lst[i].equals(""))
	    		  arr[i] = Integer.parseInt(lst[i]);
	      }
		return arr;
	}
	public void setItemList(String itemList) {
		this.itemList = itemList;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	
	public int getEst() {
		return est;
	}
	public void setEst(int est) {
		this.est = est;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public Dborder() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "Dborder [est=" + est + ", orderId=" + orderId + ", customerId=" + customerId + ", userId=" + userId
				+ ", itemList=" + itemList + ", totalPrice=" + totalPrice + ", orderTimeStamp=" + orderTimeStamp
				+ ", paymentMode=" + paymentMode + ", ebill=" + ebill + "]";
	}



	
	
	
}
