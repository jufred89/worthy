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
	
	public void updateView(int fi_no);
	
	//醫뗭븘�슂
	public int likeIt(String uid, int fi_no);
	public void likeInsert(String uid, int fi_no);
	public int likeCheck(String uid, int fi_no);
	public void like(int likeCheck, String uid, int fi_no);
	public void likeUpdate(int fi_no);
	public void likeDel(int fi_no);
	public List<HashMap<String, Object>> mainPage_food_list();
}
