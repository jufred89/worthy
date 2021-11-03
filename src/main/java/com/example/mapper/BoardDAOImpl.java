package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO{
	@Autowired
	SqlSession session;
	
	String namespace="com.example.mapper.BoardMapper";

	@Override
	public List<BoardVO> list() {
		return session.selectList(namespace+".list");
	}

	@Override
	public void insert(BoardVO vo) {
		session.insert(namespace+".insert",vo);
	}

	@Override
	public BoardVO read(int fb_no) {
		return session.selectOne(namespace+".read",fb_no);
	}

	@Override
	public void update(BoardVO vo) {
		session.update(namespace+".update",vo);
	}

	@Override
	public void insertAttach(String image, int fb_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("image", image);
		map.put("fb_no", fb_no);
		session.insert(namespace+".attachInsert",map);
	}

	@Override
	public int maxNo() {
		return session.selectOne(namespace+".maxNo");
	}
	
}
