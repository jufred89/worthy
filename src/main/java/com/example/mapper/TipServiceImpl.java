package com.example.mapper;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.domain.TipVO;


@Service
public class TipServiceImpl implements TipService{
	@Autowired
	TipDAO dao;

	@Override
	public void insert(TipVO vo) {
		dao.insert(vo);
		
		ArrayList<String> images = vo.getImages();
		for(String image:images){
			dao.att_insert(image, vo.getTip_no());
		}
	}

	@Override
	public void delete(int tip_no) {
		dao.likeDel(tip_no);
		dao.att_deleteAll(tip_no);
		dao.delete(tip_no);
	}
	@Override
	public void update(TipVO vo) {
		dao.update(vo);
		ArrayList<String> images = vo.getImages();
		System.out.println(images);
		for(String image:images){
			dao.att_insert(image, vo.getTip_no());
		}
	}
}
