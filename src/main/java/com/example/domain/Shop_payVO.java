package com.example.domain;


public class Shop_payVO {
	private int pay_no;
	private String pay_date;
	private int pay_price;
	private String pay_type;
	private String pay_uid;
	private int pay_status;
	private String deli_postno;
	private String deli_address1;
	private String deli_address2;
	private String deli_tel;
	private String deli_name;
	private String deli_memo;
	
	@Override
	public String toString() {
		return "Shop_payVO [pay_no=" + pay_no + ", pay_date=" + pay_date + ", pay_price=" + pay_price + ", pay_type="
				+ pay_type + ", pay_uid=" + pay_uid + ", pay_status=" + pay_status + ", deli_postno=" + deli_postno
				+ ", deli_address1=" + deli_address1 + ", deli_address2=" + deli_address2 + ", deli_tel=" + deli_tel
				+ ", deli_name=" + deli_name + ", deli_memo=" + deli_memo + "]";
	}
	public int getPay_no() {
		return pay_no;
	}
	public void setPay_no(int pay_no) {
		this.pay_no = pay_no;
	}
	public String getPay_date() {
		return pay_date;
	}
	public void setPay_date(String pay_date) {
		this.pay_date = pay_date;
	}
	
	public int getPay_price() {
		return pay_price;
	}
	public void setPay_price(int pay_price) {
		this.pay_price = pay_price;
	}
	public String getPay_type() {
		return pay_type;
	}
	public void setPay_type(String pay_type) {
		this.pay_type = pay_type;
	}
	public String getPay_uid() {
		return pay_uid;
	}
	public void setPay_uid(String pay_uid) {
		this.pay_uid = pay_uid;
	}
	public int getPay_status() {
		return pay_status;
	}
	public void setPay_status(int pay_status) {
		this.pay_status = pay_status;
	}
	public String getDeli_postno() {
		return deli_postno;
	}
	public void setDeli_postno(String deli_postno) {
		this.deli_postno = deli_postno;
	}
	public String getDeli_address1() {
		return deli_address1;
	}
	public void setDeli_address1(String deli_address1) {
		this.deli_address1 = deli_address1;
	}
	public String getDeli_address2() {
		return deli_address2;
	}
	public void setDeli_address2(String deli_address2) {
		this.deli_address2 = deli_address2;
	}
	public String getDeli_tel() {
		return deli_tel;
	}
	public void setDeli_tel(String deli_tel) {
		this.deli_tel = deli_tel;
	}
	public String getDeli_name() {
		return deli_name;
	}
	public void setDeli_name(String deli_name) {
		this.deli_name = deli_name;
	}
	public String getDeli_memo() {
		return deli_memo;
	}
	public void setDeli_memo(String deli_memo) {
		this.deli_memo = deli_memo;
	}
}
