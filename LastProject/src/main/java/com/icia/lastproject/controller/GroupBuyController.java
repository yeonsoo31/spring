package com.icia.lastproject.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.icia.lastproject.dto.GroupBuyDTO;
import com.icia.lastproject.service.GroupBuyService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class GroupBuyController {

	@Autowired
	private GroupBuyService groupBuyService;

	private ModelAndView mav;

	// 공동구매 업로드 화면 출력
	@RequestMapping(value = "/groupbuyingaddform", method = RequestMethod.GET)
	public String groupbuyingaddform() {
		return "groupbuy/GroupBuyingAddForm";
	}

	// 공동구매 업로드
	@RequestMapping(value = "/groupBuyingAdd", method = RequestMethod.POST)
	public ModelAndView groupBuyingAdd(@ModelAttribute GroupBuyDTO groupBuy) throws IllegalStateException, IOException {
		log.info(">>>>>>> [groupBuyingAdd] : " + groupBuy.toString());
		mav = groupBuyService.groupBuyingAdd(groupBuy);
		return mav;
	}

	// 공동구매 상품 조회
	@RequestMapping(value="/groupbuylistpaging")
	public ModelAndView groupbuylistpaging(@RequestParam(value = "page", required=false, defaultValue="1") int page) {
		mav = groupBuyService.groupBuyListPaging(page);

		return mav;
	}


	 // 공동구매 상품 상세조회
	 @RequestMapping(value = "/groupBuyView", method = RequestMethod.GET)
	 public ModelAndView groupBuyView(@RequestParam("g_number") int g_number) {
		 mav = groupBuyService.groupBuyView(g_number);

		 return mav;
	 }





}