package com.icia.lastproject.controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.icia.lastproject.dto.OrderDTO;
import com.icia.lastproject.dto.air_L_DTO;
import com.icia.lastproject.service.AirService;

@Controller
public class AirController {
	@Autowired
	private AirService airService;
	@Autowired
	private HttpSession session;
	private ModelAndView mav;
	
	@RequestMapping(value="/airLine",method=RequestMethod.GET)
	public String joinForm() {
		return "air/airLine";
	}

	//왕복 항공 검색
	@RequestMapping(value="/airsearch",method=RequestMethod.POST)
	public ModelAndView airseach(@RequestParam("from") String from, @RequestParam("to") String to,@RequestParam("endarea") String endarea, @RequestParam("airuser") int airuser){
		String[] fromArray = from.split("/");
	     String starttime = fromArray[2]+"/"+fromArray[0]+"/"+fromArray[1];
	     String[] toArray = to.split("/");
	     String endtime = toArray[2]+"/"+toArray[0]+"/"+toArray[1];
		
		air_L_DTO airl = new air_L_DTO();
		 airl.setStarttime(starttime);
		 airl.setEndtime(endtime);
		 airl.setEndarea(endarea);
		 mav = airService.airseach(airl,airuser);
		return mav;
	}
	@RequestMapping(value="/airreservation",method=RequestMethod.GET)
	public ModelAndView airreservation(@RequestParam("endnum") int endnum, @RequestParam("airuser") int airuser) {
		mav= airService.airreservation(endnum, airuser);
		return mav;
	}
	@RequestMapping(value="/userreservation",method=RequestMethod.POST)
	public @ResponseBody String userreservation(@RequestParam("endnum") int endnum,@RequestParam("name") String name, @RequestParam("email") String email, @RequestParam("phone") String phone, @RequestParam("phone1") String phone1, @RequestParam("airuser") int airuser,@RequestParam("rprice") String rprice) {
		String userreservation = airService.userreservation(endnum, name,email,phone,phone1,airuser,rprice);
		return userreservation;
	}
	@RequestMapping(value="/myReservation", method=RequestMethod.GET)
	public ModelAndView myReservation() {
		String id =(String) session.getAttribute("loginId");
		mav = airService.myReservation(id);
		return mav;
	}
	@RequestMapping(value="/reservationDesion")
	public ModelAndView reservationDesion(@RequestParam("reservationnum") int reservationnum, @RequestParam("endnum") int endnum) {
		mav = airService.reservationDesion(reservationnum, endnum);
		return mav;
	}
	
	@RequestMapping(value="/paymentUpdate", method=RequestMethod.GET)
	public @ResponseBody String paymentUpdate(@RequestParam("no") int no) {
		String result = airService.paymentUpdate(no);
		return result;
	}
	@RequestMapping(value = "/airpayment") 
	public String airpayment() {
		return "air/airpayment"; 
	  }
	@RequestMapping(value="/reservationResult")
	public ModelAndView reservationResult(@RequestParam("reservationnum") int reservationnum, @RequestParam("endnum") int endnum) {
		mav = airService.reservationResult(reservationnum,endnum);
		return mav;
	}
	//페이징
	@RequestMapping(value = "/airlistpaging")
	   
	   public ModelAndView airlistpaging
	      (@RequestParam(value="page", required=false, defaultValue="1") int page, @RequestParam("endarea") String endarea, @RequestParam int airuser) {

	      mav = airService.airListPaging(page, endarea, airuser);

	      return mav;
	   }
	@RequestMapping(value="/reservationresult",method=RequestMethod.GET)
	public String reservationresult() {
		return "air/reservationresult";
	}
	
	@RequestMapping(value="/reservationdelete")
	public ModelAndView reservationdelete(@RequestParam("reservationnum") int reservationnum) {
		mav = airService.reservationdelete(reservationnum);
		
		return mav;
	}
}

