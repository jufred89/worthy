package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.NoticeVO;
import com.example.domain.RecipeVO;
import com.example.mapper.NoticeDAO;
import com.example.mapper.RecipeDAO;

@Controller
@RequestMapping("/info")
public class InfoController {
	@Autowired
	NoticeDAO ndao;
	
	@Autowired
	RecipeDAO rdao;
	
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
	
	//공지사항 삭제
	@RequestMapping(value = "/notice/delete", method = RequestMethod.POST)
	public void noticeDelete(int nb_no){
		ndao.delete(nb_no);
	}
	
	//공지사항 읽기
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
	
	//레시피 목록
	@RequestMapping(value = "/recipe/list", method = RequestMethod.GET)
	public String recipeList() {
		return "/info/recipe_list";
	}
	
	@RequestMapping(value="/rlist.json", method = RequestMethod.GET)
	@ResponseBody
	public List<RecipeVO> recipeJSON(){
		return rdao.list();
	}
	
	@RequestMapping(value = "/recipe/insert", method = RequestMethod.GET)
	public String recipeInsert() {
		return "/info/recipe_insert";
	}
	
	//레시피 입력
	@RequestMapping(value = "/recipe/insert", method = RequestMethod.POST)
	public String recipeInsertPost(RecipeVO vo){
		vo.setFi_writer("admin");
		vo.setFi_image("none");
		rdao.insert(vo);
		return "/info/recipe_insert";
	}
	
	//레시피 읽기
	@RequestMapping(value = "/recipe/read", method = RequestMethod.GET)
	public String recipeRead(int fi_no, Model model) {
		model.addAttribute("vo",rdao.read(fi_no));
		return "/info/recipe_read";
	}

	@RequestMapping(value = "/recipe/delete", method = RequestMethod.POST)
	public void recipeDelete(int fi_no){
		rdao.delete(fi_no);
	}
}
