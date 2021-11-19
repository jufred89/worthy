package com.example.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.Shop_payVO;

@Controller
public class KakaoPayController {
	//카카오페이
	@RequestMapping(value="/kakaoPay", method=RequestMethod.POST)
	@ResponseBody
	public String kakaoPay(String item_name, String total_amount ,HttpSession session){
		SSLTrust.sslTrustAllCerts();
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
			param +="&approval_url=http://localhost:8088/approval";
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
	@RequestMapping(value="/kakaoPayApproval", method=RequestMethod.POST)
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
	@RequestMapping(value="/kakaoPaySuccess", method=RequestMethod.POST)
	@ResponseBody
	public void kakaoPayApproval(String aid, String pay_date, String pay_type,
		String quantity, String pay_price, HttpSession session) { 
		String item_name = (String)session.getAttribute("item_name");
		System.out.println("item_name: "+ item_name);
		System.out.println("aid: "+ aid);
		StringBuilder st_pay_date = new StringBuilder(pay_date);
		st_pay_date.setCharAt(10, ' '); //10번째 문자 T대신 공백으로 대체
		pay_date = st_pay_date.toString();
		
		System.out.println("pay_type: "+ pay_type);
		System.out.println("pay_price: "+ Integer.parseInt(pay_price));
		System.out.println("quantity: "+ quantity);
		System.out.println("pay_date: "+ pay_date);
		
		Shop_payVO vo = new Shop_payVO();
		vo.setPay_date(pay_date);
		vo.setPay_type(pay_type);
		//String pay_no = (String)session.getAttribute("pay_no");//세션에서 가져오기
		//vo.setPay_no(pay_no); 
		//dao.pay_update(vo); //tbl_shop_payment update
		
		//return dao.pay_read(pay_no);
	}
	
	@RequestMapping(value = "/approval", method = RequestMethod.GET)
	public String approval() {	
		return "/paystatus/approval";
	}
	@RequestMapping(value = "/fail", method = RequestMethod.GET)
	public String fail() {	
		return "/paystatus/fail";
	}
	@RequestMapping(value = "/cancel", method = RequestMethod.GET)
	public String cancel() {	
		return "/paystatus/cancel";
	}
}
