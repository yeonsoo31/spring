package com.icia.lastproject.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
		String loginId = mdao.memberLogin(member);
		if(loginId!=null) {
			session.setAttribute("loginId", loginId);
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
	
	public ModelAndView memberModify(MemberDTO member) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		MultipartFile file = member.getFile();
		String profile = file.getOriginalFilename();
		String savePath = "C:\\Users\\7\\git\\springgit\\Spring\\LastProject\\src\\main\\webapp\\resources\\profilepic\\"+profile;
		if(!file.isEmpty()) {
			file.transferTo(new File(savePath));
		}
		member.setProfile(profile);
		member.setAddress(member.getAddress1()+"/"+member.getAddress2()+"/"+member.getAddress3()+"/"+member.getAddress4());
		int memberModifyResult = mdao.memberModify(member);
		if(memberModifyResult > 0) {
			mav.setViewName("member/MemberModifySuccess");
		} else {
			mav.setViewName("member/MemberModifyFail");
		}
		return mav;
	}
	
	public ModelAndView memberView(String id) {
		mav = new ModelAndView();
		MemberDTO memberView = mdao.memberView(id);
		mav.addObject("memberView", memberView);
		mav.setViewName("member/MemberView");
		return mav;
	}
	
	public ModelAndView memberList() {
		mav = new ModelAndView();
		List<MemberDTO> memberList = mdao.memberList();
		mav.addObject("memberList", memberList);
		mav.setViewName("member/MemberList");
		return mav;
	}
	
}
