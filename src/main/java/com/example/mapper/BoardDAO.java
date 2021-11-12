package com.example.mapper;

import java.util.List;

import com.example.domain.BoardReplyVO;
import com.example.domain.BoardVO;
import com.example.domain.Criteria;

public interface BoardDAO {
	public List<BoardVO> list(Criteria cri,String desc);
	public void insert(BoardVO vo);
	public BoardVO read(int fb_no);
	public void update(BoardVO vo);
	public void delete(int fb_no);
	public int maxNo();
	public int totalCount(Criteria cri);
	
	
	//첨부파일
	public void insertAttach(String image, int fb_no);
	public List<String> attachList(int fb_no);
	public void deleteAttach(String image);
	public void deleteAttachAll(int fb_no);
	
	

	//조회수 증가
	public void updateView(int fb_no);
	
	//댓글
	public List<BoardReplyVO> replyList(int fb_bno,Criteria cri);
	public void replyInsert(BoardReplyVO vo);
	public void replyDelete(int fb_rno);
	public int replyCount(int fb_bno);
	
	//좋아요
	public int likeIt(String uid, int fb_no);
	public void likeTableInsert(String uid, int fb_no);
	public int likeCheck(String uid, int fb_no);
	public void like(int likeCheck, String uid, int fb_no);
	public void likeUpdate(int fb_no); 
}
