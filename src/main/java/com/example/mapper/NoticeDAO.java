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
	public int maxNo();
	
	public void updateView(int nb_no);
	
	//첨부파일
	public void att_insert(String image, int nb_no);
	public List<String> att_list(int nb_no);
	public void att_delete(String image);
	public void att_deleteAll(int nb_no);

	
	//좋아요
	public int likeIt(String uid, int nb_no);
	public void likeInsert(String uid, int nb_no);
	public int likeCheck(String uid, int nb_no);
	public void like(int likeCheck, String uid, int nb_no);
	public void likeUpdate(int nb_no);
	public void likeDel(int nb_no);
	public List<HashMap<String, Object>> mainPage_notice_list();
}

