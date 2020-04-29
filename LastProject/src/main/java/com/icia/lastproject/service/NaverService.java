package com.icia.lastproject.service;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.icia.lastproject.dao.MemberDAO;
import com.icia.lastproject.dto.MemberDTO;

@Service
public class NaverService {
	
	@Autowired
	private MemberDAO mdao;

	@Autowired
	private HttpSession session;
	
	private ModelAndView mav;
	
	public ModelAndView naverLogin(String profile) throws ParseException {
		mav = new ModelAndView();
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(profile);
		JSONObject naverUser = (JSONObject) obj;
		JSONObject userInfo = (JSONObject) naverUser.get("response");
		String naverId = (String) userInfo.get("id");
		String email = (String) userInfo.get("email");
//		String name = (String) userInfo.get("name");
//		String gender = (String) userInfo.get("gender");
//		String birthday = (String) userInfo.get("birthday");
		MemberDTO naverMember = mdao.naverLogin(naverId);
		if(naverMember==null) {
			mav.setViewName("member/MemberJoinAsk");
		} else {
//		session.setAttribute("loginId", naverMember.getMid());
		session.setAttribute("loginId", email);
		mav.addObject("naverId", naverId);
		mav.setViewName("member/MemberMain");
		}
		return mav;
	}
	
	public ModelAndView naverLogin(JsonNode profile) {
		mav = new ModelAndView();
		String naverId = profile.get("id").asText();
		JsonNode naverAccount = profile.get("naver_account");
		JsonNode naverProfile = naverAccount.get("profile");
		String nickName = naverProfile.path("nickname").asText();
		String email = naverProfile.path("email").asText();
		String thumbnail = naverProfile.path("thumbnail_image_url").asText();
		MemberDTO member = mdao.naverLogin(naverId);
		session.setAttribute("loginId", member.getId());
		mav.addObject("naverId", naverId);
		mav.addObject("loginMember", member);
		mav.addObject("email", email);
		mav.addObject("nickName", nickName);
		mav.addObject("naverProfile", naverProfile);
		mav.addObject("thumbnail", thumbnail);
		mav.setViewName("member/MemberMain");
		return mav;
	}
}
