package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import com.example.domain.CampingFacilityVO;
import com.example.domain.CampingReserVO;
import com.example.domain.CampingReviewVO;
import com.example.domain.CampingStyleVO;
import com.example.domain.CampingVO;
import com.example.domain.Criteria;
import com.example.domain.Shop_previewVO;

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
	// 캠핑장 업데이트 및 시설, 스타일 삭제
	public void campUpdate(CampingVO vo);
	public void campStyleDelete(String camp_id);
	public void campFacilityDelete(String camp_id);
	// 특정 유저가 예약한 내역 DAO
	public List<CampingReserVO> campReservationUserNext(String uid);
	public List<CampingReserVO> campReservationUserPrev(String uid);
	public List<CampingReserVO> campReservationUserCancel(String uid,String reser_status);
	// 캠핑장 리뷰 관련 DAO
	public List<HashMap<String, Object>> campReviewList(String camp_id);
	public void campReviewInsert(CampingReviewVO cvo);
	public int campReviewTotalCount(String camp_id);
	// 캠핑장 좋아요 버튼 관련 DAO
	public int campLikeIt(String uid, String camp_id);
	public void campLikeTableInsert(String uid,String camp_id);
	public int campLikeTableCheck(String uid, String camp_id);
	public void campLikeTableUpdate(int likeCheck,String uid, String camp_id);
	public List<HashMap<String, Object>> campLikeUserCheck(String uid);
}
