package com.example.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.UserVO;
import com.example.mapper.UserDAO;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	UserDAO udao;
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
	 session.invalidate();
	 return "redirect:/";
	}

	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String userJoin() {
		return "/user/join";
	}
	
	@RequestMapping(value ="/login", method = RequestMethod.GET)
	public String userLogin(Model model) {
		model.addAttribute("pageName", "login.jsp");
		return "/user/login";
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
}
