package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.CampingFacilityVO;
import com.example.domain.CampingStyleVO;
import com.example.domain.CampingVO;
import com.example.domain.Criteria;

@Repository
public class CampingDAOImpl implements CampingDAO {
	@Autowired
	SqlSession session;
	
	String namespace="com.example.mapper.CampingMapper";

	@Override
	public List<CampingVO> campList(Criteria cri) {
		return session.selectList(namespace+".campList",cri);
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

	@Override
	public String maxCode() {
		return session.selectOne(namespace+".maxCode");
	}

	@Override
	public List<CampingFacilityVO> campFacilityList() {
		return session.selectList(namespace+".campFacilityList");
	}

	@Override
	public List<CampingStyleVO> campStyleList() {
		return session.selectList(namespace+".campStyleList");
	}

	@Override
	public void campInsert(CampingVO vo) {
		session.insert(namespace+".campInsert", vo);
	}

	@Override
	public void campFacilityInsert(String camp_id, String fno) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("camp_id", camp_id);
		map.put("facility_no", fno);
		session.insert(namespace+".campFacilityInsert", map);
	}

	@Override
	public void campStyleInsert(String camp_id, String sno, int sqty) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("camp_id", camp_id);
		map.put("style_no", sno);
		map.put("style_qty", sqty);
		session.insert(namespace+".campStyleInsert", map);
	}

	@Override
	public int campTotcount(Criteria cri) {
		return session.selectOne(namespace+".campTotcount",cri);
	}

}
