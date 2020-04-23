package com.icia.oauth.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberDTO {

	private String mid;
	private String mpassword;
	private String mname;
	private String mbirth;
	private String memail;
	private String maddress;
	private String maddress1;
	private String maddress2;
	private String maddress3;
	private String maddress4;
	private String fulladdress;
	private String mphone;
	private MultipartFile mprofilepic;
	private String mprofilepicname;
	private String kakaoId;
	private String naverId;
}
