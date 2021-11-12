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
	public List<BoardVO> list(Criteria cri,String desc) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cri", cri);
		map.put("desc", desc);		
		return session.selectList(namespace+".list",map);
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
	
	@Override
	public int totalCount(Criteria cri) {
		return session.selectOne(namespace+".totalCount",cri);
	}
	
	//---------------------√∑∫Œ∆ƒ¿œ---------------------
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


	//----------------------¥Ò±€------------------------
	
	@Override
	public List<BoardReplyVO> replyList(int fb_bno,Criteria cri) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cri", cri);
		map.put("fb_bno", fb_bno);
		return session.selectList(namespace+".replyList",map);
	}

	@Override
	public void replyInsert(BoardReplyVO vo) {
		session.insert(namespace+".replyInsert",vo);
	}

	@Override
	public void replyDelete(int fb_rno) {
		session.delete(namespace+".replyDelete",fb_rno);
	}

	@Override
	public int replyCount(int fb_bno) {
		return session.selectOne(namespace+".replyCount",fb_bno);
	}

	
	//----------------------¡¡æ∆ø‰-----------------------


	@Override
	public int likeIt(String uid, int fb_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("uid", uid);
		map.put("fb_no", fb_no);
		return session.selectOne(namespace+".likeIt",map);
	}

	@Override
	public void likeTableInsert(String uid, int fb_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("uid", uid);
		map.put("fb_no", fb_no);
		session.selectOne(namespace+".likeTableInsert",map);
	}
	
	@Override
	public int likeCheck(String uid, int fb_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("uid", uid);
		map.put("fb_no", fb_no);
		return session.selectOne(namespace+".likeCheck",map);
	}

	@Override
	public void like(int likeCheck, String uid, int fb_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("likeCheck", likeCheck);
		map.put("uid", uid);
		map.put("fb_no", fb_no);
		session.update(namespace+".like",map);
	}

	@Override
	public void likeUpdate(int fb_no) {
		session.update(namespace+".likeUpdate",fb_no);
	}

}
