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
	@Override
	public int maxNo() {
		return session.selectOne(namespace + ".maxNo");
	}

	
	//좋아요
	@Override
	public int likeIt(String uid, int fi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("uid",uid);
		map.put("fi_no", fi_no);
		return session.selectOne(namespace+".likeIt", map);
	}

	@Override
	public void likeInsert(String uid, int fi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("uid",uid);
		map.put("fi_no", fi_no);
		session.selectOne(namespace + ".likeInsert", map);
	}

	@Override
	public int likeCheck(String uid, int fi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("uid",uid);
		map.put("fi_no", fi_no);
		return session.selectOne(namespace + ".likeCheck", map);
	}

	@Override
	public void like(int likeCheck, String uid, int fi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("likeCheck", likeCheck);
		map.put("uid",uid);
		map.put("fi_no", fi_no);
		session.update(namespace + ".like", map);
	}

	@Override
	public void likeUpdate(int fi_no) {
		session.update(namespace + ".likeUpdate", fi_no);
	}

	@Override
	public void likeDel(int fi_no) {
		session.delete(namespace + ".likeDel", fi_no);
	}
	
	//조회수
	@Override
	public void updateView(int fi_no) {
		session.update(namespace + ".updateView", fi_no);
	}
	

	//첨부파일
	@Override
	public void att_insert(String image, int fi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("image", image);
		map.put("fi_no", fi_no);
		session.insert(namespace + ".att_insert", map);
	}

	@Override
	public List<String> att_list(int fi_no) {
		return session.selectList(namespace + ".att_list", fi_no);
	}

	@Override
	public void att_delete(String image) {
		session.delete(namespace+".att_delete",image);		
	}

	@Override
	public void att_deleteAll(int fi_no) {
		session.delete(namespace+".att_deleteAll",fi_no);
	}
}
