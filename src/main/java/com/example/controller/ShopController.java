package com.example.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.domain.AttachVO;
import com.example.domain.Criteria;
import com.example.domain.PageMaker;
import com.example.domain.ShopVO;
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

	public String shopRead() {
		return "/shop/read";
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
	
	@RequestMapping("/pre_list.json")
	@ResponseBody
	public HashMap<String, Object> pre_list(String prod_rid, Criteria cri){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		cri.setPerPageNum(5);
		
		map.put("cri", cri);
		map.put("list", dao.pre_list(cri, prod_rid));
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.pre_totalCount(prod_rid));
		
		map.put("pm", pm);
		
		return map;
	}
	
	@RequestMapping("/pre_insert")
	public void pre_insert(Shop_previewVO pvo, Criteria cri){
		dao.pre_insert(pvo);
	}
}
