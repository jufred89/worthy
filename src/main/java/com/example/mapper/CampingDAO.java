package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import com.example.domain.CampingFacilityVO;
import com.example.domain.CampingReserVO;
import com.example.domain.CampingStyleVO;
import com.example.domain.CampingVO;
import com.example.domain.Criteria;

public interface CampingDAO {
	public List<CampingVO> campList(Criteria cri);
	public CampingVO campRead(String camp_id);
	public List<CampingVO> campStyleRead(String camp_id);
	public List<CampingVO> campFacilityRead(String camp_id);
	public String maxCode();
	public List<CampingFacilityVO> campFacilityList();
	public List<CampingStyleVO> campStyleList();
	public void campInsert(CampingVO vo);
	public void campFacilityInsert(String camp_id,String facility_no);
	public void campStyleInsert(String camp_id, String style_no, int style_qty, int style_price);
	public int campTotcount(Criteria cri);
	public List<HashMap<String, Object>> campSearchList(String camp_addr,String reser_checkin,String reser_checkout,String style_no, List<String> facility_no, int listSize);
	public List<HashMap<String, Object>> campAvailableReser(String camp_id,String reser_checkin,String reser_checkout);
	public List<HashMap<String,Object>> campSlide();
	public void campReservationCheckoutInsert(CampingReserVO crvo);
	public void campUpdate(CampingVO vo);
	public void campStyleDelete(String camp_id);
	public void campFacilityDelete(String camp_id);
	public List<CampingReserVO> campReservationUser(String uid);
}
