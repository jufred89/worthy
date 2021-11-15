package com.example.mapper;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.BoardVO;

@Service
public class BoardServiceImpl implements BoardService{
	@Autowired
	BoardDAO dao;
	
	@Transactional
	@Override
	public void board_insert(BoardVO vo) {
		dao.board_insert(vo);
		
		ArrayList<String> images = vo.getImages();
		for(String image:images){
			dao.board_insertAttach(image, vo.getFb_no());
		}
	}

	@Transactional
	@Override
	public void board_delete(int fb_no) {
		dao.board_deleteAttachAll(fb_no);
		dao.board_delete(fb_no);
	} 

	@Transactional
	@Override
	public BoardVO board_read(int fb_no) {
		dao.board_updateView(fb_no);
		return dao.board_read(fb_no);
	}
	

	@Transactional
	@Override
	public void board_like(int likeCheck, String uid, int fb_no) {
		dao.board_like(likeCheck, uid, fb_no);
		dao.board_likeUpdate(fb_no);
	}
}
