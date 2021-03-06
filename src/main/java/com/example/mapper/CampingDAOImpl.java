package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.CampingFacilityVO;
import com.example.domain.CampingReserVO;
import com.example.domain.CampingReviewVO;
import com.example.domain.CampingStyleVO;
import com.example.domain.CampingVO;
import com.example.domain.Criteria;

@Repository
public class CampingDAOImpl implements CampingDAO {
	@Autowired
	SqlSession session;
	
	String namespace="com.example.mapper.CampingMapper";

	@Override
	public List<CampingVO> campList(Criteria cri) {
		return session.selectList(namespace+".campList",cri);
	}

	@Override
	public CampingVO campRead(String camp_id) {
		return session.selectOne(namespace+".campRead",camp_id);
	}

	@Override
	public List<CampingVO> campStyleRead(String camp_id) {
		return session.selectList(namespace+".campStyleRead", camp_id);
	}

	@Override
	public List<CampingVO> campFacilityRead(String camp_id) {
		return session.selectList(namespace+".campFacilityRead", camp_id);
	}

	@Override
	public String maxCode() {
		return session.selectOne(namespace+".maxCode");
	}

	@Override
	public List<CampingFacilityVO> campFacilityList() {
		return session.selectList(namespace+".campFacilityList");
	}

	@Override
	public List<CampingStyleVO> campStyleList() {
		return session.selectList(namespace+".campStyleList");
	}

	@Override
	public void campInsert(CampingVO vo) {
		session.insert(namespace+".campInsert", vo);
	}

	@Override
	public void campFacilityInsert(String camp_id, String fno) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("camp_id", camp_id);
		map.put("facility_no", fno);
		session.insert(namespace+".campFacilityInsert", map);
	}

	@Override
	public void campStyleInsert(String camp_id, String sno, int sqty, int sprice) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("camp_id", camp_id);
		map.put("style_no", sno);
		map.put("style_qty", sqty);
		map.put("style_price", sprice);
		session.insert(namespace+".campStyleInsert", map);
	}

	@Override
	public int campTotcount(Criteria cri) {
		return session.selectOne(namespace+".campTotcount",cri);
	}

	@Override
	public List<HashMap<String, Object>> campSearchList(String camp_addr,String reser_checkin,String reser_checkout,String style_no, List<String> facility_no, int listSize) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("camp_addr", camp_addr);
		map.put("reser_checkin", reser_checkin);
		map.put("reser_checkout", reser_checkout);
		map.put("style_no", style_no);
		map.put("facility_no", facility_no);
		map.put("listSize", listSize);
		System.out.println("/////////////////////////////"+facility_no);
		return session.selectList(namespace+".campSearchList",map);
	}

	@Override
	public List<HashMap<String, Object>> campAvailableReser(String camp_id, String reser_checkin,
			String reser_checkout) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("camp_id", camp_id);
		map.put("reser_checkin", reser_checkin);
		map.put("reser_checkout", reser_checkout);
		return session.selectList(namespace+".campAvailableReser", map);
	}

	@Override
	public void campUpdate(CampingVO vo) {
		session.update(namespace+".campUpdate", vo);
	}

	@Override
	public void campStyleDelete(String camp_id) {
		session.delete(namespace+".campStyleDelete", camp_id);
	}

	@Override
	public void campFacilityDelete(String camp_id) {
		session.delete(namespace+".campFacilityDelete", camp_id);
	}

	@Override
	public void campReservationCheckoutInsert(CampingReserVO crvo) {
		session.insert(namespace+".campReservationCheckoutInsert", crvo);
	}

	@Override
	public List<CampingReserVO> campReservationUserNext(String uid) {
		return session.selectList(namespace+".campReservationUserNext", uid);
	}

	@Override
	public List<HashMap<String, Object>> campSlide() {
		return session.selectList(namespace+".campSlide");
	}

	@Override
	public List<HashMap<String, Object>> campReviewList(String camp_id) {
		return session.selectList(namespace+".campReviewList", camp_id);
	}

	@Override
	public void campReviewInsert(CampingReviewVO cvo) {
		session.insert(namespace+".campReviewInsert", cvo);
	}

	@Override
	public int campReviewTotalCount(String camp_id) {
		return session.selectOne(namespace+".campReviewTotalCount", camp_id);
	}

	@Override
	public void campLikeTableInsert(String uid, String camp_id) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("camp_id", camp_id);
		map.put("uid", uid);
		session.insert(namespace+".campLikeTableInsert",map);
	}

	@Override
	public int campLikeTableCheck(String uid, String camp_id) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("camp_id", camp_id);
		map.put("uid", uid);
		return session.selectOne(namespace+".campLikeTableCheck", map);
	}

	@Override
	public void campLikeTableUpdate(int likeCheck, String uid, String camp_id) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("likeCheck", likeCheck);
		map.put("camp_id", camp_id);
		map.put("uid", uid);
		session.update(namespace+".campLikeTableUpdate", map);
	}

	@Override
	public int campLikeIt(String uid, String camp_id) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("camp_id", camp_id);
		map.put("uid", uid);
		return session.selectOne(namespace+".campLikeIt", map);
	}

	@Override
	public List<CampingReserVO> campReservationUserPrev(String uid) {
		return session.selectList(namespace+".campReservationUserPrev", uid);
	}

	@Override
	public List<CampingReserVO> campReservationUserCancel(String uid, String reser_status) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("uid", uid);
		map.put("reser_status", reser_status);
		return session.selectList(namespace+".campReservationUserCancel", map);
	}

	@Override
	public List<HashMap<String, Object>> campLikeUserCheck(String uid) {
		return session.selectList(namespace+".campLikeUserCheck", uid);
	}

	@Override
	public HashMap<String, Object> campCancelData(int reser_no) {
		return session.selectOne(namespace+".campCancelData", reser_no);
	}

	@Override
	public void campCancelRequest(int reser_no) {
		session.update(namespace+".campCancelRequest",reser_no);
	}

	@Override
	public List<HashMap<String, Object>> campReservListforAdmin(Criteria cri) {
		return session.selectList(namespace+".campReservListforAdmin", cri);
	}

	@Override
	public int campResevTotcount(Criteria cri) {
		return session.selectOne(namespace+".campResevTotcount",cri);
	}

	@Override
	public HashMap<String, Object> campReservReadforAdmin(int reser_no) {
		return session.selectOne(namespace+".campReservReadforAdmin", reser_no);
	}
}
