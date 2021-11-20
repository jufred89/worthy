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
	
	//罹좏븨�옣 �솃�씠�옉 �뿰寃�
	@RequestMapping(value = "/camping/list", method = RequestMethod.GET)
	public String campList(Model model,String camp_addr,String reser_checkin,String reser_checkout) {
		model.addAttribute("camp_addr",camp_addr);
		model.addAttribute("reser_checkin",reser_checkin);
		model.addAttribute("reser_checkout",reser_checkout);
		model.addAttribute("pageName", "camping/list.jsp");
		return "home";
	}
	 @RequestMapping("/campSlide.json")
	 @ResponseBody
	 public List<HashMap<String,Object>> best(){
		 return cdao.campSlide();
	 }
	
	//罹좏븨�옣 紐⑸줉 json�쑝濡� 媛�吏�怨� �삤湲�
	@ResponseBody
	@RequestMapping(value = "/camping/list.json", method = RequestMethod.GET)
	public List<CampingVO> list(Criteria cri) {
		return cdao.campList(cri);
	}
	
	//罹좏븨�옣 �떆�꽕紐⑸줉 json�쑝濡� 媛�吏�怨� �삤湲�
	@ResponseBody
	@RequestMapping(value = "/camping/campFacilitylist.json", method = RequestMethod.GET)
	public List<CampingFacilityVO> campFacilityList() {
		return cdao.campFacilityList();
	}
	
	//罹좏븨�옣 �뒪���씪紐⑸줉 json�쑝濡� 媛�吏�怨� �삤湲�
	@ResponseBody
	@RequestMapping(value = "/camping/campStylelist.json", method = RequestMethod.GET)
	public List<CampingStyleVO> campStyleList() {
		return cdao.campStyleList();
	}
	
	// �듅�젙 罹좏븨�옣 �긽�꽭 �럹�씠吏�
	@RequestMapping(value = "/camping/read", method = RequestMethod.GET)
	public String campRead(Model model, String camp_id, String reser_checkin, String reser_checkout) {
		model.addAttribute("reser_checkin", reser_checkin);
		model.addAttribute("reser_checkout", reser_checkout);
		model.addAttribute("attList",cadao.list(camp_id));
		model.addAttribute("cvo",cdao.campRead(camp_id));
		model.addAttribute("styleList", cdao.campStyleRead(camp_id));
		model.addAttribute("facilityList", cdao.campFacilityRead(camp_id));
		model.addAttribute("reserList", cdao.campAvailableReser(camp_id, reser_checkin, reser_checkout));
		model.addAttribute("pageName", "camping/read.jsp");
		return "home";
	}
	// 罹좏븨�옣 insert �옉�뾽
	@RequestMapping(value = "/camping/insert", method = RequestMethod.POST)
	public String campInsert(CampingVO vo, MultipartHttpServletRequest multi, 
			@RequestParam(value="facility_no") List<String> facility_no,
			@RequestParam(value="style_no") List<String> style_no,
			@RequestParam(value="style_qty") List<Integer> style_qty,
			@RequestParam(value="style_price") List<Integer> style_price) throws Exception {
		// �씠誘몄� 蹂듭궗
		MultipartFile file = multi.getFile("file"); // �뾽濡쒕뱶�븳 �뙆�씪 吏��젙
		// �뙆�씪 �씠由� �쑀�땲�겕�븯寃�
		String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();
		vo.setCamp_image(image);
		// �뙆�씪 �뾽濡쒕뱶 �븯湲�
		file.transferTo(new File(path + "/camping/" + image));
		
		// new
		// 泥⑤� �뙆�씪 �뾽濡쒕뱶 �븯湲�
		List<MultipartFile> files = multi.getFiles("files");
		ArrayList<String> images=new ArrayList<String>();
		for(MultipartFile attFile:files){
			if(!attFile.isEmpty()){
				String attImage=System.currentTimeMillis()+"_"+attFile.getOriginalFilename();
				images.add(vo.getCamp_id()+"/"+attImage); // new
				// �깉�뤃�뜑 �깮�꽦
				File folder = new File(path+"/camping/"+vo.getCamp_id());
				if(!folder.exists()){
					folder.mkdir();
				}
				// �빐�떦 �뤃�뜑 �뾽濡쒕뱶
				attFile.transferTo(new File(path+"/camping/"+vo.getCamp_id()+"/"+attImage));
			}
		}
		vo.setImages(images);
		cservice.insert(vo);
		
		// �떆�꽕 紐⑸줉 諛곗뿴�뿉 �떞�븘�꽌 媛� �꽆湲곌린
		for(String fno:facility_no){
			String camp_id=vo.getCamp_id();
			cdao.campFacilityInsert(camp_id, fno);
		}

		// style_qty null 媛� �젣嫄�
		while (style_qty.remove(null)) {
		}
		// style_price null 媛� �젣嫄�
		while (style_price.remove(null)) {
		}
		
		// �뒪���씪 紐⑸줉�뿉 媛� �꽆湲곌린
		for (int i = 0; i < style_no.size(); i++) {
			String camp_id=vo.getCamp_id();
			String sno=style_no.get(i);
			int sqty=style_qty.get(i);
			int sprice=style_price.get(i);			
			cdao.campStyleInsert(camp_id, sno, sqty,sprice);
		}
		return "redirect:/camping/list";
	}
	
	// �씠誘몄��뙆�씪 異쒕젰
	@ResponseBody
	@RequestMapping("/camping/display")
	public byte[] display(String file) throws Exception {
		String cpath = "/camping/";
		FileInputStream in = new FileInputStream(path + cpath + file);
		byte[] image = IOUtils.toByteArray(in);
		in.close();
		return image;
	}
	
	@ResponseBody
	@RequestMapping(value="/camping/searchlist.json", method = RequestMethod.GET)
	public List<HashMap<String, Object>> campSearchList(String camp_addr, String reser_checkin,String reser_checkout){
		return cdao.campSearchList(camp_addr,reser_checkin,reser_checkout);
	}
	
	// �삁�빟�럹�씠吏� �뿰寃�
	@RequestMapping(value = "/camping/checkout", method = RequestMethod.GET)
	public String campReservationCheckout(Model model,String camp_id, String reser_checkin, String reser_checkout, String style_no) {
		model.addAttribute("camp_id",camp_id);
		model.addAttribute("style_no",style_no);
		model.addAttribute("reser_checkin",reser_checkin);
		model.addAttribute("reser_checkout",reser_checkout);
		model.addAttribute("vo",cdao.campRead(camp_id));
		model.addAttribute("pageName", "camping/reservation.jsp");
		return "home";
	}
	
	@RequestMapping(value = "/camping/checkout", method = RequestMethod.POST)
	public String campReservationCheckoutInsert(HttpSession session,String camp_id, String style_no, String reser_checkin, String reser_checkout) {
		String uid = (String)session.getAttribute("uid");
		if(uid!=null){
			System.out.println(uid);
			String camp_room_no=camp_id.concat(style_no);
			System.out.println(camp_room_no);
			cdao.campReservationCheckoutInsert(camp_id, camp_room_no, reser_checkin, reser_checkout, uid);
		}
		return "redirect:/";
	}

}
