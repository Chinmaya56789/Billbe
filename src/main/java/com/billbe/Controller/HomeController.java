package com.billbe.Controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.billbe.Dao.HibernateDao;
import com.billbe.Model.Menu;
import com.billbe.Model.Customer;
import com.billbe.Model.Dborder;
import com.billbe.Model.User;
import com.google.gson.Gson;

@Controller
public class HomeController {
	ApplicationContext context=new ClassPathXmlApplicationContext("hibernateConfig.xml");
	HibernateDao dao=context.getBean("factory", HibernateDao.class);
	@RequestMapping("upload")
	public String upload( HttpServletRequest request, HttpServletResponse response) {
		
		return "upload";
	}
	@RequestMapping("/signup")
	public ModelAndView signup(HttpServletRequest requset, HttpServletResponse response)
	{
		ModelAndView mv= new ModelAndView();
		
		String name= requset.getParameter("name");
		String email= requset.getParameter("email");
		String password= requset.getParameter("password");
		String contact= requset.getParameter("contact");
		String address= requset.getParameter("address");
		Random random= new Random();
		if(contact.charAt(0)=='0')
			contact=contact.substring(1);
		String userId=name.substring(0,2)+contact.substring(6,10)+random.nextInt(9999);
		User user = new User(userId, password, name, contact, email, address);
		if(dao.emailValidator(email)!=null) {
			mv.setViewName("Signup");
			mv.addObject("sweetAlertCode",789);
		}
		else {
			mv.setViewName("Login");
			System.out.println(dao.insert(user));
			mv.addObject("sweetAlertCode",143);
		}
		
		return mv;

	}
	
	@RequestMapping("/loginValidator")
	public void home(HttpServletRequest request, HttpServletResponse response) throws IOException
	{	
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		User user=dao.emailValidator(email);
		if(user!=null && user.getPassword().equals(password)) {
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			response.sendRedirect(request.getContextPath() + "/redirectToHome");
		}
		else {
			response.sendRedirect(request.getContextPath() + "/wrongCredential");
		}
	}
	@RequestMapping("wrongCredential")
	public ModelAndView wrongCredential() {
		ModelAndView mv= new ModelAndView();
		mv.setViewName("Login");
		mv.addObject("sweetAlertCode",654);
		return mv;	}
	
	@RequestMapping("redirectToHome")
	public String redirectToHome(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session= request.getSession();
		session.setMaxInactiveInterval(24*60*60); // Session time out set to 3 hours.
		if(request.getSession(false)==null)
			return "Login";
		User u= (User) session.getAttribute("user");
		if (u==null) {
			return "Login";
			
		}
		List<Menu> menu=dao.getMenu(u.getEmail());
		Set<String> category= new LinkedHashSet<String>();
		for (Menu menu2 : menu) {
			category.add(menu2.getCategory());
		}
		
		session.setAttribute("Category", category);
		session.setAttribute("Menu", menu);
		return "Home";
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
	@RequestMapping("logout")
	public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session= request.getSession();
		session.removeAttribute("user");
		
		response.sendRedirect("redirectToLogin");
	}
	@RequestMapping("userProfile")
	public String  profile(){
		return "profile";
	}
	
	@RequestMapping("addNewItemsToMenu")
	
	public void addNewItemsToMenu(HttpServletRequest request, HttpServletResponse response) throws IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
		String json = "";
		if(br != null){
			json = br.readLine();
		}
		Gson g = new Gson(); 
		Menu menuItem = g.fromJson(json, Menu.class);
		HttpSession session= request.getSession();
		menuItem.setRestEmailId(((User)session.getAttribute("user")).getEmail());
		
		System.out.println(menuItem);
		dao.addNewMenu(menuItem);
	}
	@RequestMapping("billsave")
	public void billsave(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//System.out.println("entered Order Listing Ajax");
		BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
				String json = "";
				if(br != null){
					json = br.readLine();
				}
				Gson g = new Gson();  
				Dborder order = g.fromJson(json, Dborder.class);
				Customer cust= g.fromJson(json, Customer.class);
				
				//sending Ebill to customer 
				//List<Menu> orderedItems= dao.getOrderedMenu(order.getItemList());
				String sms="Hello "+cust.getName()+", Thank you for choosing us."+'\n'+'\n';
						sms+="----------------"+'\n'+"Total Amount Paid:"+order.getTotalPrice();
				if(order.isEbill()&&!cust.getName().isEmpty()&&!cust.getContact().isEmpty())
					System.out.println(sendSms(sms, cust.getContact())); 
					
					//saving Order and customer to server
				String checkCustomer=dao.checkCustomer(cust.getContact());
				order.setCustomerId(checkCustomer);
				if(!cust.getName().isEmpty()&&!cust.getContact().isEmpty()&&checkCustomer.isEmpty()) 
				{
					
					String customerId=cust.getName().substring(0,2)+(int)(Math.random()*100000);
					cust.setCustomerId(customerId);
					order.setCustomerId(customerId);
					System.out.println(dao.insert(cust));
				}
				
				order.setOrderId( Integer.toString((int)(Math.random() * 10000001 )));
				order.setOrderTimeStamp(new Date(System.currentTimeMillis()));
				
				System.out.println(dao.insert(order));	 
	}

	@RequestMapping("massCommunication")
	public void massCommunication(HttpServletRequest request, HttpServletResponse response) throws IOException {
		BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
		String json = "";
		if(br != null){
			json = br.readLine();
		}
		List<Customer> customers= dao.getallCustomer();
		String allContact="";
		for (Customer customer : customers) {
			allContact+=customer.getContact()+",";
		}
		System.out.println(sendSms(json, allContact));
		
	}
	private String sendSms(String sms, String contact) throws IOException {
		System.out.println(sms);
		String authorization = "LWu3KfQtm7bwXg8jVICe69iRnEOHN4sJd2kGcMzxlpABFYv0ayoXDF94greUBEp37s28HvubTywmd5cM";
				String route = "v3";
				String sender_id = "FTWSMS";
				String message = URLEncoder.encode(sms,"UTF-8");
				String language = "english";
				String numbers =contact;
				String flash = "0";
				String myUrl = "https://www.fast2sms.com/dev/bulkV2?authorization="+authorization+
							"&route="+route+
							"&sender_id="+sender_id+
							"&message="+message+
							"&language="+language+
							"&numbers="+numbers;
					URL url = new URL(myUrl);

				HttpsURLConnection con= (HttpsURLConnection)url.openConnection();
				con.setRequestMethod("GET");
				con.setRequestProperty("User-Agent", "Mozilla/5.0");
				con.setRequestProperty("cache-control", "no-cache");
				int respCode=con.getResponseCode();
				System.out.println("SMS seResponse Coede: "+respCode);
				StringBuffer response = new StringBuffer();
				BufferedReader br= new BufferedReader(new InputStreamReader(con.getInputStream()));
				while(true) {
					String line=br.readLine();
					if (line==null) {
						break;
					}
					response.append(line);
				}
				return "The SMS was sent successfully to customer !";
	}
}
