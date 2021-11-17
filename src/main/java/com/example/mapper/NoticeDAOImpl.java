package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
import com.example.domain.NoticeVO;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	@Autowired
	SqlSession session;
	String namespace="com.example.mapper.NoticeMapper";
	

	@Override
	public List<HashMap<String, Object>> list(Criteria cri) {
		return session.selectList(namespace + ".list", cri);
	}

	@Override
	public NoticeVO read(int nb_no) {
		return session.selectOne(namespace + ".read", nb_no);
	}

	@Override
	public void insert(NoticeVO vo) {
		session.insert(namespace + ".insert", vo);
	}

	@Override
	public void delete(int nb_no) {
		session.delete(namespace + ".delete", nb_no);		
	}

	@Override
	public void update(NoticeVO vo) {
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
	public int likeIt(String uid, int nb_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("uid",uid);
		map.put("nb_no", nb_no);
		return session.selectOne(namespace+".likeIt", map);
	}

	@Override
	public void likeInsert(String uid, int nb_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("uid",uid);
		map.put("nb_no", nb_no);
		session.selectOne(namespace + ".likeInsert", map);
	}

	@Override
	public int likeCheck(String uid, int nb_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("uid",uid);
		map.put("nb_no", nb_no);
		return session.selectOne(namespace + ".likeCheck", map);
	}

	@Override
	public void like(int likeCheck, String uid, int nb_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("likeCheck", likeCheck);
		map.put("uid",uid);
		map.put("nb_no", nb_no);
		session.update(namespace + ".like", map);
	}

	@Override
	public void likeUpdate(int nb_no) {
		session.update(namespace + ".likeUpdate", nb_no);
	}
	
	@Override
	public void likeDel(int nb_no) {
		session.delete(namespace + ".likeDel", nb_no);
	}
	
	//조회수
	@Override
	public void updateView(int nb_no) {
		session.update(namespace + ".updateView", nb_no);
	}
	
	//첨부파일
	@Override
	public void att_insert(String image, int nb_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("image", image);
		map.put("nb_no", nb_no);
		session.insert(namespace + ".att_insert", map);
	}
	
	@Override
	public List<String> att_list(int nb_no) {
		return session.selectList(namespace + ".att_list", nb_no);
	}

	@Override
	public void att_delete(String image) {
		session.delete(namespace+".att_delete",image);
	}

	@Override
	public void att_deleteAll(int nb_no) {
		session.delete(namespace+".att_deleteAll",nb_no);
	}

}
