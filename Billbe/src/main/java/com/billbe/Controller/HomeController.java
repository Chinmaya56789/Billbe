package com.billbe.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.billbe.Dao.HibernateDao;
import com.billbe.Model.User;

@Controller
public class HomeController {
	@RequestMapping("/signup")
	public ModelAndView home(HttpServletRequest requset, HttpServletResponse response)
	{
		ModelAndView mv= new ModelAndView();
		mv.setViewName("Login");
		String name= requset.getParameter("name");
		String email= requset.getParameter("email");
		String password= requset.getParameter("password");
		String contact= requset.getParameter("contact");
		String address= requset.getParameter("address");
		int min =1000;
		int max= 9999;
		String userId=name.substring(0,2)+contact.substring(6,10)+(Math.random() * (max - min) + min);
		User user = new User(userId, password, name, contact, email, address);
		ApplicationContext context=new ClassPathXmlApplicationContext("hibernateConfig.xml");
		HibernateDao dao= context.getBean("factory", HibernateDao.class);
		int i=dao.insert(user);
//		mv.addObject("signup_flag",);
		System.out.println("The task runned by the Hibernate :"+ i);
		return mv;
	}
	@RequestMapping("/redirectToLogin")
	public String redirectToLogin()
	{
		return "Login";
	}
	@RequestMapping("redirectToSignup")
	public String redirectToSignup()
	{
		System.out.println("hello in signup servlet");
		return "Signup";
	}
	@RequestMapping("/forgotpassword")
	public String forgotpassword()
	{
		return "forget";
	}
}
