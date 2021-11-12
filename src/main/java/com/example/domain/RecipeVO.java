package com.example.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class RecipeVO {
	private int fi_no;
	private String fi_title;
	private String fi_content;
	private String fi_writer;
	private String fi_image;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="Asia/Seoul")
	private Date fi_regdate;
	private int fi_like;
	private int fi_viewcnt;
	
	
	@Override
	public String toString() {
		return "RecipeVO [fi_no=" + fi_no + ", fi_title=" + fi_title + ", fi_content=" + fi_content + ", fi_writer="
				+ fi_writer + ", fi_image=" + fi_image + ", fi_regdate=" + fi_regdate + ", fi_like=" + fi_like
				+ ", fi_viewcnt=" + fi_viewcnt + "]";
	}
	public int getFi_like() {
		return fi_like;
	}
	public void setFi_like(int fi_like) {
		this.fi_like = fi_like;
	}
	public int getFi_viewcnt() {
		return fi_viewcnt;
	}
	public void setFi_viewcnt(int fi_viewcnt) {
		this.fi_viewcnt = fi_viewcnt;
	}
	public int getFi_no() {
		return fi_no;
	}
	public void setFi_no(int fi_no) {
		this.fi_no = fi_no;
	}
	public String getFi_title() {
		return fi_title;
	}
	public void setFi_title(String fi_title) {
		this.fi_title = fi_title;
	}
	public String getFi_content() {
		return fi_content;
	}
	public void setFi_content(String fi_content) {
		this.fi_content = fi_content;
	}
	public String getFi_writer() {
		return fi_writer;
	}
	public void setFi_writer(String fi_writer) {
		this.fi_writer = fi_writer;
	}
	public String getFi_image() {
		return fi_image;
	}
	public void setFi_image(String fi_image) {
		this.fi_image = fi_image;
	}
	public Date getFi_regdate() {
		return fi_regdate;
	}
	public void setFi_regdate(Date fi_regdate) {
		this.fi_regdate = fi_regdate;
	}	
}
