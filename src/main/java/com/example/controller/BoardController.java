package com.example.controller;

import java.io.File;
import java.io.FileInputStream;
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

import com.example.domain.BoardReplyVO;
import com.example.domain.BoardVO;
import com.example.domain.Criteria;
import com.example.domain.PageMaker;
import com.example.mapper.BoardDAO;
import com.example.mapper.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardDAO dao;
	
	@Autowired
	BoardService service;
	
	@Resource(name="uploadPath")
	private String path;

	//�씠誘몄��뙆�씪 異쒕젰
	@ResponseBody
	@RequestMapping("/display")
	public byte[] display(String file)throws Exception{
	   FileInputStream in=new FileInputStream(path + "/board/" + file);
	   byte[] image=IOUtils.toByteArray(in);
	   in.close();
	   return image;
	}
 
	
	
	//----------------------------寃뚯떆�뙋---------------------------
	//�옄�쑀寃뚯떆�뙋 紐⑸줉 �럹�씠吏� �씠�룞
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String boardList(Model model) {
		model.addAttribute("pageName","board/list.jsp");
		return "home";
	}
	
	//�옄�쑀寃뚯떆�뙋 紐⑸줉 JSON �뜲�씠�꽣 媛��졇�삤湲�
	@RequestMapping(value = "/list.json", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> boardListJSON(Criteria cri,String desc) {
		HashMap<String, Object> map = new HashMap<>();
		PageMaker pm = new PageMaker();
		cri.setPerPageNum(7);
		pm.setCri(cri);
		pm.setTotalCount(dao.board_totalCount(cri));
		map.put("cri", cri);
		map.put("pm", pm);
		map.put("list", dao.board_list(cri,desc));
		return map;
	}
	
	
	//�옄�쑀寃뚯떆�뙋 湲��벑濡� �럹�씠吏� �씠�룞
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String boardInsert(Model model) {
		int maxNo = dao.board_maxNo();
		int fb_no = maxNo+1;
		model.addAttribute("fb_no",fb_no);
		model.addAttribute("pageName","board/insert.jsp");
		return "home";
	}
	
	//게시판 글 등록
	@RequestMapping(value="/insert" ,method=RequestMethod.POST)
	public String insertPost(BoardVO vo, MultipartHttpServletRequest multi) throws Exception{
		MultipartFile file = multi.getFile("file"); //form�뿉�꽌 input type="file"�뿉 以� name�쑝濡� 媛��졇�삤湲�
		String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
		vo.setFb_image(image);
		
		//���몴 �뙆�씪 �뾽濡쒕뱶
		File imagefolder = new File(path+"/board/");
		if(!imagefolder.exists()){
			imagefolder.mkdir();
		}
		file.transferTo(new File(path+"/board/"+image));
				
		//�뜲�씠�꽣�엯�젰
		//dao.insert(vo);
		
		//泥⑤��뙆�씪 �뿬�윭媛� �뾽濡쒕뱶
		List<MultipartFile> files = multi.getFiles("files");
		ArrayList<String> images = new ArrayList<>();
		
		//첨부파일 폴더 만들기
		File folder = new File(path+"/board/"+vo.getFb_no());
		if(!folder.exists()){
			folder.mkdir();
		}
		for(MultipartFile attFile : files) {
			if(!attFile.isEmpty()){
				String attImage = System.currentTimeMillis()+"_"+attFile.getOriginalFilename();
				images.add(attImage);
				

				attFile.transferTo(new File(path+"/board/"+vo.getFb_no()+"/"+attImage));
			}
		}
		vo.setImages(images);
		System.out.println(vo.toString());
		
		service.board_insert(vo);

		return "redirect:/board/list";
	}
	
	
	//�옄�쑀寃뚯떆�뙋 湲��씫湲�
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String boardRead(Model model, int fb_no, HttpSession session) {
		model.addAttribute("pageName","board/read.jsp");
		model.addAttribute("vo",service.board_read(fb_no));
		//泥⑤��뙆�씪 由ъ뒪�듃
		model.addAttribute("attList",dao.board_attachList(fb_no));
		
		
		String uid = (String)session.getAttribute("uid");
		int check = dao.board_likeIt(uid, fb_no); //寃뚯떆湲��뿉 �뱾�뼱媛꾩쟻�엳�뒗吏� �솗�씤
		if(check==0){
			dao.board_likeTableInsert(uid, fb_no); //醫뗭븘�슂 �뀒�씠釉붿뿉 醫뗭븘�슂0 �긽�깭濡� �엯�젰
		}
		model.addAttribute("likeCheck",dao.board_likeCheck(uid, fb_no)); //醫뗭븘�슂 �긽�깭媛�吏�怨� 媛�湲�
		
		return "home";
	}
	
	//�옄�쑀寃뚯떆�뙋 湲��닔�젙
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public String update(BoardVO vo, String fb_image, String oldImage, MultipartHttpServletRequest multi) throws Exception{
		MultipartFile file = multi.getFile("file");
		if(!file.isEmpty()){ 
			new File(path+"/board/"+vo.getFb_image()).delete();
			System.out.println(path+"/board/"+vo.toString());
			String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
			file.transferTo(new File(path+"/board/"+image));
			vo.setFb_image(image);
		}else{
			vo.setFb_image(oldImage);
		}
		//System.out.println(vo.toString());
		dao.board_update(vo);
		return "redirect:/board/list";
	}
	
	//�옄�쑀寃뚯떆�뙋 湲��궘�젣
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public String deletePost(int fb_no){
		
		File folder = new File(path+"/"+fb_no);
		File[] files = folder.listFiles();

           for(File file : files){
               file.delete(); // �븯�쐞 �뙆�씪 �궘�젣
           }
        
		//�뤃�뜑�옄泥대�� �궘�젣
		new File(path+"/"+fb_no).delete();
		
		//寃뚯떆湲��뀒�씠釉�, 泥⑤��뙆�씪�뀒�씠釉� �궘�젣
		service.board_delete(fb_no);
		return "redirect:list";
	}
	
	
	//----------------------------泥⑤��뙆�씪---------------------------
	//첨부파일 등록
	@RequestMapping(value="/attInsert",method=RequestMethod.POST)
	@ResponseBody
	public String attInsert(int fb_no, MultipartFile file) throws Exception{
		//泥⑤��뙆�씪 �뾽濡쒕뱶
		File attPath = new File(path+"/"+fb_no);
		if(!attPath.exists()) attPath.mkdir();
		String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
		file.transferTo(new File(path+"/board/"+fb_no +"/"+image));

		//泥⑤��뜲�씠�꽣 �엯�젰
		dao.board_insertAttach(image, fb_no);
		return image;
	}
	
	//�옄�쑀寃뚯떆�뙋 泥⑤��뙆�씪 �궘�젣
	@RequestMapping(value="/attDelete",method=RequestMethod.POST)
	@ResponseBody
	public void attDelete(String image, int fb_no) throws Exception{
		new File(path+"/board/"+fb_no+"/"+image).delete();
		dao.board_deleteAttach(image);
	}
	
	
	
	//----------------------------�뙎湲�---------------------------
	//�옄�쑀寃뚯떆�뙋 �뙎湲� 由ъ뒪�듃 遺덈윭�삤湲�
	@RequestMapping("/reply.json")
	@ResponseBody
	public HashMap<String, Object> replyList(int fb_bno,Criteria cri){
		HashMap<String, Object> map = new HashMap<>();
		cri.setPerPageNum(5);
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.board_replyCount(fb_bno));
		
		map.put("cri", cri);
		map.put("pm", pm);
		map.put("list", dao.board_replyList(fb_bno, cri));
		return map;
	}

	
	//�옄�쑀寃뚯떆�뙋 �뙎湲� 異붽� 
	@RequestMapping(value="/replyInsert",method=RequestMethod.POST)
	@ResponseBody
	public void replyInsert(BoardReplyVO vo){
		dao.board_replyInsert(vo);
	}
	
	//�옄�쑀寃뚯떆�뙋 �뙎湲� �궘�젣
	@RequestMapping(value="/replyDelete",method=RequestMethod.POST)
	@ResponseBody
	public void replyDelete(int fb_rno){
		dao.board_replyDelete(fb_rno);
	}
	

	//----------------------------醫뗭븘�슂---------------------------
	//�옄�쑀寃뚯떆�뙋 醫뗭븘�슂 湲곕뒫
	@RequestMapping(value="/like",method=RequestMethod.POST)
	@ResponseBody
	public void like(int likeCheck, String uid, int fb_no){
		service.board_like(likeCheck, uid, fb_no);
	}

}
