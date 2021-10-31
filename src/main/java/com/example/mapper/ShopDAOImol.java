package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
import com.example.domain.ShopVO;

@Repository
public class ShopDAOImol implements ShopDAO{

	@Autowired
	SqlSession session;
	
	String namespace="com.example.mapper.ShopMapper";
	
	@Override
	public List<HashMap<String, Object>> prod_list(Criteria cri) {
		return session.selectList(namespace + ".prod_list", cri);
	}

	@Override
	public ShopVO prod_read(String prod_id) {
		return session.selectOne(namespace + ".prod_read", prod_id);
	}

	@Override
	public int totalCount() {
		return session.selectOne(namespace + ".totalCount");
	}
}
