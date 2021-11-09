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

	//이미지파일 출력
	@ResponseBody
	@RequestMapping("/display")
	public byte[] display(String file)throws Exception{
	   FileInputStream in=new FileInputStream(path + "/" + file);
	   byte[] image=IOUtils.toByteArray(in);
	   in.close();
	   return image;
	}
 
	
	
	//----------------------------게시판---------------------------
	//자유게시판 목록 페이지 이동
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String boardList(Model model) {
		model.addAttribute("pageName","board/list.jsp");
		return "home";
	}
	
	//자유게시판 목록 JSON 데이터 가져오기
	@RequestMapping(value = "/list.json", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> boardListJSON(Criteria cri) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", dao.list(cri));
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.totalCount(cri));
		map.put("cri", cri);
		map.put("pm", pm);
		return map;
	}
	
	
	//자유게시판 글등록 페이지 이동
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String boardInsert(Model model) {
		int maxNo = dao.maxNo();
		int fb_no = maxNo+1;
		model.addAttribute("fb_no",fb_no);
		model.addAttribute("pageName","board/insert.jsp");
		return "home";
	}
	
	//자유게시판 글등록
	@RequestMapping(value="/insert" ,method=RequestMethod.POST)
	public String insertPost(BoardVO vo, MultipartHttpServletRequest multi) throws Exception{
		MultipartFile file = multi.getFile("file"); //form에서 input type="file"에 준 name으로 가져오기
		String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
		vo.setFb_image(image);
		
		//대표 파일 업로드
		file.transferTo(new File(path+"/"+image));
				
		//데이터입력
		//dao.insert(vo);
		
		//첨부파일 여러개 업로드
		List<MultipartFile> files = multi.getFiles("files");
		ArrayList<String> images = new ArrayList<>();
		for(MultipartFile attFile : files) {
			if(!attFile.isEmpty()){
				String attImage = System.currentTimeMillis()+"_"+attFile.getOriginalFilename();
				images.add(attImage);
				
				//새폴더 생성
				File folder = new File(path+"/"+vo.getFb_no());
				if(!folder.exists()){
					folder.mkdir();
				}
				attFile.transferTo(new File(path+"/"+vo.getFb_no()+"/"+attImage));
			}
		}
		vo.setImages(images);
		System.out.println(vo.toString());
		
		service.insert(vo);

		return "redirect:/board/list";
	}
	
	
	//자유게시판 글읽기
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String boardRead(Model model, int fb_no, HttpSession session) {
		model.addAttribute("pageName","board/read.jsp");
		model.addAttribute("vo",service.read(fb_no));
		//첨부파일 리스트
		model.addAttribute("attList",dao.attachList(fb_no));
		
		
		String uid = (String)session.getAttribute("uid");
		int check = dao.likeIt(uid, fb_no); //게시글에 들어간적있는지 확인
		if(check==0){
			dao.likeTableInsert(uid, fb_no); //좋아요 테이블에 좋아요0 상태로 입력
		}
		model.addAttribute("likeCheck",dao.likeCheck(uid, fb_no)); //좋아요 상태가지고 가기
		
		return "home";
	}
	
	//자유게시판 글수정
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public String update(BoardVO vo, String oldImage, MultipartHttpServletRequest multi) throws Exception{
		MultipartFile file = multi.getFile("file");
		
		if(!file.isEmpty()){  //이미지가 바뀐경우
			new File(path+"/"+vo.getFb_image()).delete();
			String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
			file.transferTo(new File(path+"/"+image));
			vo.setFb_image(image);
		}else{
			vo.setFb_image(oldImage);
		}
		//System.out.println(vo.toString());
		dao.update(vo);
		return "redirect:/board/list";
	}
	
	//자유게시판 글삭제
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public String deletePost(int fb_no){
		
		File folder = new File(path+"/"+fb_no);
		File[] files = folder.listFiles();

           for(File file : files){
               file.delete(); // 하위 파일 삭제
           }
        
		//폴더자체를 삭제
		new File(path+"/"+fb_no).delete();
		
		//게시글테이블, 첨부파일테이블 삭제
		service.delete(fb_no);
		return "redirect:list";
	}
	
	
	//----------------------------첨부파일---------------------------
	//자유게시판 첨부파일 추가
	@RequestMapping(value="/attInsert",method=RequestMethod.POST)
	@ResponseBody
	public String attInsert(int fb_no, MultipartFile file) throws Exception{
		//첨부파일 업로드
		File attPath = new File(path+"/"+fb_no);
		if(!attPath.exists()) attPath.mkdir();
		String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
		file.transferTo(new File(path+"/"+fb_no +"/"+image));

		//첨부데이터 입력
		dao.insertAttach(image, fb_no);
		return image;
	}
	
	//자유게시판 첨부파일 삭제
	@RequestMapping(value="/attDelete",method=RequestMethod.POST)
	@ResponseBody
	public void attDelete(String image, int fb_no) throws Exception{
		new File(path+"/"+fb_no+"/"+image).delete();
		dao.deleteAttach(image);
	}
	
	
	
	//----------------------------댓글---------------------------
	//자유게시판 댓글 리스트 불러오기
	@RequestMapping("/reply.json")
	@ResponseBody
	public HashMap<String, Object> replyList(int fb_bno,Criteria cri){
		HashMap<String, Object> map = new HashMap<>();
		cri.setPerPageNum(5);
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.replyCount(fb_bno));
		
		map.put("cri", cri);
		map.put("pm", pm);
		map.put("list", dao.replyList(fb_bno, cri));
		return map;
	}

	
	//자유게시판 댓글 추가 
	@RequestMapping(value="/replyInsert",method=RequestMethod.POST)
	@ResponseBody
	public void replyInsert(BoardReplyVO vo){
		dao.replyInsert(vo);
	}
	
	//자유게시판 댓글 삭제
	@RequestMapping(value="/replyDelete",method=RequestMethod.POST)
	@ResponseBody
	public void replyDelete(int fb_rno){
		dao.replyDelete(fb_rno);
	}
	

	//----------------------------좋아요---------------------------
	//자유게시판 좋아요 기능
	@RequestMapping(value="/like",method=RequestMethod.POST)
	@ResponseBody
	public void like(int likeCheck, String uid, int fb_no){
		dao.like(likeCheck, uid, fb_no);
	}

}
