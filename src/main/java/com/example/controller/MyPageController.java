package com.example.controller;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.CampingReserVO;
import com.example.domain.ChatVO;
import com.example.domain.UserVO;
import com.example.mapper.CampingDAO;
import com.example.mapper.ChatDAO;
import com.example.mapper.ShopDAO;
import com.example.mapper.UserDAO;

@Controller
@RequestMapping("/")
public class MyPageController {
	@Autowired
	UserDAO udao;

	@Autowired
	ChatDAO cdao;
	
	@Autowired
	CampingDAO campDAO;
	
	@Autowired
	ShopDAO sdao;

	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String mypage(Model model, HttpSession session) {
		String uid = (String) session.getAttribute("uid");
		String uname = udao.login(uid).getUname();
		
		// 현재 날짜 구하기 (시스템 시계, 시스템 타임존)
		LocalDate now = LocalDate.now(ZoneId.of("Asia/Seoul"));
		
		session.setAttribute("uname", uname);
		model.addAttribute("campReserNextList", campDAO.campReservationUserNext(uid));
		model.addAttribute("campReserPrevList", campDAO.campReservationUserPrev(uid));
		model.addAttribute("campReserCancelList", campDAO.campReservationUserCancel(uid,"0"));
		model.addAttribute("now", now);
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName", "mycamping.jsp");
		return "home";
	}

	// ����ķ���� ������ �̵�
	@RequestMapping(value = "/mycampingLike", method = RequestMethod.GET)
	public String mycampingLike(Model model, HttpSession session) {
		String uid = (String) session.getAttribute("uid");
		model.addAttribute("campLikeList", campDAO.campLikeUserCheck(uid));
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName", "mycampingLike.jsp");
		return "home";
	}
	
	// 캠핑 취소 페이지 연결
	@RequestMapping(value = "/mycampingCancel", method = RequestMethod.GET)
	public String mycampingCancel(Model model, int reser_no) {
		model.addAttribute("campData", campDAO.campCancelData(reser_no));
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName", "mycampingCancel.jsp");
		return "home";
	}
	
	@RequestMapping(value="/mycampingCancelRequest", method=RequestMethod.POST)
	@ResponseBody
	public void mycampingCancelRequest(int reser_no){
		campDAO.campCancelRequest(reser_no);
	}

	// ----------------------ȸ�� ���� ����---------------------------
	// ȸ������ ������ �̵�
	@RequestMapping(value = "/beforeMyinfo", method = RequestMethod.GET)
	public String beforeMyinfo(Model model) {
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName", "beforeMyinfo.jsp");
		return "home";
	}

	@RequestMapping(value = "/checkMyinfo", method = RequestMethod.POST)
	@ResponseBody
	public int checkMyinfo(String upass, HttpSession session) {
		String uid = (String) session.getAttribute("uid");
		UserVO vo = udao.login(uid);
		if (vo.getUpass().equals(upass)) {
			return 1;
		} else {
			return 0;
		}
	}

	@RequestMapping(value = "/myinfo", method = RequestMethod.GET)
	public String myinfo(Model model, HttpSession session) {
		String uid = (String) session.getAttribute("uid");
		UserVO vo = udao.login(uid);
		model.addAttribute("vo", vo);
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName", "myinfo.jsp");
		return "home";
	}

	// ȸ�� ���� ����
	@RequestMapping(value = "/myinfo/update", method = RequestMethod.POST)
	public String myinfoUpdate(UserVO vo, HttpSession session) {
		udao.update(vo);
		session.setAttribute("uid", vo.getUid());
		return "redirect:/mypage";
	}

	// ------------------------1:1 ä��-----------------------------
	// ä��â ����
	@RequestMapping("/chat")
	public String chat(Model model, String chat_id) {
		model.addAttribute("chat_room", chat_id);
		return "user/chat";
	}

	// ä�õ����� ��������
	@RequestMapping(value = "/chat.json", method = RequestMethod.GET)
	@ResponseBody
	public List<ChatVO> list(String chat_room) {
		System.out.println(chat_room);
		System.out.println(cdao.list(chat_room));
		return cdao.list(chat_room);
	}

	// ä�� �Է�
	@RequestMapping(value = "/chat/insert", method = RequestMethod.POST)
	@ResponseBody
	public int ChatInsert(ChatVO vo) {
		cdao.insert(vo);
		int lastNo = cdao.lastNo(vo.getChat_id());
		return lastNo;
	}

	// ä�� ����
	@RequestMapping(value = "/chat/delete", method = RequestMethod.POST)
	@ResponseBody
	public void delete(int chat_no) {
		cdao.delete(chat_no);
	}

	@RequestMapping(value = "/chatList.json", method = RequestMethod.GET)
	@ResponseBody
	public List<ChatVO> chatList() {
		return cdao.chatList();
	}

	@RequestMapping(value = "/myshop", method = RequestMethod.GET)
	public String myshop(Model model, HttpSession session) {
		String uid = (String) session.getAttribute("uid");
		String uname = udao.login(uid).getUname();
		
		model.addAttribute("uname", uname);
		model.addAttribute("order_list2", sdao.myshopList2(uid));
		model.addAttribute("order_list3", sdao.myshopList3(uid));
		model.addAttribute("order_list4", sdao.myshopList4(uid));
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName", "myshop.jsp");
		return "home";
	}

	@RequestMapping(value = "/mycart", method = RequestMethod.GET)
	public String mycart(Model model, HttpSession session) {
		String uid = (String) session.getAttribute("uid");
		String uname = udao.login(uid).getUname();
		
		model.addAttribute("cart_list", sdao.cart_list(uid));
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName", "mycart.jsp");
		return "home";
	}

	@RequestMapping(value = "/orderSuccess", method = RequestMethod.GET)
	public String orderSuccess(Model model) {
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName", "orderSuccess.jsp");
		return "home";
	}
	
	@RequestMapping(value = "/reservationSuccess", method = RequestMethod.GET)
	public String reservationSuccess(Model model) {
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName", "mycamping.jsp");
		return "home";
	}
	
}
