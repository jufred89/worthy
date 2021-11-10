package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.TipVO;

public interface TipDAO {
	public List<HashMap<String, Object>> list(Criteria cri);
	public TipVO read(int tip_no);
	public void delete(int tip_no);
	public void insert(TipVO vo);
	public void update(TipVO vo);
	public int totalCount(Criteria cri);
}
