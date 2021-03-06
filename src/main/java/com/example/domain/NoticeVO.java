package com.example.domain;

import java.util.ArrayList;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class NoticeVO {
	private int nb_no;
	private String nb_title;
	private String nb_content;
	private String nb_writer;
	private String nb_image;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="Asia/Seoul")
	private Date nb_regdate;
	private int nb_like;
	private int nb_viewcnt;
	private ArrayList<String> images;
	
	
	@Override
	public String toString() {
		return "NoticeVO [nb_no=" + nb_no + ", nb_title=" + nb_title + ", nb_content=" + nb_content + ", nb_writer="
				+ nb_writer + ", nb_image=" + nb_image + ", nb_regdate=" + nb_regdate + ", nb_like=" + nb_like
				+ ", nb_viewcnt=" + nb_viewcnt + ", images=" + images + "]";
	}
	
	public ArrayList<String> getImages() {
		return images;
	}
	public void setImages(ArrayList<String> nb_images) {
		this.images = nb_images;
	}
	public int getNb_viewcnt() {
		return nb_viewcnt;
	}
	public void setNb_viewcnt(int nb_viewcnt) {
		this.nb_viewcnt = nb_viewcnt;
	}
	public int getNb_like() {
		return nb_like;
	}
	public void setNb_like(int nb_like) {
		this.nb_like = nb_like;
	}
	public int getNb_no() {
		return nb_no;
	}
	public void setNb_no(int nb_no) {
		this.nb_no = nb_no;
	}
	public String getNb_title() {
		return nb_title;
	}
	public void setNb_title(String nb_title) {
		this.nb_title = nb_title;
	}
	public String getnb_content() {
		return nb_content;
	}
	public void setnb_content(String nb_content) {
		this.nb_content = nb_content;
	}
	public String getnb_writer() {
		return nb_writer;
	}
	public void setnb_writer(String nb_writer) {
		this.nb_writer = nb_writer;
	}
	public String getNb_image() {
		return nb_image;
	}
	public void setNb_image(String nb_image) {
		this.nb_image = nb_image;
	}
	public Date getnb_regdate() {
		return nb_regdate;
	}
	public void setnb_regdate(Date nb_regdate) {
		this.nb_regdate = nb_regdate;
	}
	
}
