package com.billbe.Model;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class User {
	
	private String userId;
	private String password;
	private String name;
	private String contact;
	@Id
	private String email;
	private String address;
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	public User(String userId, String password, String name, String contact, String email, String address) {
		super();
		this.userId = userId;
		this.password = password;
		this.name = name;
		this.contact = contact;
		this.email = email;
		this.address = address;
	}
	@Override
	public String toString() {
		return "User [userId=" + userId + ", password=" + password + ", name=" + name + ", contact=" + contact
				+ ", email=" + email + ", address=" + address + "]";
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
}
