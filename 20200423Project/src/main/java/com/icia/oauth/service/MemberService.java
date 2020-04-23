package com.icia.oauth.service;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.icia.oauth.dao.MemberDAO;
import com.icia.oauth.dto.MemberDTO;

@Service
public class MemberService {

	private ModelAndView mav;
	
	@Autowired
	private MemberDAO mdao;
	
	public ModelAndView MemberJoin(MemberDTO member) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		MultipartFile mprofilepic = member.getMprofilepic();
		String mprofilepicname = mprofilepic.getOriginalFilename();
		String savePath = "C:\\Users\\7\\Desktop\\Development\\source\\Servlet\\20200423Project\\src\\main\\webapp\\resources\\profilepic\\"+mprofilepicname;
		if(!mprofilepic.isEmpty()) {
			mprofilepic.transferTo(new File(savePath));
		}
		member.setMprofilepicname(mprofilepicname);
		String fulladdress = "우편번호 : "+member.getMaddress1()+"_"+member.getMaddress2()+"_"+member.getMaddress3()+"_"+member.getMaddress4();
		member.setFulladdress(fulladdress);
		int memberSignUpResult = mdao.MemberJoin(member);
		if(memberSignUpResult > 0) {
			mav.setViewName("member/MemberMain");
		} else {
			mav.setViewName("member/MemberSignUpFail");
		}
		return mav;
	}

}
