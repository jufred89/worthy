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
}
