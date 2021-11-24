package com.example.domain;

import java.util.Date;

public class CampingReviewVO {
	private int camp_rno;
	private String camp_ruid;
	private int camp_rstar;
	private String camp_review;
	private String camp_id;
	private Date camp_reviewdate;
	public int getCamp_rno() {
		return camp_rno;
	}
	public void setCamp_rno(int camp_rno) {
		this.camp_rno = camp_rno;
	}
	public String getCamp_ruid() {
		return camp_ruid;
	}
	public void setCamp_ruid(String camp_ruid) {
		this.camp_ruid = camp_ruid;
	}
	public int getCamp_rstar() {
		return camp_rstar;
	}
	public void setCamp_rstar(int camp_rstar) {
		this.camp_rstar = camp_rstar;
	}
	public String getCamp_review() {
		return camp_review;
	}
	public void setCamp_review(String camp_review) {
		this.camp_review = camp_review;
	}
	public String getCamp_id() {
		return camp_id;
	}
	public void setCamp_id(String camp_id) {
		this.camp_id = camp_id;
	}
	public Date getCamp_reviewdate() {
		return camp_reviewdate;
	}
	public void setCamp_reviewdate(Date camp_reviewdate) {
		this.camp_reviewdate = camp_reviewdate;
	}
	@Override
	public String toString() {
		return "CampingReviewVO [camp_rno=" + camp_rno + ", camp_ruid=" + camp_ruid + ", camp_rstar=" + camp_rstar
				+ ", camp_review=" + camp_review + ", camp_id=" + camp_id + ", camp_reviewdate=" + camp_reviewdate
				+ "]";
	}

}
