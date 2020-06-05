package com.icia.lastproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.icia.lastproject.dto.AuctionDTO;
import com.icia.lastproject.dto.AuctionMemberDTO;
import com.icia.lastproject.dto.AuctionQnAAnswerDTO;
import com.icia.lastproject.dto.AuctionQnADTO;
import com.icia.lastproject.dto.OrderDTO;
import com.icia.lastproject.service.AuctionService;

@Controller
public class AuctionController {
	
	@Autowired
	private AuctionService auctionService;
	
	private ModelAndView mav;
	
	@RequestMapping(value="/goMain")
	public String main() {
		return "Main";
	}
	
	@RequestMapping(value="/auctionList")
	public ModelAndView auctionList(@RequestParam(value="page", required=false, defaultValue="1") int page) {
		mav = new ModelAndView();
		mav = auctionService.auctionList(page);
		return mav;
	}
	
	@RequestMapping(value="/auctionAddForm")
	public String auctionAddForm() {
		return "auction/AuctionAddForm";
	}
	
	@RequestMapping(value="/auctionAdd")
	public ModelAndView auctionAdd(@ModelAttribute AuctionDTO auction) {
		mav = auctionService.auctionAdd(auction);
		return mav;
	}
	@RequestMapping(value="/auctionView")
	public ModelAndView auctionView(@RequestParam("a_number") int a_number, 
									@RequestParam("page") int page,
									@RequestParam(value="qnaPage", required=false, defaultValue="1") int qnaPage) {
		mav = auctionService.auctionView(a_number, page, qnaPage);
		return mav;
	}
	
	@RequestMapping(value="/bidding")
	public @ResponseBody AuctionDTO bidding(@ModelAttribute AuctionMemberDTO am) {
		AuctionDTO auctionView = auctionService.bidding(am);
		return auctionView;
	}
	
	@RequestMapping(value="/auctionModifyForm")
	public ModelAndView auctionModifyForm(@RequestParam("a_number") int a_number) {
		mav = auctionService.auctionModifyForm(a_number);
		return mav;
	}
	
	@RequestMapping(value="/auctionModify")
	public ModelAndView auctionModify(@ModelAttribute AuctionDTO auction) {
		mav = auctionService.auctionModify(auction);
		return mav;
	}
	
	@RequestMapping(value="/auctionDelete")
	public ModelAndView auctionDelete(@RequestParam("a_number") int a_number) {
		mav = auctionService.auctionDelete(a_number);
		return mav;
	}
	
	@RequestMapping(value="/biddingList")
	public ModelAndView biddingList(@RequestParam("a_number") int a_number, @RequestParam(value="page", required=false, defaultValue="1") int page, @RequestParam("paging") int paging) {
		mav = auctionService.biddingList(a_number,page,paging);
		return mav;
	}
	
	@RequestMapping(value="/bidSuccess")
	public ModelAndView bidSuccess(@RequestParam("a_number") int a_number, @RequestParam("id") String id, @RequestParam("page") int page) {
		mav = auctionService.bidSuccess(a_number,id,page);
		return mav;
	}
	
	@RequestMapping(value="/bidCheck")
	public @ResponseBody String bidCheck(@RequestParam("a_number") int a_number) {
		String resultMsg = auctionService.bidCheck(a_number);
		return resultMsg;
	}
	
	@RequestMapping(value="/auctionOrder")
	public ModelAndView auctionOrder(@RequestParam("a_number") int a_number,
									 @RequestParam("id") String id) {
		mav = auctionService.auctionOrder(a_number,id);
		return mav;
	}
	
	@RequestMapping(value="/payment")
	public ModelAndView payment(@ModelAttribute OrderDTO order) {
		mav = auctionService.payment(order);
		return mav;
	}
	
	@RequestMapping(value="/uploadSummernoteImageFile")
	public @ResponseBody String uploadSummernoteImageFile(@RequestParam("file") MultipartFile file){
		System.out.println("ddddddddddddddd>>>>>>>>>>>>>>>>>>"+file);
		String jsonObject = auctionService.uploadSummernoteImageFile(file);
		System.out.println("ddddddddddddd>>>>>>>>>>>>"+jsonObject);
		return jsonObject;
	}
	
	@RequestMapping(value="/auctionQnA")
	public @ResponseBody List<Object> auctionQnA(@ModelAttribute AuctionQnADTO auctionQnA,
										   @RequestParam("addpage") int addpage) {
		List<Object> result = auctionService.auctionQnA(auctionQnA,addpage);
		return result;
	}
	
	@RequestMapping(value="/moreList")
	public @ResponseBody List<Object> qnaList(@RequestParam("a_number") int a_number,
													 @RequestParam("addpage") int addpage) {
		List<Object> qnaList = auctionService.qnaList(a_number,addpage);
		return qnaList;
	}
	
	@RequestMapping(value="/auctionQnAAnswer")
	public @ResponseBody List<Object> auctionQnAAnswer(@ModelAttribute AuctionQnAAnswerDTO auctionQnAAnswer,
													   @RequestParam("addPage") int addPage){
		List<Object> qnaAnswerList = auctionService.auctionQnAAnswer(auctionQnAAnswer,addPage);
		return qnaAnswerList;
	}
	
	@RequestMapping(value="/auctionQnAAnswerMoreList")
	public @ResponseBody List<Object> auctionQnAAnswerMoreList(@ModelAttribute AuctionQnAAnswerDTO auctionQnAAnswer,
															   @RequestParam("addPage") int addPage){
		List<Object> qnaAnswerList = auctionService.auctionQnAAnswerMoreList(auctionQnAAnswer,addPage);
		return qnaAnswerList;
	}
	
	@RequestMapping(value="/qnaPaging")
	public @ResponseBody List<Object> qnaPaging(@RequestParam("a_number") int a_number,
												@RequestParam("qnaPage") int qnaPage){
		List<Object> qnaList = auctionService.qnaPaging(a_number,qnaPage);
		return qnaList;
	}
	
	@RequestMapping(value="/orderSuccess")
	public String orderSuccess() {
		return "auction/OrderSuccess";
	}
	
	@RequestMapping(value="/bidAuction")
	public ModelAndView bidAuction() {
		mav = auctionService.bidAuction();
		return mav;
	}
}
