package com.example.controller;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
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

	//�̹������� ���
	@ResponseBody
	@RequestMapping("/display")
	public byte[] display(String file)throws Exception{
	   FileInputStream in=new FileInputStream(path + "/" + file);
	   byte[] image=IOUtils.toByteArray(in);
	   in.close();
	   return image;
	}
 
	
	
	//----------------------------�Խ���---------------------------
	//�����Խ��� ��� ������ �̵�
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String boardList(Model model) {
		model.addAttribute("pageName","board/list.jsp");
		return "home";
	}
	
	//�����Խ��� ��� JSON ������ ��������
	@RequestMapping(value = "/list.json", method = RequestMethod.GET)
	@ResponseBody
	public List<BoardVO> boardListJSON() {
		return dao.list();
	}
	
	
	//�����Խ��� �۵�� ������ �̵�
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String boardInsert(Model model) {
		int maxNo = dao.maxNo();
		int fb_no = maxNo+1;
		model.addAttribute("fb_no",fb_no);
		model.addAttribute("pageName","board/insert.jsp");
		return "home";
	}
	
	//�����Խ��� �۵��
	@RequestMapping(value="/insert" ,method=RequestMethod.POST)
	public String insertPost(BoardVO vo, MultipartHttpServletRequest multi) throws Exception{
		MultipartFile file = multi.getFile("file"); //form���� input type="file"�� �� name���� ��������
		String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
		vo.setFb_image(image);
		
		//��ǥ ���� ���ε�
		file.transferTo(new File(path+"/"+image));
				
		//�������Է�
		//dao.insert(vo);
		
		//÷������ ������ ���ε�
		List<MultipartFile> files = multi.getFiles("files");
		ArrayList<String> images = new ArrayList<>();
		for(MultipartFile attFile : files) {
			if(!attFile.isEmpty()){
				String attImage = System.currentTimeMillis()+"_"+attFile.getOriginalFilename();
				images.add(attImage);
				
				//������ ����
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
	
	
	//�����Խ��� ���б�
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String boardRead(Model model, int fb_no) {
		model.addAttribute("pageName","board/read.jsp");
		model.addAttribute("vo",service.read(fb_no));
		model.addAttribute("attList",dao.attachList(fb_no));
		
		return "home";
	}
	
	//�����Խ��� �ۼ���
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public String update(BoardVO vo, String oldImage, MultipartHttpServletRequest multi) throws Exception{
		MultipartFile file = multi.getFile("file");
		
		if(!file.isEmpty()){  //�̹����� �ٲ���
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
	
	//�����Խ��� �ۻ���
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public String deletePost(int fb_no){
		
		File folder = new File(path+"/"+fb_no);
		File[] files = folder.listFiles();

           for(File file : files){
               file.delete(); // ���� ���� ����
           }
        
		//������ü�� ����
		new File(path+"/"+fb_no).delete();
		
		//�Խñ����̺�, ÷���������̺� ����
		service.delete(fb_no);
		return "redirect:list";
	}
	
	
	//----------------------------÷������---------------------------
	//�����Խ��� ÷������ �߰�
	@RequestMapping(value="/attInsert",method=RequestMethod.POST)
	@ResponseBody
	public String attInsert(int fb_no, MultipartFile file) throws Exception{
		//÷������ ���ε�
		File attPath = new File(path+"/"+fb_no);
		if(!attPath.exists()) attPath.mkdir();
		String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
		file.transferTo(new File(path+"/"+fb_no +"/"+image));

		//÷�ε����� �Է�
		dao.insertAttach(image, fb_no);
		return image;
	}
	
	//�����Խ��� ÷������ ����
	@RequestMapping(value="/attDelete",method=RequestMethod.POST)
	@ResponseBody
	public void attDelete(String image, int fb_no) throws Exception{
		new File(path+"/"+fb_no+"/"+image).delete();
		dao.deleteAttach(image);
	}
	
	
	
	//----------------------------���---------------------------
	//�����Խ��� ��� ����Ʈ �ҷ�����
	@RequestMapping("/reply.json")
	@ResponseBody
	public List<BoardReplyVO> replyList(int fb_bno){
		return dao.replyList(fb_bno);
	}

	
	//�����Խ��� ��� �߰� 
	@RequestMapping(value="/replyInsert",method=RequestMethod.POST)
	@ResponseBody
	public void replyInsert(BoardReplyVO vo){
		dao.replyInsert(vo);
	}

}
