package com.example.mapper;

import java.util.List;

import com.example.domain.TipVO;

public interface TipDAO {
	public List<TipVO> list();
	public TipVO read(int fi_no);
	public void insert(TipVO vo);
	public void delete(int fi_no);
}
