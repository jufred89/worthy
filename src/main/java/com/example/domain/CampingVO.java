package com.example.domain;

import java.util.ArrayList;

public class CampingVO {
	private String camp_id;
	private String camp_name;
	private String camp_maker;
	private String camp_addr;
	private String camp_tel;
	private int camp_price;
	private String camp_status;
	private String camp_memo;
	private String camp_detail;
	private String camp_image;

	// camping Style, camping facility

	private String style_name;
	private int style_qty;
	private String facility_name;
	private String facility_no;
	private int style_price;
	
	// camping attach image
	
	private ArrayList<String> images;

	public String getCamp_id() {
		return camp_id;
	}

	public void setCamp_id(String camp_id) {
		this.camp_id = camp_id;
	}

	public String getCamp_name() {
		return camp_name;
	}

	public void setCamp_name(String camp_name) {
		this.camp_name = camp_name;
	}

	public String getCamp_maker() {
		return camp_maker;
	}

	public void setCamp_maker(String camp_maker) {
		this.camp_maker = camp_maker;
	}

	public String getCamp_addr() {
		return camp_addr;
	}

	public void setCamp_addr(String camp_addr) {
		this.camp_addr = camp_addr;
	}

	public String getCamp_tel() {
		return camp_tel;
	}

	public void setCamp_tel(String camp_tel) {
		this.camp_tel = camp_tel;
	}

	public int getCamp_price() {
		return camp_price;
	}

	public void setCamp_price(int camp_price) {
		this.camp_price = camp_price;
	}

	public String getCamp_status() {
		return camp_status;
	}

	public void setCamp_status(String camp_status) {
		this.camp_status = camp_status;
	}

	public String getCamp_memo() {
		return camp_memo;
	}

	public void setCamp_memo(String camp_memo) {
		this.camp_memo = camp_memo;
	}

	public String getCamp_detail() {
		return camp_detail;
	}

	public void setCamp_detail(String camp_detail) {
		this.camp_detail = camp_detail;
	}

	public String getCamp_image() {
		return camp_image;
	}

	public void setCamp_image(String camp_image) {
		this.camp_image = camp_image;
	}

	public String getStyle_name() {
		return style_name;
	}

	public void setStyle_name(String style_name) {
		this.style_name = style_name;
	}

	public int getStyle_qty() {
		return style_qty;
	}

	public void setStyle_qty(int style_qty) {
		this.style_qty = style_qty;
	}

	public String getFacility_name() {
		return facility_name;
	}

	public void setFacility_name(String facility_name) {
		this.facility_name = facility_name;
	}

	public String getFacility_no() {
		return facility_no;
	}

	public void setFacility_no(String facility_no) {
		this.facility_no = facility_no;
	}

	public int getStyle_price() {
		return style_price;
	}

	public void setStyle_price(int style_price) {
		this.style_price = style_price;
	}

	public ArrayList<String> getImages() {
		return images;
	}

	public void setImages(ArrayList<String> images) {
		this.images = images;
	}

	@Override
	public String toString() {
		return "CampingVO [camp_id=" + camp_id + ", camp_name=" + camp_name + ", camp_maker=" + camp_maker
				+ ", camp_addr=" + camp_addr + ", camp_tel=" + camp_tel + ", camp_price=" + camp_price
				+ ", camp_status=" + camp_status + ", camp_memo=" + camp_memo + ", camp_detail=" + camp_detail
				+ ", camp_image=" + camp_image + ", style_name=" + style_name + ", style_qty=" + style_qty
				+ ", facility_name=" + facility_name + ", facility_no=" + facility_no + ", style_price=" + style_price
				+ ", images=" + images + "]";
	}

}
