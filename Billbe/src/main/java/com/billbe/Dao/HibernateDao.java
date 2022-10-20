package com.billbe.Dao;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.springframework.orm.hibernate5.HibernateTemplate;

import com.billbe.Model.User;

import jakarta.transaction.Transactional;

public class HibernateDao {
	
	private HibernateTemplate hibernatetemp;
	public HibernateTemplate getHibernatetemp() {
		return hibernatetemp;
	}
	public void setHibernatetemp(HibernateTemplate hibernatetemp) {
		this.hibernatetemp = hibernatetemp;
	}
	@Transactional
	public int insert(User user)
	{
		Integer i= (Integer)hibernatetemp.save(user);
		return 1;
	}
	public static void main(String[] args) {
		SessionFactory factory = new Configuration().configure().buildSessionFactory();
		System.out.println(factory.isClosed());	
	}
}
