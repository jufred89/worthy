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

	//占쎌뵠沃섎챷占쏙옙�솁占쎌뵬 �빊�뮆�젾
	@ResponseBody
	@RequestMapping("/display")
	public byte[] display(String file)throws Exception{
	   FileInputStream in=new FileInputStream(path + "/board/" + file);
	   byte[] image=IOUtils.toByteArray(in);
	   in.close();
	   return image;
	}
 
	
	
	//----------------------------野껊슣�뻻占쎈솇---------------------------
	//占쎌쁽占쎌�野껊슣�뻻占쎈솇 筌뤴뫖以� 占쎈읂占쎌뵠筌욑옙 占쎌뵠占쎈짗
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String boardList(Model model) {
		model.addAttribute("pageName","board/list.jsp");
		return "home";
	}
	
	//占쎌쁽占쎌�野껊슣�뻻占쎈솇 筌뤴뫖以� JSON 占쎈쑓占쎌뵠占쎄숲 揶쏉옙占쎌죬占쎌궎疫뀐옙
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
	 @RequestMapping("/board_list.json")
	 @ResponseBody
	 public List<BoardVO> best(){
		 return dao.mainPage_board_list();
	 }
	
	//占쎌쁽占쎌�野껊슣�뻻占쎈솇 疫뀐옙占쎈쾻嚥∽옙 占쎈읂占쎌뵠筌욑옙 占쎌뵠占쎈짗
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String boardInsert(Model model) {
		int maxNo = dao.board_maxNo();
		int fb_no = maxNo+1;
		model.addAttribute("fb_no",fb_no);
		model.addAttribute("pageName","board/insert.jsp");
		return "home";
	}
	
	//寃뚯떆�뙋 湲� �벑濡�
	@RequestMapping(value="/insert" ,method=RequestMethod.POST)
	public String insertPost(BoardVO vo, MultipartHttpServletRequest multi) throws Exception{
		MultipartFile file = multi.getFile("file"); //form占쎈퓠占쎄퐣 input type="file"占쎈퓠 餓ο옙 name占쎌몵嚥∽옙 揶쏉옙占쎌죬占쎌궎疫뀐옙
		String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
		vo.setFb_image(image);
		
		//占쏙옙占쎈ご 占쎈솁占쎌뵬 占쎈씜嚥≪뮆諭�
		File imagefolder = new File(path+"/board/");
		if(!imagefolder.exists()){
			imagefolder.mkdir();
		}
		file.transferTo(new File(path+"/board/"+image));
				
		//占쎈쑓占쎌뵠占쎄숲占쎌뿯占쎌젾
		//dao.insert(vo);
		
		//筌ｂ뫀占쏙옙�솁占쎌뵬 占쎈연占쎌쑎揶쏉옙 占쎈씜嚥≪뮆諭�
		List<MultipartFile> files = multi.getFiles("files");
		ArrayList<String> images = new ArrayList<>();
		
		//泥⑤��뙆�씪 �뤃�뜑 留뚮뱾湲�
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
	
	
	//占쎌쁽占쎌�野껊슣�뻻占쎈솇 疫뀐옙占쎌뵭疫뀐옙
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String boardRead(Model model, int fb_no, HttpSession session) {
		model.addAttribute("pageName","board/read.jsp");
		model.addAttribute("vo",service.board_read(fb_no));
		//筌ｂ뫀占쏙옙�솁占쎌뵬 �뵳�딅뮞占쎈뱜
		model.addAttribute("attList",dao.board_attachList(fb_no));
		
		
		String uid = (String)session.getAttribute("uid");
		int check = dao.board_likeIt(uid, fb_no); //野껊슣�뻻疫뀐옙占쎈퓠 占쎈굶占쎈선揶쏄쑴�읅占쎌뿳占쎈뮉筌욑옙 占쎌넇占쎌뵥
		if(check==0){
			dao.board_likeTableInsert(uid, fb_no); //�넫�뿭釉섓옙�뒄 占쎈�믭옙�뵠�뇡遺용퓠 �넫�뿭釉섓옙�뒄0 占쎄맒占쎄묶嚥∽옙 占쎌뿯占쎌젾
		}
		model.addAttribute("likeCheck",dao.board_likeCheck(uid, fb_no)); //�넫�뿭釉섓옙�뒄 占쎄맒占쎄묶揶쏉옙筌욑옙�⑨옙 揶쏉옙疫뀐옙
		
		return "home";
	}
	
	//寃뚯떆湲� �닔�젙
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public String update(BoardVO vo, String oldImage, MultipartHttpServletRequest multi) throws Exception{
		MultipartFile file = multi.getFile("file");
		if(!file.isEmpty()){ 
			new File(path+"/board/"+oldImage).delete();
			
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
	
	//寃뚯떆湲� �궘�젣
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public String deletePost(int fb_no,String formImage){
		System.out.println(formImage);
		File thumbnail = new File(path+"/board/"+formImage);
		thumbnail.delete();
		
		
		//泥⑤��뙆�씪 �궘�젣
		File folder = new File(path+"/board/"+fb_no);
		File[] files = folder.listFiles();

           for(File file : files){
               file.delete(); 
           }
		//�뤃�뜑 �옄泥대�� �궘�젣
		new File(path+"/board/"+fb_no).delete();
		
		//寃뚯떆湲�, 泥⑤��뙆�씪, 醫뗭븘�슂 �뀒�씠釉붿뿉�꽌 �궘�젣
		service.board_delete(fb_no);
		return "redirect:list";
	}
	
	
	//----------------------------筌ｂ뫀占쏙옙�솁占쎌뵬---------------------------
	//泥⑤��뙆�씪 �벑濡�
	@RequestMapping(value="/attInsert",method=RequestMethod.POST)
	@ResponseBody
	public String attInsert(int fb_no, MultipartFile file) throws Exception{
		//筌ｂ뫀占쏙옙�솁占쎌뵬 占쎈씜嚥≪뮆諭�
		File attPath = new File(path+"/"+fb_no);
		if(!attPath.exists()) attPath.mkdir();
		String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
		file.transferTo(new File(path+"/board/"+fb_no +"/"+image));

		//筌ｂ뫀占쏙옙�쑓占쎌뵠占쎄숲 占쎌뿯占쎌젾
		dao.board_insertAttach(image, fb_no);
		return image;
	}
	
	//占쎌쁽占쎌�野껊슣�뻻占쎈솇 筌ｂ뫀占쏙옙�솁占쎌뵬 占쎄텣占쎌젫
	@RequestMapping(value="/attDelete",method=RequestMethod.POST)
	@ResponseBody
	public void attDelete(String image, int fb_no) throws Exception{
		new File(path+"/board/"+fb_no+"/"+image).delete();
		dao.board_deleteAttach(image);
	}
	
	
	
	//----------------------------占쎈솊疫뀐옙---------------------------
	//占쎌쁽占쎌�野껊슣�뻻占쎈솇 占쎈솊疫뀐옙 �뵳�딅뮞占쎈뱜 �겫�뜄�쑎占쎌궎疫뀐옙
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

	
	//占쎌쁽占쎌�野껊슣�뻻占쎈솇 占쎈솊疫뀐옙 �빊遺쏙옙 
	@RequestMapping(value="/replyInsert",method=RequestMethod.POST)
	@ResponseBody
	public void replyInsert(BoardReplyVO vo){
		dao.board_replyInsert(vo);
	}
	
	//占쎌쁽占쎌�野껊슣�뻻占쎈솇 占쎈솊疫뀐옙 占쎄텣占쎌젫
	@RequestMapping(value="/replyDelete",method=RequestMethod.POST)
	@ResponseBody
	public void replyDelete(int fb_rno){
		dao.board_replyDelete(fb_rno);
	}
	

	//----------------------------�넫�뿭釉섓옙�뒄---------------------------
	//占쎌쁽占쎌�野껊슣�뻻占쎈솇 �넫�뿭釉섓옙�뒄 疫꿸퀡�뮟
	@RequestMapping(value="/like",method=RequestMethod.POST)
	@ResponseBody
	public void like(int likeCheck, String uid, int fb_no){
		service.board_like(likeCheck, uid, fb_no);
	}

}
