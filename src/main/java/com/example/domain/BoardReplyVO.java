package com.example.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class BoardReplyVO {
	private int fb_rno;
	private int fb_bno;
	private String fb_reply;
	private String fb_replyer;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="Asia/Seoul")
	private Date fb_replydate;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="Asia/Seoul")
	private Date fb_updatedate;
	
	public int getFb_rno() {
		return fb_rno;
	}
	public void setFb_rno(int fb_rno) {
		this.fb_rno = fb_rno;
	}
	public int getFb_bno() {
		return fb_bno;
	}
	public void setFb_bno(int fb_bno) {
		this.fb_bno = fb_bno;
	}
	public String getFb_reply() {
		return fb_reply;
	}
	public void setFb_reply(String fb_reply) {
		this.fb_reply = fb_reply;
	}
	public String getFb_replyer() {
		return fb_replyer;
	}
	public void setFb_replyer(String fb_replyer) {
		this.fb_replyer = fb_replyer;
	}
	public Date getFb_replydate() {
		return fb_replydate;
	}
	public void setFb_replydate(Date fb_replydate) {
		this.fb_replydate = fb_replydate;
	}
	public Date getFb_updatedate() {
		return fb_updatedate;
	}
	public void setFb_updatedate(Date fb_updatedate) {
		this.fb_updatedate = fb_updatedate;
	}
	@Override
	public String toString() {
		return "BoardReplyVO [fb_rno=" + fb_rno + ", fb_bno=" + fb_bno + ", fb_reply=" + fb_reply + ", fb_replyer="
				+ fb_replyer + ", fb_replydate=" + fb_replydate + ", fb_updatedate=" + fb_updatedate + "]";
	}
	
	
}
