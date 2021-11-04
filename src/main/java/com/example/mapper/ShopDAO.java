package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import com.example.domain.AttachVO;
import com.example.domain.Criteria;
import com.example.domain.ShopVO;

public interface ShopDAO {
	public List<HashMap<String, Object>> prod_list(Criteria cri);
	public ShopVO prod_read(String prod_id);
	public int totalCount(Criteria cri);
	public void prod_insert(ShopVO vo);
	public void prod_update(ShopVO vo);
	public String prod_maxID();
	public void prod_delete(String prod_id);
	
	public String attach(String shop_pid);
	public void att_insert(AttachVO vo);
}
