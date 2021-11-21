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
	@Override
	public int maxNo() {
		return session.selectOne(namespace + ".maxNo");
	}
	
	//좋아요
	@Override
	public int likeIt(String uid, int tip_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("uid",uid);
		map.put("tip_no", tip_no);
		return session.selectOne(namespace+".likeIt", map);
	}
	@Override
	public void likeInsert(String uid, int tip_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("uid",uid);
		map.put("tip_no", tip_no);
		session.selectOne(namespace + ".likeInsert", map);
	}
	@Override
	public int likeCheck(String uid, int tip_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("uid",uid);
		map.put("tip_no", tip_no);
		return session.selectOne(namespace + ".likeCheck", map);
	}
	@Override
	public void like(int likeCheck, String uid, int tip_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("likeCheck", likeCheck);
		map.put("uid",uid);
		map.put("tip_no", tip_no);
		session.update(namespace + ".like", map);
	}
	@Override
	public void likeUpdate(int tip_no) {
		session.update(namespace + ".likeUpdate", tip_no);
	}
	
	//조회수
	@Override
	public void updateView(int tip_no) {
		session.update(namespace + ".updateView", tip_no);
	}
	@Override
	public void likeDel(int tip_no) {
		session.delete(namespace + ".likeDel", tip_no);
	}

	@Override
	public void att_insert(String image, int tip_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("image", image);
		map.put("tip_no", tip_no);
		session.insert(namespace + ".att_insert", map);
	}

	@Override
	public List<String> att_list(int tip_no) {
		return session.selectList(namespace + ".att_list", tip_no);
	}

	@Override
	public void att_delete(String image) {
		session.delete(namespace+".att_delete",image);
	}

	@Override
	public void att_deleteAll(int tip_no) {
		session.delete(namespace+".att_deleteAll",tip_no);
	}
	
	@Override
	public List<TipVO> mainPage_tip_list() {
		return session.selectList(namespace+".mainPage_tip_list");
	}
}
