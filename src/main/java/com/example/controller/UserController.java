package com.example.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import com.example.domain.UserVO;
import com.example.mapper.UserDAO;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	UserDAO udao;
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {

		//쿠키 삭제
		try {
			Cookie cookie = WebUtils.getCookie(request, "uid");
			String uid = cookie.getValue();
			if (uid != null) {
				cookie.setPath("/");
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}			
		} catch (Exception e) {
			System.out.println("logout error : "+e.toString());
		}

		// 세션 초기화
		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String userJoin(Model model) {
		model.addAttribute("pageName", "user/join.jsp");
		return "home";
	}
	
	@RequestMapping(value ="/login", method = RequestMethod.GET)
	public String userLogin(Model model) {
		model.addAttribute("pageName", "user/login.jsp");
		return "home";
	}

	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String userMypage() {
		
		return "/user/mypage";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	@ResponseBody
	public int loginPost(String uid, String upass, HttpSession session, boolean isLogin, HttpServletResponse response){
		int result=0;
		UserVO vo=udao.login(uid);
		if(vo != null){
			if(upass.equals(vo.getUpass())){
				session.setAttribute("uid", uid);
				if(isLogin){
					Cookie cookie = new Cookie("uid", uid);
					cookie.setPath("/");
					cookie.setMaxAge(60*60*24*7);
					response.addCookie(cookie);
				}
				result=1;
			}else{
				result=2;
			}
		}
		return result;
	}
	@RequestMapping(value="/chkid", method=RequestMethod.POST)
	@ResponseBody
	public int chkid(String uid, String upass, HttpSession session){
		int result=0;
		UserVO vo=udao.login(uid);
		if(vo != null){
				result=1;
			}else{
				result=0;
			}
		return result;
	}
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String joinPost(UserVO vo){
		vo.setAddress(vo.getAddress()+" "+vo.getDetail());
		System.out.println(vo.toString());
		udao.insert(vo);
		return "/user/login";
	}
}
