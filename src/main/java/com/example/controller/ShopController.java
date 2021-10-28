package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/shop")
public class ShopController {
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String shopList() {
		return "/shop/list";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String shopInsert() {
		return "/shop/insert";
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String shopRead() {
		return "/shop/read";
	}
}
