package com.billbe.Dao;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import javax.persistence.Query;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.NativeQuery;
import org.springframework.orm.hibernate5.HibernateTemplate;
import com.billbe.Model.Menu;
import com.billbe.Model.Customer;
import com.billbe.Model.Dborder;
import com.billbe.Model.User;



public class HibernateDao {
	
	private HibernateTemplate hibernatetemp;
	public HibernateTemplate getHibernatetemp() {
		return hibernatetemp;
	}
	public void setHibernatetemp(HibernateTemplate hibernatetemp) {
		this.hibernatetemp = hibernatetemp;
	}
	SessionFactory factory= new Configuration().configure().buildSessionFactory();
	
	@Transactional
	public void addNewMenu(Menu menuItem) {
		// TODO Auto-generated method stub
		try {
			hibernatetemp.save(menuItem);
			System.out.println("New Item Added to System");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("HibernateDao.java->addNewMenu(Menu): "+e.getMessage());
		}
	}
	@Transactional
	public String insert(User user)
	{
		try {
			hibernatetemp.save(user);
			return "User Added to System";
		} catch (Exception e) {
			// TODO: handle exception
			return "HibernateDao.java->Insert(User): "+e.getMessage();
		}
		
		
	}
	@Transactional
	public String insert(Dborder order)
	{
		if (order.getItemList().length==0) {
			return "Order was Empty";
		}
		try {
			hibernatetemp.save(order);
			return "Order Added to server";
		} catch (Exception e) {
			// TODO: handle exception
			return "HibernateDao.java->Insert(Order): "+e.getMessage();
		}
		
		
	}
	@Transactional
	public String insert(Customer cust) {
		try {
			hibernatetemp.save(cust);
			return "New Customer Added to server";
		} catch (Exception e) {
			// TODO: handle exception
			return "HibernateDao.java->Insert(Cust): "+e.getMessage();
		}
	}
	
	@Transactional
	public User emailValidator(String email) {
		User user = new User();
		try {
			user= this.hibernatetemp.get(User.class, email);
		} catch (Exception e) {
			return null;
		}
		return user;
	}
	@Transactional
	public String checkCustomer(String contact) {
		Customer cust = new Customer();
		try {
			cust= this.hibernatetemp.get(Customer.class, contact);
			return cust.getCustomerId();
		} catch (Exception e) {
			return "";
		}

	}
	
	public List<Menu> getMenu(String email) {
		
		
//		Menu m = new Menu(1,"chinmayabhera866@gmail.coma","gulab jamun",12,"Dessert",5);
		
		Session session=factory.openSession();
		Transaction tx= session.beginTransaction();
//		session.save(m);
//		tx.commit();
		org.hibernate.Query q= session.createQuery("from Menu where restEmailId='"+email+"'");
//		q.setString("email", "chinmayabhera866@gmail.coma");
		List<Menu> menu=(List<Menu>)q.list();
		System.out.println("HibernateDao.java->getmenu(email) :menu loaded Successfully.");
		session.close();
		return menu;
	}
	public List<Menu> getOrderedMenu(String[] itemList) {
		Menu item = new Menu();
		List<Menu> lst= new ArrayList<Menu>();
		for (int i = 0; i < itemList.length; i++) {
			
			try {
				item= this.hibernatetemp.get(Menu.class, Integer.parseInt(itemList[i]));
				lst.add(item);
			} catch (Exception e) {
				return null;
			}
		}
		return lst;
	}
	public List<Dborder> getOrder(String userId) {
		Session session=factory.openSession();
		Transaction tx= session.beginTransaction();
		org.hibernate.Query q= session.createQuery("from Dborder where userId='"+userId+"'");
		@SuppressWarnings({ "deprecation", "unchecked" })
		List<Dborder> orders=(List<Dborder>)q.list();
		//System.out.println("Retrived the order details");
		session.close();
		return orders;
	}
	public List<Customer> getallCustomer() {
		// TODO Auto-generated method stub
		Session session=factory.openSession();
		Transaction tx= session.beginTransaction();
		org.hibernate.Query q= session.createQuery("from Customer");
		@SuppressWarnings({ "deprecation", "unchecked" })
		List<Customer> customer=(List<Customer>)q.list();
		//System.out.println("Retrived the Customer details");
		session.close();
		
		return customer;
	}
	public Customer getCustomer(String id) {
		// TODO Auto-generated method stub
		Session session=factory.openSession();
		Transaction tx= session.beginTransaction();
		org.hibernate.Query q= session.createQuery("from Customer where customerId='"+id+"'");
		@SuppressWarnings({ "deprecation", "unchecked" })
		List<Customer> customer=(List<Customer>)q.list();
		
		session.close();
		
		return customer.get(0);
	}
	public Menu getIteMenu(int id) {
		// TODO Auto-generated method stub
		
		Session session=factory.openSession();
		
		Transaction tx= session.beginTransaction();
		
		org.hibernate.Query q= session.createQuery("from Menu where itemId='"+id+"'");
		
		
		List<Menu> item=new ArrayList<Menu>();
		
		
		try {
			item=(List<Menu>)q.list();
		} catch (Exception e) {
			return null;
		}
		
		session.close();
		
		return item.get(0)!=null?item.get(0):null;
	}
	
	
	
	
	
}
