package com.example.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.ChatVO;
import com.example.domain.UserVO;
import com.example.mapper.ChatDAO;
import com.example.mapper.UserDAO;

@Controller
@RequestMapping("/")
public class MyPageController {
	@Autowired
	UserDAO udao;
	
	@Autowired
	ChatDAO cdao;
	
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String mypage(Model model) {
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName","mycamping.jsp");
		return "home";
	}
	
	
	//----------------------회원 정보 수정---------------------------
	//회원정보 페이지 이동
	@RequestMapping(value = "/beforeMyinfo", method = RequestMethod.GET)
	public String beforeMyinfo(Model model) {
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName","beforeMyinfo.jsp");
		return "home";
	}
	
	@RequestMapping(value = "/checkMyinfo", method = RequestMethod.POST)
	@ResponseBody
	public int checkMyinfo(String upass, HttpSession session) {
		String uid = (String)session.getAttribute("uid");
		UserVO vo = udao.login(uid);
		if(vo.getUpass().equals(upass)){
			return 1;
		}else{
			return 0;
		}
	}
	
	@RequestMapping(value = "/myinfo", method = RequestMethod.GET)
	public String myinfo(Model model, HttpSession session) {
		String uid = (String)session.getAttribute("uid");
		UserVO vo = udao.login(uid);
		model.addAttribute("vo",vo);
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName","myinfo.jsp");
		return "home";
	}
	//회원 정보 수정
	@RequestMapping(value = "/myinfo/update", method = RequestMethod.POST)
	public String myinfoUpdate(UserVO vo, HttpSession session){
		udao.update(vo);
		session.setAttribute("uid", vo.getUid());
		return "redirect:/mypage";
	}
	
	//------------------------1:1 채팅-----------------------------
	//채팅창 열기
	@RequestMapping("/chat")
	public String chat(Model model,String chat_id){
		model.addAttribute("chatName",chat_id);
		return "user/chat";
	}
	//채팅데이터 가져오기
	@RequestMapping(value = "/chat.json", method = RequestMethod.GET)
	@ResponseBody
	public List<ChatVO> list(String chat_id){
		System.out.println(chat_id);
		System.out.println(cdao.list(chat_id));
		return cdao.list(chat_id);
	}
	//채팅 입력
	@RequestMapping(value="/chat/insert", method=RequestMethod.POST)
	@ResponseBody
	public int ChatInsert(ChatVO vo){
		cdao.insert(vo);
		int lastNo = cdao.lastNo(vo.getChat_id());
		return lastNo;
	}
	//채팅 삭제
	@RequestMapping(value="/chat/delete", method=RequestMethod.POST)
	@ResponseBody
	public void delete(int chat_no){
		cdao.delete(chat_no);
	}
	
	//------------------------관리자 채팅-----------------------------
	//관리자 채팅목록 페이지 이동
	@RequestMapping(value = "/adminChat", method = RequestMethod.GET)
	public String adminChat(Model model) {
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName","adminChat.jsp");
		return "home";
	}
	//채팅을 한 유저 가져오기
	@RequestMapping(value = "/chatList.json", method = RequestMethod.GET)
	@ResponseBody
	public List<ChatVO> chatList(){
		return cdao.chatList(); 
	}
	
	@RequestMapping(value = "/myshop", method = RequestMethod.GET)
	public String myshop(Model model) {
		model.addAttribute("pageName", "user/mypage.jsp");
		model.addAttribute("myPageName","myshop.jsp");
		return "home";
	}
}
 