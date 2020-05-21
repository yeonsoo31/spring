package com.icia.lastproject.dto;

public class ProductQnaDTO {

	private int qnano;
	private int productno;
	private String id;
	private String contents;
	private String sys_date;
	private int password;
	private int qnacheck;
	
	
	public int getQnacheck() {
		return qnacheck;
	}
	public void setQnacheck(int qnacheck) {
		this.qnacheck = qnacheck;
	}
	public int getQnano() {
		return qnano;
	}
	public void setQnano(int qnano) {
		this.qnano = qnano;
	}
	public int getProductno() {
		return productno;
	}
	public void setProductno(int productno) {
		this.productno = productno;
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
	public int getPassword() {
		return password;
	}
	public void setPassword(int password) {
		this.password = password;
	}
	
	
}
