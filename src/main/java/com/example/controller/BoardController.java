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

	//�뜝�럩逾졿쾬�꼶梨룟뜝�룞�삕占쎌냱�뜝�럩逾� 占쎈퉲占쎈츊占쎌졑
	@ResponseBody
	@RequestMapping("/display")
	public byte[] display(String file)throws Exception{
	   FileInputStream in=new FileInputStream(path + "/board/" + file);
	   byte[] image=IOUtils.toByteArray(in);
	   in.close();
	   return image;
	}
 
	
	
	//----------------------------�뇦猿딆뒩占쎈뻣�뜝�럥�냷---------------------------
	//�뜝�럩�겱�뜝�럩占썽뇦猿딆뒩占쎈뻣�뜝�럥�냷 嶺뚮ㅄ維뽨빳占� �뜝�럥�쓡�뜝�럩逾좂춯�쉻�삕 �뜝�럩逾졾뜝�럥吏�
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String boardList(Model model) {
		model.addAttribute("pageName","board/list.jsp");
		return "home";
	}
	
	//�뜝�럩�겱�뜝�럩占썽뇦猿딆뒩占쎈뻣�뜝�럥�냷 嶺뚮ㅄ維뽨빳占� JSON �뜝�럥�몥�뜝�럩逾졾뜝�럡�댉 �뤆�룊�삕�뜝�럩二у뜝�럩沅롧뼨�먯삕
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
	
	//�뜝�럩�겱�뜝�럩占썽뇦猿딆뒩占쎈뻣�뜝�럥�냷 �뼨�먯삕�뜝�럥苡삣슖�댙�삕 �뜝�럥�쓡�뜝�럩逾좂춯�쉻�삕 �뜝�럩逾졾뜝�럥吏�
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String boardInsert(Model model) {
		int maxNo = dao.board_maxNo();
		int fb_no = maxNo+1;
		model.addAttribute("fb_no",fb_no);
		model.addAttribute("pageName","board/insert.jsp");
		return "home";
	}
	
	//野껊슣�뻻占쎈솇 疫뀐옙 占쎈쾻嚥∽옙
	@RequestMapping(value="/insert" ,method=RequestMethod.POST)
	public String insertPost(BoardVO vo, MultipartHttpServletRequest multi) throws Exception{
		MultipartFile file = multi.getFile("file"); //form�뜝�럥�뱺�뜝�럡�맋 input type="file"�뜝�럥�뱺 繞벿우삕 name�뜝�럩紐드슖�댙�삕 �뤆�룊�삕�뜝�럩二у뜝�럩沅롧뼨�먯삕
		
		if(!file.isEmpty()){
			String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
			vo.setFb_image(image);
			
			//�뜝�룞�삕�뜝�럥�걫 �뜝�럥�냱�뜝�럩逾� �뜝�럥�뵜�슖�돦裕녻キ占�
			File imagefolder = new File(path+"/board/");
			if(!imagefolder.exists()){
				imagefolder.mkdir();
			}
			file.transferTo(new File(path+"/board/"+image));
		}			
		//�뜝�럥�몥�뜝�럩逾졾뜝�럡�댉�뜝�럩肉��뜝�럩�졑
		//dao.insert(vo);
		
		//嶺뚳퐘維��뜝�룞�삕占쎌냱�뜝�럩逾� �뜝�럥�뿰�뜝�럩�몠�뤆�룊�삕 �뜝�럥�뵜�슖�돦裕녻キ占�
		List<MultipartFile> files = multi.getFiles("files");
		ArrayList<String> images = new ArrayList<>();
		
		//筌ｂ뫀占쏙옙�솁占쎌뵬 占쎈쨨占쎈쐭 筌띾슢諭얏묾占�
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
	
	
	//�뜝�럩�겱�뜝�럩占썽뇦猿딆뒩占쎈뻣�뜝�럥�냷 �뼨�먯삕�뜝�럩逾��뼨�먯삕
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String boardRead(Model model, int fb_no, HttpSession session) {
		model.addAttribute("pageName","board/read.jsp");
		model.addAttribute("vo",service.board_read(fb_no));
		//嶺뚳퐘維��뜝�룞�삕占쎌냱�뜝�럩逾� 占쎈뎨占쎈봾裕욃뜝�럥諭�
		model.addAttribute("attList",dao.board_attachList(fb_no));
		
		
		String uid = (String)session.getAttribute("uid");
		int check = dao.board_likeIt(uid, fb_no); //�뇦猿딆뒩占쎈뻣�뼨�먯삕�뜝�럥�뱺 �뜝�럥援뜹뜝�럥�꽑�뤆�룄�뫒占쎌쓤�뜝�럩肉녑뜝�럥裕됬춯�쉻�삕 �뜝�럩�꼪�뜝�럩逾�
		if(check==0){
			dao.board_likeTableInsert(uid, fb_no); //占쎈꽞占쎈열�뇡�꼻�삕占쎈뭵 �뜝�럥占쎈���삕占쎈턄占쎈눀�겫�슜�뱺 占쎈꽞占쎈열�뇡�꼻�삕占쎈뭵0 �뜝�럡留믣뜝�럡臾뜹슖�댙�삕 �뜝�럩肉��뜝�럩�졑
		}
		model.addAttribute("likeCheck",dao.board_likeCheck(uid, fb_no)); //占쎈꽞占쎈열�뇡�꼻�삕占쎈뭵 �뜝�럡留믣뜝�럡臾뜻뤆�룊�삕嶺뚯쉻�삕占썩뫅�삕 �뤆�룊�삕�뼨�먯삕
		
		return "home";
	}
	
	//野껊슣�뻻疫뀐옙 占쎈땾占쎌젟
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public String update(BoardVO vo, String oldImage, MultipartHttpServletRequest multi) throws Exception{
		MultipartFile file = multi.getFile("file");
		if(!file.isEmpty()){ 
			if(oldImage!=null | oldImage!=""){
				new File(path+"/board/"+oldImage).delete();
				
				String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
				file.transferTo(new File(path+"/board/"+image));
				vo.setFb_image(image);
			}

		}else{
			vo.setFb_image(oldImage);
		}
		//System.out.println(vo.toString());
		dao.board_update(vo); 
		System.out.println(vo.toString()+ "oldImage="+oldImage);
		return "redirect:/board/list";
	}
	
	//野껊슣�뻻疫뀐옙 占쎄텣占쎌젫
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public String deletePost(int fb_no,String formImage){
		System.out.println(formImage);
		File thumbnail = new File(path+"/board/"+formImage);
		thumbnail.delete();
		
		
		//筌ｂ뫀占쏙옙�솁占쎌뵬 占쎄텣占쎌젫
		File folder = new File(path+"/board/"+fb_no);
		File[] files = folder.listFiles();

           for(File file : files){
               file.delete(); 
           }
		//占쎈쨨占쎈쐭 占쎌쁽筌ｋ�占쏙옙 占쎄텣占쎌젫
		new File(path+"/board/"+fb_no).delete();
		
		//野껊슣�뻻疫뀐옙, 筌ｂ뫀占쏙옙�솁占쎌뵬, �넫�뿭釉섓옙�뒄 占쎈�믭옙�뵠�뇡遺용퓠占쎄퐣 占쎄텣占쎌젫
		service.board_delete(fb_no);
		return "redirect:list";
	}
	
	
	//----------------------------嶺뚳퐘維��뜝�룞�삕占쎌냱�뜝�럩逾�---------------------------
	//筌ｂ뫀占쏙옙�솁占쎌뵬 占쎈쾻嚥∽옙
	@RequestMapping(value="/attInsert",method=RequestMethod.POST)
	@ResponseBody
	public String attInsert(int fb_no, MultipartFile file) throws Exception{
		//嶺뚳퐘維��뜝�룞�삕占쎌냱�뜝�럩逾� �뜝�럥�뵜�슖�돦裕녻キ占�
		File attPath = new File(path+"/"+fb_no);
		if(!attPath.exists()) attPath.mkdir();
		String image = System.currentTimeMillis()+"_"+file.getOriginalFilename();
		file.transferTo(new File(path+"/board/"+fb_no +"/"+image));

		//嶺뚳퐘維��뜝�룞�삕占쎌몥�뜝�럩逾졾뜝�럡�댉 �뜝�럩肉��뜝�럩�졑
		dao.board_insertAttach(image, fb_no);
		return image;
	}
	
	//�뜝�럩�겱�뜝�럩占썽뇦猿딆뒩占쎈뻣�뜝�럥�냷 嶺뚳퐘維��뜝�룞�삕占쎌냱�뜝�럩逾� �뜝�럡�뀭�뜝�럩�젷
	@RequestMapping(value="/attDelete",method=RequestMethod.POST)
	@ResponseBody
	public void attDelete(String image, int fb_no) throws Exception{
		new File(path+"/board/"+fb_no+"/"+image).delete();
		dao.board_deleteAttach(image);
	}
	
	
	
	//----------------------------�뜝�럥�냺�뼨�먯삕---------------------------
	//�뜝�럩�겱�뜝�럩占썽뇦猿딆뒩占쎈뻣�뜝�럥�냷 �뜝�럥�냺�뼨�먯삕 占쎈뎨占쎈봾裕욃뜝�럥諭� 占쎄껀占쎈쐞占쎌몠�뜝�럩沅롧뼨�먯삕
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

	
	//�뜝�럩�겱�뜝�럩占썽뇦猿딆뒩占쎈뻣�뜝�럥�냷 �뜝�럥�냺�뼨�먯삕 占쎈퉲�겫�룞�삕 
	@RequestMapping(value="/replyInsert",method=RequestMethod.POST)
	@ResponseBody
	public void replyInsert(BoardReplyVO vo){
		dao.board_replyInsert(vo);
	}
	
	//�뜝�럩�겱�뜝�럩占썽뇦猿딆뒩占쎈뻣�뜝�럥�냷 �뜝�럥�냺�뼨�먯삕 �뜝�럡�뀭�뜝�럩�젷
	@RequestMapping(value="/replyDelete",method=RequestMethod.POST)
	@ResponseBody
	public void replyDelete(int fb_rno){
		dao.board_replyDelete(fb_rno);
	}
	

	//----------------------------占쎈꽞占쎈열�뇡�꼻�삕占쎈뭵---------------------------
	//�뜝�럩�겱�뜝�럩占썽뇦猿딆뒩占쎈뻣�뜝�럥�냷 占쎈꽞占쎈열�뇡�꼻�삕占쎈뭵 �뼨轅명�∽옙裕�
	@RequestMapping(value="/like",method=RequestMethod.POST)
	@ResponseBody
	public void like(int likeCheck, String uid, int fb_no){
		service.board_like(likeCheck, uid, fb_no);
	}

}
