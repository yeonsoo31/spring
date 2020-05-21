package com.icia.lastproject.dto;

public class ProductAnswerDTO {
	private int answerno;
	private int qnano;
	private String id;
	private String contents;
	private String sys_date;
	public int getAnswerno() {
		return answerno;
	}
	public void setAnswerno(int answerno) {
		this.answerno = answerno;
	}
	public int getQnano() {
		return qnano;
	}
	public void setQnano(int qnano) {
		this.qnano = qnano;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getSys_date() {
		return sys_date;
	}
	public void setSys_date(String sys_date) {
		this.sys_date = sys_date;
	}
	
}
