package com.icia.lastproject.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;


import com.icia.lastproject.dao.AirDAO;
import com.icia.lastproject.dto.PageDTO;
import com.icia.lastproject.dto.airPageDTO;
import com.icia.lastproject.dto.air_L_DTO;
import com.icia.lastproject.dto.userreservationDTO;
@Service
public class AirService {
	@Autowired
	private AirDAO airdao;
	@Autowired
	private HttpSession session;
	
	private ModelAndView mav;
	
	public static final int PAGE_LIMIT = 8;
	public static final int BLOCK_LIMIT = 5;
	




	public ModelAndView airreservation(int endnum, int airuser) {
		mav=new ModelAndView();
		air_L_DTO result=airdao.airreservation(endnum);
		mav.addObject("result", result);
		mav.addObject("airuser", airuser);
		mav.setViewName("air/airreservationForm");
		return mav;
	}



	public String userreservation(int endnum,String name, String email, String phone, String phone1, int airuser, String rprice) {
		String id =(String) session.getAttribute("loginId");
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("endnum", endnum);
		hashMap.put("id", id);
		hashMap.put("name", name);
		hashMap.put("email", email);
		hashMap.put("phone", phone);
		hashMap.put("phone1", phone1);
		hashMap.put("airuser", airuser);
		hashMap.put("rprice", rprice);
		
		int ureservation = airdao.userreservation(hashMap);
		
		String reserult = null;
		if(ureservation > 0) {
			reserult = "comit";
		}
		return reserult;
	}



	public ModelAndView myReservation(String id) {
		mav=new ModelAndView();
		List<userreservationDTO> myreser = new ArrayList<userreservationDTO>();
		
		myreser = airdao.myReservation(id);
		mav.addObject("myreser", myreser);
		mav.setViewName("air/myReservation");
		return mav;
	}



	public ModelAndView payment(int reservationnum) {
		mav = new ModelAndView();
		int airpayment = airdao.airpaymentView(reservationnum);
		if(airpayment > 0) {
			mav.addObject("reservationnum", reservationnum);
			mav.setViewName("air/airpayment");
		}
		return mav;
	}



	public ModelAndView reservationDesion(int reservationnum, int endnum) {
		mav= new ModelAndView();
		userreservationDTO reservationDesion= airdao.desion(reservationnum);
		air_L_DTO airlreser = airdao.arlreser(endnum);
		
		mav.addObject("reservationDesion", reservationDesion);
		mav.addObject("airlreser", airlreser);
		mav.setViewName("air/reservationDesion");
		return mav;
	}
	public String paymentUpdate(int no) {
		int payresult = airdao.paymentUpdate(no);
		String result ="";
		if(payresult >0) {
			result = "OK";
		}
		return result;
	}



	public ModelAndView reservationResult(int reservationnum, int endnum) {
		userreservationDTO reservationResult=airdao.airport(reservationnum);
		air_L_DTO airlreser = airdao.arlreser(endnum);
		mav.addObject("reservationResult", reservationResult);
		mav.addObject("airlreser", airlreser);
		mav.setViewName("air/airport");
		return mav;
	}
	
	//페이징
	public ModelAndView airListPaging(int page, String endarea, int airuser) {
	      mav = new ModelAndView();
	      
	      int startRow = (page-1) * PAGE_LIMIT + 1;
	      int endRow = page * PAGE_LIMIT;
	      
	      airPageDTO paging = new airPageDTO();
	      paging.setStartpage(startRow);
	      paging.setEndrow(endRow);
	      paging.setEndarea(endarea); 
	      
	      List<air_L_DTO> airList = airdao.airListPaging(paging);
	      
	      int listCount = 0;
	      
	      if(endarea.equals("endarea")) {
	    	  airList = airdao.airendareaListPatin(paging);
	    	  listCount = airdao.endareaListCount(endarea);
	      }
	      
	      
//	      int maxPage = (int)((double)listCount / PAGE_LIMIT + 0.9);
//	      위 주석과 같은 방식 Math.ceil = 무조건 반올림해주는 함수 3.1 = 4로
	      int maxPage = (int) (Math.ceil((double)listCount / PAGE_LIMIT));      
//	      int startPage = (((int)((double)page/BLOCK_LIMIT + 0.9)) - 1) * BLOCK_LIMIT + 1;
//	      위 주석과 같은 방식 Math.ceil = 무조건 반올림해주는 함수 3.1 = 4로
	      int startPage = (((int)(Math.ceil((double)page/BLOCK_LIMIT))) - 1) * BLOCK_LIMIT + 1;
	      
	      int endPage = startPage + BLOCK_LIMIT - 1;
	      
	      if(endPage>maxPage) {
	         endPage=maxPage;
	      }
	      
	      paging.setMaxpage(maxPage);
	      paging.setStartpage(startPage);
	      paging.setEndpage(endPage);
	      paging.setPage(page);
	      
	      mav.addObject("paging", paging);
	      mav.addObject("airList", airList);
		  mav.addObject("airuser", airuser);
	      mav.setViewName("air/airSearch");
	      
	      return mav;
	   }

	public ModelAndView airseach(air_L_DTO airl, int airuser) {
		mav= new ModelAndView();
		List<air_L_DTO> airsList = airdao.airssearch(airl);		
		mav.addObject("airsList", airsList);
		mav.addObject("airuser", airuser);
		mav.setViewName("air/airSearch");
		return mav;
	}



	public ModelAndView reservationdelete(int reservationnum) {
		mav = new ModelAndView();
		int airdelete = airdao.reservationdelete(reservationnum);
		
		if(airdelete >0) {
			mav.setViewName("air/airdelete");
		}
		return mav;
		
	}



	



}
