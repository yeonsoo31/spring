package com.icia.oauth.service;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.icia.oauth.dao.MemberDAO;
import com.icia.oauth.dto.MemberDTO;

@Service
public class KakaoService {

	@Autowired
	private MemberDAO mdao;
	
	@Autowired
	private HttpSession session;
	
	private ModelAndView mav;
	
	public ModelAndView KakaoJoin(JsonNode profile) {
		mav = new ModelAndView();
		String kakaoId = profile.get("id").asText();
		mav.addObject("kakaoId", kakaoId);
		mav.setViewName("member/MemberJoinForm");
		return mav;
	}


	public ModelAndView KakaoLogin(JsonNode profile) {
		mav = new ModelAndView();
		String kakaoId = profile.get("id").asText();
		JsonNode kakaoAccount = profile.get("kakao_account");
		JsonNode kakaoProfile = kakaoAccount.get("profile");
		String nickName = kakaoProfile.path("nickname").asText();
		String email = kakaoProfile.path("email").asText();
		String thumbnail = kakaoProfile.path("thumbnail_image_url").asText();
		MemberDTO member = mdao.KakaoLogin(kakaoId);
		session.setAttribute("loginId", member.getMid());
		mav.addObject("kakaoId", kakaoId);
		mav.addObject("loginMember", member);
		mav.addObject("email", email);
		mav.addObject("nickName", nickName);
		mav.addObject("kakaoProfile", kakaoProfile);
		mav.addObject("thumbnail", thumbnail);
		mav.setViewName("member/MemberMain");
		return mav;
	}

}
