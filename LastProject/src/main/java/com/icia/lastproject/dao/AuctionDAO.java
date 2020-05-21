package com.icia.lastproject.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.lastproject.dto.AuctionDTO;
import com.icia.lastproject.dto.AuctionMemberDTO;
import com.icia.lastproject.dto.AuctionQnAAnswerDTO;
import com.icia.lastproject.dto.AuctionQnADTO;
import com.icia.lastproject.dto.OrderDTO;
import com.icia.lastproject.dto.PagingDTO;

@Repository
public class AuctionDAO {

	@Autowired
	private SqlSessionTemplate sql;

	public int listCount() {
		return sql.selectOne("Auction.listCount");
	}

	public List<AuctionDTO> auctionList(PagingDTO paging) {
		return sql.selectList("Auction.auctionList", paging);
	}

	public int auctionAdd(AuctionDTO auction) {
		if(auction.getA_photo2() == null && auction.getA_photo1() == null) {
		return sql.insert("Auction.auctionAdd2", auction);
		} else if(auction.getA_photo1() != null && auction.getA_photo2() == null){
			return sql.insert("Auction.auctionAdd1", auction);
		} else {
			return sql.insert("Auction.auctionAdd", auction);
		}
	}

	public AuctionDTO auctionView(int a_number) {
		return sql.selectOne("Auction.auctionView", a_number);
	}

	public int bidding(HashMap<String, Object> hashMap) {
		return sql.update("Auction.bidding", hashMap);
	}

	public int auctionModify(AuctionDTO auction) {
		if(auction.getA_photo2() == null && auction.getA_photo1() == null) {
			return sql.update("Auction.auctionModify", auction);
		}else if(auction.getA_photo1() != null && auction.getA_photo2() == null){
			return sql.update("Auction.auctionModify1", auction);
		}else {
			return sql.update("Auction.auctionModify2", auction);
		}
	}

	public int auctionDelete(int a_number) {
		return sql.delete("Auction.auctionDelete", a_number);
	}

	public int payment(OrderDTO order) {
		return sql.insert("Auction.payment", order);
	}

	public List<AuctionQnADTO> auctionQnA(PagingDTO paging) {
		return sql.selectList("Auction.auctionQnA", paging);
	}

	public int qnaListCount(int a_number) {
		return sql.selectOne("Auction.countQnA",a_number);
	}

	public List<AuctionQnAAnswerDTO> auctionQnAAnswer() {
		return sql.selectList("Auction.auctionQnAAnswer");
	}

	public int auctionQnAWrite(AuctionQnADTO auctionQnA) {
		return sql.insert("Auction.auctionQnAWrite", auctionQnA);
	}

	public int auctionQnAAnswerWrite(AuctionQnAAnswerDTO auctionQnAAnswer) {
		return sql.insert("Auction.auctionQnAAnswerWrite", auctionQnAAnswer);
	}
}
