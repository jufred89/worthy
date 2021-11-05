package com.example.mapper;

import java.util.List;

import com.example.domain.CampingVO;

public interface CampingDAO {
	public List<CampingVO> campList();
	public CampingVO campRead(String camp_id);
	public List<CampingVO> campStyleRead(String camp_id);
	public List<CampingVO> campFacilityRead(String camp_id);
}
