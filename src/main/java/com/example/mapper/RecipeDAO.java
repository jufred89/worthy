package com.example.mapper;

import java.util.List;

import com.example.domain.RecipeVO;

public interface RecipeDAO {
	public List<RecipeVO> list();
	public RecipeVO read(int fi_no);
	public void insert(RecipeVO vo);
	public void delete(int fi_no);
	public void update(int fi_no);
}
