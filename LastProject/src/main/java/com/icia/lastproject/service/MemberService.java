package com.icia.lastproject.service;

import java.io.File;
import java.io.IOException;

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
		MultipartFile mprofilepic = member.getMprofilepic();
		String mprofilepicname = mprofilepic.getOriginalFilename();
		String savePath = "C:\\Users\\7\\Desktop\\Development\\source\\Servlet\\LastProject\\src\\main\\webapp\\resources\\profilepic\\"+mprofilepicname;
		if(!mprofilepic.isEmpty()) {
			mprofilepic.transferTo(new File(savePath));
		}
		member.setMprofilepicname(mprofilepicname);
		String fulladdress = "우편번호 : "+member.getMaddress1()+"/"+member.getMaddress2()+"/"+member.getMaddress3()+"/"+member.getMaddress4();
		member.setFulladdress(fulladdress);
		int memberSignUpResult = mdao.memberJoin(member);
		if(memberSignUpResult > 0) {
			mav.setViewName("member/MemberJoinSuccess");
		} else {
			mav.setViewName("member/MemberSignUpFail");
		}
		return mav;
	}
	
	public String idOverlap(String mid) {
		String checkResult = mdao.idOverlap(mid);
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
	
	public ModelAndView memberModifyForm(String mid) {
		mav = new ModelAndView();
		MemberDTO memberModify = mdao.memberView(mid);
		String fulladdress = memberModify.getMaddress();
//		String fulladdress = memberModify.getFulladdress();
		System.out.println(fulladdress);
		String[] array = fulladdress.split("/");
		memberModify.setMaddress1(array[0]);
		memberModify.setMaddress2(array[1]);
		memberModify.setMaddress3(array[2]);
		memberModify.setMaddress4(array[3]);
		memberModify.setMaddress4(array[4]);
		mav.addObject("memberModify", memberModify);
		mav.setViewName("member/MemberModifyForm");
		return mav;
	}
	
	public ModelAndView memberModify(MemberDTO member) {
		mav = new ModelAndView();
		member.setFulladdress(member.getMaddress1()+"/"+member.getMaddress2()+"/"+member.getMaddress3()+"/"+member.getMaddress4());
		int memberModifyResult = mdao.memberModify(member);
		if(memberModifyResult > 0) {
			mav.setViewName("member/MemberModifySuccess");
		} else {
			mav.setViewName("member/MemberModifyFail");
		}
		return mav;
	}
	
	public ModelAndView memberView(String mid) {
		mav = new ModelAndView();
		MemberDTO memberView = mdao.memberView(mid);
		mav.addObject("memberView", memberView);
		mav.setViewName("member/MemberView");
		return mav;
	}
	
}
