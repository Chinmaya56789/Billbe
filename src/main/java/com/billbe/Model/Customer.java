package com.billbe.Model;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Customer {
	private String customerId;
	private String name;
	@Id
	private String contact;
	private String address;
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	@Override
	public String toString() {
		return "Customer [customerId=" + customerId + ", name=" + name + ", contact=" + contact + ", address=" + address
				+ "]";
	}
	public Customer(String customerId, String name, String contact, String address) {
		super();
		this.customerId = customerId;
		this.name = name;
		this.contact = contact;
		this.address = address;
	}
	public Customer() {
		super();
		// TODO Auto-generated constructor stub
	}
}
