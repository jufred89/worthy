package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.TipVO;

public interface TipDAO {
	public List<HashMap<String, Object>> list(Criteria cri);
	public TipVO read(int tip_no);
	public void insert(TipVO vo);
	public void delete(int tip_no);
	public void update(TipVO vo);
	public int totalCount(Criteria cri);
	public int maxNo();
	
	public void updateView(int tip_no);
	
	//첨부파일
	public void att_insert(String image, int tip_no);
	public List<String> att_list(int tip_no);
	public void att_delete(String image);
	public void att_deleteAll(int tip_no);
	
	//좋아요
	public int likeIt(String uid, int tip_no);
	public void likeInsert(String uid, int tip_no);
	public int likeCheck(String uid, int tip_no);
	public void like(int likeCheck, String uid, int tip_no);
	public void likeUpdate(int tip_no);
	public void likeDel(int tip_no);
	public List<TipVO>  mainPage_tip_list();
}
