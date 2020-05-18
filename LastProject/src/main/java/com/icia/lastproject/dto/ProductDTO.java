package com.icia.lastproject.dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ProductDTO {

	private String id;
	private int categoryno;
	private int productno;
	private int price;
	private String explanation;
	private int hit;
	private String photo1;
	private String photo2;
	private String photo3;
	private String trade_name;
	private MultipartFile photo4;
	private List<MultipartFile> photo5;
	private MultipartFile photo6;
	private String photo7;
	private String photo8;
	private String photo9;
	
	
	
	
	public String getPhoto7() {
		return photo7;
	}
	public void setPhoto7(String photo7) {
		this.photo7 = photo7;
	}
	public String getPhoto8() {
		return photo8;
	}
	public void setPhoto8(String photo8) {
		this.photo8 = photo8;
	}
	public String getPhoto9() {
		return photo9;
	}
	public void setPhoto9(String photo9) {
		this.photo9 = photo9;
	}
	public MultipartFile getPhoto6() {
		return photo6;
	}
	public void setPhoto6(MultipartFile photo6) {
		this.photo6 = photo6;
	}
	public int getProductno() {
		return productno;
	}
	public void setProductno(int productno) {
		this.productno = productno;
	}
	public String getTrade_name() {
		return trade_name;
	}
	public void setTrade_name(String trade_name) {
		this.trade_name = trade_name;
	}
	public MultipartFile getPhoto4() {
		return photo4;
	}
	public void setPhoto4(MultipartFile photo4) {
		this.photo4 = photo4;
	}

	
	public List<MultipartFile> getPhoto5() {
		return photo5;
	}
	public void setPhoto5(List<MultipartFile> photo5) {
		this.photo5 = photo5;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getCategoryno() {
		return categoryno;
	}
	public void setCategoryno(int categoryno) {
		this.categoryno = categoryno;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getExplanation() {
		return explanation;
	}
	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getPhoto1() {
		return photo1;
	}
	public void setPhoto1(String photo1) {
		this.photo1 = photo1;
	}
	public String getPhoto2() {
		return photo2;
	}
	public void setPhoto2(String photo2) {
		this.photo2 = photo2;
	}
	public String getPhoto3() {
		return photo3;
	}
	public void setPhoto3(String photo3) {
		this.photo3 = photo3;
	}

	
	
}

