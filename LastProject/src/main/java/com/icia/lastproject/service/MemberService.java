package com.icia.lastproject.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.icia.lastproject.dao.MemberDAO;
import com.icia.lastproject.dto.MemberDTO;
import com.icia.lastproject.dto.ProductReportDTO;


@Service
public class MemberService {

	@Autowired
	private BCryptPasswordEncoder passEncoder;
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private MemberDAO mdao;
	
	private ModelAndView mav;
	
	public ModelAndView memberJoin(MemberDTO member) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		MultipartFile file = member.getFile();
		String profile = file.getOriginalFilename();
		String savePath = "C:\\Users\\8\\Desktop\\LastProject\\src\\main\\webapp\\resources\\profilepic\\"+profile;
		if(!file.isEmpty()) {
			file.transferTo(new File(savePath));
		}
		member.setProfile(profile);
		String address = member.getAddress1()+"/"+member.getAddress2()+"/"+member.getAddress3()+"/"+member.getAddress4();
		member.setAddress(address);
		int memberSignUpResult = mdao.memberJoin(member);
		if(memberSignUpResult > 0) {
			mav.setViewName("member/MemberJoinSuccess");
		} else {
			mav.setViewName("member/MemberSignUpFail");
		}
		return mav;
	}
	
	public String idOverlap(String id) {
		String checkResult = mdao.idOverlap(id);
		String resultMsg = null;
		if(checkResult==null) {
			resultMsg = "OK";
		} else {
			resultMsg = "NO";
		}
		return resultMsg;
	}

	public ModelAndView googleLogin(String googleId, String googleEmail, String url) {
		mav = new ModelAndView();
		String name = null;
		String loginId = mdao.googleLogin(googleId);
		if(loginId==null) {
			mav.setViewName("member/MemberJoinAsk");
			return mav;
		} else {
			MemberDTO googleName = mdao.memberView(googleEmail);
			name = googleName.getName();
			session.setAttribute("loginId", googleEmail);
			session.setAttribute("name", name);
			session.setAttribute("googleId", googleId);
		}
		return new ModelAndView("redirect:"+url);
	}

	public ModelAndView facebookLogin(String facebookId, String facebookEmail, String url) {
		mav = new ModelAndView();
		String name = null;
		String loginId = mdao.facebookLogin(facebookId);
		if(loginId==null) {
			mav.setViewName("member/MemberJoinAsk");
			return mav;
		} else {
			MemberDTO facebookName = mdao.memberView(facebookEmail);
			name = facebookName.getName();
			session.setAttribute("loginId", facebookEmail);
			session.setAttribute("name", name);
			session.setAttribute("facebookId", facebookId);
		}
		return new ModelAndView("redirect:"+url);
	}

	public ModelAndView memberLogin(MemberDTO member, String url) throws IOException {
		mav = new ModelAndView();
		MemberDTO loginMember = mdao.loginMember(member);
		String loginId = null;
		String name = null;
		int loginIdDivision = 0;
		String id = member.getId();
		MemberDTO memberView = mdao.memberView(id);
		MemberDTO sellerView = mdao.sellerView(id);
		String blackMemberCheckResult = mdao.blackMemberCheck(id);
		if(blackMemberCheckResult != null) {
			mav.setViewName("member/BlackMember");
			return mav;
		}
		if(member.getDivision()==2) {
			loginId = mdao.sellerLogin(member);
			loginIdDivision = mdao.sellerIdDivision(member);
//			MemberDTO sellerName = mdao.sellerView(id);
			name = sellerView.getName();
			String sellerDate = mdao.sellerDate(id);
			if(sellerDate != null) {
				session.setAttribute("name", name);
				session.setAttribute("loginId", loginId);
				session.setAttribute("loginIdDivision", loginIdDivision);
				session.setAttribute("seller", sellerView);
				mav.addObject("seller", sellerView);
				mav.setViewName("member/PasswordChangePlease");
				return mav;
			}
		} else if(passEncoder.matches(member.getPassword(),loginMember.getPassword())) {
			if(member.getDivision()==1){
			loginId = mdao.memberLogin(member);
			loginIdDivision = mdao.memberIdDivision(member);
//			MemberDTO memberName = mdao.memberView(id);
			name = memberView.getName();
			String memberDate = mdao.memberDate(id);
			if(memberDate != null) {
				session.setAttribute("name", name);
				session.setAttribute("loginId", loginId);
				session.setAttribute("loginIdDivision", loginIdDivision);
				session.setAttribute("member", memberView);
				mav.addObject("member", memberView);
				mav.setViewName("member/PasswordChangePlease");
				return mav;
			}
		}
		}
		if(loginId!=null) {
			session.setAttribute("name", name);
			session.setAttribute("loginId", loginId);
			session.setAttribute("loginIdDivision", loginIdDivision);
			session.setAttribute("member", memberView);
			session.setAttribute("seller", sellerView);
		} else {
			mav.setViewName("member/MemberLoginFail");
		}
		//url은 로그인폼으로 돌아가는건데 로그인폼 jsp에 history(-1) 입력해서 그 전페이지로 돌아감 
		return new ModelAndView("redirect:"+url);
	}
	
	public ModelAndView memberModifyForm(String id) {
		mav = new ModelAndView();
		MemberDTO memberModify = mdao.memberView(id);
		String address = memberModify.getAddress();
		String[] array = address.split("/");
		memberModify.setAddress1(array[0]);
		memberModify.setAddress2(array[1]);
		memberModify.setAddress3(array[2]);
		memberModify.setAddress4(array[3]);
		mav.addObject("memberModify", memberModify);
		mav.setViewName("member/MemberModifyForm");
		return mav;
	}
	public ModelAndView sellerModifyForm(String id) {
		mav = new ModelAndView();
		MemberDTO sellerModify = mdao.sellerView(id);
		String address = sellerModify.getAddress();
		String[] array = address.split("/");
		sellerModify.setAddress1(array[0]);
		sellerModify.setAddress2(array[1]);
		sellerModify.setAddress3(array[2]);
		sellerModify.setAddress4(array[3]);
		mav.addObject("sellerModify", sellerModify);
		mav.setViewName("member/SellerModifyForm");
		return mav;
	}
	public ModelAndView memberModify(MemberDTO member) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		MultipartFile file = member.getFile();
		String profile = file.getOriginalFilename();
		String savePath = "C:\\Users\\8\\Desktop\\LastProject\\src\\main\\webapp\\resources\\profilepic\\"+profile;
		if(!file.isEmpty()) {
			file.transferTo(new File(savePath));
			member.setProfile(profile);
		}
		member.setAddress(member.getAddress1()+"/"+member.getAddress2()+"/"+member.getAddress3()+"/"+member.getAddress4());
		int memberModifyResult = mdao.memberModify(member);
		if(memberModifyResult > 0) {
			String name = member.getName();
			session.setAttribute("name", name);
			mav.setViewName("member/MemberModifySuccess");
		} else {
			mav.setViewName("member/MemberModifyFail");
		}
		return mav;
	}
	
	public ModelAndView sellerModify(MemberDTO member) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		MultipartFile file = member.getFile();
		String profile = file.getOriginalFilename();
		String savePath = "C:\\Users\\8\\Desktop\\LastProject\\src\\main\\webapp\\resources\\profilepic\\"+profile;
		if(!file.isEmpty()) {
			file.transferTo(new File(savePath));
			member.setProfile(profile);
		}
		member.setAddress(member.getAddress1()+"/"+member.getAddress2()+"/"+member.getAddress3()+"/"+member.getAddress4());
		int sellerModifyResult = mdao.sellerModify(member);
		if(sellerModifyResult > 0) {
			mav.setViewName("member/MemberModifySuccess");
		} else {
			mav.setViewName("member/MemberModifyFail");
		}
		return mav;
	}
	
	public ModelAndView memberView(String id) {
		mav = new ModelAndView();
		MemberDTO memberView = mdao.memberView(id);
		MemberDTO sellerView = mdao.sellerView(id);
		mav.addObject("memberView", memberView);
		mav.addObject("sellerView", sellerView);
		mav.setViewName("member/MemberView");
		return mav;
	}
	
	public ModelAndView memberList() {
		mav = new ModelAndView();
		List<MemberDTO> memberList = mdao.memberList();
		List<MemberDTO> sellerList = mdao.sellerList();
		List<MemberDTO> memberBlackList = mdao.memberBlackList();
		List<MemberDTO> sellerBlackList = mdao.sellerBlackList();
		mav.addObject("memberList", memberList);
		mav.addObject("sellerList", sellerList);
		mav.addObject("memberBlackList", memberBlackList);
		mav.addObject("sellerBlackList", sellerBlackList);
		mav.setViewName("member/MemberList");
		return mav;
	}
	
	public ModelAndView reportList() {
		mav = new ModelAndView();
		List<ProductReportDTO> reportList = mdao.reportList();
		mav.addObject("reportList", reportList);
		mav.setViewName("member/ReportList");
		return mav;
	}

	public ModelAndView sellerJoin(MemberDTO member) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		MultipartFile file = member.getFile();
		String profile = file.getOriginalFilename();
		String savePath = "C:\\Users\\8\\Desktop\\LastProject\\src\\main\\webapp\\resources\\profilepic\\"+profile;
		if(!file.isEmpty()) {
			file.transferTo(new File(savePath));
		}
		member.setProfile(profile);
		String address = member.getAddress1()+"/"+member.getAddress2()+"/"+member.getAddress3()+"/"+member.getAddress4();
		member.setAddress(address);
		int memberSignUpResult = mdao.sellerJoin(member);
		if(memberSignUpResult > 0) {
			mav.setViewName("member/MemberJoinSuccess");
		} else {
			mav.setViewName("member/MemberSignUpFail");
		}
		return mav;
	}

	public String memberLoginCheck(MemberDTO member, String id, String password, int division) {
		String loginId = null;
		String resultMsg = null;
		MemberDTO loginMember = mdao.loginMember(member);
		HashMap<String, Object> hash = new HashMap<String, Object>();
		hash.put("id", id);
		if(loginMember!=null) {
		if(passEncoder.matches(password, loginMember.getPassword())) {
			loginId = mdao.memberLoginCheck(hash);
			if(loginId != null) {
				resultMsg = "OK";
			} else {
				resultMsg = "NO";
			}
		}
		} else {
			resultMsg = "NO";
		}
		return resultMsg;
	}
	
	public String sellerLoginCheck(MemberDTO member, String id, String password, int division) {
		String loginId = null;
		String resultMsg = null;
		MemberDTO loginSeller = mdao.loginSeller(member);
		HashMap<String, Object> hash = new HashMap<String, Object>();
		hash.put("id", id);
		if(loginSeller!=null) {
		if(passEncoder.matches(password, loginSeller.getPassword())) {
			loginId = mdao.sellerLoginCheck(hash);
		}
		if(loginId!=null) {
			resultMsg = "OK";
		} else {
			resultMsg = "NO";
		}
		} else {
			resultMsg = "NO";
		}
		return resultMsg;
	}
	
	public String memberBlackListAdd(String id) {
		int memberBlackListAddResult = mdao.memberBlackListAdd(id);
		String ResultMsg = null;
		if(memberBlackListAddResult > 0) {
			ResultMsg = "OK";
		} else {
			ResultMsg = "NO";
		}
		return ResultMsg;
	}
	
	public String sellerBlackListAdd(String id) {
		int sellerBlackListAddResult = mdao.sellerBlackListAdd(id);
		String ResultMsg = null;
		if(sellerBlackListAddResult > 0) {
			ResultMsg = "OK";
		} else {
			ResultMsg = "NO";
		}
		return ResultMsg;
	}
	public String reportSellerBlackListAdd(String id) {
		int reportSellerBlackListAddResult = mdao.sellerBlackListAdd(id);
		String ResultMsg = null;
		if(reportSellerBlackListAddResult > 0) {
			mdao.deleteSellerProductReport(id);
			ResultMsg = "OK";
		} else {
			ResultMsg = "NO";
		}
		return ResultMsg;
	}
	
	public String memberBlackListDelete(String id) {
		int memberBlackListDeleteResult = mdao.memberBlackListDelete(id);
		String ResultMsg = null;
		if(memberBlackListDeleteResult > 0) {
			ResultMsg = "OK";
		} else {
			ResultMsg = "NO";
		}
		return ResultMsg;
	}
	
	public String sellerBlackListDelete(String id) {
		int sellerBlackListDeleteResult = mdao.sellerBlackListDelete(id);
		String ResultMsg = null;
		if(sellerBlackListDeleteResult > 0) {
			ResultMsg = "OK";
		} else {
			ResultMsg = "NO";
		}
		return ResultMsg;
	}

//	public String sellerDeleteCheck(String id, String password) {
//		HashMap<String, Object> hash = new HashMap<String, Object>();
//		hash.put("id", id);
//		hash.put("password", password);
//		String sellerDeleteCheckResult = mdao.sellerDeleteCheckResult(hash);
//		String ResultMsg = null;
//		if(sellerDeleteCheckResult != null) {
//			ResultMsg = "OK";
//		} else {
//			ResultMsg = "NO";
//		}
//		return ResultMsg;
//	}
//
//	public String memberDeleteCheck(String id, String password) {
//		HashMap<String, Object> hash = new HashMap<String, Object>();
//		hash.put("id", id);
//		hash.put("password", password);
//		String memberDeleteCheckResult = mdao.memberDeleteCheckResult(hash);
//		String ResultMsg = null;
//		if(memberDeleteCheckResult != null) {
//			ResultMsg = "OK";
//		} else {
//			ResultMsg = "NO";
//		}
//		return ResultMsg;
//	}

	public String memberDelete(MemberDTO member, String id, String password) {
		String resultMsg = null;
		MemberDTO loginMember = mdao.loginMember(member);
		if(passEncoder.matches(member.getPassword(),loginMember.getPassword())) {
		int memberDeleteResult = mdao.memberDelete(id);
		if(memberDeleteResult > 0) {
			session.invalidate();
			resultMsg = "OK";
		} else {
			resultMsg = "NO";
		}
		}
		return resultMsg;
	}

	public String sellerDelete(MemberDTO member, String id, String password) {
		String resultMsg = null;
		MemberDTO loginSeller = mdao.loginSeller(member);
		if(passEncoder.matches(member.getPassword(),loginSeller.getPassword())) {
		int sellerDeleteResult = mdao.sellerDelete(id);
		if(sellerDeleteResult > 0) {
			session.invalidate();
			resultMsg = "OK";
		} else {
			resultMsg = "NO";
		}
		}
		return resultMsg;
	}

	public ModelAndView memberIdFind(String name, String birth, String phone) {
		mav = new ModelAndView();
		MemberDTO member = new MemberDTO();
		member.setName(name);
		member.setBirth(birth);
		member.setPhone(phone);
		String memberIdFindResult = mdao.memberIdFind(member);
		if(memberIdFindResult != null) {
			mav.addObject("idFind", memberIdFindResult);
			mav.setViewName("member/IdFindSuccess");
		} else {
			mav.setViewName("member/IdFindFail");
		}
		return mav;
	}
	
	public ModelAndView sellerIdFind(String s_name, String s_number, String name) {
		mav = new ModelAndView();
		MemberDTO seller = new MemberDTO();
		seller.setS_name(s_name);
		seller.setS_number(s_number);
		seller.setName(name);
		String sellerIdFindResult = mdao.sellerIdFind(seller);
		if(sellerIdFindResult != null) {
			mav.addObject("idFind", sellerIdFindResult);
			mav.setViewName("member/IdFindSuccess");
		} else {
			mav.setViewName("member/IdFindFail");
		}
		return mav;
	}
	
	public ModelAndView memberPasswordModifyForm(String id) {
		mav = new ModelAndView();
		mav.addObject("findEmail", id);
		mav.setViewName("member/PasswordFindForm2");
		return mav;
	}

	public ModelAndView sellerPasswordModifyForm(String id) {
		mav = new ModelAndView();
		mav.addObject("findEmail", id);
		mav.setViewName("member/SellerPasswordModifyForm");
		return mav;
	}
	
	public ModelAndView newPassword(MemberDTO member, String id, String password) {
		mav = new ModelAndView();
		HashMap<String, Object> hash = new HashMap<String, Object>();
		String newPassword = member.getPassword();
		hash.put("id", id);
		hash.put("password", newPassword);
		int newPasswordResult = mdao.newPassword(hash);
		if(newPasswordResult > 0) {
			mav.setViewName("member/NewPasswordSuccess");
		} else {
			mav.setViewName("member/NewPasswordFail");
		}
		return mav;
	}

	public ModelAndView newSellerPassword(MemberDTO member, String id, String password) {
		mav = new ModelAndView();
		HashMap<String, Object> hash = new HashMap<String, Object>();
		String sellerNewpassword = member.getPassword();
		hash.put("id", id);
		hash.put("password", sellerNewpassword);
		int newSellerPasswordResult = mdao.newSellerPassword(hash);
		if(newSellerPasswordResult > 0) {
			mav.setViewName("member/NewPasswordSuccess");
		} else {
			mav.setViewName("member/NewPasswordFail");
		}
		return mav;
	}
	
	public String emailCheck(String id) {
		String emailCheckResult = mdao.emailCheck(id);
		String resultMsg = null;
		if(emailCheckResult!=null) {
			resultMsg = "OK";
		} else {
			resultMsg = "NO";
		}
		return resultMsg;
	}

	public ModelAndView adminMemberDelete(String id) {
		mav = new ModelAndView();
		int memberDeleteResult = mdao.memberDelete(id);
		if(memberDeleteResult > 0) {
			mav.setViewName("redirect:/memberList");
		} else {
			mav.setViewName("member/adminMemberDeleteFail");
		}
		return mav;
	}

	public ModelAndView adminSellerDelete(String id) {
		mav = new ModelAndView();
		int sellerDeleteResult = mdao.sellerDelete(id);
		if(sellerDeleteResult > 0) {
			mav.setViewName("redirect:/memberList");
		} else {
			mav.setViewName("member/adminSellerDeleteFail");
		}
		return mav;
	}
	
	public ModelAndView memberOldPasswordChange(String id, String password) {
		mav = new ModelAndView();
		HashMap<String, Object> hash = new HashMap<String, Object>();
		hash.put("id", id);
		hash.put("password", password);
		int memberOldPasswordChangeResult = mdao.memberOldPasswordChange(hash);
		if(memberOldPasswordChangeResult > 0) {
			mav.setViewName("member/memberOldPasswordChangeSuccess");
		} else {
			mav.setViewName("member/memberOldPasswordChangeFail");
		}
		return mav;
	}
	
	public ModelAndView sellerOldPasswordChange(String id, String password) {
		mav = new ModelAndView();
		HashMap<String, Object> hash = new HashMap<String, Object>();
		hash.put("id", id);
		hash.put("password", password);
		int sellerOldPasswordChangeResult = mdao.sellerOldPasswordChange(hash);
		if(sellerOldPasswordChangeResult > 0) {
			mav.setViewName("member/memberOldPasswordChangeSuccess");
		} else {
			mav.setViewName("member/memberOldPasswordChangeFail");
		}
		return mav;
	}
	
	public ModelAndView test() {
		mav = new ModelAndView();
		mav.setViewName("member/Test");
		return mav;
	}

	public String reportDelete(String sellerId, int productno, String trade_name, String reporttype) {
		String resultMsg = null;
		ProductReportDTO productReport = new ProductReportDTO();
		productReport.setSellerId(sellerId);
		productReport.setProductno(productno);
		productReport.setTrade_name(trade_name);
		productReport.setReporttype(reporttype);
		int reportDeleteResult = mdao.reportDelete(productReport);
		if(reportDeleteResult > 0) {
			resultMsg = "OK";
		} else {
			resultMsg = "NO";
		}
		return resultMsg;
	}



	

	

	

	


	
	
}
