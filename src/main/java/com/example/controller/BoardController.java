package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String boardList() {
		return "/board/list";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String boardInsert() {
		return "/board/insert";
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String boardRead() {
		return "/board/read";
	}
}
