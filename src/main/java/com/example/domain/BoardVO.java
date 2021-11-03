package com.example.domain;

import java.util.ArrayList;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class BoardVO {
	private int fb_no;
	private String fb_title;
	private String fb_content;
	private String fb_writer;
	private String fb_image;
	private ArrayList<String> images;


	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="Asia/Seoul")
	private Date fb_regdate;	
	private String fb_category;
	private int fb_like;
	private int fb_viewcnt;
	
	
	
	public ArrayList<String> getImages() {
		return images;
	}
	public void setImages(ArrayList<String> images) {
		this.images = images;
	}
	public int getFb_no() {
		return fb_no;
	}
	public void setFb_no(int fb_no) {
		this.fb_no = fb_no;
	}
	public String getFb_title() {
		return fb_title;
	}
	public void setFb_title(String fb_title) {
		this.fb_title = fb_title;
	}
	public String getFb_content() {
		return fb_content;
	}
	public void setFb_content(String fb_content) {
		this.fb_content = fb_content;
	}
	public String getFb_writer() {
		return fb_writer;
	}
	public void setFb_writer(String fb_writer) {
		this.fb_writer = fb_writer;
	}
	public String getFb_image() {
		return fb_image;
	}
	public void setFb_image(String fb_image) {
		this.fb_image = fb_image;
	}
	public Date getFb_regdate() {
		return fb_regdate;
	}
	public void setFb_regdate(Date fb_regdate) {
		this.fb_regdate = fb_regdate;
	}
	public String getFb_category() {
		return fb_category;
	}
	public void setFb_category(String fb_category) {
		this.fb_category = fb_category;
	}
	public int getFb_like() {
		return fb_like;
	}
	public void setFb_like(int fb_like) {
		this.fb_like = fb_like;
	}
	public int getFb_viewcnt() {
		return fb_viewcnt;
	}
	public void setFb_viewcnt(int fb_viewcnt) {
		this.fb_viewcnt = fb_viewcnt;
	}
	@Override
	public String toString() {
		return "BoardVO [fb_no=" + fb_no + ", fb_title=" + fb_title + ", fb_content=" + fb_content + ", fb_writer="
				+ fb_writer + ", fb_image=" + fb_image + ", images=" + images + ", fb_regdate=" + fb_regdate
				+ ", fb_category=" + fb_category + ", fb_like=" + fb_like + ", fb_viewcnt=" + fb_viewcnt + "]";
	}
	

		
}
