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
	
<<<<<<< HEAD
	//∞¯¡ˆªÁ«◊ ∏Ò∑œ JSON
=======
	//Í≥µÏßÄÏÇ¨Ìï≠
	@RequestMapping(value = "/notice/list", method = RequestMethod.GET)
	public String noticeList() {
		return "/info/notice_list";
	}
	
	//Í≥µÏßÄÏÇ¨Ìï≠ Î™©Î°ù
>>>>>>> a5bd56885ef774485a075d0122f678efd122802f
	@RequestMapping(value="/nlist.json", method = RequestMethod.GET)
	@ResponseBody
	public List<NoticeVO> noticeJSON(){
		return ndao.list();
	}
	
<<<<<<< HEAD
	//∞¯¡ˆªÁ«◊ ¿‘∑¬
	@RequestMapping(value = "/ninsert", method = RequestMethod.POST)
=======
	@RequestMapping(value = "/notice/insert", method = RequestMethod.GET)
	public String noticeInsert() {
		return "/info/notice_insert";
	}
	
	//Í≥µÏßÄÏÇ¨Ìï≠ ÏûÖÎ†•
	@RequestMapping(value = "/notice/insert", method = RequestMethod.POST)
>>>>>>> a5bd56885ef774485a075d0122f678efd122802f
	public String noticeInsertPost(NoticeVO vo){
		vo.setnb_writer("admin");
		ndao.insert(vo);
		return "/notice_list";
	}
	
<<<<<<< HEAD
	//∞¯¡ˆªÁ«◊ ªË¡¶
=======
	//Í≥µÏßÄÏÇ¨Ìï≠ ÏÇ≠Ï†ú
>>>>>>> a5bd56885ef774485a075d0122f678efd122802f
	@RequestMapping(value = "/notice/delete", method = RequestMethod.POST)
	public void noticeDelete(int nb_no){
		ndao.delete(nb_no);
	}
	
<<<<<<< HEAD
	//∞¯¡ˆªÁ«◊ ¿–±‚
=======
	//Í≥µÏßÄÏÇ¨Ìï≠ ÏùΩÍ∏∞
>>>>>>> a5bd56885ef774485a075d0122f678efd122802f
	@RequestMapping(value = "/notice/read", method = RequestMethod.GET)
	public String noticeRead(int nb_no, Model model) {
		model.addAttribute("vo", ndao.read(nb_no));
		model.addAttribute("pageName", "info/notice_read.jsp");
		return "home";
	}
	
<<<<<<< HEAD
	//∆¡ ∏Ò∑œ
	@RequestMapping(value="/tlist.json", method = RequestMethod.GET)
	@ResponseBody
	public List<TipVO> tipJSON(){
		return tdao.list();
=======
	//ÌåÅ
	@RequestMapping(value = "/tip/list", method = RequestMethod.GET)
	public String tipList() {
		return "/info/tip_list";
	}
	
	@RequestMapping(value = "/tip/insert", method = RequestMethod.GET)
	public String tipInsert() {
		return "/info/tip_insert";
>>>>>>> a5bd56885ef774485a075d0122f678efd122802f
	}
	
	@RequestMapping(value = "/tip/read", method = RequestMethod.GET)
	public String tipRead(Model model) {
		model.addAttribute("pageName", "info/tip_read.jsp");
		return "home";
	}
	
<<<<<<< HEAD
	
=======
	//Î†àÏãúÌîº Î™©Î°ù
	@RequestMapping(value = "/recipe/list", method = RequestMethod.GET)
	public String recipeList() {
		return "/info/recipe_list";
	}
>>>>>>> a5bd56885ef774485a075d0122f678efd122802f
	
	@RequestMapping(value="/rlist.json", method = RequestMethod.GET)
	@ResponseBody
	public List<RecipeVO> recipeJSON(){
		return rdao.list();
	}
	
<<<<<<< HEAD
	//∑πΩ√«« ¿‘∑¬
=======
	@RequestMapping(value = "/recipe/insert", method = RequestMethod.GET)
	public String recipeInsert() {
		return "/info/recipe_insert";
	}
	
	//Î†àÏãúÌîº ÏûÖÎ†•
>>>>>>> a5bd56885ef774485a075d0122f678efd122802f
	@RequestMapping(value = "/recipe/insert", method = RequestMethod.POST)
	public String recipeInsertPost(RecipeVO vo){
		vo.setFi_writer("admin");
		vo.setFi_image("none");
		rdao.insert(vo);
		return "/recipe_insert";
	}
	
	//Î†àÏãúÌîº ÏùΩÍ∏∞
	@RequestMapping(value = "/recipe/read", method = RequestMethod.GET)
	public String recipeRead(int fi_no, Model model) {
		model.addAttribute("vo",rdao.read(fi_no));
		model.addAttribute("pageName", "info/recipe_read.jsp");
		return "home";
	}

	@RequestMapping(value = "/recipe/delete", method = RequestMethod.POST)
	public void recipeDelete(int fi_no){
		rdao.delete(fi_no);
	}
}
