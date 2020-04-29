package com.icia.lastproject.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.icia.lastproject.api.KakaoJoinApi;
import com.icia.lastproject.api.KakaoLoginApi;
import com.icia.lastproject.api.NaverJoinApi;
import com.icia.lastproject.api.NaverLoginApi;
import com.icia.lastproject.dto.MemberDTO;
import com.icia.lastproject.service.KakaoService;
import com.icia.lastproject.service.MemberService;
import com.icia.lastproject.service.NaverService;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private KakaoService kakaoService;
	
	@Autowired
	private NaverService naverService;
	
	@Autowired
	private NaverJoinApi naverJoinApi;
	
	@Autowired
	private NaverLoginApi naverLoginApi;
	
	@Autowired
	private HttpSession session;
	
	private ModelAndView mav;
	
	//================================== OAuth Controller ==================================//
	@RequestMapping(value="/googleJoinForm")
	public ModelAndView GoogleJoinForm(
			@RequestParam("googleEmail") String googleEmail,
			@RequestParam("googleName") String googleName,
			@RequestParam("googleId") String googleId){
		mav = new ModelAndView();
		mav.addObject("googleEmail", googleEmail);
		mav.addObject("googleName", googleName);
		mav.addObject("googleId", googleId);
		mav.setViewName("member/MemberJoinForm2");
		return mav;
	}
	@RequestMapping(value="/facebookJoinForm")
	public ModelAndView SignUpForm2(
			@RequestParam("facebookId") String facebookId,
			@RequestParam("facebookName") String facebookName,
			@RequestParam("facebookEmail") String facebookEmail){
		mav = new ModelAndView();
		mav.addObject("facebookId", facebookId);
		mav.addObject("facebookName", facebookName);
		mav.addObject("facebookEmail", facebookEmail);
		mav.setViewName("member/MemberJoinForm2");
		return mav;
	}
	@RequestMapping(value="/kakaojoin", method=RequestMethod.GET)
	public ModelAndView kakaoJoin(HttpSession session) {
		String kakaoUrl = KakaoJoinApi.getAuthorizationUrl(session);
		mav = new ModelAndView();
		mav.addObject("kakaoUrl", kakaoUrl);
		System.out.println(kakaoUrl);
		mav.setViewName("member/KakaoLogin");
		return mav;
	}
	@RequestMapping(value="/naverjoin")
	public ModelAndView naverJoin(HttpSession session) {
		String naverUrl = naverJoinApi.getAuthorizationUrl(session);
		mav = new ModelAndView();
		mav.addObject("naverUrl", naverUrl);
		mav.setViewName("member/NaverLogin");
		return mav;
	}
	@RequestMapping(value="/yyskakaoJoinOK")
	public ModelAndView kakaoJoinOK
			(@RequestParam("code") String code, HttpSession session) {
		mav = new ModelAndView();
		JsonNode token = KakaoJoinApi.getAccessToken(code);
		JsonNode profile = KakaoJoinApi.getKakaoUserInfo(token.path("access_token"));
		mav = kakaoService.KakaoJoin(profile);		
		return mav;
	}
	@RequestMapping(value="/yysnaverJoinOK")
	public ModelAndView naverJoinOK
		(@RequestParam("code") String code, @RequestParam("state") String state, HttpSession session) throws IOException, ParseException {
		mav = new ModelAndView();
		OAuth2AccessToken oauthToken = naverJoinApi.getAccessToken(session, code, state);
		String profile = naverJoinApi.getUserProfile(oauthToken);
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(profile);
		JSONObject naverUser = (JSONObject) obj;
		JSONObject userInfo = (JSONObject) naverUser.get("response");
		String naverId = (String) userInfo.get("id");
		String naverEmail = (String) userInfo.get("email");
		String naverName = (String) userInfo.get("name");
		mav.addObject("naverId", naverId);
		mav.addObject("naverEmail", naverEmail);
		mav.addObject("naverName", naverName);
		mav.setViewName("member/MemberJoinForm2");
		return mav;
	}
	@RequestMapping(value="googleLogin", method = RequestMethod.GET)
	public ModelAndView googleLogin(
			@RequestParam("googleId") String googleId,
			@RequestParam("googleEmail") String googleEmail) {
		mav = new ModelAndView();
		return mav = memberService.googleLogin(googleId, googleEmail);
	}
	@RequestMapping(value="facebookLogin", method = RequestMethod.GET)
	public ModelAndView facebookLogin(
			@RequestParam("facebookId") String facebookId,
			@RequestParam("facebookEmail") String facebookEmail) {
		mav = new ModelAndView();
		return mav = memberService.facebookLogin(facebookId, facebookEmail);
	}
	@RequestMapping(value="/kakaoLogin", method=RequestMethod.GET)
	public ModelAndView kakaoLogin(HttpSession session) {
		String kakaoUrl = KakaoLoginApi.getAuthorizationUrl(session);
		mav = new ModelAndView();
		mav.addObject("kakaoUrl", kakaoUrl);
		mav.setViewName("member/KakaoLogin");
		return mav;
	}
	@RequestMapping(value="/naverLogin")
	public ModelAndView naverLogin(HttpSession session) {
		String naverUrl = naverLoginApi.getAuthorizationUrl(session);
		mav = new ModelAndView();
		mav.addObject("naverUrl", naverUrl);
		mav.setViewName("member/NaverLogin");
		return mav;
	}
	@RequestMapping(value="/yyskakaoLoginOK")
	public ModelAndView kakaoLoginOK
			(@RequestParam("code") String code, HttpSession session) {
		mav = new ModelAndView();
		JsonNode token = KakaoLoginApi.getAccessToken(code);
		JsonNode profile = KakaoLoginApi.getKakaoUserInfo(token.path("access_token"));
		mav = kakaoService.KakaoLogin(profile);
		return mav;
	}
	@RequestMapping(value="/yysnaverLoginOK")
	public ModelAndView naverLoginOK
		(@RequestParam("code") String code, @RequestParam("state") String state, HttpSession session) throws IOException, ParseException {
		mav = new ModelAndView();
		OAuth2AccessToken oauthToken = naverLoginApi.getAccessToken(session, code, state);
		String profile = naverLoginApi.getUserProfile(oauthToken);
		mav = naverService.naverLogin(profile);
		return mav;
	}
	//======================================================================================//
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main() {
		return "Main";
	}
	
	@RequestMapping(value = "/goMain", method = RequestMethod.GET)
	public String goMain() {
		return "Main";
	}
	
	@RequestMapping(value = "/memberMain", method = RequestMethod.GET)
	public String memberMain() {
		return "member/MemberMain";
	}
	
	@RequestMapping(value = "/termsOfService", method = RequestMethod.GET)
	public String termsOfService() {
		return "member/TermsOfService";
	}
	
	@RequestMapping(value = "/memberJoinForm", method = RequestMethod.GET)
	public String memberJoinForm() {
		return "member/MemberJoinForm";
	}
	
	@RequestMapping(value = "/memberJoinForm2", method = RequestMethod.GET)
	public String memberJoinForm2() {
		return "member/MemberJoinForm2";
	}
	
	@RequestMapping(value="/idOverlap", method=RequestMethod.POST)
	public @ResponseBody String idOverlap(@RequestParam("mid") String mid) {
		String resultMsg = memberService.idOverlap(mid);
		return resultMsg;
	}
	
	@RequestMapping(value="/memberJoin", method = RequestMethod.POST)
	public ModelAndView memberJoin(@ModelAttribute MemberDTO member) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		return mav = memberService.memberJoin(member);
	}
	
	@RequestMapping(value="/memberLoginForm", method = RequestMethod.GET)
	public String memberLoginForm() {
		return "member/MemberLoginForm";
	}
	
	@RequestMapping(value="/memberLogin", method=RequestMethod.POST)
	public ModelAndView memberLogin(@ModelAttribute MemberDTO member) {
		mav = memberService.memberLogin(member);
		return mav;
	}
	
	@RequestMapping(value="/memberLogout", method=RequestMethod.GET)
	public String memberLogout() {
		session.invalidate();
		return "member/MemberLoginForm";
	}
	
	@RequestMapping(value="/memberModifyForm", method=RequestMethod.GET)
	public ModelAndView modifyView() {
		String mid = (String) session.getAttribute("loginId");
		mav = memberService.memberModifyForm(mid);
		return mav;
	}
	
	@RequestMapping(value="/memberModify", method=RequestMethod.POST)
	public ModelAndView memberModify(@ModelAttribute MemberDTO member) {
		mav = memberService.memberModify(member);
		return mav;
	}
	
	@RequestMapping(value="/memberView", method=RequestMethod.GET)
	public ModelAndView memberView(@RequestParam("mid") String mid) {
		mav = memberService.memberView(mid);
		return mav;
	}
	
}
