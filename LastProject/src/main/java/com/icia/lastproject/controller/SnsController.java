package com.icia.lastproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

import com.icia.lastproject.dto.MessageDTO;
import com.icia.lastproject.dto.SnsDTO;
import com.icia.lastproject.dto.SnsFriendDTO;
import com.icia.lastproject.service.SnsService;

@Controller
public class SnsController {

	@Autowired
	private SnsService snsService;
	
	private ModelAndView mav;
	
	@RequestMapping(value="/snsMain")
	public ModelAndView snsMain(@RequestParam(value="page", required=false, defaultValue="1") int page) {
		mav = snsService.snsMain(page);
		return mav;
	}
	
	@RequestMapping(value="/snsWrite")
	public @ResponseBody SnsDTO snsWrite(@ModelAttribute SnsDTO sns,
											   @RequestParam("page") int page){
		SnsDTO snsWriteList = snsService.snsWrite(sns,page);
		return snsWriteList;
	}
	
	@RequestMapping(value="/snsMoreList")
	public @ResponseBody List<Object> snsMoreList(@RequestParam("page") int page){
		List<Object> snsMoreList = snsService.snsMoreList(page);
		return snsMoreList;
	}
	
	@RequestMapping(value="/snsFriendList")
	public ModelAndView snsFriendList() {
		mav = snsService.snsFriendList();
		return mav;
	}
	
	@RequestMapping(value="/snsSearch")
	public @ResponseBody List<Object> snsSearch(@RequestParam("search") String search){
		List<Object> searchList = snsService.snsSearch(search);
		return searchList;
	}
	
	@RequestMapping(value="/addFriend")
	public @ResponseBody String addFriend(@ModelAttribute SnsFriendDTO addFriend) {
		String resultMsg = snsService.addFriend(addFriend);
		return resultMsg;
	}
	
	@RequestMapping(value="/friendRequest")
	public ModelAndView friendRequest() {
		mav = snsService.friendRequest();
		return mav;
	}
	
	@RequestMapping(value="/requestAccept")
	public @ResponseBody List<SnsFriendDTO> requestAccept(@ModelAttribute SnsFriendDTO snsFriend){
			List<SnsFriendDTO> collection = snsService.requestAccept(snsFriend);
		return collection;
	}
	
	@RequestMapping(value="/requestReject")
	public @ResponseBody List<SnsFriendDTO> requestReject(@ModelAttribute SnsFriendDTO snsFriend){
		List<SnsFriendDTO> collection = snsService.requestReject(snsFriend);
		return collection;
	}
	
	@RequestMapping(value="/deleteSnsPost")
	public @ResponseBody String deleteSnsPost(@RequestParam("s_number") int s_number) {
		String resultMsg = snsService.deleteSnsPost(s_number);
		return resultMsg;
	}
	
	@RequestMapping(value="/snsMessenger")
	public ModelAndView snsMessenger() {
		mav = snsService.snsMessenger();
		return mav;
	}
	
	@RequestMapping(value="/goMessenger")
	public ModelAndView goMessenger(@RequestParam("f_id") String f_id) {
		mav = snsService.goMessenger(f_id);
		return mav;
	}
	
	@RequestMapping(value="/goChat")
	public @ResponseBody List<Object> goChat(@ModelAttribute MessageDTO message){
		List<Object> messageList = snsService.goChat(message);
		return messageList;
	}
	
	@RequestMapping(value="/friendMessageCount")
	public @ResponseBody String friendMessageCount(@ModelAttribute MessageDTO message) {
		String MessageCount = snsService.friendMessageCount(message);
		return MessageCount;
	}
	
	@RequestMapping(value="/friendStatus")
	public @ResponseBody List<Object> friendStatus(@RequestParam("f_id") String f_id){
		List<Object> friendStatus = snsService.friendStatus(f_id);
		return friendStatus;
	}
}
