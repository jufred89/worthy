package com.example.controller;


import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.CampingVO;
import com.example.mapper.CampingDAO;
import com.example.mapper.UserDAO;

@Controller
@RequestMapping("/")
public class AdminController {
	@Autowired
	UserDAO udao;
	
	@Autowired
	CampingDAO cdao;
	
   @RequestMapping("/admin")
   public String home(HttpSession session, Model model) {
		String uid = (String)session.getAttribute("uid");
		String uname = udao.login(uid).getUname();
		session.setAttribute("uname", uname);
	    model.addAttribute("pageName", "admin/admin.jsp");
      return "home";
   }
   
	//관리자 페이지 캠핑장 리스트 연결
	@RequestMapping(value = "/admin/camping/list", method = RequestMethod.GET)
	public String adminCampList(Model model) {
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "campingList.jsp");
		return "home";
	}
	
	//관리자 페이지 캠핑장 목록 json데이터
	@ResponseBody
   @RequestMapping("/admin/camping/list.json")
   public List<CampingVO> adminCampListJSON(Model model) {
		return cdao.campList();
   }

}