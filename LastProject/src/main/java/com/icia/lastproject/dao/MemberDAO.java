package com.icia.lastproject.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.lastproject.dto.MemberDTO;

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
	
	public MemberDTO memberView(String id) {
		return sql.selectOne("Member.memberView", id);
	}
	
	public List<MemberDTO> memberList() {
		return sql.selectList("Member.memberList");
	}
	
}
