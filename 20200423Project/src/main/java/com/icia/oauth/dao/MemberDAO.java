package com.icia.oauth.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.oauth.dto.MemberDTO;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSessionTemplate sql;
	
	public int memberJoin(MemberDTO member) {
		if(member.getKakaoId() != null) {
			return sql.insert("Member.kakaoJoin", member);
		} else if(member.getNaverId() != null) {
			return sql.insert("Member.naverJoin", member);
		} else {
		return sql.insert("Member.memberJoin", member);
		}
	}
	
	public MemberDTO KakaoLogin(String kakaoId) {
		return sql.selectOne("Member.kakaoLogin", kakaoId);
	}

	public MemberDTO NaverLogin(String naverId) {
		return sql.selectOne("Member.naverLogin", naverId);
	}
	
}
