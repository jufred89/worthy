package com.example.controller;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.domain.CampingFacilityVO;
import com.example.domain.CampingStyleVO;
import com.example.domain.CampingVO;
import com.example.mapper.CampingDAO;

@Controller
@RequestMapping("/camping")
public class CampController {
	@Autowired
	CampingDAO cdao;
	
	@Resource(name = "uploadPath")
	private String path;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String campList() {
		return "/camping/list";
	}
	
	@ResponseBody
	@RequestMapping(value = "/list.json", method = RequestMethod.GET)
	public List<CampingVO> list() {
		return cdao.campList();
	}
	
	@ResponseBody
	@RequestMapping(value = "/campFacilitylist.json", method = RequestMethod.GET)
	public List<CampingFacilityVO> campFacilityList() {
		return cdao.campFacilityList();
	}
	
	@ResponseBody
	@RequestMapping(value = "/campStylelist.json", method = RequestMethod.GET)
	public List<CampingStyleVO> campStyleList() {
		return cdao.campStyleList();
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String campRead(Model model, String camp_id) {
		model.addAttribute("cvo",cdao.campRead(camp_id));
		return "/camping/read";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String campInsertPage(Model model) {
		String maxCode = cdao.maxCode();
		String camp_id="c"+(Integer.parseInt(maxCode.substring(1))+1);
		model.addAttribute("camp_id",camp_id);
		return "/camping/insert";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String campInsert(CampingVO vo, MultipartHttpServletRequest multi, @RequestParam(value="facility_no") List<String> facility_no) throws Exception {
		// 이미지 복사
		MultipartFile file = multi.getFile("file"); // 업로드한 파일 지정
		// 파일 이름 유니크하게
		String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();
		vo.setCamp_image(image);
		// 파일 업로드 하기
		file.transferTo(new File(path + "/camping/" + image));
		// 데이터 입력
		cdao.campInsert(vo);
		
		// 시설 목록 배열에 담아서 값 넘기기
		System.out.println(facility_no);
		for(String fno:facility_no){
			String camp_id=vo.getCamp_id();
			cdao.campFacilityInsert(camp_id, fno);
		}
		return "redirect:/camping/list";
	}
	
	@ResponseBody
	@RequestMapping(value = "/cslist.json", method = RequestMethod.GET)
	public List<CampingVO> campStyleRead(String camp_id) {
		return cdao.campStyleRead(camp_id);
	}
	
	@ResponseBody
	@RequestMapping(value = "/cflist.json", method = RequestMethod.GET)
	public List<CampingVO> campFacilityRead(String camp_id) {
		return cdao.campFacilityRead(camp_id);
	}
}
