package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
import com.example.domain.RecipeVO;

@Repository
public class RecipeDAOImpl implements RecipeDAO {
	@Autowired
	SqlSession session;
	String namespace="com.example.mapper.RecipeMapper";
	
	@Override
	public List<HashMap<String, Object>> list(Criteria cri) {
		return session.selectList(namespace + ".list", cri);
	}

	@Override
	public RecipeVO read(int fi_no) {
		return session.selectOne(namespace + ".read", fi_no);
	}

	@Override
	public void insert(RecipeVO vo) {
		session.insert(namespace + ".insert", vo);
	}

	@Override
	public void delete(int fi_no) {
		session.delete(namespace + ".delete", fi_no);
	}

	@Override
	public void update(RecipeVO vo) {
		session.update(namespace + ".update", vo);
	}

	@Override
	public int totalCount(Criteria cri) {
		return session.selectOne(namespace + ".totalCount", cri);
	}

}
