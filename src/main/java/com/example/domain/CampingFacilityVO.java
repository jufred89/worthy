package com.example.domain;

public class CampingFacilityVO {
	private String facility_no;
	private String facility_name;

	public String getFacility_no() {
		return facility_no;
	}

	public void setFacility_no(String facility_no) {
		this.facility_no = facility_no;
	}

	public String getFacility_name() {
		return facility_name;
	}

	public void setFacility_name(String facility_name) {
		this.facility_name = facility_name;
	}

	@Override
	public String toString() {
		return "CampingFacilityVO [facility_no=" + facility_no + ", facility_name=" + facility_name + "]";
	}

}
