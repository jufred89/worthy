package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String userJoin() {
		return "/user/join";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String userLogin() {
		return "/user/login";
	}
	
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String userMypage() {
		return "/user/mypage";
	}
	

}
