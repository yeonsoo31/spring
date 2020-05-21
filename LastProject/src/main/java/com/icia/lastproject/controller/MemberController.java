package com.icia.lastproject.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	@Autowired
	private BCryptPasswordEncoder passEncoder;
	
	private ModelAndView mav;
	
	//================================== Email Authentication ==============================//
	@Inject
	JavaMailSender mailSender;
	//로깅을 위한 변수
    private static final Logger logger=
    LoggerFactory.getLogger(MemberController.class);
    private static final String String = null;
    
 // mailSending 코드
    @RequestMapping(value="/auth.do", method=RequestMethod.POST)
    public ModelAndView mailSending(HttpServletRequest request, String e_mail, HttpServletResponse response_email) throws IOException {
        Random r = new Random();
        int dice = r.nextInt(4589362) + 49311; //이메일로 받는 인증코드 부분 (난수)
        String setfrom = "plusyys33@gmail.com";
        String tomail = request.getParameter("id"); // 받는 사람 이메일
        String title = "회원가입 인증 이메일 입니다."; // 제목
        String content =
        System.getProperty("line.separator")+ //한줄씩 줄간격을 두기위해 작성
        System.getProperty("line.separator")+
        "안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"
        +System.getProperty("line.separator")+
        System.getProperty("line.separator")+
        " 인증번호는 " +dice+ " 입니다. "
        +System.getProperty("line.separator")+
        System.getProperty("line.separator")+
        "받으신 인증번호를 홈페이지에 입력해 주시면 다음으로 넘어갑니다."; // 내용
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message,
                    true, "UTF-8");
            messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
            messageHelper.setTo(tomail); // 받는사람 이메일
            messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
            messageHelper.setText(content); // 메일 내용
            mailSender.send(message);
        } catch (Exception e) {
            System.out.println(e);
        }
        ModelAndView mv = new ModelAndView();    //ModelAndView로 보낼 페이지를 지정하고, 보낼 값을 지정한다.
        mv.addObject("findEmail", tomail); // EmailAnumber로 가져갈 이메일 값
        mv.setViewName("member/EmailAnumber");     //뷰의이름
        mv.addObject("dice", dice);
        System.out.println("mv : "+mv);
        response_email.setContentType("text/html; charset=UTF-8");
        PrintWriter out_email = response_email.getWriter();
        out_email.println("<script>alert('이메일이 발송되었습니다. 인증번호를 입력해주세요.');</script>");
        out_email.flush();
        return mv;
    }
//이메일 인증 페이지 맵핑 메소드
    	@RequestMapping("/email.do")
    		public String email() {
   			return "member/PasswordFindForm";
    	}
//이메일로 받은 인증번호를 입력하고 전송 버튼을 누르면 맵핑되는 메소드.
//내가 입력한 인증번호와 메일로 입력한 인증번호가 맞는지 확인해서 맞으면 회원가입 페이지로 넘어가고,
//틀리면 다시 원래 페이지로 돌아오는 메소드
@RequestMapping(value = "/join_injeung.do{dice}", method = RequestMethod.POST)
public ModelAndView join_injeung(@RequestParam("id") String findEmail, String email_injeung, @PathVariable String dice, HttpServletResponse response_equals) throws IOException {    
    System.out.println("마지막 : email_injeung : "+email_injeung);
    System.out.println("마지막 : dice : "+dice);
    //페이지이동과 자료를 동시에 하기위해 ModelAndView를 사용해서 이동할 페이지와 자료를 담음
    ModelAndView mv = new ModelAndView();
    mv.setViewName("member/PasswordFindForm");
    mv.addObject("id",email_injeung);
    if (email_injeung.equals(dice)) {
        //인증번호가 일치할 경우 인증번호가 맞다는 창을 출력하고 회원가입창으로 이동함
    	mv.addObject("findEmail", findEmail);
    	mv.setViewName("member/PasswordFindForm2");
        mv.addObject("id",email_injeung);
        //만약 인증번호가 같다면 이메일을 회원가입 페이지로 같이 넘겨서 이메일을
        //한번더 입력할 필요가 없게 한다.
        response_equals.setContentType("text/html; charset=UTF-8");
        PrintWriter out_equals = response_equals.getWriter();
        out_equals.println("<script>alert('인증번호가 일치하였습니다. 비밀번호 설정창으로 이동합니다.');</script>");
        out_equals.flush();
        return mv;        
    }else if (email_injeung != dice) {
        ModelAndView mv2 = new ModelAndView(); 
        mv2.setViewName("member/EmailAnumber");
        response_equals.setContentType("text/html; charset=UTF-8");
        PrintWriter out_equals = response_equals.getWriter();
        out_equals.println("<script>alert('인증번호가 일치하지않습니다. 인증번호를 다시 입력해주세요.');</script>");//history.go(-1);
        out_equals.flush();
        return mv2;
    	}
    return mv;
	}
	//================================== Email Authentication ==============================//
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
			@RequestParam("googleEmail") String googleEmail,
			@RequestParam("url") String url) {
		mav = new ModelAndView();
		return mav = memberService.googleLogin(googleId, googleEmail, url);
	}
	@RequestMapping(value="facebookLogin", method = RequestMethod.GET)
	public ModelAndView facebookLogin(
			@RequestParam("facebookId") String facebookId,
			@RequestParam("facebookEmail") String facebookEmail,
			@RequestParam("url") String url) {
		mav = new ModelAndView();
		return mav = memberService.facebookLogin(facebookId, facebookEmail, url);
	}
	@RequestMapping(value="/kakaoLogin", method=RequestMethod.GET)
	public ModelAndView kakaoLogin(HttpSession session, @RequestParam("url") String url) {
		session.setAttribute("url", url);
		String kakaoUrl = KakaoLoginApi.getAuthorizationUrl(session);
		mav = new ModelAndView();
		mav.addObject("kakaoUrl", kakaoUrl);
		mav.setViewName("member/KakaoLogin");
		return mav;
	}
	@RequestMapping(value="/naverLogin")
	public ModelAndView naverLogin(HttpSession session, @RequestParam("url") String url) {
		session.setAttribute("url", url);
		String naverUrl = naverLoginApi.getAuthorizationUrl(session);
		mav = new ModelAndView();
		mav.addObject("naverUrl", naverUrl);
		mav.setViewName("member/NaverLogin");
		return mav;
	}
	@RequestMapping(value="/yyskakaoLoginOK")
	public ModelAndView kakaoLoginOK
			(@RequestParam("code") String code, HttpSession session, String url) {
		mav = new ModelAndView();
		url = (java.lang.String) session.getAttribute("url");
		JsonNode token = KakaoLoginApi.getAccessToken(code);
		JsonNode profile = KakaoLoginApi.getKakaoUserInfo(token.path("access_token"));
		mav = kakaoService.KakaoLogin(profile, url);
		return mav;
	}
	@RequestMapping(value="/yysnaverLoginOK")
	public ModelAndView naverLoginOK
		(@RequestParam("code") String code, @RequestParam("state") String state, HttpSession session, String url) throws IOException, ParseException {
		mav = new ModelAndView();
		url = (java.lang.String) session.getAttribute("url");
		OAuth2AccessToken oauthToken = naverLoginApi.getAccessToken(session, code, state);
		String profile = naverLoginApi.getUserProfile(oauthToken);
		mav = naverService.naverLogin(profile, url);
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
		String encPassword = passEncoder.encode(member.getPassword());
		member.setPassword(encPassword);
		System.out.println("암호화 비번 확인 : "+ member.getPassword());
		return mav = memberService.memberJoin(member);
	}
	
	@RequestMapping(value="/sellerJoin", method = RequestMethod.POST)
	public ModelAndView sellerJoin(@ModelAttribute MemberDTO member) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		return mav = memberService.sellerJoin(member);
	}
	
	@RequestMapping(value="/memberLoginForm", method = RequestMethod.GET)
	public ModelAndView memberLoginForm(HttpServletRequest request) {
		mav = new ModelAndView();
		String url = request.getHeader("Referer");
		mav.addObject("url", url);
		mav.setViewName("member/MemberLoginForm");
		return mav;
	}
	
	@RequestMapping(value="/memberLogin", method=RequestMethod.POST)
	public ModelAndView memberLogin(@ModelAttribute MemberDTO member,
									@RequestParam("url") String url) throws java.text.ParseException, IOException {
		mav = memberService.memberLogin(member, url);
		return mav;
	}
	
	@RequestMapping(value="/myPage", method=RequestMethod.GET)
	public String myPage() {
		return "member/Mypage";
	}
	
	@RequestMapping(value="/memberLoginCheck")
	public @ResponseBody String loginCheck( @ModelAttribute MemberDTO member,
											@RequestParam("id") String id,
											@RequestParam("password") String password,
											@RequestParam("division") int division) {
		String resultMsg = memberService.loginCheck(member, id, password, division);
		return resultMsg;
	}
	
	@RequestMapping(value="/memberLogout", method=RequestMethod.GET)
	public String memberLogout() {
		session.invalidate();
		return "redirect:/memberLoginForm";
	}
	
	@RequestMapping(value="/memberModifyForm", method=RequestMethod.GET)
	public ModelAndView modifyView() {
		String id = (String) session.getAttribute("loginId");
		if(id==null) {
			mav.setViewName("member/MemberLoginForm");
		} else {
			mav = memberService.memberModifyForm(id);
		}
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
	
	@RequestMapping(value="/reportList", method=RequestMethod.GET)
	public ModelAndView reportList() {
		mav = memberService.reportList();
		return mav;
	}
	
	@RequestMapping(value="/reportDelete", method=RequestMethod.POST)
	public @ResponseBody String reportDelete(@RequestParam("sellerId") String sellerId,
									 @RequestParam("productno") int productno,
									 @RequestParam("trade_name") String trade_name,
									 @RequestParam("reporttype") String reporttype) {
		String resultMsg = memberService.reportDelete(sellerId, productno, trade_name, reporttype);
		return resultMsg;
	}
	
	@RequestMapping(value="/reportSellerBlackListAdd", method=RequestMethod.POST)
	public @ResponseBody String reportSellerBlackListAdd(@RequestParam("id") String id) {
		String reportSellerBlackListAdd = memberService.reportSellerBlackListAdd(id);
		return reportSellerBlackListAdd;
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
	
	@RequestMapping(value="/idFindForm")
	public String idFindForm() {
		return "member/IdFindForm";
	}
	
	@RequestMapping(value="/passwordFindForm")
	public String passwordFindForm() {
		return "member/PasswordFindForm";
	}
	
	@RequestMapping(value="/memberIdFind")
	public ModelAndView memberIdFind(String name, String birth, String phone) {
		mav = memberService.memberIdFind(name, birth, phone);
		return mav;
	}
	
	@RequestMapping(value="/sellerIdFind")
	public ModelAndView sellerIdFind(String s_name, String s_number, String name) {
		mav = memberService.sellerIdFind(s_name, s_number, name);
		return mav;
	}
	
	@RequestMapping(value="/emailCheck")
	public @ResponseBody String emailCheck(@RequestParam("id") String id) {
		String resultMsg = memberService.emailCheck(id);
		return resultMsg;
	}
	
	@RequestMapping(value="/newPassword", method=RequestMethod.POST)
	public ModelAndView newPassword(@RequestParam("id") String id,
									@RequestParam("password") String password) {
		mav = memberService.newPassword(id, password);
		return mav;
	}
	
	@RequestMapping(value="/adminMemberDelete")
	public ModelAndView adminMemberDelete(@RequestParam("id") String id) {
		mav = memberService.adminMemberDelete(id);
		return mav;
	}
	
	@RequestMapping(value="/adminSellerDelete")
	public ModelAndView adminSellerDelete(@RequestParam("id") String id) {
		mav = memberService.adminSellerDelete(id);
		return mav;
	}
	
	@RequestMapping(value="/memberPasswordModifyForm")
	public ModelAndView memberPasswordModifyForm() {
		String id = (String) session.getAttribute("loginId");
		mav = memberService.memberPasswordModifyForm(id);
		return mav;
	}
	
	@RequestMapping(value="/sellerPasswordModifyForm")
	public ModelAndView sellerPasswordModifyForm() {
		String id = (String) session.getAttribute("loginId");
		mav = memberService.sellerPasswordModifyForm(id);
		return mav;
	}
	
	@RequestMapping(value="/newSellerPassword")
	public ModelAndView newSellerPassword(@RequestParam("id") String id,
										  @RequestParam("password") String password) {
		mav = memberService.newSellerPassword(id, password);
		return mav;
	}
	
	@RequestMapping(value="/memberOldPasswordChange", method=RequestMethod.POST)
	public ModelAndView memberOldPasswordChange(@RequestParam("id") String id,
									@RequestParam("password") String password) {
		mav = memberService.memberOldPasswordChange(id, password);
		return mav;
	}
	
	@RequestMapping(value="/sellerOldPasswordChange", method=RequestMethod.POST)
	public ModelAndView sellerOldPasswordChange(@RequestParam("id") String id,
									@RequestParam("password") String password) {
		mav = memberService.sellerOldPasswordChange(id, password);
		return mav;
	}
	
	@RequestMapping(value="/test")
	public ModelAndView test() {
		mav = memberService.test();
		return mav;
	}
}
