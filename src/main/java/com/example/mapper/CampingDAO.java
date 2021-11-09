package com.example.mapper;

import java.util.List;

import com.example.domain.CampingFacilityVO;
import com.example.domain.CampingStyleVO;
import com.example.domain.CampingVO;

public interface CampingDAO {
	public List<CampingVO> campList();
	public CampingVO campRead(String camp_id);
	public List<CampingVO> campStyleRead(String camp_id);
	public List<CampingVO> campFacilityRead(String camp_id);
	public String maxCode();
	public List<CampingFacilityVO> campFacilityList();
	public List<CampingStyleVO> campStyleList();
	public void campInsert(CampingVO vo);
	public void campFacilityInsert(String camp_id,String facility_no);
}
