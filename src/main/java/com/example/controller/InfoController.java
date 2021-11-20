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
	
	//공지사항
	@RequestMapping(value = "/notice/list", method = RequestMethod.GET)
	public String noticeList(Model model) {
		model.addAttribute("pageName", "info/notice_list.jsp");
		return "home";
	}
	
	//공지사항 JSON
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
	//이다희 작업부 메인으로 목록 
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
	
	//공지사항 입력
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
		
		//첨부파일 폴더 만들기
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
		//대표이미지 저장
		if(image.equals(System.currentTimeMillis()+"_")){//이미지를 none.jpg로 바꿈
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

	//공지사항 삭제
	@RequestMapping(value = "/notice/delete", method = RequestMethod.POST)
	public void noticeDelete(int nb_no, String image){
		nservice.delete(nb_no);
		if(image.equals("none.jpg")){
			return;
		}
		//대표이미지삭제
		new File(path +"/notice/"+image).delete();
		
		//해당 게시글 첨부파일이 담긴 폴더 삭제
		File delFolder = new File(path+"/notice/"+nb_no);
		File[] files = delFolder.listFiles();
		//1.해당 폴더의 하위파일 삭제
        for(File file : files){
            file.delete();
        }
        //2.해당폴더 삭제
      	delFolder.delete();
	}
	
	//공지사항 읽기
	@RequestMapping(value = "/notice/read", method = RequestMethod.GET)
	public String noticeRead(int nb_no, Model model, HttpSession session) {
		model.addAttribute("att", ndao.att_list(nb_no));
		model.addAttribute("vo", ndao.read(nb_no));
		model.addAttribute("pageName","info/notice_read.jsp");
		
		ndao.updateView(nb_no);
		
		String uid = (String)session.getAttribute("uid");
		if(uid!=null){ //로그인을 했을경우
			int check = ndao.likeIt(uid, nb_no); //게시글에 들어간적있는지 확인
			if(check==0){
				ndao.likeInsert(uid, nb_no); //좋아요 테이블에 좋아요0 상태로 입력
			}
			model.addAttribute("likeCheck",ndao.likeCheck(uid, nb_no)); //좋아요 상태가지고 가기
		}else if(uid==null){//로그인을 안한경우
			return "home";
		}
		return "home";
	}
	
	//공지사항 좋아요
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
	
	//공지사항 수정
	@RequestMapping(value = "/notice/update", method = RequestMethod.POST)
	public String noticeUpdatePost(NoticeVO vo, String oldImage, MultipartHttpServletRequest multi) throws IllegalStateException, IOException{
		MultipartFile file = multi.getFile("file");
		String nb_no = Integer.toString(vo.getNb_no());
		if(!file.isEmpty()){ //대표이미지가 바뀌는 경우
			//기존 대표이미지 삭제
			new File(path+"/notice/"+oldImage).delete();

			//대표이미지 파일 업로드
			String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
			file.transferTo(new File(path + "/notice/" + image));
			vo.setNb_image(image);
			
			ndao.update(vo);
		}else{ //대표이미지가 바뀌지 않는경우
			vo.setNb_image(oldImage);
			ndao.update(vo);
		}
		//첨부 이미지 파일 업로드
		List<MultipartFile> files = multi.getFiles("files"); //files name을 가진 태그의 값을 가져옴			
		ArrayList<String> images = new ArrayList<>(); //vo.getImages()에 넣을 배열
		
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
	
	//공지사항 첨부이미지 삭제
	@RequestMapping(value="/notice/attDel",method=RequestMethod.POST)
	public void notice_attDelete(String image, int nb_no) throws Exception{
		new File(path+"/notice/"+nb_no+"/"+image).delete();
		//System.out.println(image + " + " + nb_no);
		ndao.att_delete(image);
	}
	
	//팁 목록
	@RequestMapping(value = "/tip/list", method = RequestMethod.GET)
	public String tipList(Model model) {
		model.addAttribute("pageName", "info/tip_list.jsp");
		return "home";
	}
	
	//팁 JSON
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
  //이다희 팁 메인으로
  	@RequestMapping(value="/tip_list.json", method = RequestMethod.GET)
	@ResponseBody
	public List<TipVO> tipAboutJSON(){
		return tdao.mainPage_tip_list();
	};
	
	@RequestMapping(value = "/tip/insert", method = RequestMethod.GET)
	public String tipInsert(Model model) {
		int tip_no = tdao.maxNo();
		model.addAttribute("tip_no",tip_no);
		model.addAttribute("pageName", "info/tip_insert.jsp");
		return "home";
	}
	
	//팁 입력
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
		
		//첨부파일 폴더 만들기
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
		
		//이미지 저장
		if(image.equals(System.currentTimeMillis()+"_")){//이미지를 none.jpg로 바꿈
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
	
	//팁 읽기
	@RequestMapping(value = "/tip/read", method = RequestMethod.GET)
	public String tipRead(int tip_no, Model model, HttpSession session) {
		model.addAttribute("att", tdao.att_list(tip_no));
		model.addAttribute("vo", tdao.read(tip_no));
		model.addAttribute("pageName", "info/tip_read.jsp");

		tdao.updateView(tip_no);
		
		String uid = (String)session.getAttribute("uid");
		
		if(uid!=null){ //로그인을 했을경우
			int check = tdao.likeIt(uid, tip_no); //게시글에 들어간적있는지 확인
			if(check==0){
				tdao.likeInsert(uid, tip_no); //좋아요 테이블에 좋아요0 상태로 입력
			}
			model.addAttribute("likeCheck",tdao.likeCheck(uid, tip_no)); //좋아요 상태가지고 가기
		}else if(uid==null){//로그인을 안한경우
			return "home";
		}
		return "home";
	}
	
	//팁 좋아요
	@RequestMapping(value="/tip/like", method=RequestMethod.POST)
	@ResponseBody
	public void tipLike(int likeCheck, String uid, int tip_no){
		tdao.like(likeCheck, uid, tip_no);
		tdao.likeUpdate(tip_no);
	}
	
	//팁 삭제
	@RequestMapping(value = "/tip/delete", method = RequestMethod.POST)
	public void tipDelete(int tip_no, String image){
		tservice.delete(tip_no);
		if(image.equals("none.jpg")){
			return;
		}
		//대표이미지삭제
		new File(path +"/tip/"+image).delete();
		
		//해당 게시글 첨부파일이 담긴 폴더 삭제
		File delFolder = new File(path+"/tip/"+tip_no);
		File[] files = delFolder.listFiles();
		//1.해당 폴더의 하위파일 삭제
        for(File file : files){
            file.delete();
        }
        //2.해당폴더 삭제
      	delFolder.delete();
	}

	@RequestMapping(value = "/tip/update", method = RequestMethod.GET)
	public String tipUpdate(int tip_no, Model model){
		model.addAttribute("att", tdao.att_list(tip_no));
		model.addAttribute("vo",tdao.read(tip_no));
		model.addAttribute("pageName", "info/tip_update.jsp");
		return "home";
	}
	
	//팁 수정
		@RequestMapping(value = "/tip/update", method = RequestMethod.POST)
		public String tipUpdatePost(TipVO vo, String oldImage, MultipartHttpServletRequest multi) throws IllegalStateException, IOException{
			MultipartFile file = multi.getFile("file");
			String tip_no = Integer.toString(vo.getTip_no());
			if(!file.isEmpty()){ //대표이미지가 바뀌는 경우
				//기존 대표이미지 삭제
				new File(path+"/tip/"+oldImage).delete();

				//대표이미지 파일 업로드
				String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
				file.transferTo(new File(path + "/tip/" + image));
				vo.setTip_image(image);
				
				tdao.update(vo);
			}else{ //대표이미지가 바뀌지 않는경우
				vo.setTip_image(oldImage);
				tdao.update(vo);
			}
			//첨부 이미지 파일 업로드
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
		
	//팁 첨부이미지 삭제
	@RequestMapping(value="/tip/attDel",method=RequestMethod.POST)
	public void tip_attDelete(String image, int tip_no) throws Exception{
		new File(path+"/tip/"+tip_no+"/"+image).delete();
		//System.out.println(image + " + " + nb_no);
		tdao.att_delete(image);
	}
	
	//레시피
	@RequestMapping(value = "/recipe/list", method = RequestMethod.GET)
	public String recipeList(Model model) {
		model.addAttribute("pageName", "info/recipe_list.jsp");
		return "home";
	}
	
	//레시피 JSON
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
  // 이다희 푸드 리스트 메인
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
	
	
	//레시피 입력
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
		
		//첨부파일 폴더 만들기
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
		
		//이미지 저장
		if(image.equals(System.currentTimeMillis()+"_")){//이미지를 none.jpg로 바꿈
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
	
	//레시피 읽기
	@RequestMapping(value = "/recipe/read", method = RequestMethod.GET)
	public String recipeRead(int fi_no, Model model, HttpSession session) {
		model.addAttribute("att", rdao.att_list(fi_no));
		model.addAttribute("vo", rdao.read(fi_no));
		model.addAttribute("pageName","info/recipe_read.jsp");
		
		rdao.updateView(fi_no);
		
		String uid = (String)session.getAttribute("uid");
		if(uid!=null){ //로그인을 했을경우
			int check = rdao.likeIt(uid, fi_no); //게시글에 들어간적있는지 확인
			if(check==0){
				rdao.likeInsert(uid, fi_no); //좋아요 테이블에 좋아요0 상태로 입력
			}
			model.addAttribute("likeCheck",rdao.likeCheck(uid, fi_no)); //좋아요 상태가지고 가기
		}else if(uid==null){//로그인을 안한경우
			return "home";
		}
		return "home";
	}
	
	//레시피 좋아요
	@RequestMapping(value="/recipe/like", method=RequestMethod.POST)
	@ResponseBody
	public void recipeLike(int likeCheck, String uid, int fi_no){
		rdao.like(likeCheck, uid, fi_no);
		rdao.likeUpdate(fi_no);
	}

	//레시피 삭제
	@RequestMapping(value = "/recipe/delete", method = RequestMethod.POST)
	public void recipeDelete(int fi_no, String image){
		rservice.delete(fi_no);
		nservice.delete(fi_no);
		if(image.equals("none.jpg")){
			return;
		}
		//대표이미지삭제
		new File(path +"/recipe/"+image).delete();
		
		//해당 게시글 첨부파일이 담긴 폴더 삭제
		File delFolder = new File(path+"/recipe/"+fi_no);
		File[] files = delFolder.listFiles();
		//1.해당 폴더의 하위파일 삭제
        for(File file : files){
            file.delete();
        }
        //2.해당폴더 삭제
      	delFolder.delete();
	}
	
	@RequestMapping(value = "/recipe/update", method = RequestMethod.GET)
	public String recipeUpdate(int fi_no, Model model){
		model.addAttribute("att", rdao.att_list(fi_no));
		model.addAttribute("vo",rdao.read(fi_no));
		model.addAttribute("pageName", "info/recipe_update.jsp");
		return "home";
	}
	
	//레시피 수정
	@RequestMapping(value = "/recipe/update", method = RequestMethod.POST)
	public String recipeUpdatePost(RecipeVO vo, String oldImage, MultipartHttpServletRequest multi) throws IllegalStateException, IOException{
		MultipartFile file = multi.getFile("file");
		String fi_no = Integer.toString(vo.getFi_no());
		if(!file.isEmpty()){ //대표이미지가 바뀌는 경우
			//기존 대표이미지 삭제
			new File(path+"/recipe/"+oldImage).delete();

			//대표이미지 파일 업로드
			String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
			file.transferTo(new File(path + "/recipe/" + image));
			vo.setFi_image(image);
			
			rdao.update(vo);
		}else{ //대표이미지가 바뀌지 않는경우
			vo.setFi_image(oldImage);
			rdao.update(vo);
		}
		//첨부 이미지 파일 업로드
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

	//레시피 첨부이미지 삭제
	@RequestMapping(value="/recipe/attDel",method=RequestMethod.POST)
	public void recipe_attDelete(String image, int fi_no) throws Exception{
		new File(path+"/recipe/"+fi_no+"/"+image).delete();
		//System.out.println(image + " + " + nb_no);
		rdao.att_delete(image);
	}
	
	//공지사항 이미지 파일 보기
	@ResponseBody
	@RequestMapping("/notice/display")
	public byte[] noticeDisplay(String file)throws Exception{
		FileInputStream in=new FileInputStream(path + "/notice/" + file);
		byte[] image=IOUtils.toByteArray(in);
		in.close();
		return image;
	}
		
	//팁 이미지 파일 보기
	@ResponseBody
	@RequestMapping("/tip/display")
	public byte[] tipDisplay(String file)throws Exception{
		FileInputStream in=new FileInputStream(path + "/tip/" + file);
		byte[] image=IOUtils.toByteArray(in);
		in.close();
		return image;
	}
	//레시피 이미지 파일 보기
	@ResponseBody
	@RequestMapping("/recipe/display")
	public byte[] display(String file)throws Exception{
		FileInputStream in=new FileInputStream(path + "/recipe/" + file);
		byte[] image=IOUtils.toByteArray(in);
		in.close();
		return image;
	}
}
