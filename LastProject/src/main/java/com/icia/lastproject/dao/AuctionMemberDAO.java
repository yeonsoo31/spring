package com.icia.lastproject.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.lastproject.dto.AuctionMemberDTO;
import com.icia.lastproject.dto.PagingDTO;

@Repository
public class AuctionMemberDAO {

	@Autowired
	private SqlSessionTemplate sql;

	public void biddingAdd(AuctionMemberDTO am) {
		sql.insert("AuctionMember.biddingAdd", am);
		
	}

	public List<AuctionMemberDTO> biddingList(PagingDTO paging) {
		return sql.selectList("AuctionMember.biddingList", paging);
	}

	public int listCount(int a_number) {
		return sql.selectOne("AuctionMember.listCount",a_number);
	}

	public int bidSuccess(HashMap<String, Object> hash) {
		return sql.insert("AuctionMember.bidSuccess", hash);
	}

	public int bidCheck(int a_number) {
		return sql.selectOne("AuctionMember.bidCheck", a_number);
	}

	public AuctionMemberDTO auctionBidMember(int a_number) {
		return sql.selectOne("AuctionMember.auctionBidMember", a_number);
	}
}
