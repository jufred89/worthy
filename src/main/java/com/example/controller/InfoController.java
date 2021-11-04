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
import com.example.domain.TipVO;
import com.example.mapper.NoticeDAO;
import com.example.mapper.RecipeDAO;
import com.example.mapper.TipDAO;

@Controller
public class InfoController {
	@Autowired
	NoticeDAO ndao;
	@Autowired
	RecipeDAO rdao;
	@Autowired
	TipDAO tdao;
	
	//공지사항
	@RequestMapping(value = "/notice/list", method = RequestMethod.GET)
	public String noticeList(Model model) {
		model.addAttribute("pageName", "info/notice_list.jsp");
		return "home";
	}
	//공지사항 JSON
	@RequestMapping(value="/nlist.json", method = RequestMethod.GET)
	@ResponseBody
	public List<NoticeVO> noticeJSON(){
		return ndao.list();
	}
	
	@RequestMapping(value = "/notice/insert", method = RequestMethod.GET)
	public String noticeInsert(Model model) {
		model.addAttribute("pageName", "info/notice_insert.jsp");
		return "home";
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
		model.addAttribute("pageName","info/notice_read.jsp");
		return "home";
	}
	
	//팁 목록
	@RequestMapping(value = "/tip/list", method = RequestMethod.GET)
	public String tipList(Model model) {
		model.addAttribute("pageName", "info/tip_list.jsp");
		return "home";
	}
	
	//팁JSON
	@RequestMapping(value="/tlist.json", method = RequestMethod.GET)
	@ResponseBody
	public List<TipVO> tipJSON(){
		return tdao.list();
	}	
	
	@RequestMapping(value = "/tip/insert", method = RequestMethod.GET)
	public String tipInsert(Model model) {
		model.addAttribute("pageName", "info/tip_insert.jsp");
		return "home";
	}
	
	//팁 입력
	@RequestMapping(value = "/tip/insert", method = RequestMethod.POST)
	public String tipInsertPost(TipVO vo){
		vo.setTip_writer("admin");
		vo.setTip_image("none");
		tdao.insert(vo);
		return "/info/tip_insert";
	}
	
	//팁 읽기
	@RequestMapping(value = "/tip/read", method = RequestMethod.GET)
	public String tipRead(int tip_no, Model model) {
		model.addAttribute("vo", tdao.read(tip_no));
		model.addAttribute("pageName", "info/tip_read.jsp");
		return "home";
	}
	
	//팁 삭제
	@RequestMapping(value = "/tip/delete", method = RequestMethod.POST)
	public void tipDelete(int tip_no){
		tdao.delete(tip_no);
	}
	
	//레시피
	@RequestMapping(value = "/recipe/list", method = RequestMethod.GET)
	public String recipeList(Model model) {
		model.addAttribute("pageName", "info/recipe_list.jsp");
		return "home";
	}
	
	//레시피 JSON
	@RequestMapping(value="/rlist.json", method = RequestMethod.GET)
	@ResponseBody
	public List<RecipeVO> recipeJSON(){
		return rdao.list();
	}

	@RequestMapping(value = "/recipe/insert", method = RequestMethod.GET)
	public String recipeInsert(Model model) {
		model.addAttribute("pageName", "info/recipe_insert.jsp");
		return "home";
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
		model.addAttribute("pageName","info/recipe_read.jsp");
		return "home";
	}

	//레시피 삭제
	@RequestMapping(value = "/recipe/delete", method = RequestMethod.POST)
	public void recipeDelete(int fi_no){
		rdao.delete(fi_no);
	}
	
	@RequestMapping(value = "/recipe/update", method = RequestMethod.GET)
	public String recipeUpdate(int fi_no, Model model){
		model.addAttribute("pageName", "info/recipe_update.jsp");
		return "home";
	}
	
	//레시피 수정
	@RequestMapping(value = "/recipe/update", method = RequestMethod.POST)
	public void recipeUpdatePost(int fi_no){
		rdao.update(fi_no);
	}
}
