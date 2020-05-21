package com.icia.lastproject.dto;

import lombok.Data;

@Data
public class ProductReportDTO {
	private String memberId;
	private String sellerId;
	private int productno;
	private String trade_name;
	private String reporttype;
}
