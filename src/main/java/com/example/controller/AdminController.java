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
import com.example.mapper.CampingAttachDAO;
import com.example.mapper.CampingDAO;
import com.example.mapper.IncomeDAO;
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
	CampingAttachDAO cadao;
	
	@Autowired
	ShopDAO sdao;
	
	@Autowired
	IncomeDAO idao;

	@RequestMapping("/admin")
	public String home(HttpSession session, Model model) {
		String uid = (String) session.getAttribute("uid");
		String uname = udao.login(uid).getUname();
		session.setAttribute("uname", uname);
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "income.jsp");
		return "home";
	}
	
	@RequestMapping("/admin/incomeProduct")
	public String incomeProduct(Model model) {
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "incomeProduct.jsp");
		return "home";
	}
	
	@RequestMapping("/admin/dayIncome.json")
	@ResponseBody
	public List<HashMap<String, Object>> getDayIncome(){
		return idao.getDayIncome();
	}
	
	@RequestMapping("/admin/dayProductIncome.json")
	@ResponseBody
	public List<HashMap<String, Object>> getDayProductIncome(){
		return idao.getDayProductIncome();
	}
	
	@RequestMapping("/admin/bestProductCount.json")
	@ResponseBody
	public List<HashMap<String, Object>> getBestProduct(){
		return idao.getBestProduct();
	}
	
	@RequestMapping("/admin/worstProductCount.json")
	@ResponseBody
	public List<HashMap<String, Object>> getWorstProduct(){
		return idao.getWorstProduct();
	}
	
	@RequestMapping("/admin/monthIncome.json")
	@ResponseBody
	public List<HashMap<String, Object>> getMonthIncome(){
		return idao.getMonthIncome();
	}
	
	@RequestMapping("/admin/bestCamping.json")
	@ResponseBody
	public List<HashMap<String, Object>> getBestCamping(){
		return idao.getBestCamping();
	}
	@RequestMapping("/admin/worstCamping.json")
	@ResponseBody
	public List<HashMap<String, Object>> getWorstCamping(){
		return idao.getWorstCamping();
	}
	
	//----------------------------------------캠핑장 관련 시작-----------------------------------------------------------
	// 관리자 페이지 캠핑장 리스트 연결
	@RequestMapping(value = "/admin/camping/list", method = RequestMethod.GET)
	public String adminCampList(Model model) {
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "campingList.jsp");
		return "home";
	}
	
	// 관리자 페이지 캠핑장 리스트 연결
	@RequestMapping(value = "/admin/camping/Reservelist", method = RequestMethod.GET)
	public String adminCampReservelist(Model model) {
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "campingReservList.jsp");
		return "home";
	}
	
	// 관리자 페이지 캠핑장 리스트 연결
	@RequestMapping(value = "/admin/camping/reserveread", method = RequestMethod.GET)
	public String adminCampReserveRead(Model model, int reser_no) {
		model.addAttribute("crr", cdao.campReservReadforAdmin(reser_no));
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "campingReservRead.jsp");
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
	
	// 관리자 페이지 캠핑장 예약 목록 json데이터
	@ResponseBody
	@RequestMapping("/admin/camping/Resevlist.json")
	public HashMap<String, Object> adminCampResevListJSON(Criteria cri) {
		HashMap<String, Object> map = new HashMap<>();
		cri.setPerPageNum(10);
		map.put("reservlist", cdao.campReservListforAdmin(cri));
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(cdao.campResevTotcount(cri));
		map.put("cri", cri);
		map.put("pm", pm);
		return map;
	}

	// 관리자 페이지 캠핑장 업데이트 페이지
	@RequestMapping(value = "/admin/camping/update", method = RequestMethod.GET)
	public String adminCampUpdate(Model model, String camp_id) {
		model.addAttribute("styleList", cdao.campStyleRead(camp_id));
		model.addAttribute("facilityList",cdao.campFacilityRead(camp_id));
		model.addAttribute("fList", cdao.campFacilityList());
		model.addAttribute("sList", cdao.campStyleList());
		model.addAttribute("attList", cadao.list(camp_id));
		model.addAttribute("cvo", cdao.campRead(camp_id));
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "campingUpdate.jsp");
		return "home";
	}
	//----------------------------------------캠핑장 관련 끝-----------------------------------------------------------
	
	//----------------------------------------회원 관련 시작-----------------------------------------------------------
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
		pm.setTotalCount(udao.userTotcount(cri));
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
	@RequestMapping(value = "/adminChat", method = RequestMethod.GET)
	public String adminChat(Model model) {
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "adminChat.jsp");
		return "home";
	}
	//----------------------------------------회원 관련 끝-----------------------------------------------------------
	
	//----------------------------------------상품 관련 시작-----------------------------------------------------------
	@RequestMapping(value="/admin/shop/list", method = RequestMethod.GET)
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
	
	@RequestMapping(value="/admin/order", method = RequestMethod.GET)
	public String adminShopOrder(Model model){
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "shopOrder.jsp");
		return "home";
	}
	
	//admin 상품 주문 현황
	@RequestMapping("/admin/order.json")
	@ResponseBody
	public HashMap<String, Object> adminShopJSON(Criteria cri){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", sdao.adminShopJSON(cri));
		map.put("cri", cri);
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(sdao.adminOrderCount(cri));
		
		map.put("pm", pm);
		
		return map;
	}
	
	@RequestMapping(value="/admin/orderInfo", method = RequestMethod.GET)
	public String adminOrderInfo(Model model, int pay_no, int cart_no){
		System.out.println(sdao.orderInfo(pay_no, cart_no));
		model.addAttribute("orderInfo", sdao.orderInfo(pay_no, cart_no));
		model.addAttribute("pageName", "admin/admin.jsp");
		model.addAttribute("adminPageName", "shopOrderInfo.jsp");
		return "home";
	}
	//----------------------------------------상품 관련 끝-----------------------------------------------------------
	
}