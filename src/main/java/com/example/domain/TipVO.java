package com.example.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class TipVO {
	private int tip_no;
	private String tip_title;
	private String tip_content;
	private String tip_writer;
	private String tip_image;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="Asia/Seoul")
	private Date tip_regdate;
	public int getTip_no() {
		return tip_no;
	}
	public void setTip_no(int tip_no) {
		this.tip_no = tip_no;
	}
	public String getTip_title() {
		return tip_title;
	}
	public void setTip_title(String tip_title) {
		this.tip_title = tip_title;
	}
	public String getTip_content() {
		return tip_content;
	}
	public void setTip_content(String tip_content) {
		this.tip_content = tip_content;
	}
	public String getTip_writer() {
		return tip_writer;
	}
	public void setTip_writer(String tip_writer) {
		this.tip_writer = tip_writer;
	}
	public String getTip_image() {
		return tip_image;
	}
	public void setTip_image(String tip_image) {
		this.tip_image = tip_image;
	}
	public Date getTip_regdate() {
		return tip_regdate;
	}
	public void setTip_regdate(Date tip_regdate) {
		this.tip_regdate = tip_regdate;
	}
	@Override
	public String toString() {
		return "TipVO [tip_no=" + tip_no + ", tip_title=" + tip_title + ", tip_content=" + tip_content + ", tip_writer="
				+ tip_writer + ", tip_image=" + tip_image + ", tip_regdate=" + tip_regdate + "]";
	}
	
}
