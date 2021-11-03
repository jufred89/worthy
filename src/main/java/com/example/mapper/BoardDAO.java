package com.example.mapper;

import java.util.List;

import com.example.domain.BoardVO;

public interface BoardDAO {
	public List<BoardVO> list();
	public void insert(BoardVO vo);
	public BoardVO read(int fb_no);
	public void update(BoardVO vo);
	public void insertAttach(String image, int fb_no);
	public int maxNo();
}
