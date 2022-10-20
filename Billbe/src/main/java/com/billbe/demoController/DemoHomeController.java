package com.billbe.demoController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DemoHomeController {
@RequestMapping("/demo")
public String demo() {
	System.out.println("Entered The Demo");
	return "demo";
}
}
