package com.example.domain;

public class CampingReserVO extends CampingVO {
	private int reser_no;
	private String camp_id;
	private String camp_room_no;
	private String reser_status;
	private String reser_checkin;
	private String reser_checkout;
	private String uid;
	private int reser_man_qty;
	private String reser_booker;
	private String reser_booker_phone;
	private int reser_price;
	private String reser_date;
	
	public String getReser_date() {
		return reser_date;
	}
	public void setReser_date(String reser_date) {
		this.reser_date = reser_date;
	}
	public int getReser_no() {
		return reser_no;
	}
	public void setReser_no(int reser_no) {
		this.reser_no = reser_no;
	}
	public String getCamp_id() {
		return camp_id;
	}
	public void setCamp_id(String camp_id) {
		this.camp_id = camp_id;
	}
	public String getCamp_room_no() {
		return camp_room_no;
	}
	public void setCamp_room_no(String camp_room_no) {
		this.camp_room_no = camp_room_no;
	}
	public String getReser_status() {
		return reser_status;
	}
	public void setReser_status(String reser_status) {
		this.reser_status = reser_status;
	}
	public String getReser_checkin() {
		return reser_checkin;
	}
	public void setReser_checkin(String reser_checkin) {
		this.reser_checkin = reser_checkin;
	}
	public String getReser_checkout() {
		return reser_checkout;
	}
	public void setReser_checkout(String reser_checkout) {
		this.reser_checkout = reser_checkout;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public int getReser_man_qty() {
		return reser_man_qty;
	}
	public void setReser_man_qty(int reser_man_qty) {
		this.reser_man_qty = reser_man_qty;
	}
	public String getReser_booker() {
		return reser_booker;
	}
	public void setReser_booker(String reser_booker) {
		this.reser_booker = reser_booker;
	}
	public String getReser_booker_phone() {
		return reser_booker_phone;
	}
	public void setReser_booker_phone(String reser_booker_phone) {
		this.reser_booker_phone = reser_booker_phone;
	}
	public int getReser_price() {
		return reser_price;
	}
	public void setReser_price(int reser_price) {
		this.reser_price = reser_price;
	}
	@Override
	public String toString() {
		return "CampingReserVO [reser_no=" + reser_no + ", camp_id=" + camp_id + ", camp_room_no=" + camp_room_no
				+ ", reser_status=" + reser_status + ", reser_checkin=" + reser_checkin + ", reser_checkout="
				+ reser_checkout + ", uid=" + uid + ", reser_man_qty=" + reser_man_qty + ", reser_booker="
				+ reser_booker + ", reser_booker_phone=" + reser_booker_phone + ", reser_price=" + reser_price
				+ ", reser_date=" + reser_date + "]";
	}
}
