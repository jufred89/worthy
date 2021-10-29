package com.example.mapper;

import java.util.List;

import com.example.domain.NoticeVO;

public interface NoticeDAO {
	public List<NoticeVO> list();
	public NoticeVO read(int nb_no);
	public void insert(NoticeVO vo);
	public void delete(int nb_no);
}

