package com.example.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/camping")
public class CampController {
	
	@RequestMapping(value = "/list.json", method = {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String campSearchJSON(int page){
		StringBuffer result = new StringBuffer();
		String spage=Integer.toString(page);
		try {
			StringBuilder urlBuilder = new StringBuilder("http://api.visitkorea.or.kr/openapi/service/rest/GoCamping/searchList"); /*URL*/
			
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + "1MQraYV21m%2BXDjQfcjoBBSsE9I6m5yZv71esCoqD1VhdnsCm4EiBh4re2Pcpq3bf0IuPQaZvdYS8lEtFiodHNQ%3D%3D"); /*�������������п��� ���� ����Ű*/
			urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode(spage, "UTF-8")); /*���� ��������ȣ*/
			urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*�� ������ ��� ��*/
			urlBuilder.append("&" + URLEncoder.encode("MobileOS","UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); /*IOS(������), AND(�ȵ���̵�), WIN(��������), ETC*/
			urlBuilder.append("&" + URLEncoder.encode("MobileApp","UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8")); /*���񽺸�=���ø�*/
			urlBuilder.append("&" + URLEncoder.encode("keyword","UTF-8") + "=" + URLEncoder.encode("����", "UTF-8")); /*�˻� ��û�� Ű����(���ڵ� �ʿ�)*/
			urlBuilder.append("&_type=json");
			
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			BufferedReader rd;
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			String line;
			while ((line = rd.readLine()) != null) {
				result.append(line+"\n");
			}
			rd.close();
			conn.disconnect();
			System.out.println(result.toString());
		} catch (Exception e) {
			System.out.println("campSearchJSON Error : "+e.toString());
		}
	    
		return result+"";
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String campingList() {
		return "/camping/list";
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String campingRead() {
		return "/camping/read";
	}
}
