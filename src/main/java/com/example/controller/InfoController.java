package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.NoticeVO;
import com.example.mapper.NoticeDAO;

@Controller
@RequestMapping("/info")
public class InfoController {
	@Autowired
	NoticeDAO ndao;
	
	//공지사항
	@RequestMapping(value = "/notice/list", method = RequestMethod.GET)
	public String noticeList() {	
		return "/info/notice_list";
	}
	//공지사항 목록
	@RequestMapping(value="/nlist.json", method = RequestMethod.GET)
	@ResponseBody
	public List<NoticeVO> noticeJSON(){
		return ndao.list();
	}
	
	@RequestMapping(value = "/notice/insert", method = RequestMethod.GET)
	public String noticeInsert() {
		return "/info/notice_insert";
	}
	//공지사항 입력
	@RequestMapping(value = "/notice/insert", method = RequestMethod.POST)
	public String noticeInsertPost(NoticeVO vo){
		vo.setnb_writer("admin");
		ndao.insert(vo);
		return "/info/notice_list";
	}
	
	@RequestMapping(value = "/notice/delete", method = RequestMethod.POST)
	public void noticeDelete(int nb_no){
		ndao.delete(nb_no);
	}
	
	@RequestMapping(value = "/notice/read", method = RequestMethod.GET)
	public String noticeRead(int nb_no, Model model) {
		model.addAttribute("vo", ndao.read(nb_no));
		return "/info/notice_read";
	}
	
	//팁
	@RequestMapping(value = "/tip/list", method = RequestMethod.GET)
	public String tipList() {
		return "/info/tip_list";
	}
	
	@RequestMapping(value = "/tip/insert", method = RequestMethod.GET)
	public String tipInsert() {
		return "/info/tip_insert";
	}
	
	@RequestMapping(value = "/tip/read", method = RequestMethod.GET)
	public String tipRead() {
		return "/info/tip_read";
	}
	
	//레시피
	@RequestMapping(value = "/recipe/list", method = RequestMethod.GET)
	public String recipeList() {
		return "/info/recipe_list";
	}
	
	@RequestMapping(value = "/recipe/insert", method = RequestMethod.GET)
	public String recipeInsert() {
		return "/info/recipe_insert";
	}
	
	@RequestMapping(value = "/recipe/read", method = RequestMethod.GET)
	public String recipeRead() {
		return "/info/recipe_read";
	}
}
