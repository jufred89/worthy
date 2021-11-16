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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.domain.AttachVO;
import com.example.domain.Criteria;
import com.example.domain.PageMaker;
import com.example.domain.Shop_payVO;
import com.example.domain.ShopVO;
import com.example.domain.Shop_cartVO;
import com.example.domain.Shop_orderVO;
import com.example.domain.Shop_previewVO;
import com.example.mapper.ShopDAO;

@Controller
@RequestMapping("/shop")
public class ShopController {

	@Autowired
	ShopDAO dao;

	@Resource(name = "uploadPath")
	private String path;

	// 占싱뱄옙占쏙옙占쏙옙占쏙옙 占쏙옙占�
	@ResponseBody
	@RequestMapping("/display")
	public byte[] display(String file) throws Exception {
		FileInputStream in = new FileInputStream(path + "/" + file);
		// System.out.println(file);
		byte[] image = IOUtils.toByteArray(in);
		in.close();
		return image;
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String shopList() {
		return "/shop/list";
	}

	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String shopInsert(Model model) {
		String max = dao.prod_maxID();
		String maxID = "p" + (Integer.parseInt(max.substring(1)) + 1);
		model.addAttribute("prod_id", maxID);
		// System.out.println(maxID);
		model.addAttribute("pageName", "shop/insert.jsp");
		
		return "home";
	}

	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String shopRead(Model model, String prod_id) {
		model.addAttribute("vo", dao.prod_read(prod_id));
		String shop_ano = prod_id;
		model.addAttribute("avo", dao.attach(shop_ano));
		model.addAttribute("pageName", "shop/read.jsp");
		return "home";
	}

	@RequestMapping("/list.json")
	@ResponseBody
	public HashMap<String, Object> listJSON(Criteria cri) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("list", dao.prod_list(cri));
		map.put("cri", cri);

		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.totalCount(cri));

		map.put("pm", pm);
		return map;
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(ShopVO vo, MultipartHttpServletRequest multi, AttachVO avo) throws IllegalStateException, IOException {
		MultipartFile file = multi.getFile("file");
		MultipartFile att_file = multi.getFile("att_file");	
		
		//System.out.println(file.getOriginalFilename());
		//System.out.println(att_file.getOriginalFilename());
		
		//이미지 저장
		if (!file.isEmpty()) {
			String prod_image = System.currentTimeMillis() + "_" + file.getOriginalFilename();
			file.transferTo(new File(path + File.separator + prod_image));
			vo.setProd_image(prod_image);
//			System.out.println(vo.toString());
			dao.prod_insert(vo);
		}
		
		if (!att_file.isEmpty()) {
			String shop_ano = System.currentTimeMillis() + "_" + att_file.getOriginalFilename();
			att_file.transferTo(new File(path + File.separator + shop_ano));
			avo.setShop_ano(shop_ano);
			dao.att_insert(avo);
		}
		return "redirect:/shop";
	}
	
	@RequestMapping(value="/update", method = RequestMethod.GET)
	public String updatePage(String prod_id, Model model){
		model.addAttribute("vo", dao.prod_read(prod_id));
		String shop_ano = prod_id;
		model.addAttribute("avo", dao.attach(shop_ano));
		model.addAttribute("pageName", "shop/update.jsp");
		return "home";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String update(ShopVO vo, AttachVO avo, MultipartHttpServletRequest multi, String oldImage, String att_oldImage) throws Exception {
		MultipartFile file = multi.getFile("file");
		MultipartFile att_file = multi.getFile("att_file");
		
//		System.out.println(oldImage);
//		System.out.println(file.getOriginalFilename());
//		System.out.println(vo.toString());
		
		if(!file.isEmpty()){
			//이미지를 변경할 경우
			new File(path + File.separator + oldImage).delete();
			
			String prod_image = System.currentTimeMillis() + "_" + file.getOriginalFilename();
			file.transferTo(new File(path + File.separator + prod_image));
			vo.setProd_image(prod_image);
			dao.prod_update(vo);
		}else{
			//이미지를 변경하지 않은 경우
			new File(path + File.separator + oldImage);
			vo.setProd_image(oldImage);
			dao.prod_update(vo);
		}
		
		if(!att_file.isEmpty()){
			//이미지를 변경할 경우
			new File(path + File.separator + att_oldImage).delete();
			
			String shop_ano = System.currentTimeMillis() + "_" + att_file.getOriginalFilename();
			att_file.transferTo(new File(path + File.separator + shop_ano));
			avo.setShop_ano(shop_ano);
			//System.out.println(avo);
			dao.att_update(avo);
		}else{
			//이미지를 변경하지 않은 경우
			new File(path + File.separator + att_oldImage);
			avo.setShop_ano(att_oldImage);
			//System.out.println(avo);
			dao.att_update(avo);
		}
		return "redirect:/shop";
	}
	
	@RequestMapping("/prod_slide.json")
	@ResponseBody
	public HashMap<String, Object> prod_slide(){
		HashMap<String, Object> map = new HashMap<>();
		map.put("slide", dao.prod_slide());
		//System.out.println(map);
		return map;		
	}
	
	@RequestMapping("/pre_list.json")
	@ResponseBody
	public HashMap<String, Object> pre_list(String prod_rid, Criteria cri){
		HashMap<String, Object> map = new HashMap<>();
		
		cri.setPerPageNum(5);
		
		map.put("list", dao.pre_list(cri, prod_rid));
		map.put("cri", cri);
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.pre_totalCount(prod_rid));
		
		map.put("pm", pm);
		
		//System.out.println(map);
		
		return map;
	}
	
	@RequestMapping(value="/pre_insert", method=RequestMethod.POST)
	@ResponseBody
	public void pre_insert(Shop_previewVO pvo, Criteria cri){
		//System.out.println(pvo.toString());
		dao.pre_insert(pvo);
	}
	
	@RequestMapping(value="/pre_delete", method=RequestMethod.POST)
	@ResponseBody
	public void pre_delete(int prod_rno){
		dao.pre_delete(prod_rno);
	}
	
	@RequestMapping(value="/cart_insert", method=RequestMethod.POST)
	@ResponseBody
	public void cart_insert(Shop_cartVO cvo){
		dao.cart_insert(cvo);
	}
	
	@RequestMapping("/cart_list.json")
	@ResponseBody
	public HashMap<String, Object> cart_listJSON(String cart_uid, Model model){
		HashMap<String, Object> cart = new HashMap<>();
		cart.put("cart_list", dao.cart_list(cart_uid));
		return cart;
	}
	
	@RequestMapping(value="/cart_delete", method=RequestMethod.POST)
	@ResponseBody
	public void cart_delete(int cart_no){
		System.out.println(cart_no);
		dao.cart_delete(cart_no);
	}
	
	@RequestMapping("/cart_price_sum")
	@ResponseBody
	public int cart_price_sum(String cart_uid){
		return dao.cart_price_sum(cart_uid);
	}
	
	@RequestMapping(value="/pay_insert", method=RequestMethod.POST)
	@ResponseBody
	public void pay_insert(Shop_payVO pvo){
		dao.pay_insert(pvo);
	}
	
	@RequestMapping(value="/order_insert", method=RequestMethod.POST)
	@ResponseBody
	public void pay_insert(Shop_orderVO ovo){
		dao.order_insert(ovo);
	}
	
	
	//카카오페이
	@RequestMapping(value="/kakaoPay", method=RequestMethod.POST)
	@ResponseBody
	public String kakaoPay(){
		SSLTrust.sslTrustAllCerts();
		try {
			URL url = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestProperty("Authorization", "KakaoAK 956ed9671910d705fc2f851a38d250e1");
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true);
			
			String param = "cid=TC0ONETIME&partner_order_id=partner_order_id&partner_user_id=partner_user_id";
			param +="&item_name=초코파이&quantity=1&total_amount=2200&tax_free_amount=0";
			param +="&vat_amount=200";
			param +="&approval_url=http://localhost:8088";
			param +="&fail_url=http://localhost:8088";
			param +="&cancel_url=http://localhost:8088";
			OutputStream out = conn.getOutputStream();
			DataOutputStream dataout = new DataOutputStream(out);
			dataout.writeBytes(param);
			dataout.close(); //flush() 자동 호출
			
			//통신
			int rst = conn.getResponseCode(); //확인
			
			InputStream in;
			if(rst==200){ //성공
				in = conn.getInputStream();
			}else{ //실패
				in = conn.getErrorStream();
			}
			
			InputStreamReader reader = new InputStreamReader(in);
			BufferedReader br = new BufferedReader(reader);
			String str =  br.readLine();
			return str;
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "null";
	}
}
