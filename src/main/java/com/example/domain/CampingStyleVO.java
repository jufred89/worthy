package com.example.domain;

public class CampingStyleVO {
	private String style_no;
	private String style_name;

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

	@Override
	public String toString() {
		return "CampingStyleVO [style_no=" + style_no + ", style_name=" + style_name + "]";
	}

}
