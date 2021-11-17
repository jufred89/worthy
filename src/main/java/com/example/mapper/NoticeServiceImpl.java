package com.example.mapper;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.domain.NoticeVO;


@Service
public class NoticeServiceImpl implements NoticeService{
	@Autowired
	NoticeDAO dao;

	@Override
	public void insert(NoticeVO vo) {
		dao.insert(vo);
		
		ArrayList<String> images = vo.getImages();
		for(String image:images){
			dao.att_insert(image, vo.getNb_no());
		}
	}

	@Override
	public void delete(int nb_no) {
		dao.likeDel(nb_no);
		dao.att_deleteAll(nb_no);
		dao.delete(nb_no);
	}
}
