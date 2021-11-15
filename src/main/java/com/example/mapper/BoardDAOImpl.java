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
	public List<BoardVO> board_list(Criteria cri,String desc) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cri", cri);
		map.put("desc", desc);		
		return session.selectList(namespace+".board_list",map);
	}

	@Override
	public void board_insert(BoardVO vo) {
		session.insert(namespace+".board_insert",vo);
	}

	@Override
	public BoardVO board_read(int fb_no) {
		return session.selectOne(namespace+".board_read",fb_no);
	}

	@Override
	public void board_update(BoardVO vo) {
		session.update(namespace+".board_update",vo);
	}
	
	@Override
	public void board_delete(int fb_no) {
		session.delete(namespace+".board_delete",fb_no);
	}
	

	@Override
	public int board_maxNo() {
		return session.selectOne(namespace+".board_maxNo");
	}
	
	@Override
	public int board_totalCount(Criteria cri) {
		return session.selectOne(namespace+".board_totalCount",cri);
	}
	
	//---------------------√∑∫Œ∆ƒ¿œ---------------------
	@Override
	public void board_insertAttach(String image, int fb_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("image", image);
		map.put("fb_no", fb_no);
		session.insert(namespace+".board_attachInsert",map);
	}


	@Override
	public List<String> board_attachList(int fb_no) {
		return session.selectList(namespace+".board_attachList",fb_no);
	}

	@Override
	public void board_deleteAttach(String image) {
		session.delete(namespace+".board_attachDelete",image);
	}

	@Override
	public void board_deleteAttachAll(int fb_no) {
		session.delete(namespace+".board_attachDeleteAll",fb_no);
	}

	@Override
	public void board_updateView(int fb_no) {
		session.update(namespace+".board_updateView",fb_no);
	}


	//----------------------¥Ò±€------------------------
	
	@Override
	public List<BoardReplyVO> board_replyList(int fb_bno,Criteria cri) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cri", cri);
		map.put("fb_bno", fb_bno);
		return session.selectList(namespace+".board_replyList",map);
	}

	@Override
	public void board_replyInsert(BoardReplyVO vo) {
		session.insert(namespace+".board_replyInsert",vo);
	}

	@Override
	public void board_replyDelete(int fb_rno) {
		session.delete(namespace+".board_replyDelete",fb_rno);
	}

	@Override
	public int board_replyCount(int fb_bno) {
		return session.selectOne(namespace+".board_replyCount",fb_bno);
	}

	
	//----------------------¡¡æ∆ø‰-----------------------


	@Override
	public int board_likeIt(String uid, int fb_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("uid", uid);
		map.put("fb_no", fb_no);
		return session.selectOne(namespace+".board_likeIt",map);
	}

	@Override
	public void board_likeTableInsert(String uid, int fb_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("uid", uid);
		map.put("fb_no", fb_no);
		session.selectOne(namespace+".board_likeTableInsert",map);
	}
	
	@Override
	public int board_likeCheck(String uid, int fb_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("uid", uid);
		map.put("fb_no", fb_no);
		return session.selectOne(namespace+".board_likeCheck",map);
	}

	@Override
	public void board_like(int likeCheck, String uid, int fb_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("likeCheck", likeCheck);
		map.put("uid", uid);
		map.put("fb_no", fb_no);
		session.update(namespace+".board_like",map);
	}

	@Override
	public void board_likeUpdate(int fb_no) {
		session.update(namespace+".board_likeUpdate",fb_no);
	}

}
