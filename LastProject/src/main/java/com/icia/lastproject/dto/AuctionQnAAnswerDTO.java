package com.icia.lastproject.dto;

import lombok.Data;

@Data
public class AuctionQnAAnswerDTO {
	private int qa_number;
	private int q_number;
	private String id;
	private String qa_contents;
	private String qa_date;
}
