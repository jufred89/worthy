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
import javax.servlet.http.HttpServletRequest;
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
import org.w3c.dom.ls.LSInput;

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
	public List<HashMap<String, Object>> campSearchList(String camp_addr, String reser_checkin, String reser_checkout, String style_no,
			@RequestParam(value = "facility_no[]", required=false) List<String> facility_no) {
		int listSize = 1;
		if(facility_no!=null){
			listSize = facility_no.size();
		}
		return cdao.campSearchList(camp_addr, reser_checkin, reser_checkout,style_no,facility_no,listSize);
	}

	// 예약페이지 연결
	@RequestMapping(value = "/camping/checkout", method = RequestMethod.GET)
	public String campReservationCheckout(Model model, String camp_id,String style_price, String reser_checkin, String reser_checkout,
			String style_no) {
		model.addAttribute("camp_id", camp_id);
		model.addAttribute("style_no", style_no);
		model.addAttribute("style_price", style_price);
		model.addAttribute("reser_checkin", reser_checkin);
		model.addAttribute("reser_checkout", reser_checkout);
		model.addAttribute("vo", cdao.campRead(camp_id));
		model.addAttribute("pageName", "camping/reservation.jsp");
		return "home";
	}

	@RequestMapping(value = "/camping/checkout", method = RequestMethod.POST)
	public String campReservationCheckoutInsert(HttpSession session, String camp_id, String style_no,
			String reser_checkin, String reser_checkout) {
		String uid = (String) session.getAttribute("uid");
		if (uid != null) {
			System.out.println(uid);
			String camp_room_no = camp_id.concat(style_no);
			System.out.println(camp_room_no);
			cdao.campReservationCheckoutInsert(camp_id, camp_room_no,
			reser_checkin, reser_checkout, uid);
		}
		return "redirect:/";
	}

	// 카카오페이
	@RequestMapping(value = "/camping/kakaoPay", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> kakaoPay() {
		HashMap<String, Object> map = new HashMap<>();
		String result = "0";
		SSLTrust.sslTrustAllCerts();
		try {
			URL url = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestProperty("Authorization", "KakaoAK 956ed9671910d705fc2f851a38d250e1");
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true);

			String param = "cid=TC0ONETIME";
			param += "&partner_order_id=partner_order_id";
			param += "&partner_user_id=partner_user_id";
			param += "&item_name=초코파이"; // 물품명
			param += "&quantity=1"; // 물품 수량
			param += "&total_amount=2200"; // 물품가
			param += "&tax_free_amount=0"; // 세금면제가
			param += "&vat_amount=0"; // 부가세
			param += "&approval_url=http://localhost:8088"; // 요청성공
			param += "&fail_url=http://localhost:8088"; // 요청실패
			param += "&cancel_url=http://localhost:8088"; // 요청취소
			OutputStream out = conn.getOutputStream();
			DataOutputStream dataout = new DataOutputStream(out);
			dataout.writeBytes(param);
			dataout.close(); // flush() 자동 호출

			// 통신
			int rst = conn.getResponseCode(); // 확인

			InputStream in;
			if (rst == 200) { // 성공
				in = conn.getInputStream();
				result = "1";
				System.out.println("성공" + result);
			} else { // 실패
				in = conn.getErrorStream();
				result = "0";
				System.out.println("실패" + result);
			}

			InputStreamReader reader = new InputStreamReader(in);
			BufferedReader br = new BufferedReader(reader);
			String str = br.readLine();
			System.out.println("str?" + str);
			map.put("str", str);
			map.put("result", result);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return map;
	}

}
