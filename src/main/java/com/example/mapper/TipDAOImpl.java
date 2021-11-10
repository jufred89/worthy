package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
import com.example.domain.TipVO;

@Repository
public class TipDAOImpl implements TipDAO {
	@Autowired
	SqlSession session;
	String namespace="com.example.mapper.TipMapper";
	
	@Override
	public List<HashMap<String, Object>> list(Criteria cri) {
		return session.selectList(namespace + ".list", cri);
	}

	@Override
	public TipVO read(int tip_no) {
		return session.selectOne(namespace + ".read", tip_no);
	}

	@Override
	public void delete(int tip_no) {
		session.delete(namespace + ".delete", tip_no);
	}

	@Override
	public void insert(TipVO vo) {
		session.insert(namespace + ".insert", vo);
	}

	@Override
	public void update(TipVO vo) {
		session.update(namespace + ".update", vo);
	}

	@Override
	public int totalCount(Criteria cri) {
		return session.selectOne(namespace + ".totalCount", cri);
	}
}
