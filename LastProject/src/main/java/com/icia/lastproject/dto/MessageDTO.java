package com.icia.lastproject.dto;

import java.util.Date;

import com.google.gson.Gson;

import lombok.Data;

@Data
public class MessageDTO {
	private String id;
	private String f_id;
	private String message;
	private String m_date;
	private int division;
}
