package com.example.controller;

import java.util.HashMap;
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
import com.example.domain.Criteria;
import com.example.domain.PageMaker;
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
		String uid = (String) session.getAttribute("uid");
		String uname = udao.login(uid).getUname();
		session.setAttribute("uname", uname);
		model.addAttribute("pageName", "admin/admin.jsp");
		return "home";
	}
	//----------------------------------------캠핑장 관련 시작-----------------------------------------------------------
	// 관리자 페이지 캠핑장 리스트 연결
	@RequestMapping(value = "/admin/camping/list", method = RequestMethod.GET)
	public String adminCampList(Model model) {
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "campingList.jsp");
		return "home";
	}

	@RequestMapping(value = "/admin/camping/insert", method = RequestMethod.GET)
	public String adminCampInsert(Model model) {
		String maxCode = cdao.maxCode();
		String camp_id = "c" + (Integer.parseInt(maxCode.substring(1)) + 1);
		model.addAttribute("camp_id", camp_id);
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "campingInsert.jsp");
		return "home";
	}

	// 관리자 페이지 캠핑장 목록 json데이터
	@ResponseBody
	@RequestMapping("/admin/camping/list.json")
	public HashMap<String, Object> adminCampListJSON(Criteria cri) {
		HashMap<String, Object> map = new HashMap<>();
		cri.setPerPageNum(10);
		map.put("list", cdao.campList(cri));

		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(cdao.campTotcount(cri));
		map.put("cri", cri);
		map.put("pm", pm);
		return map;
	}

	// 관리자 페이지 캠핑장 업데이트 페이지
	@RequestMapping(value = "/admin/camping/update", method = RequestMethod.GET)
	public String adminCampUpdate(Model model, String camp_id) {
		model.addAttribute("styleList",cdao.campFacilityRead(camp_id));
		model.addAttribute("cvo", cdao.campRead(camp_id));
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "campingUpdate.jsp");
		return "home";
	}
	//----------------------------------------캠핑장 관련 끝-----------------------------------------------------------
}