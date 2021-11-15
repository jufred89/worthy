package com.example.mapper;

import java.util.List;

import com.example.domain.BoardReplyVO;
import com.example.domain.BoardVO;
import com.example.domain.Criteria;

public interface BoardDAO {
	public List<BoardVO> board_list(Criteria cri,String desc);
	public void board_insert(BoardVO vo);
	public BoardVO board_read(int fb_no);
	public void board_update(BoardVO vo);
	public void board_delete(int fb_no);
	public int board_maxNo();
	public int board_totalCount(Criteria cri);
	
	
	//첨부파일
	public void board_insertAttach(String image, int fb_no);
	public List<String> board_attachList(int fb_no);
	public void board_deleteAttach(String image);
	public void board_deleteAttachAll(int fb_no);
	
	

	//조회수 증가
	public void board_updateView(int fb_no);
	
	//댓글
	public List<BoardReplyVO> board_replyList(int fb_bno,Criteria cri);
	public void board_replyInsert(BoardReplyVO vo);
	public void board_replyDelete(int fb_rno);
	public int board_replyCount(int fb_bno);
	
	//좋아요
	public int board_likeIt(String uid, int fb_no);
	public void board_likeTableInsert(String uid, int fb_no);
	public int board_likeCheck(String uid, int fb_no);
	public void board_like(int likeCheck, String uid, int fb_no);
	public void board_likeUpdate(int fb_no); 
}
