package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.BoardReplyVO;
import com.example.domain.BoardVO;
import com.example.domain.Criteria;

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
	public void delete(int fb_no) {
		session.delete(namespace+".delete",fb_no);
	}
	

	@Override
	public int maxNo() {
		return session.selectOne(namespace+".maxNo");
	}
	
	//---------------------Ã·ºÎÆÄÀÏ---------------------
	@Override
	public void insertAttach(String image, int fb_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("image", image);
		map.put("fb_no", fb_no);
		session.insert(namespace+".attachInsert",map);
	}


	@Override
	public List<String> attachList(int fb_no) {
		return session.selectList(namespace+".attachList",fb_no);
	}

	@Override
	public void deleteAttach(String image) {
		session.delete(namespace+".attachDelete",image);
	}

	@Override
	public void deleteAttachAll(int fb_no) {
		session.delete(namespace+".attachDeleteAll",fb_no);
	}

	@Override
	public void updateView(int fb_no) {
		session.update(namespace+".updateView",fb_no);
	}


	//----------------------´ñ±Û------------------------
	
	@Override
	public List<BoardReplyVO> replyList(int fb_bno) {
		return session.selectList(namespace+".replyList",fb_bno);
	}

	@Override
	public void replyInsert(BoardReplyVO vo) {
		session.insert(namespace+".replyInsert",vo);
	}
	
}
