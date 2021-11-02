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
	
	//�������� ��� JSON
	@RequestMapping(value="/nlist.json", method = RequestMethod.GET)
	@ResponseBody
	public List<NoticeVO> noticeJSON(){
		return ndao.list();
	}
	
	//�������� �Է�
	@RequestMapping(value = "/ninsert", method = RequestMethod.POST)
	public String noticeInsertPost(NoticeVO vo){
		vo.setnb_writer("admin");
		ndao.insert(vo);
		return "/notice_list";
	}
	
	//�������� ����
	@RequestMapping(value = "/notice/delete", method = RequestMethod.POST)
	public void noticeDelete(int nb_no){
		ndao.delete(nb_no);
	}
	
	//�������� �б�
	@RequestMapping(value = "/notice/read", method = RequestMethod.GET)
	public String noticeRead(int nb_no, Model model) {
		model.addAttribute("vo", ndao.read(nb_no));
		model.addAttribute("pageName", "info/notice_read.jsp");
		return "home";
	}
	
	//�� ���
	@RequestMapping(value="/tlist.json", method = RequestMethod.GET)
	@ResponseBody
	public List<TipVO> tipJSON(){
		return tdao.list();
	}
	
	@RequestMapping(value = "/tip/read", method = RequestMethod.GET)
	public String tipRead(Model model) {
		model.addAttribute("pageName", "info/tip_read.jsp");
		return "home";
	}
	
	
	
	//������ ���
	@RequestMapping(value="/rlist.json", method = RequestMethod.GET)
	@ResponseBody
	public List<RecipeVO> recipeJSON(){
		return rdao.list();
	}
	
	//������ �Է�
	@RequestMapping(value = "/recipe/insert", method = RequestMethod.POST)
	public String recipeInsertPost(RecipeVO vo){
		vo.setFi_writer("admin");
		vo.setFi_image("none");
		rdao.insert(vo);
		return "/recipe_insert";
	}
	
	//������ �б�
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
