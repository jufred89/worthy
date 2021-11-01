package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
import com.example.domain.ShopVO;

@Repository
public class ShopDAOImpl implements ShopDAO{

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

	@Override
	public void prod_insert(ShopVO vo) {
		session.insert(namespace + ".prod_insert", vo);
	}

	@Override
	public void prod_update(ShopVO vo) {
		session.update(namespace + ".prod_update", vo);
	}

	@Override
	public String prod_maxID() {
		return session.selectOne(namespace + ".prod_maxID");
	}

}
