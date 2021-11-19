package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CampingAttachDAOImpl implements CampingAttachDAO {
	@Autowired
	SqlSession session;
	
	String namespace="com.example.mapper.CampingAttachMapper";
	
	@Override
	public void insert(String camp_image, String camp_id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("camp_image", camp_image);
		map.put("camp_id", camp_id);
		session.insert(namespace + ".campAttachInsert", map);
	}

	@Override
	public List<String> list(String camp_id) {
		return session.selectList(namespace+".campAttachList", camp_id);
	}

	@Override
	public void delete(String camp_image) {
		session.delete(namespace+".campAttachDelete",camp_image);
	}

}
