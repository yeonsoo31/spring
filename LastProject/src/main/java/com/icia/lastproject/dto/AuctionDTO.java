package com.icia.lastproject.dto;

import org.springframework.web.multipart.MultipartFile;

import java.util.*;

import lombok.Data;

@Data
public class AuctionDTO {
	private int a_number;
	private String a_name;
	private String id;
	private String a_information;
	private String a_price;
	private String a_date;
	private int a_hit;
	private MultipartFile a_photo3;
	private List<MultipartFile> a_photo4;
	private String a_photo;
	private String a_photo1;
	private String a_photo2;
	private String a_photo5;
	private String a_photo6;
	private String a_photo7;
	
}
