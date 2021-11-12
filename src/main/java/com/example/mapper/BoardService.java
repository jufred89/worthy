package com.example.mapper;

import com.example.domain.BoardVO;

public interface BoardService {
	public void insert(BoardVO vo);
	public void delete(int fb_no);
	public BoardVO read(int fb_no);
	public void like(int likeCheck, String uid, int fb_no); 

}
