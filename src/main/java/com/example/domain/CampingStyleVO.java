package com.example.domain;

public class CampingStyleVO {
	private String style_no;
	private String style_name;
	private int style_qty;

	public String getStyle_no() {
		return style_no;
	}

	public void setStyle_no(String style_no) {
		this.style_no = style_no;
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

	@Override
	public String toString() {
		return "CampingStyleVO [style_no=" + style_no + ", style_name=" + style_name + ", style_qty=" + style_qty + "]";
	}

}
