package com.icia.lastproject.dto;

public class ReviewDTO {

	private int reviewno;
	private int productno;
	private String id;
	private String contents;
	private String sys_date;
	private int rating;
	public int getReviewno() {
		return reviewno;
	}
	public void setReviewno(int reviewno) {
		this.reviewno = reviewno;
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
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	
	
}
