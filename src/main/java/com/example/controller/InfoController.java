package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/info")
public class InfoController {
	
	//공지사항
	@RequestMapping(value = "/notice/list", method = RequestMethod.GET)
	public String noticeList() {
		return "/info/notice_list";
	}
	
	@RequestMapping(value = "/notice/insert", method = RequestMethod.GET)
	public String noticeInsert() {
		return "/info/notice_insert";
	}
	
	@RequestMapping(value = "/notice/read", method = RequestMethod.GET)
	public String noticeRead() {
		return "/info/notice_read";
	}
	
	
	//팁
	@RequestMapping(value = "/tip/list", method = RequestMethod.GET)
	public String tipList() {
		return "/info/tip_list";
	}
	
	@RequestMapping(value = "/tip/insert", method = RequestMethod.GET)
	public String tipInsert() {
		return "/info/tip_insert";
	}
	
	@RequestMapping(value = "/tip/read", method = RequestMethod.GET)
	public String tipRead() {
		return "/info/tip_read";
	}
	
	
	//레시피
	@RequestMapping(value = "/recipe/list", method = RequestMethod.GET)
	public String recipeList() {
		return "/info/recipe_list";
	}
	
	@RequestMapping(value = "/recipe/insert", method = RequestMethod.GET)
	public String recipeInsert() {
		return "/info/recipe_insert";
	}
	
	@RequestMapping(value = "/recipe/read", method = RequestMethod.GET)
	public String recipeRead() {
		return "/info/recipe_read";
	}
}
