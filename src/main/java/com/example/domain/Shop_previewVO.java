package com.example.domain;

public class Shop_previewVO {
	private int prod_rno;
	private String prod_ruid;
	private String prod_rstar;
	private String prod_review;
	private String prod_rid;
	private String prod_r_regdate;
	
	@Override
	public String toString() {
		return "Shop_previewVO [prod_rno=" + prod_rno + ", prod_ruid=" + prod_ruid + ", prod_rstar=" + prod_rstar
				+ ", prod_review=" + prod_review + ", prod_rid=" + prod_rid + ", prod_r_regdate=" + prod_r_regdate
				+ "]";
	}
	public int getProd_rno() {
		return prod_rno;
	}
	public void setProd_rno(int prod_rno) {
		this.prod_rno = prod_rno;
	}
	public String getProd_ruid() {
		return prod_ruid;
	}
	public void setProd_ruid(String prod_ruid) {
		this.prod_ruid = prod_ruid;
	}
	public String getProd_rstar() {
		return prod_rstar;
	}
	public void setProd_rstar(String prod_rstar) {
		this.prod_rstar = prod_rstar;
	}
	public String getProd_review() {
		return prod_review;
	}
	public void setProd_review(String prod_review) {
		this.prod_review = prod_review;
	}
	public String getProd_rid() {
		return prod_rid;
	}
	public void setProd_rid(String prod_rid) {
		this.prod_rid = prod_rid;
	}
	public String getProd_r_regdate() {
		return prod_r_regdate;
	}
	public void setProd_r_regdate(String prod_r_regdate) {
		this.prod_r_regdate = prod_r_regdate;
	}
}
