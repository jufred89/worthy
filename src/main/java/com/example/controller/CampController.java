package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/camping")
public class CampController {
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String campingList() {
		return "/camping/list";
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String campingRead() {
		return "/camping/read";
	}
}
