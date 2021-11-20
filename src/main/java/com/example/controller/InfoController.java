package com.example.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.domain.Criteria;
import com.example.domain.NoticeVO;
import com.example.domain.PageMaker;
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
	@Resource(name="uploadPath")
	private String path;
	
	//怨듭��궗�빆
	@RequestMapping(value = "/notice/list", method = RequestMethod.GET)
	public String noticeList(Model model) {
		model.addAttribute("pageName", "info/notice_list.jsp");
		return "home";
	}
	
	//怨듭��궗�빆 JSON
	@RequestMapping(value="/notice/list.json", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> noticeJSON(Criteria cri){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("cri", cri);
		map.put("list", ndao.list(cri));
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(ndao.totalCount(cri));
		
		map.put("pm", pm);
		return map;
	};
	//怨듭��궗�빆 JSON
	@RequestMapping(value="/notice/notice_list.json", method = RequestMethod.GET)
	@ResponseBody
	public List<HashMap<String, Object>> mainNoticeJSON(){
		
		
		return ndao.mainPage_notice_list();
	};
	
	@RequestMapping(value = "/notice/insert", method = RequestMethod.GET)
	public String noticeInsert(Model model) {
		model.addAttribute("pageName", "info/notice_insert.jsp");
		return "home";
	}
	
	//怨듭��궗�빆 �엯�젰
	@RequestMapping(value = "/notice/insert", method = RequestMethod.POST)
	public String noticeInsertPost(NoticeVO vo,MultipartHttpServletRequest multi, HttpSession session) throws IllegalStateException, IOException{
		String uid = (String)session.getAttribute("uid");
		vo.setnb_writer(uid);
		MultipartFile file = multi.getFile("file");
		System.out.println(file);
		//�씠誘몄� ���옣
		String image = System.currentTimeMillis()+"_" + file.getOriginalFilename();
		if(image.equals(System.currentTimeMillis()+"_")){//�씠誘몄�瑜� none.jpg濡� 諛붽퓞
			vo.setNb_image("none.jpg");
			ndao.insert(vo);
			return "redirect:/notice/list";
		}else{
			file.transferTo(new File(path + "/" + image));
			vo.setNb_image(image);
			ndao.insert(vo);
			return "redirect:/notice/list";
		}
	}

	//怨듭��궗�빆 �궘�젣
	@RequestMapping(value = "/notice/delete", method = RequestMethod.POST)
	public void noticeDelete(int nb_no, String image){
		ndao.likeDel(nb_no);
		ndao.delete(nb_no);
		if(image.equals("none.jpg")){
			return;
		}
		new File(path + File.separator + image).delete();
	}
	
	//怨듭��궗�빆 �씫湲�
	@RequestMapping(value = "/notice/read", method = RequestMethod.GET)
	public String noticeRead(int nb_no, Model model, HttpSession session) {
		model.addAttribute("vo", ndao.read(nb_no));
		model.addAttribute("pageName","info/notice_read.jsp");
		
		ndao.updateView(nb_no);
		
		String uid = (String)session.getAttribute("uid");
		if(uid!=null){ //濡쒓렇�씤�쓣 �뻽�쓣寃쎌슦
			int check = ndao.likeIt(uid, nb_no); //寃뚯떆湲��뿉 �뱾�뼱媛꾩쟻�엳�뒗吏� �솗�씤
			if(check==0){
				ndao.likeInsert(uid, nb_no); //醫뗭븘�슂 �뀒�씠釉붿뿉 醫뗭븘�슂0 �긽�깭濡� �엯�젰
			}
			model.addAttribute("likeCheck",ndao.likeCheck(uid, nb_no)); //醫뗭븘�슂 �긽�깭媛�吏�怨� 媛�湲�
		}else if(uid==null){//濡쒓렇�씤�쓣 �븞�븳寃쎌슦
			return "home";
		}
		return "home";
	}
	
	//怨듭��궗�빆 醫뗭븘�슂
	@RequestMapping(value="/notice/like", method=RequestMethod.POST)
	@ResponseBody
	public void noticeLike(int likeCheck, String uid, int nb_no){
		ndao.like(likeCheck, uid, nb_no);
		ndao.likeUpdate(nb_no);
	}
	
	@RequestMapping(value = "/notice/update", method = RequestMethod.GET)
	public String noticeUpdate(int nb_no, Model model){
		model.addAttribute("vo",ndao.read(nb_no));
		model.addAttribute("pageName", "info/notice_update.jsp");
		return "home";
	}
	
	//怨듭��궗�빆 �닔�젙
	@RequestMapping(value = "/notice/update", method = RequestMethod.POST)
	public void noticeUpdatePost(NoticeVO vo){
		System.out.println(vo.toString());
		ndao.update(vo);
	}
	
	//�똻 紐⑸줉
	@RequestMapping(value = "/tip/list", method = RequestMethod.GET)
	public String tipList(Model model) {
		model.addAttribute("pageName", "info/tip_list.jsp");
		return "home";
	}
	
	//�똻 JSON
	@RequestMapping(value="/tip/list.json", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> tipJSON(Criteria cri){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("cri", cri);
		map.put("list", tdao.list(cri));
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(tdao.totalCount(cri));
		
		map.put("pm", pm);
		return map;
	};
	//�똻 JSON
	@RequestMapping(value="/tip_list.json", method = RequestMethod.GET)
	@ResponseBody
	public List<TipVO> tipAboutJSON(){
		
	
		return tdao.mainPage_tip_list();
	};
	
	@RequestMapping(value = "/tip/insert", method = RequestMethod.GET)
	public String tipInsert(Model model) {
		model.addAttribute("pageName", "info/tip_insert.jsp");
		return "home";
	}
	
	//�똻 �엯�젰
	@RequestMapping(value = "/tip/insert", method = RequestMethod.POST)
	public String tipInsertPost(TipVO vo,MultipartHttpServletRequest multi,HttpSession session) throws IllegalStateException, IOException{
		String uid = (String)session.getAttribute("uid");
		vo.setTip_writer(uid);
		MultipartFile file = multi.getFile("file");
		
		//�씠誘몄� ���옣
		String image = System.currentTimeMillis()+"_" + file.getOriginalFilename();
		if(image.equals(System.currentTimeMillis()+"_")){
			vo.setTip_image("none.jpg");
			tdao.insert(vo);
			return "redirect:/tip/list";
		}else{
			file.transferTo(new File(path + "/" + image));
			vo.setTip_image(image);
			tdao.insert(vo);
			return "redirect:/tip/list";
		}
	}
	
	//�똻 �씫湲�
	@RequestMapping(value = "/tip/read", method = RequestMethod.GET)
	public String tipRead(int tip_no, Model model, HttpSession session) {
		model.addAttribute("vo", tdao.read(tip_no));
		model.addAttribute("pageName", "info/tip_read.jsp");

		tdao.updateView(tip_no);
		
		String uid = (String)session.getAttribute("uid");
		
		if(uid!=null){ //濡쒓렇�씤�쓣 �뻽�쓣寃쎌슦
			int check = tdao.likeIt(uid, tip_no); //寃뚯떆湲��뿉 �뱾�뼱媛꾩쟻�엳�뒗吏� �솗�씤
			if(check==0){
				tdao.likeInsert(uid, tip_no); //醫뗭븘�슂 �뀒�씠釉붿뿉 醫뗭븘�슂0 �긽�깭濡� �엯�젰
			}
			model.addAttribute("likeCheck",tdao.likeCheck(uid, tip_no)); //醫뗭븘�슂 �긽�깭媛�吏�怨� 媛�湲�
		}else if(uid==null){//濡쒓렇�씤�쓣 �븞�븳寃쎌슦
			return "home";
		}
		return "home";
	}
	
	//�똻 醫뗭븘�슂
	@RequestMapping(value="/tip/like", method=RequestMethod.POST)
	@ResponseBody
	public void tipLike(int likeCheck, String uid, int tip_no){
		tdao.like(likeCheck, uid, tip_no);
		tdao.likeUpdate(tip_no);
	}
	
	//�똻 �궘�젣
	@RequestMapping(value = "/tip/delete", method = RequestMethod.POST)
	public void tipDelete(int tip_no, String image){
		tdao.likeDel(tip_no);
		tdao.delete(tip_no);
		if(image.equals("none.jpg")){
			return;
		}
		new File(path + File.separator + image).delete();
	}

	@RequestMapping(value = "/tip/update", method = RequestMethod.GET)
	public String tipUpdate(int tip_no, Model model){
		model.addAttribute("vo",tdao.read(tip_no));
		model.addAttribute("pageName", "info/tip_update.jsp");
		return "home";
	}
	
	//�똻 �닔�젙
	@RequestMapping(value = "/tip/update", method = RequestMethod.POST)
	public void tipUpdatePost(TipVO vo){
		System.out.println(vo.toString());
		tdao.update(vo);
	}
	
	//�젅�떆�뵾
	@RequestMapping(value = "/recipe/list", method = RequestMethod.GET)
	public String recipeList(Model model) {
		model.addAttribute("pageName", "info/recipe_list.jsp");
		return "home";
	}
	
	//�젅�떆�뵾 JSON
	@RequestMapping(value="/recipe/list.json", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String,Object> recipeJSON(Criteria cri){
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("list", rdao.list(cri));
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(rdao.totalCount(cri));
		
		map.put("cri", cri);
		map.put("pm", pm);
		return map;
	}
	//�똻 JSON
		@RequestMapping(value="/food_list.json", method = RequestMethod.GET)
		@ResponseBody
		public List<HashMap<String, Object>> reciepeAboutJSON(){
			
		
			return rdao.mainPage_food_list();
		};
	@RequestMapping("/recipe/insert")
	public String recipeInsert(Model model){
		model.addAttribute("pageName", "info/recipe_insert.jsp");
		return "home";
	}
	
	
	//�젅�떆�뵾 �엯�젰
	@RequestMapping(value = "/recipe/insert", method = RequestMethod.POST)
	public String recipeInsertPost(RecipeVO vo, HttpSession session, MultipartHttpServletRequest multi) throws IllegalStateException, IOException{
		String uid = (String)session.getAttribute("uid");
		
		vo.setFi_writer(uid);
		MultipartFile file = multi.getFile("file");
		
		//�씠誘몄� ���옣
		String image = System.currentTimeMillis()+"_" + file.getOriginalFilename();
		if(image.equals(System.currentTimeMillis()+"_")){
			vo.setFi_image("none.jpg");
			rdao.insert(vo);
			return "redirect:/recipe/list";
		}else{
			file.transferTo(new File(path + "/" + image));
			vo.setFi_image(image);
			rdao.insert(vo);
			return "redirect:/recipe/list";
		}
	}
	
	//�젅�떆�뵾 �씫湲�
	@RequestMapping(value = "/recipe/read", method = RequestMethod.GET)
	public String recipeRead(int fi_no, Model model, HttpSession session) {
		model.addAttribute("vo",rdao.read(fi_no));
		model.addAttribute("pageName","info/recipe_read.jsp");
		
		rdao.updateView(fi_no);
		
		String uid = (String)session.getAttribute("uid");
		
		if(uid!=null){ //濡쒓렇�씤�쓣 �뻽�쓣寃쎌슦
			int check = rdao.likeIt(uid, fi_no); //寃뚯떆湲��뿉 �뱾�뼱媛꾩쟻�엳�뒗吏� �솗�씤
			if(check==0){
				rdao.likeInsert(uid, fi_no); //醫뗭븘�슂 �뀒�씠釉붿뿉 醫뗭븘�슂0 �긽�깭濡� �엯�젰
			}
			model.addAttribute("likeCheck",rdao.likeCheck(uid, fi_no)); //醫뗭븘�슂 �긽�깭媛�吏�怨� 媛�湲�
		}else if(uid==null){//濡쒓렇�씤�쓣 �븞�븳寃쎌슦
			return "home";
		}
		return "home";
	}
	
	//�젅�떆�뵾 醫뗭븘�슂
	@RequestMapping(value="/recipe/like", method=RequestMethod.POST)
	@ResponseBody
	public void recipeLike(int likeCheck, String uid, int fi_no){
		rdao.like(likeCheck, uid, fi_no);
		rdao.likeUpdate(fi_no);
	}

	//�젅�떆�뵾 �궘�젣
	@RequestMapping(value = "/recipe/delete", method = RequestMethod.POST)
	public void recipeDelete(int fi_no, String image){
		rdao.likeDel(fi_no);
		rdao.delete(fi_no);
		System.out.println(image);
		if(image.equals("none.jpg")){
			return;
		}
		new File(path + File.separator + image).delete();
	}
	
	@RequestMapping(value = "/recipe/update", method = RequestMethod.GET)
	public String recipeUpdate(int fi_no, Model model){
		model.addAttribute("vo",rdao.read(fi_no));
		model.addAttribute("pageName", "info/recipe_update.jsp");
		return "home";
	}
	
	//�젅�떆�뵾 �닔�젙
	@RequestMapping(value = "/recipe/update", method = RequestMethod.POST)
	public void recipeUpdatePost(RecipeVO vo){
		System.out.println(vo.toString());
		rdao.update(vo);
	}
	
	//�젅�떆�뵾 �씠誘몄� �뙆�씪 蹂닿린
	@ResponseBody
	@RequestMapping("/info/display")
	public byte[] display(String file)throws Exception{
		FileInputStream in=new FileInputStream(path + "/" + file);
		byte[] image=IOUtils.toByteArray(in);
		in.close();
		return image;
	}	
}
