package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.ShopVO;

public interface ShopDAO {
	public List<HashMap<String, Object>> prod_list(Criteria cri);
	public ShopVO prod_read(String prod_id);
	public int totalCount();
}
