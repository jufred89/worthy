package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import com.example.domain.BoardReplyVO;
import com.example.domain.BoardVO;
import com.example.domain.Criteria;

public interface BoardDAO {
	public List<BoardVO> list();
	public void insert(BoardVO vo);
	public BoardVO read(int fb_no);
	public void update(BoardVO vo);
	public void delete(int fb_no);
	
	//첨부파일
	public void insertAttach(String image, int fb_no);
	public List<String> attachList(int fb_no);
	public void deleteAttach(String image);
	public void deleteAttachAll(int fb_no);
	
	//
	public int maxNo();
	//조회수 증가
	public void updateView(int fb_no);
	
	//댓글
	public List<BoardReplyVO> replyList(int fb_bno);
	public void replyInsert(BoardReplyVO vo);
}
