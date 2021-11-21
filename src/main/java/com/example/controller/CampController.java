package com.example.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
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
import com.example.domain.CampingReserVO;
import com.example.domain.CampingReviewVO;
import com.example.domain.CampingStyleVO;
import com.example.domain.CampingVO;
import com.example.domain.Criteria;
import com.example.domain.Shop_payVO;
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

	// 캠핑장 홈이랑 연결
	@RequestMapping(value = "/camping/list", method = RequestMethod.GET)
	public String campList(Model model, String camp_addr, String reser_checkin, String reser_checkout) {
		model.addAttribute("camp_addr", camp_addr);
		model.addAttribute("styleList", cdao.campStyleList());
		model.addAttribute("facilityList", cdao.campFacilityList());
		model.addAttribute("reser_checkin", reser_checkin);
		model.addAttribute("reser_checkout", reser_checkout);
		model.addAttribute("pageName", "camping/list.jsp");
		return "home";
	}
    
	 @RequestMapping("/campSlide.json")
	 @ResponseBody
	 public List<HashMap<String,Object>> best(){
		 return cdao.campSlide();
	 }

	// 캠핑장 목록 json으로 가지고 오기
	@ResponseBody
	@RequestMapping(value = "/camping/list.json", method = RequestMethod.GET)
	public List<CampingVO> list(Criteria cri) {
		return cdao.campList(cri);
	}

	// 캠핑장 시설목록 json으로 가지고 오기
	@ResponseBody
	@RequestMapping(value = "/camping/campFacilitylist.json", method = RequestMethod.GET)
	public List<CampingFacilityVO> campFacilityList() {
		return cdao.campFacilityList();
	}

	// 캠핑장 스타일목록 json으로 가지고 오기
	@ResponseBody
	@RequestMapping(value = "/camping/campStylelist.json", method = RequestMethod.GET)
	public List<CampingStyleVO> campStyleList() {
		return cdao.campStyleList();
	}

	// 특정 캠핑장 상세 페이지
	@RequestMapping(value = "/camping/read", method = RequestMethod.GET)
	public String campRead(Model model, String camp_id, String reser_checkin, String reser_checkout) {
		model.addAttribute("reser_checkin", reser_checkin);
		model.addAttribute("reser_checkout", reser_checkout);
		model.addAttribute("attList", cadao.list(camp_id));
		model.addAttribute("cvo", cdao.campRead(camp_id));
		model.addAttribute("styleList", cdao.campStyleRead(camp_id));
		model.addAttribute("facilityList", cdao.campFacilityRead(camp_id));
		model.addAttribute("reserList", cdao.campAvailableReser(camp_id, reser_checkin, reser_checkout));
		model.addAttribute("pageName", "camping/read.jsp");
		return "home";
	}
	// 캠핑장 insert 작업
	@RequestMapping(value = "/camping/insert", method = RequestMethod.POST)
	public String campInsert(CampingVO vo, MultipartHttpServletRequest multi,
			@RequestParam(value = "facility_no") List<String> facility_no,
			@RequestParam(value = "style_no") List<String> style_no,
			@RequestParam(value = "style_qty") List<Integer> style_qty,
			@RequestParam(value = "style_price") List<Integer> style_price) throws Exception {
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
		ArrayList<String> images = new ArrayList<String>();
		for (MultipartFile attFile : files) {
			if (!attFile.isEmpty()) {
				String attImage = System.currentTimeMillis() + "_" + attFile.getOriginalFilename();
				images.add(vo.getCamp_id() + "/" + attImage); // new
				// 새폴더 생성
				File folder = new File(path + "/camping/" + vo.getCamp_id());
				if (!folder.exists()) {
					folder.mkdir();
				}
				// 해당 폴더 업로드
				attFile.transferTo(new File(path + "/camping/" + vo.getCamp_id() + "/" + attImage));
			}
		}
		vo.setImages(images);
		cservice.insert(vo);

		// 시설 목록 배열에 담아서 값 넘기기
		for (String fno : facility_no) {
			String camp_id = vo.getCamp_id();
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
			String camp_id = vo.getCamp_id();
			String sno = style_no.get(i);
			int sqty = style_qty.get(i);
			int sprice = style_price.get(i);
			cdao.campStyleInsert(camp_id, sno, sqty, sprice);
		}
		return "redirect:/camping/list";
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

	// 캠핑장 조건 검색
	@ResponseBody
	@RequestMapping(value = "/camping/searchlist.json", method = RequestMethod.GET)
	public List<HashMap<String, Object>> campSearchList(String camp_addr, String reser_checkin, String reser_checkout,
			String style_no, @RequestParam(value = "facility_no[]", required = false) List<String> facility_no) {
		int listSize = 1;
		if (facility_no != null) {
			listSize = facility_no.size();
		}
		return cdao.campSearchList(camp_addr, reser_checkin, reser_checkout, style_no, facility_no, listSize);
	}

	// 예약페이지 연결
	@RequestMapping(value = "/camping/checkout", method = RequestMethod.GET)
	public String campReservationCheckout(Model model, String camp_id, String style_price, String reser_checkin,
			String reser_checkout, String style_no) {
		model.addAttribute("camp_id", camp_id);
		model.addAttribute("style_no", style_no);
		model.addAttribute("style_price", style_price);
		model.addAttribute("reser_checkin", reser_checkin);
		model.addAttribute("reser_checkout", reser_checkout);
		model.addAttribute("vo", cdao.campRead(camp_id));
		model.addAttribute("pageName", "camping/reservation.jsp");
		return "home";
	}
	/*
	// 캠핑장 예약
	@RequestMapping(value = "/camping/checkout", method = RequestMethod.POST)
	public String campReservationCheckoutInsert(HttpSession session, String camp_id, String style_no,
			String reser_checkin, String reser_checkout) {
		String uid = (String) session.getAttribute("uid");
		if (uid != null) {
			System.out.println(uid);
			String camp_room_no = camp_id.concat(style_no);
			System.out.println(camp_room_no);
			cdao.campReservationCheckoutInsert(camp_id, camp_room_no, reser_checkin, reser_checkout, uid);
		}
		return "redirect:/";
	}
	*/
	// 첨부 파일 삭제
	@ResponseBody
	@RequestMapping(value = "/camping/attDelete", method = RequestMethod.POST)
	public void attDelete(String camp_image) {
		cadao.delete(camp_image); // 테이블에서 삭제
		new File(path + "/camping/" + camp_image).delete(); // 디스크에서 삭제
	}

	// 첨부 파일 추가
	@ResponseBody
	@RequestMapping(value = "/camping/attInsert", method = RequestMethod.POST)
	public String attInsert(String camp_id, MultipartFile file) throws Exception {
		// 첨부파일 업로드
		File attPath = new File(path + "/camping/" + camp_id);
		if (!attPath.exists()) {
			attPath.mkdir(); // .mkdir ; 디렉토리 생성
		}
		String camp_image = camp_id + "/" + System.currentTimeMillis() + "_" + file.getOriginalFilename();
		file.transferTo(new File(path + "/camping/" + camp_image));

		// 첨부데이터 입력
		System.out.println(camp_id + "/" + camp_image);
		cadao.insert(camp_image, camp_id);
		return camp_image;
	}

	// 캠핑장 update 작업
	@RequestMapping(value = "/camping/update", method = RequestMethod.POST)
	public String campUpdate(CampingVO vo, MultipartHttpServletRequest multi,
			@RequestParam(value = "facility_no", required = false) List<String> facility_no,
			@RequestParam(value = "style_no", required = false) List<String> style_no,
			@RequestParam(value = "style_qty", required = false) List<Integer> style_qty,
			@RequestParam(value = "style_price", required = false) List<Integer> style_price) throws Exception {
		MultipartFile file = multi.getFile("file");
		// 이미지가 바뀐 경우 기존 이미지 삭제 후 바뀐 이미지 입력
		if (!file.isEmpty()) {
			new File(path + "/camping/" + vo.getCamp_image()).delete();
			String image = System.currentTimeMillis() + "_" + file.getOriginalFilename();
			file.transferTo(new File(path+"/camping/"+image));
			vo.setCamp_image(image);
		}
		// 아니면 update
		cdao.campUpdate(vo);

		// 기존 시설 목록 삭제
		String camp_id = vo.getCamp_id();
		cdao.campFacilityDelete(camp_id);

		// 시설 목록 배열에 담아서 값 넘기기
		for (String fno : facility_no) {
			cdao.campFacilityInsert(camp_id, fno);
		}

		// 기존 스타일 목록 삭제
		cdao.campStyleDelete(camp_id);

		// style_qty null 값 제거
		while (style_qty.remove(null)) {
		}
		// style_price null 값 제거
		while (style_price.remove(null)) {
		}

		// 스타일 목록에 값 넘기기
		for (int i = 0; i < style_no.size(); i++) {
			String sno = style_no.get(i);
			int sqty = style_qty.get(i);
			int sprice = style_price.get(i);
			cdao.campStyleInsert(camp_id, sno, sqty, sprice);
		}
		return "redirect:/admin/camping/list";
	}

	//카카오페이
	@RequestMapping(value="/camping/kakaoPay", method=RequestMethod.POST)
	@ResponseBody
	public String kakaoPay(String camp_id, String uid, String style_no, String reser_checkin, String reser_checkout,
			String reser_booker, String reser_booker_phone, String item_name, String total_amount ,HttpSession session){
		SSLTrust.sslTrustAllCerts();
		System.out.println(camp_id+"/"+uid+"/"+style_no+"/"+reser_checkin+"/"+reser_checkout+"/"+reser_booker+"/"+reser_booker_phone);
        session.setAttribute("camp_id", camp_id);
        session.setAttribute("style_no", style_no);
        session.setAttribute("reser_checkin", reser_checkin);
        session.setAttribute("reser_checkout", reser_checkout);
        session.setAttribute("reser_booker", reser_booker);
        session.setAttribute("reser_booker_phone", reser_booker_phone);
		try {
			URL url = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestProperty("Authorization", "KakaoAK 956ed9671910d705fc2f851a38d250e1");
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true);
			
			String param = "cid=TC0ONETIME&partner_order_id=partner_order_id&partner_user_id=partner_user_id";
			param +="&quantity=1&tax_free_amount=0";
			param +="&item_name="+item_name;
			param +="&total_amount="+total_amount;
			param +="&vat_amount=200";
			param +="&approval_url=http://localhost:8088/camping/approval";
			param +="&fail_url=http://localhost:8088";
			param +="&cancel_url=http://localhost:8088";
			
			OutputStream out = conn.getOutputStream();
			DataOutputStream dataout = new DataOutputStream(out);
			//dataout.writeBytes(param);
			dataout.write(param.getBytes("utf-8")); //한글깨짐 방지
			dataout.close(); //flush() 자동 호출
			
			//통신
			int rst = conn.getResponseCode(); //확인
			
			InputStream in;
			if(rst==200){ //성공
				in = conn.getInputStream();
			}else{ //실패
				in = conn.getErrorStream();
			}
			
		
			//데이터 읽어오기
			InputStreamReader reader = new InputStreamReader(in);
			BufferedReader br = new BufferedReader(reader);
			String str =  br.readLine();
			System.out.println(str);
			return str;
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "null";
	}
	
	//결제 승인
	@RequestMapping(value="/camping/kakaoPayApproval", method=RequestMethod.POST)
	@ResponseBody
	public String kakaoPayApproval(String pg_token,String tid, Model model, HttpSession httpSession) { 
		//String user_id = (String) httpSession.getAttribute("user_id"); 
		//System.out.println("kakaoPaySuccess pg_token : " + pg_token.substring(9)); 
		pg_token = pg_token.substring(9);
		SSLTrust.sslTrustAllCerts();
		try {
			URL url = new URL("https://kapi.kakao.com/v1/payment/approve");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestProperty("Authorization", "KakaoAK 956ed9671910d705fc2f851a38d250e1");
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true);
			
			String param = "cid=TC0ONETIME&partner_order_id=partner_order_id&partner_user_id=partner_user_id";
			param +="&tid="+tid;
			param +="&pg_token="+pg_token;
			
			OutputStream out = conn.getOutputStream();
			DataOutputStream dataout = new DataOutputStream(out);
			dataout.writeBytes(param);
			dataout.close(); //flush() 자동 호출
			
			//통신
			int rst = conn.getResponseCode(); //확인
			System.out.println(rst);
			InputStream in;
			if(rst==200){ //성공
				in = conn.getInputStream();
			}else{ //실패
				in = conn.getErrorStream();
			}
			
			InputStreamReader reader = new InputStreamReader(in,"UTF-8"); //한글깨짐 방지
			BufferedReader br = new BufferedReader(reader);
			String str =  br.readLine();
			System.out.println(str);
			return str;
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
		
	}

	//결제 완료
	@RequestMapping(value="/camping/kakaoPaySuccess", method=RequestMethod.POST)
	@ResponseBody
	public void kakaoPayApproval(String aid, String pay_date, String pay_type,
		String quantity, String pay_price,String camp_id, String uid, String style_no, String reser_checkin, String reser_checkout,
		String reser_booker, String reser_booker_phone, HttpSession session) { 
		String item_name = (String)session.getAttribute("item_name");
		System.out.println("item_name: "+ item_name);
		System.out.println("aid: "+ aid);
		StringBuilder st_pay_date = new StringBuilder(pay_date);
		st_pay_date.setCharAt(10, ' '); //10번째 문자 T대신 공백으로 대체
		pay_date = st_pay_date.toString();
		
		System.out.println("결제타입: "+ pay_type);
		System.out.println("결제금액: "+ Integer.parseInt(pay_price));
		System.out.println("결제수량: "+ quantity);
		System.out.println("결제일자: "+ pay_date);
		System.out.println("캠프장번호: "+ camp_id);
		System.out.println("예약자ID: "+uid);
		System.out.println("캠프스타일: "+style_no);
		System.out.println("체크인: "+reser_checkin);
		System.out.println("체크아웃: "+reser_checkout);
		System.out.println("예약자: "+reser_booker);
		System.out.println("전화번호: "+reser_booker_phone);
		String camp_room_no=camp_id.concat(style_no);
		String reser_status = "1";
		int reser_price=Integer.parseInt(pay_price);
		CampingReserVO crvo = new CampingReserVO();
		crvo.setCamp_id(camp_id);
		crvo.setCamp_room_no(camp_room_no);
		crvo.setReser_status(reser_status);
		crvo.setReser_checkin(reser_checkin);
		crvo.setReser_checkout(reser_checkout);
		crvo.setUid(uid);
		crvo.setReser_booker(reser_booker);
		crvo.setReser_booker_phone(reser_booker_phone);
		crvo.setReser_price(reser_price);
		crvo.setReser_date(pay_date);
		cdao.campReservationCheckoutInsert(crvo);
			
		// 데이터 입력 후 세션 삭제
        session.removeAttribute("camp_id");
        session.removeAttribute("style_no");
        session.removeAttribute("reser_checkin");
        session.removeAttribute("reser_checkout");
        session.removeAttribute("reser_booker");
        session.removeAttribute("reser_booker_phone");
	}
	
	@RequestMapping(value = "/camping/approval", method = RequestMethod.GET)
	public String approval(Model model, String camp_id, String uid, String style_no, String reser_checkin, String reser_checkout,
			String reser_booker, String reser_booker_phone) {
		model.addAttribute("camp_id", camp_id);
		model.addAttribute("uid", uid);
		model.addAttribute("style_no", style_no);
		model.addAttribute("reser_checkin", reser_checkin);
		model.addAttribute("reser_checkout", reser_checkout);
		model.addAttribute("reser_booker", reser_booker);
		model.addAttribute("reser_booker_phone", reser_booker_phone);
		System.out.println("이곳까지 왔다.");
		return "/paystatus/campApproval";
	}
	@RequestMapping(value = "/camping/fail", method = RequestMethod.GET)
	public String fail() {	
		return "/paystatus/fail";
	}
	@RequestMapping(value = "/camping/cancel", method = RequestMethod.GET)
	public String cancel() {	
		return "/paystatus/cancel";
	}
	@RequestMapping(value = "/camping/campReservationSuccess", method = RequestMethod.GET)
	public String campReservationSuccess() {	
		return "/mypage/mycamping";
	}
	@RequestMapping(value = "/camping/campReviewInsert", method = RequestMethod.POST)
	@ResponseBody
	public void campReviewInsert(CampingReviewVO cvo) {
		cdao.campReviewInsert(cvo);
	}
}
