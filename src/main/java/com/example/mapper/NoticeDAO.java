package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.NoticeVO;

public interface NoticeDAO {
	public List<HashMap<String, Object>> list(Criteria cri);
	public NoticeVO read(int nb_no);
	public void insert(NoticeVO vo);
	public void delete(int nb_no);
	public void update(NoticeVO vo);
	public int totalCount(Criteria cri);
}

