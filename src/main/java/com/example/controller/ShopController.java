package com.example.controller;

import java.io.FileInputStream;
import java.util.HashMap;
import javax.annotation.Resource;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.Criteria;
import com.example.domain.PageMaker;
import com.example.domain.ShopVO;
import com.example.mapper.ShopDAO;

@Controller
@RequestMapping("/shop")
public class ShopController {

	@Autowired
	ShopDAO dao;


	@Resource(name = "uploadPath")
	private String path;

	// �̹������� ���
	@ResponseBody
	@RequestMapping("/display")
	public byte[] display(String file) throws Exception {
		FileInputStream in = new FileInputStream(path + "/" + file);
		// System.out.println(file);
		byte[] prod_image = IOUtils.toByteArray(in);
		in.close();
		return prod_image;
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
		return "/shop/insert";
	}

	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String shopRead(Model model, String prod_id) {
		ShopVO vo = new ShopVO();
		model.addAttribute("vo", dao.prod_read(prod_id));
		return "/shop/read";
	}

	@RequestMapping("/list.json")
	@ResponseBody
	public HashMap<String, Object> listJSON(Criteria cri) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", dao.prod_list(cri));
		map.put("cri", cri);

		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(dao.totalCount());

		map.put("pm", pm);
		return map;
	}

	public String shopRead() {
		return "/shop/read";
	}

	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public void insert(ShopVO vo) {

	}
}
