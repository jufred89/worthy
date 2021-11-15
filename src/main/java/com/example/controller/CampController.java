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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.domain.CampingFacilityVO;
import com.example.domain.CampingStyleVO;
import com.example.domain.CampingVO;
import com.example.domain.Criteria;
import com.example.mapper.CampingAttachDAO;
import com.example.mapper.CampingDAO;
import com.example.service.CampingService;

@Controller
public class CampController {
	@Autowired
	CampingDAO cdao;
	
	@Autowired
	CampingAttachDAO cadao;
	
	@Autowired
	CampingService cservice;
	
	@Resource(name = "uploadPath")
	private String path;
	
	//캠핑장 홈이랑 연결
	@RequestMapping(value = "/camping/list", method = RequestMethod.GET)
	public String campList(Model model,String camp_addr,String reser_checkin,String reser_checkout) {
		System.out.println(camp_addr+"/"+reser_checkin+"/"+reser_checkout);
		model.addAttribute("camp_addr",camp_addr);
		model.addAttribute("reser_checkin",reser_checkin);
		model.addAttribute("reser_checkout",reser_checkout);
		model.addAttribute("pageName", "camping/list.jsp");
		return "home";
	}
	
	//캠핑장 목록 json으로 가지고 오기
	@ResponseBody
	@RequestMapping(value = "/camping/list.json", method = RequestMethod.GET)
	public List<CampingVO> list(Criteria cri) {
		return cdao.campList(cri);
	}
	
	//캠핑장 시설목록 json으로 가지고 오기
	@ResponseBody
	@RequestMapping(value = "/camping/campFacilitylist.json", method = RequestMethod.GET)
	public List<CampingFacilityVO> campFacilityList() {
		return cdao.campFacilityList();
	}
	
	//캠핑장 스타일목록 json으로 가지고 오기
	@ResponseBody
	@RequestMapping(value = "/camping/campStylelist.json", method = RequestMethod.GET)
	public List<CampingStyleVO> campStyleList() {
		return cdao.campStyleList();
	}
	
	// 특정 캠핑장 상세 페이지
	@RequestMapping(value = "/camping/read", method = RequestMethod.GET)
	public String campRead(Model model, String camp_id, String reser_checkin, String reser_checkout) {
		System.out.println(camp_id+","+reser_checkin+","+reser_checkout);
		model.addAttribute("reser_checkin", reser_checkin);
		model.addAttribute("reser_checkout", reser_checkout);
		model.addAttribute("attList",cadao.list(camp_id));
		model.addAttribute("cvo",cdao.campRead(camp_id));
		model.addAttribute("pageName", "camping/read.jsp");
		return "home";
	}
	/*
	// 캠핑장 insert page
	@RequestMapping(value = "/camping/insert", method = RequestMethod.GET)
	public String campInsertPage(Model model) {
		String maxCode = cdao.maxCode();
		String camp_id="c"+(Integer.parseInt(maxCode.substring(1))+1);
		model.addAttribute("camp_id",camp_id);
		model.addAttribute("pageName", "camping/insert.jsp");
		return "home";
	}
	*/
	// 캠핑장 insert 작업
	@RequestMapping(value = "/camping/insert", method = RequestMethod.POST)
	public String campInsert(CampingVO vo, MultipartHttpServletRequest multi, 
			@RequestParam(value="facility_no") List<String> facility_no,
			@RequestParam(value="style_no") List<String> style_no,
			@RequestParam(value="style_qty") List<Integer> style_qty,
			@RequestParam(value="style_price") List<Integer> style_price) throws Exception {
		// 이미지 복사
		MultipartFile file = multi.getFile("file"); // 업로드한 파일 지정
		// 파일 이름 유니크하게
		String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();
		vo.setCamp_image(image);
		// 파일 업로드 하기
		file.transferTo(new File(path + "/camping/" + image));
		
		// new
		// 첨부 파일 업로드 하기
		List<MultipartFile> files = multi.getFiles("files");
		ArrayList<String> images=new ArrayList<String>();
		for(MultipartFile attFile:files){
			if(!attFile.isEmpty()){
				String attImage=System.currentTimeMillis()+"_"+attFile.getOriginalFilename();
				images.add(vo.getCamp_id()+"/"+attImage); // new
				// 새폴더 생성
				File folder = new File(path+"/camping/"+vo.getCamp_id());
				if(!folder.exists()){
					folder.mkdir();
				}
				// 해당 폴더 업로드
				attFile.transferTo(new File(path+"/camping/"+vo.getCamp_id()+"/"+attImage));
			}
		}
		vo.setImages(images);
		cservice.insert(vo);
		
		// 시설 목록 배열에 담아서 값 넘기기
		for(String fno:facility_no){
			String camp_id=vo.getCamp_id();
			cdao.campFacilityInsert(camp_id, fno);
		}

		// style_qty null 값 제거
		while (style_qty.remove(null)) {
		}
		// style_price null 값 제거
		while (style_price.remove(null)) {
		}
		
		// 스타일 목록에 값 넘기기
		for (int i = 0; i < style_no.size(); i++) {
			String camp_id=vo.getCamp_id();
			String sno=style_no.get(i);
			int sqty=style_qty.get(i);
			int sprice=style_price.get(i);			
			cdao.campStyleInsert(camp_id, sno, sqty,sprice);
		}
		return "redirect:/camping/list";
	}
	
	// 캠핑장 스타일 목록
	@ResponseBody
	@RequestMapping(value = "/camping/cslist.json", method = RequestMethod.GET)
	public List<CampingVO> campStyleRead(String camp_id) {
		return cdao.campStyleRead(camp_id);
	}
	
	// 캠핑장 시설 목록
	@ResponseBody
	@RequestMapping(value = "/camping/cflist.json", method = RequestMethod.GET)
	public List<CampingVO> campFacilityRead(String camp_id) {
		return cdao.campFacilityRead(camp_id);
	}
	
	// 이미지파일 출력
	@ResponseBody
	@RequestMapping("/camping/display")
	public byte[] display(String file) throws Exception {
		String cpath = "/camping/";
		FileInputStream in = new FileInputStream(path + cpath + file);
		byte[] image = IOUtils.toByteArray(in);
		in.close();
		return image;
	}
	/*
	// 지역, 날짜 조건 캠핑장 목록
	@ResponseBody
	@RequestMapping("/camping/campSearchList.json")
	public List<HashMap<String, Object>> campSearchLit() {
		return cdao.campSearchList();
	}
	*/
	@ResponseBody
	@RequestMapping(value="/camping/searchlist.json", method = RequestMethod.GET)
	public List<HashMap<String, Object>> campSearchList(String camp_addr, String reser_checkin,String reser_checkout){
		System.out.println("............."+camp_addr+"/"+reser_checkin+"/"+reser_checkout);
		return cdao.campSearchList(camp_addr,reser_checkin,reser_checkout);
	}
	
}
