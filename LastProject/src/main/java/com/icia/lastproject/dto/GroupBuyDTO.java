package com.icia.lastproject.dto;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.web.multipart.MultipartFile;


public class GroupBuyDTO {
	private int g_number;
	private String id;
	private int categoryno;
	private int g_price;
	private String g_name;
	private int g_hit;

	private MultipartFile photo1;
	private MultipartFile photo2;
	private MultipartFile photo3;

	private String g_photo1name;
	private String g_photo2name;
	private String g_photo3name;


	private String g_explanation;
	private int g_person;

	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private String g_deadline;
//	@DateTimeFormat(iso = ISO.DATE_TIME)
//	private LocalDateTime g_deadline;

	public int getG_number() {
		return g_number;
	}

	public void setG_number(int g_number) {
		this.g_number = g_number;
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

	public int getG_price() {
		return g_price;
	}

	public void setG_price(int g_price) {
		this.g_price = g_price;
	}

	public String getG_name() {
		return g_name;
	}

	public void setG_name(String g_name) {
		this.g_name = g_name;
	}

	public int getG_hit() {
		return g_hit;
	}

	public void setG_hit(int g_hit) {
		this.g_hit = g_hit;
	}

	public MultipartFile getPhoto1() {
		return photo1;
	}

	public void setPhoto1(MultipartFile photo1) {
		this.photo1 = photo1;
	}

	public MultipartFile getPhoto2() {
		return photo2;
	}

	public void setPhoto2(MultipartFile photo2) {
		this.photo2 = photo2;
	}

	public MultipartFile getPhoto3() {
		return photo3;
	}

	public void setPhoto3(MultipartFile photo3) {
		this.photo3 = photo3;
	}

	public String getG_photo1name() {
		return g_photo1name;
	}

	public void setG_photo1name(String g_photo1name) {
		this.g_photo1name = g_photo1name;
	}

	public String getG_photo2name() {
		return g_photo2name;
	}

	public void setG_photo2name(String g_photo2name) {
		this.g_photo2name = g_photo2name;
	}

	public String getG_photo3name() {
		return g_photo3name;
	}

	public void setG_photo3name(String g_photo3name) {
		this.g_photo3name = g_photo3name;
	}

	public String getG_explanation() {
		return g_explanation;
	}

	public void setG_explanation(String g_explanation) {
		this.g_explanation = g_explanation;
	}

	public int getG_person() {
		return g_person;
	}

	public void setG_person(int g_person) {
		this.g_person = g_person;
	}

	public String getG_deadline() {
		return g_deadline;
	}

	public void setG_deadline(String g_deadline) {
		this.g_deadline = g_deadline;
	}
	
	
	
	
}
