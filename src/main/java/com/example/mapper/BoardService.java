package com.example.mapper;

import com.example.domain.BoardVO;

public interface BoardService {
	public void board_insert(BoardVO vo);
	public void board_delete(int fb_no);
	public BoardVO board_read(int fb_no);
	public void board_like(int likeCheck, String uid, int fb_no); 

}
