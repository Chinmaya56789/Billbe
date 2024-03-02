package com.billbe.Model;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Menu {
	@Id
	private int itemId;
	private String restEmailId;
	private String name;
	private int price;
	private String category;
	private int estTime_min;
	public String toString() {
		return "Menu [itemId=" + itemId + ", restEmailId=" + restEmailId + ", name=" + name + ", price=" + price
				+ ", category=" + category + ", estTime_min=" + estTime_min + "]";
	}
	public Menu(int itemId, String restEmailId, String name, int price, String category, int estTime_min) {
		super();
		this.itemId = itemId;
		this.restEmailId = restEmailId;
		this.name = name;
		this.price = price;
		this.category = category;
		this.estTime_min = estTime_min;
	}
	public Menu() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	public String getRestEmailId() {
		return restEmailId;
	}
	public void setRestEmailId(String restEmailId) {
		this.restEmailId = restEmailId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getEstTime_min() {
		return estTime_min;
	}
	public void setEstTime_min(int estTime_min) {
		this.estTime_min = estTime_min;
	}
}
