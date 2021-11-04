package com.example.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.CampingVO;

@Repository
public class CampingDAOImpl implements CampingDAO {
	@Autowired
	SqlSession session;
	
	String namespace="com.example.mapper.CampingMapper";

	@Override
	public List<CampingVO> campList() {
		return session.selectList(namespace+".campList");
	}

	@Override
	public CampingVO campRead(String camp_id) {
		return session.selectOne(namespace+".campRead",camp_id);
	}

	@Override
	public List<CampingVO> campStyleRead(String camp_id) {
		return session.selectList(namespace+".campStyleRead", camp_id);
	}

	@Override
	public List<CampingVO> campFacilityRead(String camp_id) {
		return session.selectList(namespace+".campFacilityRead", camp_id);
	}

}
