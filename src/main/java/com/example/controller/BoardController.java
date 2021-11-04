package com.example.controller;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.domain.BoardVO;
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

	 
	
	//자유게시판 목록 페이지 이동
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String boardList(Model model) {
		model.addAttribute("pageName","board/list.jsp");
		return "home";
	}
	
	//자유게시판 목록 JSON 데이터 가져오기
	@RequestMapping(value = "/list.json", method = RequestMethod.GET)
	@ResponseBody
	public List<BoardVO> boardListJSON() {
		return dao.list();
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

		return "redirect:/";
	}
	
	
	//자유게시판 글읽기
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String boardRead(Model model, int fb_no) {
		model.addAttribute("pageName","board/read.jsp");
		model.addAttribute("vo",dao.read(fb_no));
		return "home";
	}
	
	//자유게시판 글수정
	
}
