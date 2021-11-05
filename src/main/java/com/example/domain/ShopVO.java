package com.example.domain;

public class ShopVO {
	private String prod_id;
	private String prod_name;
	private String prod_comp;
	private int prod_normalprice;
	private int prod_saleprice;
	private String prod_detail;
	private String prod_image;
	private String prod_del;
	
	public String getProd_id() {
		return prod_id;
	}
	public void setProd_id(String prod_id) {
		this.prod_id = prod_id;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public String getProd_comp() {
		return prod_comp;
	}
	public void setProd_comp(String prod_comp) {
		this.prod_comp = prod_comp;
	}
	public int getProd_normalprice() {
		return prod_normalprice;
	}
	public void setProd_normalprice(int prod_normalprice) {
		this.prod_normalprice = prod_normalprice;
	}
	public int getProd_saleprice() {
		return prod_saleprice;
	}
	public void setProd_saleprice(int prod_saleprice) {
		this.prod_saleprice = prod_saleprice;
	}
	public String getProd_detail() {
		return prod_detail;
	}
	public void setProd_detail(String prod_detail) {
		this.prod_detail = prod_detail;
	}
	public String getProd_image() {
		return prod_image;
	}
	public void setProd_image(String prod_image) {
		this.prod_image = prod_image;
	}
	public String getProd_del() {
		return prod_del;
	}
	public void setProd_del(String prod_del) {
		this.prod_del = prod_del;
	}
	@Override
	public String toString() {
		return "UserVO [prod_id=" + prod_id + ", prod_name=" + prod_name + ", prod_comp=" + prod_comp
				+ ", prod_normalprice=" + prod_normalprice + ", prod_saleprice=" + prod_saleprice + ", prod_detail="
				+ prod_detail + ", prod_image=" + prod_image + ", prod_del=" + prod_del + "]";
	}
}