package com.ezwel.apm.controller.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	@RequestMapping("/")
	public String hello() {
		
		return "dashboard";
	}
	
	
	
}