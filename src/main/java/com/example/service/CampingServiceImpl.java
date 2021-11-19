package com.example.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.CampingVO;
import com.example.mapper.CampingAttachDAO;
import com.example.mapper.CampingDAO;

@Service
public class CampingServiceImpl implements CampingService {
	@Autowired
	CampingDAO cdao;
	
	@Autowired
	CampingAttachDAO cadao;
	
	@Transactional
	@Override
	public void insert(CampingVO vo) {
		cdao.campInsert(vo);
		ArrayList<String> images=vo.getImages();
		for(String image:images){
			cadao.insert(image, vo.getCamp_id());
		}
	}

}
