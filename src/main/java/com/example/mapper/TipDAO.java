package com.example.mapper;

import java.util.List;

import com.example.domain.TipVO;

public interface TipDAO {
	public List<TipVO> list();
	public TipVO read(int tip_no);
	public void delete(int tip_no);
	public void insert(TipVO vo);
}
