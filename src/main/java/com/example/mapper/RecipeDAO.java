package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.RecipeVO;

public interface RecipeDAO {
	public List<HashMap<String, Object>> list(Criteria cri);
	public RecipeVO read(int fi_no);
	public void insert(RecipeVO vo);
	public void delete(int fi_no);
	public void update(RecipeVO vo);
	public int totalCount(Criteria cri);
}
