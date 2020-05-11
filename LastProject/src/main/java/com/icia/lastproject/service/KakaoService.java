package com.icia.lastproject.service;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.icia.lastproject.dao.MemberDAO;
import com.icia.lastproject.dto.MemberDTO;

@Service
public class KakaoService {

	@Autowired
	private MemberDAO mdao;
	
	@Autowired
	private HttpSession session;
	
	private ModelAndView mav;
	
	public ModelAndView KakaoJoin(JsonNode profile) {
		mav = new ModelAndView();
		JsonNode kakaoAccount = profile.get("kakao_account");
		JsonNode kakaoProfile = kakaoAccount.get("profile");
		String kakaoId = profile.get("id").asText();
		String nickName = kakaoProfile.path("nickname").asText();
		String kakaoEmail = kakaoAccount.path("email").asText();
		mav.addObject("kakaoId", kakaoId);
		mav.addObject("kakaoEmail", kakaoEmail);
		mav.addObject("nickName", nickName);
		mav.setViewName("member/MemberJoinForm2");
		return mav;
	}


	public ModelAndView KakaoLogin(JsonNode profile) {
		mav = new ModelAndView();
		String name = null;
		String kakaoId = profile.get("id").asText();
		JsonNode kakaoAccount = profile.get("kakao_account");
		JsonNode kakaoProfile = kakaoAccount.get("profile");
//		String nickName = kakaoProfile.path("nickname").asText();
//		String email = kakaoProfile.path("email").asText();
		String kakaoEmail = kakaoAccount.path("email").asText();
//		String thumbnail = kakaoProfile.path("thumbnail_image_url").asText();
		MemberDTO member = mdao.kakaoLogin(kakaoId);
		if(member==null) {
			mav.setViewName("member/MemberJoinAsk");
		} else {
		MemberDTO kakaoName = mdao.memberView(kakaoEmail);
		name = kakaoName.getName();
		session.setAttribute("loginId", kakaoEmail);
		mav.addObject("kakaoId", kakaoId);
		mav.addObject("loginMember", member);
//		mav.addObject("email", email);
//		mav.addObject("nickName", nickName);
		mav.addObject("kakaoProfile", kakaoProfile);
//		mav.addObject("thumbnail", thumbnail);
		mav.addObject("name", name);
		mav.setViewName("Main");
		}
		return mav;
	}

}
