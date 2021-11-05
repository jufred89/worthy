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
	public void insert(BoardVO vo) {
		dao.insert(vo);
		
		ArrayList<String> images = vo.getImages();
		for(String image:images){
			dao.insertAttach(image, vo.getFb_no());
		}
	}

	@Transactional
	@Override
	public void delete(int fb_no) {
		dao.deleteAttachAll(fb_no);
		dao.delete(fb_no);
	} 

	@Transactional
	@Override
	public BoardVO read(int fb_no) {
		dao.updateView(fb_no);
		return dao.read(fb_no);
	}
}
