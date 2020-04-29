package com.icia.lastproject.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberDTO {
	private String id;
	private String password;
	private String name;
	private String birth;
	private String address;
	private String address1;
	private String address2;
	private String address3;
	private String address4;
	private String phone;
	private MultipartFile file;
	private String profile;
	private String kakaoId;
	private String naverId;
	private String googleId;
	private String facebookId;
	private int savemoney;
	private int division;
	private String passworddate;
}
