package com.example.controller;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		model.addAttribute("pageName", "about.jsp");
		return "home";
	}

	@RequestMapping(value = "/shop", method = RequestMethod.GET)
	public String shop(Model model) {
		model.addAttribute("pageName", "shop/list.jsp");
		return "home";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model) {
		model.addAttribute("pageName", "user/login.jsp");
		return "home";
	}

	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join(Model model) {
		model.addAttribute("pageName", "user/join.jsp");
		return "home";
	}

	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public String info(Model model) {
		model.addAttribute("pageName", "info.jsp");
		return "home";
	}

}