package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class MyPageController {
	
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String mypage(Model model) {
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName","mycamping.jsp");
		return "home";
	}
	
	@RequestMapping(value = "/myinfo", method = RequestMethod.GET)
	public String myinfo(Model model) {
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName","myinfo.jsp");
		return "home";
	}
	
	@RequestMapping(value = "/myshop", method = RequestMethod.GET)
	public String myshop(Model model) {
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName","myshop.jsp");
		return "home";
	}
}
 