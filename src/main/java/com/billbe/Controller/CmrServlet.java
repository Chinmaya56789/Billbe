package com.billbe.Controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;
import java.util.stream.Collectors;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sound.midi.SysexMessage;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.billbe.Dao.HibernateDao;
import com.billbe.Model.Customer;
import com.billbe.Model.Dborder;
import com.billbe.Model.Menu;
import com.billbe.Model.User;
import com.mysql.cj.x.protobuf.MysqlxDatatypes.Array;

@Controller
public class CmrServlet {
	ApplicationContext context=new ClassPathXmlApplicationContext("hibernateConfig.xml");
	HibernateDao dao=context.getBean("factory", HibernateDao.class);
	
	@RequestMapping("cmr")
	public String cmrDataGenerator(HttpServletRequest request, HttpServletResponse response) {
		//Dao request layer
		System.out.println("Entered cmrDataGenerator Contoller");
		HttpSession session=request.getSession();
		User user= (User) session.getAttribute("user");
		List<Menu> menu=(List<Menu>) session.getAttribute("Menu");
		List<Dborder> orders= dao.getOrder(user.getUserId());
		List<Customer> customer= dao.getallCustomer();
		List<Integer> allItems = new ArrayList<Integer>(); 
		List<String> allCust= new ArrayList<String>();
		Date today=new Date(System.currentTimeMillis());
		
		int msgCount=0;
		int monthlyOrderCount=0;
		//logic layer
		//System.err.println(orders.size());
		//int crt=1;
		int dayDiff;
		for (Dborder order : orders) {
			//System.err.println("Inside order itiration"+crt);
			allItems.addAll(Arrays.stream(order.getItemList()).boxed().collect(Collectors.toList()));
			//System.err.println();
			if(!order.getCustomerId().equals(""))
			allCust.add(order.getCustomerId());
			if(order.isEbill())
				msgCount++;
			dayDiff=(int) (((today.getTime()-order.getOrderTimeStamp().getTime())/ (1000 * 60 * 60 * 24))%365);
			if(dayDiff<= 30)
				monthlyOrderCount++;
			//crt++;
		}
		
		//System.err.println("Outside Order itiration");
		int[] temp=mostFreq(allItems);
		//System.err.println("===========================================MostSold item Called========================================");
		String mostSoldItem=dao.getIteMenu(temp[0]).getName()+" x "+temp[1];
		//System.err.println("===========================================MostSold item Ended========================================");
		String[] t=mostFreqString(allCust);
		String mostVisitedCustomer="";
		mostVisitedCustomer=dao.getCustomer(t[0]).getName()+" x "+t[1];
		
		String[] cmrResponse= new String[4];
		cmrResponse[0]=mostSoldItem; //Most sold Item
		cmrResponse[1]=mostVisitedCustomer; //most visited customer
		cmrResponse[2]=Integer.toString(msgCount);//total Message sent
		cmrResponse[3]=Integer.toString(monthlyOrderCount); //Total order this month
		session.setAttribute("cmrResponse", cmrResponse);
		//Pie chart Logic 
		
		Set<Integer> uq= new HashSet<Integer>(allItems);
		HashMap<String, Integer> itemFreq = new HashMap<>();
		//System.out.println(uq);
		int totalct=0;
		Menu mn= null;
		
		for (Integer i : uq) {
			
			 int tmp=Collections.frequency(allItems, i);
			 totalct+=tmp;
			 //System.err.println("===========================================Frequency item Called========================================");
			 mn =dao.getIteMenu(i);
			 //System.err.println("===========================================Frequency item Ended========================================");
			 if(mn!=null)
			 itemFreq.put(mn.getName(), tmp);
		}
		itemFreq=sortByValue(itemFreq);
		String[] piechartItemName= new String[5];
		int[] piechartItemCount = new int[5];
		int tempcount=0;
		for (Map.Entry<String, Integer> en : itemFreq.entrySet()) {
            if (tempcount==5) {
				break;
			}
            piechartItemName[tempcount]=en.getKey();
            piechartItemCount[tempcount]=en.getValue();
            totalct-=en.getValue();
            tempcount++;
        }
		session.setAttribute("piechartItemName", piechartItemName);
		session.setAttribute("piechartItemCount", piechartItemCount);
		session.setAttribute("totalct", totalct);
		//End of Pie chart logic
		
		//Start Bar chart 
		int dayinmili=1000*60*60*24;
		int barday1=0,barday2=0,barday3=0,barday4=0;
		int sale1=0,sale2=0,sale3=0,sale4=0;
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
		Date curTime= new Date(System.currentTimeMillis());
			for (Dborder i : orders) {
				if (formatter.format(curTime).equals(formatter.format(i.getOrderTimeStamp()))) {
					barday1++;
					sale1+=i.getTotalPrice();
				}
				if (formatter.format(curTime.getTime()-dayinmili).equals(formatter.format(i.getOrderTimeStamp()))) {
					barday2++;
					sale2+=i.getTotalPrice();
					}
				if (formatter.format(curTime.getTime()-dayinmili*2).equals(formatter.format(i.getOrderTimeStamp()))) {
					barday3++;
					sale3+=i.getTotalPrice();
					}
				if (formatter.format(curTime.getTime()-dayinmili*3).equals(formatter.format(i.getOrderTimeStamp()))) {
					barday4++;
					sale4+=i.getTotalPrice();
					}
			}
			int[] barchartorders= new int[] {barday1,barday2,barday3,barday4};
			int[] barchartsale=new int[] {sale1,sale2,sale3,sale4};
			String[] barchartdate= new String[] {formatter.format(curTime.getTime()-dayinmili*2),formatter.format(curTime.getTime()-dayinmili*3)};
			//System.out.println(Arrays.toString(barchartsale));
			//System.out.println(Arrays.toString(barchartorders));
			session.setAttribute("barchartorders", barchartorders);
			session.setAttribute("barchartsale", barchartsale);
			session.setAttribute("barchartdate", barchartdate);
		//end Of Bar chart
			System.out.println("End of cmrDataGenerator controller- Sending the CMR Data  ");
		return "cmr";
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////// USED METHOD-NOT PART OF MAIN SERVLET/////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public static HashMap<String, Integer> sortByValue(HashMap<String, Integer> hm)
    {
        // Create a list from elements of HashMap
        List<Map.Entry<String, Integer> > list =
               new LinkedList<Map.Entry<String, Integer> >(hm.entrySet());
 
        // Sort the list
        Collections.sort(list, new Comparator<Map.Entry<String, Integer> >() {
            public int compare(Map.Entry<String, Integer> o1,
                               Map.Entry<String, Integer> o2)
            {
                return (o2.getValue()).compareTo(o1.getValue());
            }
        });
         
        // put data from sorted list to hashmap
        HashMap<String, Integer> temp = new LinkedHashMap<String, Integer>();
        for (Map.Entry<String, Integer> aa : list) {
            temp.put(aa.getKey(), aa.getValue());
        }
        return temp;
    }
	public int[] mostFreq(List<Integer> arr) {
		
		System.out.println("mostFreq method called ");
		 Collections.sort(arr);
	        // find the max frequency using linear traversal
	        int max_count = 1, res = arr.get(0);
	        int curr_count = 1;
	 
	        for (int i = 1; i < arr.size(); i++) {
	            if (arr.get(i) == arr.get(i-1))
	                curr_count++;
	            else
	                curr_count = 1;
	 
	            if (curr_count > max_count) {
	                max_count = curr_count;
	                res = arr.get(i-1);
	            }
	        }
	        int[] ans= new int[2];
	        ans[0]=res;
	        ans[1]=max_count;
	        System.out.println("End of mostFreq method.");
	        return ans;
	}
	public String[] mostFreqString(List<String> arr) {
		System.out.println("mostFreqString method called ");
		 Collections.sort(arr);
	        // find the max frequency using linear traversal
	        int max_count = 1;
	        String res = arr.get(0);
	        int curr_count = 1;
	 
	        for (int i = 1; i < arr.size(); i++) {
	            if (arr.get(i).equals(arr.get(i-1)))
	                curr_count++;
	            else
	                curr_count = 1;
	 
	            if (curr_count > max_count) {
	                max_count = curr_count;
	                res = arr.get(i-1);
	            }
	        }
	        String[] ans= new String[2];
	        ans[0]=res;
	        ans[1]=Integer.toString(max_count);
	        System.out.println("End of mostFreqString");
	        return ans;
	}
}
