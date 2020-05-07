package com.icia.lastproject.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.icia.lastproject.dao.MemberDAO;
import com.icia.lastproject.dto.MemberDTO;


@Service
public class MemberService {

	@Autowired
	private HttpSession session;
	
	@Autowired
	private MemberDAO mdao;
	
	private ModelAndView mav;
	
	public ModelAndView memberJoin(MemberDTO member) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		MultipartFile file = member.getFile();
		String profile = file.getOriginalFilename();
		String savePath = "C:\\Users\\7\\git\\springgit\\Spring\\LastProject\\src\\main\\webapp\\resources\\profilepic\\"+profile;
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

	public ModelAndView googleLogin(String googleId, String googleEmail) {
		mav = new ModelAndView();
		String loginId = mdao.googleLogin(googleId);
		if(loginId==null) {
			mav.setViewName("member/MemberJoinAsk");
		} else {
			session.setAttribute("loginId", googleEmail);
			mav.setViewName("member/MemberMain");
		}
		return mav;
	}

	public ModelAndView facebookLogin(String facebookId, String facebookEmail) {
		mav = new ModelAndView();
		String loginId = mdao.facebookLogin(facebookId);
		if(loginId==null) {
			mav.setViewName("member/MemberJoinAsk");
		} else {
			session.setAttribute("loginId", facebookEmail);
			mav.setViewName("member/MemberMain");
		}
		return mav;
	}

	public ModelAndView memberLogin(MemberDTO member) {
		mav = new ModelAndView();
		String loginId = null;
		int loginIdDivision = 0;
		if(member.getDivision()==1) {
			loginId = mdao.memberLogin(member);
			loginIdDivision = mdao.memberIdDivision(member);
		} else {
			loginId = mdao.sellerLogin(member);
			loginIdDivision = mdao.sellerIdDivision(member);
		}
		if(loginId!=null) {
			session.setAttribute("loginId", loginId);
			session.setAttribute("loginIdDivision", loginIdDivision);
			mav.setViewName("member/MemberMain");
		} else {
			mav.setViewName("member/MemberLoginFail");
		}
		return mav;
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
		String savePath = "C:\\Users\\7\\git\\springgit\\Spring\\LastProject\\src\\main\\webapp\\resources\\profilepic\\"+profile;
		if(!file.isEmpty()) {
			file.transferTo(new File(savePath));
			member.setProfile(profile);
		}
		member.setAddress(member.getAddress1()+"/"+member.getAddress2()+"/"+member.getAddress3()+"/"+member.getAddress4());
		int memberModifyResult = mdao.memberModify(member);
		if(memberModifyResult > 0) {
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
		String savePath = "C:\\Users\\7\\git\\springgit\\Spring\\LastProject\\src\\main\\webapp\\resources\\profilepic\\"+profile;
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
	
	public ModelAndView memberAttendance(String id) {
		mav = new ModelAndView();
		MemberDTO memberAttendance = mdao.memberAttendance(id);
		mav.addObject("memberAttendance", memberAttendance);
		mav.setViewName("member/MemberAttendance2");
		return mav;
	}

	public ModelAndView memberAttendanceCheck(String id, int att_date) {
		mav = new ModelAndView();
		MemberDTO member = new MemberDTO();
		member.setId(id);
		member.setAtt_date(att_date);
		int memberAttendanceCheckResult = mdao.memberAttendanceCheck(member);
		if(memberAttendanceCheckResult > 0) {
			mav.setViewName("member/MemberAttendance2");
		} else {
			mav.setViewName("member/MemberAttendanceFail");
		}
		return mav;
	}

	public ModelAndView sellerJoin(MemberDTO member) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		MultipartFile file = member.getFile();
		String profile = file.getOriginalFilename();
		String savePath = "C:\\Users\\7\\git\\springgit\\Spring\\LastProject\\src\\main\\webapp\\resources\\profilepic\\"+profile;
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

	public String loginCheck(String id, String password, int division) {
		String loginId = null;
		String resultMsg = null;
		HashMap<String, Object> hash = new HashMap<String, Object>();
		hash.put("id", id);
		hash.put("password", password);
		if(division==2) {
			loginId = mdao.sellerLoginCheck(hash);
		} else {
			loginId = mdao.memberLoginCheck(hash);
		}
		if(loginId != null) {
			resultMsg = "OK";
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



	
	
}
