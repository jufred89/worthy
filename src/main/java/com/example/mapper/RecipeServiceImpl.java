package com.example.mapper;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.domain.RecipeVO;


@Service
public class RecipeServiceImpl implements RecipeService{
	@Autowired
	RecipeDAO dao;

	@Override
	public void insert(RecipeVO vo) {
		dao.insert(vo);
		
		ArrayList<String> images = vo.getImages();
		for(String image:images){
			dao.att_insert(image, vo.getFi_no());
		}
	}

	@Override
	public void delete(int fi_no) {
		dao.likeDel(fi_no);
		dao.att_deleteAll(fi_no);
		dao.delete(fi_no);
	}
}
