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
import com.example.domain.UserVO;
import com.example.domain.ShopVO;
import com.example.mapper.CampingDAO;
import com.example.mapper.ShopDAO;
import com.example.mapper.UserDAO;

@Controller
@RequestMapping("/")
public class AdminController {
	@Autowired
	UserDAO udao;

	@Autowired
	CampingDAO cdao;
	
	@Autowired
	ShopDAO sdao;

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

	//-----------------------------회원관리 --------------------
	@RequestMapping(value="/admin/user/list",method = RequestMethod.GET)
	public String list(Model model){
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "userlist.jsp");
		return "home";
	}
	@RequestMapping(value="/admin/userlist.json", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> adminUserListJSON(Criteria cri) {
		HashMap<String, Object> map = new HashMap<>();
		cri.setPerPageNum(10);
		map.put("list", udao.list(cri));

		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		map.put("cri", cri);
		map.put("pm", pm);
		return map;
	}
	@RequestMapping("/admin/user/read")
	public String read(Model model,String uid){
		model.addAttribute("vo",udao.read(uid));
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "userread.jsp");
		return "home";
	}

	@RequestMapping(value = "/admin/user/update", method = RequestMethod.POST)
	public String adminUserUpdate(Model model, UserVO vo) {
		vo.setAddress(vo.getAddress()+" "+vo.getDetail());
		System.out.println(vo.toString());
		udao.adminupdate(vo);
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "userread.jsp");
		return "redirect:/admin/user/list";
	}

	//----------------------------------------상품 관련 시작-----------------------------------------------------------
	
	@RequestMapping("/admin/shop/list")
	public String adminList(Model model){
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "shopList.jsp");
		return "home";
	}
	
	@RequestMapping("/admin/shop/list.json")
	@ResponseBody
	public HashMap<String, Object> adminListJSON(Criteria cri) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("list", sdao.adminListJSON(cri));
		map.put("cri", cri);

		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(sdao.adminTotalCount(cri));

		map.put("pm", pm);
		return map;
	}
	
	@RequestMapping("/admin/shop/qty_update")
	@ResponseBody
	public void adminQtyupdate(ShopVO vo){
		sdao.adminQtyUpdate(vo);
	}
	
	@RequestMapping("/admin/shop/hide_update")
	@ResponseBody
	public void adminHideupdate(ShopVO vo){
		System.out.println(vo.toString());
		sdao.adminHideUpdate(vo);
	}
	
}