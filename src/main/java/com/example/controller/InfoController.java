package com.example.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
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
import com.example.mapper.NoticeService;
import com.example.mapper.RecipeDAO;
import com.example.mapper.RecipeService;
import com.example.mapper.TipDAO;
import com.example.mapper.TipService;

@Controller
public class InfoController {
	@Autowired
	NoticeDAO ndao;
	@Autowired
	NoticeService nservice;
	
	@Autowired
	RecipeDAO rdao;
	@Autowired
	RecipeService rservice;
	
	@Autowired
	TipDAO tdao;
	@Autowired
	TipService tservice;
	
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
	//�씠�떎�씗 �옉�뾽遺� 硫붿씤�쑝濡� 紐⑸줉 
  	@RequestMapping(value="/notice/notice_list.json", method = RequestMethod.GET)
	@ResponseBody
	public List<HashMap<String, Object>> mainNoticeJSON(){
		return ndao.mainPage_notice_list();
	};
  
	@RequestMapping(value = "/notice/insert", method = RequestMethod.GET)
	public String noticeInsert(Model model) {
		int nb_no = ndao.maxNo();
		model.addAttribute("nb_no",nb_no);
		model.addAttribute("pageName", "info/notice_insert.jsp");
		return "home";
	}
	
	//怨듭��궗�빆 �엯�젰
	@RequestMapping(value = "/notice/insert", method = RequestMethod.POST)
	public String noticeInsertPost(NoticeVO vo,MultipartHttpServletRequest multi, HttpSession session) throws IllegalStateException, IOException{
		String uid = (String)session.getAttribute("uid");
		vo.setnb_writer(uid);
		MultipartFile file = multi.getFile("file");
		String image = System.currentTimeMillis()+"_" + file.getOriginalFilename();
		
		
		File noticeFolder = new File(path+"/notice/");
		if(!noticeFolder.exists()){
			noticeFolder.mkdir();
		}
		
		List<MultipartFile> files = multi.getFiles("files");
		System.out.println(files);
		ArrayList<String> images = new ArrayList<>();
		
		//泥⑤��뙆�씪 �뤃�뜑 留뚮뱾湲�
		File folder = new File(path+"/notice/"+vo.getNb_no());
		if(!folder.exists()){
			folder.mkdir();
		}
		for(MultipartFile attFile : files) {
			if(!attFile.isEmpty()){
				String attImage = System.currentTimeMillis()+"_"+attFile.getOriginalFilename();
				images.add(attImage);
				
				attFile.transferTo(new File(path+"/notice/"+vo.getNb_no()+"/"+attImage));
			}
		}
		vo.setImages(images);
		System.out.println(vo.toString());
		//���몴�씠誘몄� ���옣
		if(image.equals(System.currentTimeMillis()+"_")){//�씠誘몄�瑜� none.jpg濡� 諛붽퓞
			vo.setNb_image("none.jpg");
			ndao.insert(vo);
			return "redirect:/notice/list";
		}else{
			file.transferTo(new File(path + "/notice/" + image));
			vo.setNb_image(image);
			nservice.insert(vo);
			return "redirect:/notice/list";
		}
	}

	//怨듭��궗�빆 �궘�젣
	@RequestMapping(value = "/notice/delete", method = RequestMethod.POST)
	public void noticeDelete(int nb_no, String image){
		nservice.delete(nb_no);
		if(image.equals("none.jpg")){
			return;
		}
		//���몴�씠誘몄��궘�젣
		new File(path +"/notice/"+image).delete();
		
		//�빐�떦 寃뚯떆湲� 泥⑤��뙆�씪�씠 �떞湲� �뤃�뜑 �궘�젣
		File delFolder = new File(path+"/notice/"+nb_no);
		File[] files = delFolder.listFiles();
		//1.�빐�떦 �뤃�뜑�쓽 �븯�쐞�뙆�씪 �궘�젣
        for(File file : files){
            file.delete();
        }
        //2.�빐�떦�뤃�뜑 �궘�젣
      	delFolder.delete();
	}
	
	//怨듭��궗�빆 �씫湲�
	@RequestMapping(value = "/notice/read", method = RequestMethod.GET)
	public String noticeRead(int nb_no, Model model, HttpSession session) {
		model.addAttribute("att", ndao.att_list(nb_no));
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
		model.addAttribute("att", ndao.att_list(nb_no));
		model.addAttribute("vo",ndao.read(nb_no));
		model.addAttribute("pageName", "info/notice_update.jsp");
		return "home";
	}
	
	//怨듭��궗�빆 �닔�젙
	@RequestMapping(value = "/notice/update", method = RequestMethod.POST)
	public String noticeUpdatePost(NoticeVO vo, String oldImage, MultipartHttpServletRequest multi) throws IllegalStateException, IOException{
		MultipartFile file = multi.getFile("file");
		String nb_no = Integer.toString(vo.getNb_no());
		if(!file.isEmpty()){ //���몴�씠誘몄�媛� 諛붾�뚮뒗 寃쎌슦
			//湲곗〈 ���몴�씠誘몄� �궘�젣
			new File(path+"/notice/"+oldImage).delete();

			//���몴�씠誘몄� �뙆�씪 �뾽濡쒕뱶
			String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
			file.transferTo(new File(path + "/notice/" + image));
			vo.setNb_image(image);
			
			ndao.update(vo);
		}else{ //���몴�씠誘몄�媛� 諛붾�뚯� �븡�뒗寃쎌슦
			vo.setNb_image(oldImage);
			ndao.update(vo);
		}
		//泥⑤� �씠誘몄� �뙆�씪 �뾽濡쒕뱶
		List<MultipartFile> files = multi.getFiles("files"); //files name�쓣 媛�吏� �깭洹몄쓽 媛믪쓣 媛��졇�샂			
		ArrayList<String> images = new ArrayList<>(); //vo.getImages()�뿉 �꽔�쓣 諛곗뿴
		
		for(MultipartFile attFile : files) {
			if(!attFile.isEmpty()){
				String attImage = System.currentTimeMillis()+"_"+attFile.getOriginalFilename();
				images.add(attImage);
				
				attFile.transferTo(new File(path+"/notice/"+vo.getNb_no()+"/"+attImage));
				ndao.att_insert(attImage, vo.getNb_no());
			}
		}
		vo.setImages(images);
		//System.out.println(vo.toString());
		return "redirect:/notice/read?nb_no=" + nb_no;
	}
	
	//怨듭��궗�빆 泥⑤��씠誘몄� �궘�젣
	@RequestMapping(value="/notice/attDel",method=RequestMethod.POST)
	public void notice_attDelete(String image, int nb_no) throws Exception{
		new File(path+"/notice/"+nb_no+"/"+image).delete();
		//System.out.println(image + " + " + nb_no);
		ndao.att_delete(image);
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

	
	@RequestMapping(value = "/tip/insert", method = RequestMethod.GET)
	public String tipInsert(Model model) {
		int tip_no = tdao.maxNo();
		model.addAttribute("tip_no",tip_no);
		model.addAttribute("pageName", "info/tip_insert.jsp");
		return "home";
	}
	
	//�똻 �엯�젰
	@RequestMapping(value = "/tip/insert", method = RequestMethod.POST)
	public String tipInsertPost(TipVO vo,MultipartHttpServletRequest multi,HttpSession session) throws IllegalStateException, IOException{
		String uid = (String)session.getAttribute("uid");
		vo.setTip_writer(uid);
		MultipartFile file = multi.getFile("file");
		String image = System.currentTimeMillis()+"_" + file.getOriginalFilename();
		
		File noticeFolder = new File(path+"/tip/");
		if(!noticeFolder.exists()){
			noticeFolder.mkdir();
		}
		
		List<MultipartFile> files = multi.getFiles("files");
		ArrayList<String> images = new ArrayList<>();
		
		//泥⑤��뙆�씪 �뤃�뜑 留뚮뱾湲�
		File folder = new File(path+"/tip/"+vo.getTip_no());
		if(!folder.exists()){
			folder.mkdir();
		}
		for(MultipartFile attFile : files) {
			if(!attFile.isEmpty()){
				String attImage = System.currentTimeMillis()+"_"+attFile.getOriginalFilename();
				images.add(attImage);
				
				attFile.transferTo(new File(path+"/tip/"+vo.getTip_no()+"/"+attImage));
			}
		}
		vo.setImages(images);
		
		//�씠誘몄� ���옣
		if(image.equals(System.currentTimeMillis()+"_")){//�씠誘몄�瑜� none.jpg濡� 諛붽퓞
			vo.setTip_image("none.jpg");
			tdao.insert(vo);
			return "redirect:/tip/list";
		}else{
			file.transferTo(new File(path + "/tip/" + image));
			vo.setTip_image(image);
			tservice.insert(vo);
			return "redirect:/tip/list";
		}
	}
	
	//�똻 �씫湲�
	@RequestMapping(value = "/tip/read", method = RequestMethod.GET)
	public String tipRead(int tip_no, Model model, HttpSession session) {
		model.addAttribute("att", tdao.att_list(tip_no));
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
		tservice.delete(tip_no);
		if(image.equals("none.jpg")){
			return;
		}
		//���몴�씠誘몄��궘�젣
		new File(path +"/tip/"+image).delete();
		
		//�빐�떦 寃뚯떆湲� 泥⑤��뙆�씪�씠 �떞湲� �뤃�뜑 �궘�젣
		File delFolder = new File(path+"/tip/"+tip_no);
		File[] files = delFolder.listFiles();
		//1.�빐�떦 �뤃�뜑�쓽 �븯�쐞�뙆�씪 �궘�젣
        for(File file : files){
            file.delete();
        }
        //2.�빐�떦�뤃�뜑 �궘�젣
      	delFolder.delete();
	}

	@RequestMapping(value = "/tip/update", method = RequestMethod.GET)
	public String tipUpdate(int tip_no, Model model){
		model.addAttribute("att", tdao.att_list(tip_no));
		model.addAttribute("vo",tdao.read(tip_no));
		model.addAttribute("pageName", "info/tip_update.jsp");
		return "home";
	}
	
	//�똻 �닔�젙
		@RequestMapping(value = "/tip/update", method = RequestMethod.POST)
		public String tipUpdatePost(TipVO vo, String oldImage, MultipartHttpServletRequest multi) throws IllegalStateException, IOException{
			MultipartFile file = multi.getFile("file");
			String tip_no = Integer.toString(vo.getTip_no());
			if(!file.isEmpty()){ //���몴�씠誘몄�媛� 諛붾�뚮뒗 寃쎌슦
				//湲곗〈 ���몴�씠誘몄� �궘�젣
				new File(path+"/tip/"+oldImage).delete();

				//���몴�씠誘몄� �뙆�씪 �뾽濡쒕뱶
				String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
				file.transferTo(new File(path + "/tip/" + image));
				vo.setTip_image(image);
				
				tdao.update(vo);
			}else{ //���몴�씠誘몄�媛� 諛붾�뚯� �븡�뒗寃쎌슦
				vo.setTip_image(oldImage);
				tdao.update(vo);
			}
			//泥⑤� �씠誘몄� �뙆�씪 �뾽濡쒕뱶
			List<MultipartFile> files = multi.getFiles("files");			
			ArrayList<String> images = new ArrayList<>();
			
			for(MultipartFile attFile : files) {
				if(!attFile.isEmpty()){
					String attImage = System.currentTimeMillis()+"_"+attFile.getOriginalFilename();
					images.add(attImage);
					
					attFile.transferTo(new File(path+"/tip/"+vo.getTip_no()+"/"+attImage));
					tdao.att_insert(attImage, vo.getTip_no());
				}
			}
			vo.setImages(images);
			System.out.println(vo.toString());
			return "redirect:/tip/read?tip_no=" + tip_no;
		}
		
	//�똻 泥⑤��씠誘몄� �궘�젣
	@RequestMapping(value="/tip/attDel",method=RequestMethod.POST)
	public void tip_attDelete(String image, int tip_no) throws Exception{
		new File(path+"/tip/"+tip_no+"/"+image).delete();
		//System.out.println(image + " + " + nb_no);
		tdao.att_delete(image);
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
  // �씠�떎�씗 �뫖�뱶 由ъ뒪�듃 硫붿씤
  		@RequestMapping(value="/food_list.json", method = RequestMethod.GET)
		@ResponseBody
		public List<HashMap<String, Object>> reciepeAboutJSON(){
			return rdao.mainPage_food_list();
		};
  
	@RequestMapping("/recipe/insert")
	public String recipeInsert(Model model){
		int fi_no = rdao.maxNo();
		model.addAttribute("fi_no",fi_no);
		model.addAttribute("pageName", "info/recipe_insert.jsp");
		return "home";
	}
	
	
	//�젅�떆�뵾 �엯�젰
	@RequestMapping(value = "/recipe/insert", method = RequestMethod.POST)
	public String recipeInsertPost(RecipeVO vo, MultipartHttpServletRequest multi, HttpSession session) throws IllegalStateException, IOException{
		String uid = (String)session.getAttribute("uid");
		vo.setFi_writer(uid);
		MultipartFile file = multi.getFile("file");
		String image = System.currentTimeMillis()+"_" + file.getOriginalFilename();
		
		File noticeFolder = new File(path+"/recipe/");
		if(!noticeFolder.exists()){
			noticeFolder.mkdir();
		}
		
		List<MultipartFile> files = multi.getFiles("files");
		ArrayList<String> images = new ArrayList<>();
		
		//泥⑤��뙆�씪 �뤃�뜑 留뚮뱾湲�
		File folder = new File(path+"/recipe/"+vo.getFi_no());
		if(!folder.exists()){
			folder.mkdir();
		}
		for(MultipartFile attFile : files) {
			if(!attFile.isEmpty()){
				String attImage = System.currentTimeMillis()+"_"+attFile.getOriginalFilename();
				images.add(attImage);
				
				attFile.transferTo(new File(path+"/recipe/"+vo.getFi_no()+"/"+attImage));
			}
		}
		vo.setImages(images);
		
		//�씠誘몄� ���옣
		if(image.equals(System.currentTimeMillis()+"_")){//�씠誘몄�瑜� none.jpg濡� 諛붽퓞
			vo.setFi_image("none.jpg");
			rdao.insert(vo);
			return "redirect:/recipe/list";
		}else{
			file.transferTo(new File(path + "/recipe/" + image));
			vo.setFi_image(image);
			rservice.insert(vo);
			return "redirect:/recipe/list";
		}
	}
	
	//�젅�떆�뵾 �씫湲�
	@RequestMapping(value = "/recipe/read", method = RequestMethod.GET)
	public String recipeRead(int fi_no, Model model, HttpSession session) {
		model.addAttribute("att", rdao.att_list(fi_no));
		model.addAttribute("vo", rdao.read(fi_no));
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
		rservice.delete(fi_no);
		nservice.delete(fi_no);
		if(image.equals("none.jpg")){
			return;
		}
		//���몴�씠誘몄��궘�젣
		new File(path +"/recipe/"+image).delete();
		
		//�빐�떦 寃뚯떆湲� 泥⑤��뙆�씪�씠 �떞湲� �뤃�뜑 �궘�젣
		File delFolder = new File(path+"/recipe/"+fi_no);
		File[] files = delFolder.listFiles();
		//1.�빐�떦 �뤃�뜑�쓽 �븯�쐞�뙆�씪 �궘�젣
        for(File file : files){
            file.delete();
        }
        //2.�빐�떦�뤃�뜑 �궘�젣
      	delFolder.delete();
	}
	
	@RequestMapping(value = "/recipe/update", method = RequestMethod.GET)
	public String recipeUpdate(int fi_no, Model model){
		model.addAttribute("att", rdao.att_list(fi_no));
		model.addAttribute("vo",rdao.read(fi_no));
		model.addAttribute("pageName", "info/recipe_update.jsp");
		return "home";
	}
	
	//�젅�떆�뵾 �닔�젙
	@RequestMapping(value = "/recipe/update", method = RequestMethod.POST)
	public String recipeUpdatePost(RecipeVO vo, String oldImage, MultipartHttpServletRequest multi) throws IllegalStateException, IOException{
		MultipartFile file = multi.getFile("file");
		String fi_no = Integer.toString(vo.getFi_no());
		if(!file.isEmpty()){ //���몴�씠誘몄�媛� 諛붾�뚮뒗 寃쎌슦
			//湲곗〈 ���몴�씠誘몄� �궘�젣
			new File(path+"/recipe/"+oldImage).delete();

			//���몴�씠誘몄� �뙆�씪 �뾽濡쒕뱶
			String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
			file.transferTo(new File(path + "/recipe/" + image));
			vo.setFi_image(image);
			
			rdao.update(vo);
		}else{ //���몴�씠誘몄�媛� 諛붾�뚯� �븡�뒗寃쎌슦
			vo.setFi_image(oldImage);
			rdao.update(vo);
		}
		//泥⑤� �씠誘몄� �뙆�씪 �뾽濡쒕뱶
		List<MultipartFile> files = multi.getFiles("files");			
		ArrayList<String> images = new ArrayList<>();
		
		for(MultipartFile attFile : files) {
			if(!attFile.isEmpty()){
				String attImage = System.currentTimeMillis()+"_"+attFile.getOriginalFilename();
				images.add(attImage);
				
				attFile.transferTo(new File(path+"/recipe/"+vo.getFi_no()+"/"+attImage));
				rdao.att_insert(attImage, vo.getFi_no());
			}
		}
		vo.setImages(images);
		System.out.println(vo.toString());
		return "redirect:/recipe/read?fi_no=" + fi_no;
	}

	//�젅�떆�뵾 泥⑤��씠誘몄� �궘�젣
	@RequestMapping(value="/recipe/attDel",method=RequestMethod.POST)
	public void recipe_attDelete(String image, int fi_no) throws Exception{
		new File(path+"/recipe/"+fi_no+"/"+image).delete();
		//System.out.println(image + " + " + nb_no);
		rdao.att_delete(image);
	}
	
	//怨듭��궗�빆 �씠誘몄� �뙆�씪 蹂닿린
	@ResponseBody
	@RequestMapping("/notice/display")
	public byte[] noticeDisplay(String file)throws Exception{
		FileInputStream in=new FileInputStream(path + "/notice/" + file);
		byte[] image=IOUtils.toByteArray(in);
		in.close();
		return image;
	}
		
	//�똻 �씠誘몄� �뙆�씪 蹂닿린
	@ResponseBody
	@RequestMapping("/tip/display")
	public byte[] tipDisplay(String file)throws Exception{
		FileInputStream in=new FileInputStream(path + "/tip/" + file);
		byte[] image=IOUtils.toByteArray(in);
		in.close();
		return image;
	}
	//�젅�떆�뵾 �씠誘몄� �뙆�씪 蹂닿린
	@ResponseBody
	@RequestMapping("/recipe/display")
	public byte[] display(String file)throws Exception{
		FileInputStream in=new FileInputStream(path + "/recipe/" + file);
		byte[] image=IOUtils.toByteArray(in);
		in.close();
		return image;
	}
}
