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
	
	@RequestMapping(value="/sellerJoinForm", method = RequestMethod.GET)
	public String sellerJoinForm() {
		return "member/SellerJoinForm";
	}
	
	@RequestMapping(value="/idOverlap", method=RequestMethod.POST)
	public @ResponseBody String idOverlap(@RequestParam("id") String id) {
		String resultMsg = memberService.idOverlap(id);
		return resultMsg;
	}
	
	@RequestMapping(value="/memberJoin", method = RequestMethod.POST)
	public ModelAndView memberJoin(@ModelAttribute MemberDTO member) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		return mav = memberService.memberJoin(member);
	}
	
	@RequestMapping(value="/sellerJoin", method = RequestMethod.POST)
	public ModelAndView sellerJoin(@ModelAttribute MemberDTO member) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		return mav = memberService.sellerJoin(member);
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
	
	@RequestMapping(value="/myPage", method=RequestMethod.GET)
	public String myPage() {
		return "member/Mypage";
	}
	
	@RequestMapping(value="/memberLoginCheck")
	public @ResponseBody String loginCheck(@RequestParam("id") String id,
											@RequestParam("password") String password,
											@RequestParam("division") int division) {
		String resultMsg = memberService.loginCheck(id, password, division);
		return resultMsg;
	}
	
	@RequestMapping(value="/memberLogout", method=RequestMethod.GET)
	public String memberLogout() {
		session.invalidate();
		return "member/MemberLoginForm";
	}
	
	@RequestMapping(value="/memberModifyForm", method=RequestMethod.GET)
	public ModelAndView modifyView() {
		String id = (String) session.getAttribute("loginId");
		mav = memberService.memberModifyForm(id);
		return mav;
	}
	
	@RequestMapping(value="/sellerModifyForm", method=RequestMethod.GET)
	public ModelAndView sellerModifyView() {
		String id = (String) session.getAttribute("loginId");
		mav = memberService.sellerModifyForm(id);
		return mav;
	}
	
	@RequestMapping(value="/memberModify", method=RequestMethod.POST)
	public ModelAndView memberModify(@ModelAttribute MemberDTO member) throws IllegalStateException, IOException {
		mav = memberService.memberModify(member);
		return mav;
	}
	
	@RequestMapping(value="/sellerModify", method=RequestMethod.POST)
	public ModelAndView sellerModify(@ModelAttribute MemberDTO member) throws IllegalStateException, IOException {
		mav = memberService.sellerModify(member);
		return mav;
	}
	
	@RequestMapping(value="/memberView", method=RequestMethod.GET)
	public ModelAndView memberView(@RequestParam("id") String id) {
		mav = memberService.memberView(id);
		return mav;
	}
	
	@RequestMapping(value="/memberList", method=RequestMethod.GET)
	public ModelAndView memberList() {
		mav = memberService.memberList();
		return mav;
	}
	
	@RequestMapping(value="/memberBlackListAdd", method=RequestMethod.POST)
	public @ResponseBody String memberBlackListAdd(@RequestParam("id") String id) {
		String memberBlackListAdd = memberService.memberBlackListAdd(id);
		return memberBlackListAdd;
	}
	
	@RequestMapping(value="/sellerBlackListAdd", method=RequestMethod.POST)
	public @ResponseBody String sellerBlackListAdd(@RequestParam("id") String id) {
		String sellerBlackListAdd = memberService.sellerBlackListAdd(id);
		return sellerBlackListAdd;
	}
	
	@RequestMapping(value="/memberBlackListDelete", method=RequestMethod.POST)
	public @ResponseBody String memberBlackListDelete(@RequestParam("id") String id) {
		String memberBlackListDelete = memberService.memberBlackListDelete(id);
		return memberBlackListDelete;
	}
	
	@RequestMapping(value="/sellerBlackListDelete", method=RequestMethod.POST)
	public @ResponseBody String sellerBlackListDelete(@RequestParam("id") String id) {
		String sellerBlackListDelete = memberService.sellerBlackListDelete(id);
		return sellerBlackListDelete;
	}
	

	@RequestMapping(value="/memberDeleteForm", method=RequestMethod.GET)
	public String memberDeleteForm() {
		return "member/MemberDeleteForm";
	}
	
	@RequestMapping(value="/sellerDeleteForm", method=RequestMethod.GET)
	public String sellerDeleteForm() {
		return "member/MemberDeleteForm";
	}
	
	@RequestMapping(value="/memberDeleteCheck", method=RequestMethod.POST)
	public @ResponseBody String memberDeleteCheck(@RequestParam("id") String id,
												  @RequestParam("password") String password) {
		String resultMsg = memberService.memberDeleteCheck(id, password);
		return resultMsg;
	}
	
	@RequestMapping(value="/sellerDeleteCheck", method=RequestMethod.POST)
	public @ResponseBody String sellerDeleteCheck(@RequestParam("id") String id,
												  @RequestParam("password") String password) {
		String resultMsg = memberService.sellerDeleteCheck(id, password);
		return resultMsg;
	}
	
	@RequestMapping(value="/memberDelete")
	public ModelAndView memberDelete(@RequestParam("id") String id) {
		mav = memberService.memberDelete(id);
		return mav;
	}
	
	@RequestMapping(value="/sellerDelete")
	public ModelAndView sellerDelete(@RequestParam("id") String id) {
		mav = memberService.sellerDelete(id);
		return mav;
	}
	
	@RequestMapping(value = "/memberAttendance", method = RequestMethod.GET)
	public ModelAndView memberAttendance() {
		String id = (String) session.getAttribute("loginId");
		mav = memberService.memberAttendance(id);
		return mav;
	}
	
	@RequestMapping(value = "/memberAttendanceCheck")
	public ModelAndView memberAttendanceCheck(@RequestParam("att_date") int att_date) {
		String id = (String) session.getAttribute("loginId");
		mav = memberService.memberAttendanceCheck(id, att_date);
		return mav;
	}
	
	
}
