package com.example.domain;

public class Shop_orderVO {
	private String order_id;
	private int cart_no;
	
	@Override
	public String toString() {
		return "Shop_orderVO [order_id=" + order_id + ", cart_no=" + cart_no + "]";
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public int getCart_no() {
		return cart_no;
	}
	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
	}
}
