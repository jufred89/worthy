package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.AttachVO;
import com.example.domain.Criteria;
import com.example.domain.ShopVO;
import com.example.domain.Shop_cartVO;
import com.example.domain.Shop_previewVO;

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
	public int totalCount(Criteria cri) {
		return session.selectOne(namespace + ".totalCount", cri);
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

	@Override
	public void prod_delete(String prod_id) {
		session.delete(namespace + ".prod_delete", prod_id);
	}

	@Override
	public AttachVO attach(String shop_pid) {
		return session.selectOne(namespace + ".attach", shop_pid);
	}

	@Override
	public void att_insert(AttachVO avo) {
		session.insert(namespace + ".att_insert", avo);
	}

	@Override
	public void att_update(AttachVO avo) {
		session.update(namespace + ".att_update", avo);
	}

	@Override
	public List<HashMap<String, Object>> pre_list(Criteria cri, String prod_rid) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("prod_rid", prod_rid);
		map.put("cri", cri);
		return session.selectList(namespace + ".pre_list", map);
	}

	@Override
	public void pre_insert(Shop_previewVO pvo) {
		session.insert(namespace + ".pre_insert", pvo);
	}

	@Override
	public int pre_totalCount(String prod_rid) {
		return session.selectOne(namespace + ".pre_totalCount", prod_rid);
	}

	@Override
	public void pre_delete(int prod_rno) {
		session.delete(namespace + ".pre_delete", prod_rno);
	}

	@Override
	public void cart_insert(Shop_cartVO cvo) {
		session.insert(namespace + ".cart_insert", cvo);
	}

}
