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
	private String prod_status;
	private String prod_stack_qty;
	private String prod_cap;
	private String prod_mfd;
	private String prod_exp;
	
	public String getProd_status() {
		return prod_status;
	}
	public void setProd_status(String prod_status) {
		this.prod_status = prod_status;
	}
	public String getProd_stack_qty() {
		return prod_stack_qty;
	}
	public void setProd_stack_qty(String prod_stack_qty) {
		this.prod_stack_qty = prod_stack_qty;
	}
	public String getProd_cap() {
		return prod_cap;
	}
	public void setProd_cap(String prod_cap) {
		this.prod_cap = prod_cap;
	}
	public String getProd_mfd() {
		return prod_mfd;
	}
	public void setProd_mfd(String prod_mfd) {
		this.prod_mfd = prod_mfd;
	}
	public String getProd_exp() {
		return prod_exp;
	}
	public void setProd_exp(String prod_exp) {
		this.prod_exp = prod_exp;
	}
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
		return "ShopVO [prod_id=" + prod_id + ", prod_name=" + prod_name + ", prod_comp=" + prod_comp
				+ ", prod_normalprice=" + prod_normalprice + ", prod_saleprice=" + prod_saleprice + ", prod_detail="
				+ prod_detail + ", prod_image=" + prod_image + ", prod_del=" + prod_del + ", prod_status=" + prod_status
				+ ", prod_stack_qty=" + prod_stack_qty + ", prod_cap=" + prod_cap + ", prod_mfd=" + prod_mfd
				+ ", prod_exp=" + prod_exp + "]";
	}
}