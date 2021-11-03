package com.example.domain;

public class AttachVO {
	private String shop_pid;
	private String shop_ano;
	
	@Override
	public String toString() {
		return "AttachVO [shop_pid=" + shop_pid + ", shop_ano=" + shop_ano + "]";
	}
	public String getShop_pid() {
		return shop_pid;
	}
	public void setShop_pid(String shop_pid) {
		this.shop_pid = shop_pid;
	}
	public String getShop_ano() {
		return shop_ano;
	}
	public void setShop_ano(String shop_ano) {
		this.shop_ano = shop_ano;
	}
}
