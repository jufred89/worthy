package com.example.controller;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.mapper.NoticeDAO;

@Controller
public class HomeController {
	@Autowired
	NoticeDAO ndao;
	
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
	
	//공지사항
	@RequestMapping(value = "/notice/list", method = RequestMethod.GET)
	public String noticeList(Model model) {
		model.addAttribute("pageName", "info/notice_list.jsp");
		return "home";
	}

<<<<<<< HEAD
	@RequestMapping(value = "/notice/insert", method = RequestMethod.GET)
	public String noticeInsert(Model model) {
		model.addAttribute("pageName", "info/notice_insert.jsp");
		return "home";
	}
	
	//팁
	@RequestMapping(value = "/tip/list", method = RequestMethod.GET)
	public String tipList(Model model) {
		model.addAttribute("pageName", "info/tip_list.jsp");
		return "home";
	}
	
	@RequestMapping(value = "/tip/insert", method = RequestMethod.GET)
	public String tipInsert(Model model) {
		model.addAttribute("pageName", "info/tip_insert.jsp");
		return "home";
	}
	
	//레시피
	@RequestMapping(value = "/recipe/list", method = RequestMethod.GET)
	public String recipeList(Model model) {
		model.addAttribute("pageName", "info/recipe_list.jsp");
=======

	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public String info(Model model) {
		model.addAttribute("pageName", "info.jsp");
>>>>>>> a5bd56885ef774485a075d0122f678efd122802f
		return "home";
	}

	@RequestMapping(value = "/recipe/insert", method = RequestMethod.GET)
	public String recipeInsert(Model model) {
		model.addAttribute("pageName", "info/recipe_insert.jsp");
		return "home";
	}
	
}