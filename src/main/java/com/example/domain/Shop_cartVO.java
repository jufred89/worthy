package com.example.domain;

public class Shop_cartVO {
	private int cart_no;
	private String cart_pid;
	private String cart_uid;
	private int cart_price;
	private int cart_pqty;
	private String cart_status;
	
	@Override
	public String toString() {
		return "Shop_cartVO [cart_no=" + cart_no + ", cart_pid=" + cart_pid + ", cart_uid=" + cart_uid + ", cart_price="
				+ cart_price + ", cart_pqty=" + cart_pqty + ", cart_status=" + cart_status + "]";
	}
	public int getCart_no() {
		return cart_no;
	}
	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
	}
	public String getCart_pid() {
		return cart_pid;
	}
	public void setCart_pid(String cart_pid) {
		this.cart_pid = cart_pid;
	}
	public String getCart_uid() {
		return cart_uid;
	}
	public void setCart_uid(String cart_uid) {
		this.cart_uid = cart_uid;
	}
	public int getCart_price() {
		return cart_price;
	}
	public void setCart_price(int cart_price) {
		this.cart_price = cart_price;
	}
	public int getCart_pqty() {
		return cart_pqty;
	}
	public void setCart_pqty(int cart_pqty) {
		this.cart_pqty = cart_pqty;
	}
	public String getCart_status() {
		return cart_status;
	}
	public void setCart_status(String cart_status) {
		this.cart_status = cart_status;
	}
}
