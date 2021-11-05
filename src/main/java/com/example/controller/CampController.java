package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.CampingVO;
import com.example.mapper.CampingDAO;

@Controller
@RequestMapping("/camping")
public class CampController {
	@Autowired
	CampingDAO cdao;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String campingList() {
		return "/camping/list";
	}
	
	@ResponseBody
	@RequestMapping(value = "/list.json", method = RequestMethod.GET)
	public List<CampingVO> list() {
		return cdao.campList();
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String campingRead(Model model, String camp_id) {
		model.addAttribute("cvo",cdao.campRead(camp_id));
		return "/camping/read";
	}
	
	@ResponseBody
	@RequestMapping(value = "/cslist.json", method = RequestMethod.GET)
	public List<CampingVO> campStyleRead(String camp_id) {
		return cdao.campStyleRead(camp_id);
	}
	
	@ResponseBody
	@RequestMapping(value = "/cflist.json", method = RequestMethod.GET)
	public List<CampingVO> campFacilityRead(String camp_id) {
		return cdao.campFacilityRead(camp_id);
	}
}
