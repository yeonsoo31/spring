package com.icia.lastproject.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.lastproject.dto.MemberDTO;
import com.icia.lastproject.dto.ProductReportDTO;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSessionTemplate sql;
	
	public int memberJoin(MemberDTO member) {
		if(member.getGoogleId() != null) {
			return sql.insert("Member.googleJoin", member);
		} else if(member.getFacebookId() != null) {
			return sql.insert("Member.facebookJoin", member);
		} else if(member.getKakaoId() != null) {
			return sql.insert("Member.kakaoJoin", member);
		} else if(member.getNaverId() != null) {
			return sql.insert("Member.naverJoin", member);
		} else {
			return sql.insert("Member.memberJoin", member);
		}
	}
	
	public MemberDTO kakaoLogin(String kakaoId) {
		return sql.selectOne("Member.kakaoLogin", kakaoId);
	}

	public MemberDTO naverLogin(String naverId) {
		return sql.selectOne("Member.naverLogin", naverId);
	}

	public String googleLogin(String googleId) {
		return sql.selectOne("Member.googleLogin", googleId);
	}

	public String facebookLogin(String facebookId) {
		return sql.selectOne("Member.facebookLogin", facebookId);
	}

	public String memberLogin(MemberDTO member) {
		return sql.selectOne("Member.memberLogin", member);
	}
	
	public String idOverlap(String id) {
		return sql.selectOne("Member.idOverlap", id);
	}
	
	public int memberModify(MemberDTO member) {
		return sql.update("Member.memberModify", member);
	}
	
	public int sellerModify(MemberDTO member) {
		return sql.update("Member.sellerModify", member);
	}
	
	public MemberDTO memberView(String id) {
		return sql.selectOne("Member.memberView", id);
	}
	
	public MemberDTO sellerView(String id) {
		return sql.selectOne("Member.sellerView", id);
	}
	
	public List<MemberDTO> memberList() {
		return sql.selectList("Member.memberList");
	}
	
	public List<ProductReportDTO> reportList() {
		return sql.selectList("Member.reportList");
	}
	
	public List<MemberDTO> sellerList() {
		return sql.selectList("Member.sellerList");
	}
	
	public List<MemberDTO> memberBlackList() {
		return sql.selectList("Member.memberBlackList");
	}
	
	public List<MemberDTO> sellerBlackList() {
		return sql.selectList("Member.sellerBlackList");
	}
	
	public int memberIdDivision(MemberDTO member) {
		return sql.selectOne("Member.memberIdDivision", member);
	}

	public int sellerJoin(MemberDTO member) {
		return sql.insert("Member.sellerJoin", member);
	}

	public String sellerLogin(MemberDTO member) {
		return sql.selectOne("Member.sellerLogin", member);
	}

	public int sellerIdDivision(MemberDTO member) {
		return sql.selectOne("Member.sellerIdDivision", member);
	}

	public String memberLoginCheck(HashMap<String, Object> hash) {
		return sql.selectOne("Member.memberLoginCheck", hash);
	}
	
	public String sellerLoginCheck(HashMap<String, Object> hash) {
		return sql.selectOne("Member.sellerLoginCheck", hash);
	}
	
	public int memberBlackListAdd(String id) {
		return sql.update("Member.memberBlackListAdd", id);
	}
	
	public int sellerBlackListAdd(String id) {
		return sql.update("Member.sellerBlackListAdd", id);
	}
	
	public int memberBlackListDelete(String id) {
		return sql.update("Member.memberBlackListDelete", id);
	}

	public int sellerBlackListDelete(String id) {
		return sql.update("Member.sellerBlackListDelete", id);
	}

	public int sellerDelete(String id) {
		return sql.delete("Member.sellerDelete", id);
	}

	public String sellerDeleteCheckResult(HashMap<String, Object> hash) {
		return sql.selectOne("Member.sellerDeleteCheckResult", hash);
	}

	public String memberDeleteCheckResult(HashMap<String, Object> hash) {
		return sql.selectOne("Member.memberDeleteCheckResult", hash);
	}

	public int memberDelete(String id) {
		return sql.delete("Member.memberDelete", id);
	}

	public String memberIdFind(MemberDTO member) {
		return sql.selectOne("Member.memberIdFind", member);
	}
	
	public String sellerIdFind(MemberDTO seller) {
		return sql.selectOne("Member.sellerIdFind", seller);
	}

	public int newPassword(HashMap<String, Object> hash) {
		return sql.update("Member.newPassword", hash);
	}
	
	public int newSellerPassword(HashMap<String, Object> hash) {
		return sql.update("Member.newSellerPassword", hash);
	}
	
	public String emailCheck(String id) {
		return sql.selectOne("Member.emailCheck", id);
	}

	public String blackMemberCheck(String id) {
		return sql.selectOne("Member.blackMemberCheck", id);
	}

	public String memberDate(String id) {
		return sql.selectOne("Member.memberDate", id);
	}
	
	public String sellerDate(String id) {
		return sql.selectOne("Member.sellerDate", id);
	}

	public int memberOldPasswordChange(HashMap<String, Object> hash) {
		return sql.update("Member.memberOldPasswordChange", hash);
	}

	public int sellerOldPasswordChange(HashMap<String, Object> hash) {
		return sql.update("Member.sellerOldPasswordChange", hash);
	}

	public String memberAddress(String id) {
		return sql.selectOne("Member.memberAddress", id);
	}

	public int deleteSellerProductReport(String id) {
		return sql.delete("Member.deleteSellerProductReport", id);
	}

	public int reportDelete(ProductReportDTO productReport) {
		return sql.delete("Member.reportDelete", productReport);
	}

	public MemberDTO loginMember(MemberDTO member) {
		return sql.selectOne("Member.loginMember", member);
	}






}
