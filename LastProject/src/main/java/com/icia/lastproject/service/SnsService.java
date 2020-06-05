package com.icia.lastproject.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.icia.lastproject.dao.ChatDAO;
import com.icia.lastproject.dao.MemberDAO;
import com.icia.lastproject.dao.SnsDAO;
import com.icia.lastproject.dto.AuctionMemberDTO;
import com.icia.lastproject.dto.MemberDTO;
import com.icia.lastproject.dto.MessageDTO;
import com.icia.lastproject.dto.PagingDTO;
import com.icia.lastproject.dto.SnsDTO;
import com.icia.lastproject.dto.SnsFriendDTO;

@Service
public class SnsService {
	
	@Autowired
	private SnsDAO sdao;
	
	@Autowired 
	private MemberDAO mdao;
	
	@Autowired
	private ChatDAO cdao;
	
	@Autowired
	private HttpSession session;
	
	private ModelAndView mav;
	
	public static final int PAGE_LIMIT = 8;
	
	public ModelAndView snsMain(int page) {
		mav = new ModelAndView();
		int startRow = (page-1) * PAGE_LIMIT + 1 ;
		int endRow = page * PAGE_LIMIT;
		int friendRequestCount = 0;
		int messageCount = 0;
		
		PagingDTO paging = new PagingDTO();
		paging.setStartRow(startRow);
		paging.setEndRow(endRow);
		
		List<SnsDTO> snsList = sdao.snsList(paging);
		
		paging.setPage(page);
		
		String id = null;
		int division = 0;
		if(session.getAttribute("loginId")!= null) {
			id = (String)session.getAttribute("loginId");
			division = (int)session.getAttribute("loginIdDivision");
			friendRequestCount = sdao.friendRequest(id);
			messageCount = cdao.messageList(id);
		}
		if(division == 1 || division == 5) {
			MemberDTO member = mdao.memberView(id);
			mav.addObject("messageCount", messageCount);
			mav.addObject("friendRequestCount", friendRequestCount);
			mav.addObject("snsList", snsList);
			mav.addObject("paging", paging);
			mav.addObject("member", member);
			mav.setViewName("sns/SnsMain");
		}else if(division == 2) {
			MemberDTO seller = mdao.sellerView(id);
			mav.addObject("messageCount", messageCount);
			mav.addObject("friendRequestCount", friendRequestCount);
			mav.addObject("snsList", snsList);
			mav.addObject("paging", paging);
			mav.addObject("member", seller);
			mav.setViewName("sns/SnsMain");
		}else {
			mav.addObject("snsList", snsList);
			mav.addObject("paging", paging);
			mav.setViewName("sns/SnsMain");
		}
		return mav;
	}

	public SnsDTO snsWrite(SnsDTO sns, int page) {
		List<SnsDTO> snsList = new ArrayList<SnsDTO>();
		PagingDTO paging = new PagingDTO();
		sns.setName((String)session.getAttribute("name"));
		int writeResult = sdao.snsWrite(sns);		
		if(writeResult > 0) {
			int startRow = (page-1) * PAGE_LIMIT + 1 ;
			int endRow = page * PAGE_LIMIT;
			paging.setStartRow(startRow);
			paging.setEndRow(endRow);
			paging.setPage(page);
			snsList = sdao.snsList(paging);
		}
		SnsDTO write = sdao.write();
		List<Object> collection = new ArrayList<Object>();
		collection.add(snsList);
		collection.add(paging);
		return write;
	}

	public List<Object> snsMoreList(int page) {
		page = page+1;
		int startRow = (page-1) * PAGE_LIMIT + 1 ;
		int endRow = page * PAGE_LIMIT;
		PagingDTO paging = new PagingDTO();
		List<SnsDTO> snsList = new ArrayList<SnsDTO>();
		paging.setStartRow(startRow);
		paging.setEndRow(endRow);
		paging.setPage(page);
		snsList = sdao.snsList(paging);
		List<Object> collection = new ArrayList<Object>();
		collection.add(snsList);
		collection.add(paging);
		return collection;
	}

	public ModelAndView snsFriendList() {
		mav = new ModelAndView();
		String id = (String)session.getAttribute("loginId");
		List<SnsFriendDTO> friendList = sdao.snsFriendList(id);
		
		mav.addObject("friendList", friendList);
		mav.setViewName("sns/SnsFriendList");
		
		return mav;
	}

	public List<Object> snsSearch(String search) {
		List<MemberDTO> member = sdao.memberSearch(search);
		List<MemberDTO> seller = sdao.sellerSearch(search);
		List<SnsDTO> sns = sdao.boardSearch(search);
		String f_id = (String)session.getAttribute("loginId");
		List<SnsFriendDTO> snsFriend = sdao.snsFriendList2(f_id);
		List<Object> searchList = new ArrayList<Object>();
		searchList.add(member);
		searchList.add(seller);
		searchList.add(sns);
		searchList.add(snsFriend);
		return searchList;
	}

	public String addFriend(SnsFriendDTO addFriend) {
		String id = addFriend.getF_id();
		HashMap<String,Object> hash = new HashMap<String,Object>();
		hash.put("id", addFriend.getId());
		hash.put("f_id",addFriend.getF_id());
		Integer friendDivision = sdao.friendDivision(hash);
		String resultMsg = "NO";
		if(friendDivision==null) {
			MemberDTO member = mdao.memberView(id);
			int addFriendResult = 0;
			if(member!=null){
				System.out.println("이름>>>>>>>>>>>>>>>>>>>>>>>>>"+member.getName());
				addFriend.setF_name(member.getName());
				if(member.getProfile()!=null) {
				addFriend.setF_profile(member.getProfile());
				} else {
					addFriend.setF_profile("");
				}
				addFriendResult = sdao.addFriend(addFriend);
			} else {
				MemberDTO seller = mdao.sellerView(id);
				addFriend.setF_name(seller.getName());
				if(seller.getProfile()!=null) {
				addFriend.setF_profile(seller.getProfile());
				} else {
					addFriend.setF_profile("");
				}
				addFriendResult = sdao.addFriend(addFriend);
			}
			
			if(addFriendResult>0) {
				resultMsg = "add";
			}
		} else if(friendDivision==1) {
				System.out.println("1번으로 왔습니다");
				int deleteResult = sdao.deleteFriend(hash);
				if(deleteResult > 0) {
				resultMsg = "delete";
				}
		} else if(friendDivision==2) {
				System.out.println("2번으로 왔습니다");
				int cancelResult = sdao.cancelFriend(hash);
				if(cancelResult > 0) {
				resultMsg = "cancel";
				}
		}
		
		return resultMsg;
	}

	public ModelAndView friendRequest() {
		mav = new ModelAndView();
		String id = (String)session.getAttribute("loginId");
		int division = (int)session.getAttribute("loginIdDivision");
		List<SnsFriendDTO> requestList = sdao.friendRequestList(id);
		int friendRequestCount = sdao.friendRequest(id);
		if(division == 1 || division == 5) {
			MemberDTO member = mdao.memberView(id);
			mav.addObject("friendRequestCount", friendRequestCount);
			mav.addObject("member", member);
			mav.addObject("requestList", requestList);
			mav.setViewName("sns/SnsFriendRequest");
		}else if(division == 2) {
			MemberDTO seller = mdao.sellerView(id);
			mav.addObject("friendRequestCount", friendRequestCount);
			mav.addObject("member", seller);
			mav.addObject("requestList", requestList);
			mav.setViewName("sns/SnsFriendRequest");
		}
		return mav;
	}

	public List<SnsFriendDTO> requestAccept(SnsFriendDTO snsFriend) {
		int requestAcceptResult = sdao.requestAccept(snsFriend);
		List<SnsFriendDTO> requestList = new ArrayList<SnsFriendDTO>();
		String id = snsFriend.getId();
		String f_id = snsFriend.getF_id();
		if(requestAcceptResult > 0) {
			MemberDTO member = mdao.memberView(id);
			if(member != null) {
				snsFriend.setId(f_id);
				snsFriend.setF_id(id);
				snsFriend.setF_name(member.getName());
				if(member.getProfile()!=null) {
					snsFriend.setF_profile(member.getProfile());
				}else {
					snsFriend.setF_profile("");
				}
				sdao.friendCheck(snsFriend);
			}else {
				MemberDTO seller = mdao.sellerView(id);
				snsFriend.setId(f_id);
				snsFriend.setF_id(id);
				snsFriend.setF_name(seller.getS_name());
				if(seller.getProfile()!=null) {
					snsFriend.setF_profile(seller.getProfile());
				}else {
					snsFriend.setF_profile("");
				}
				sdao.friendCheck(snsFriend);
			}
			requestList = sdao.friendRequestList(id);
		}
		return requestList;
	}

	public List<SnsFriendDTO> requestReject(SnsFriendDTO snsFriend) {
		int requestRejectResult = sdao.requestReject(snsFriend);
		String id = snsFriend.getId();
		List<SnsFriendDTO> requestList = new ArrayList<SnsFriendDTO>();
		if(requestRejectResult > 0) {
			requestList = sdao.friendRequestList(id);
		}
		return requestList;
	}

	public String deleteSnsPost(int s_number) {
		int deleteResult = sdao.deleteSnsPost(s_number);
		String resultMsg = null;
		if(deleteResult > 0) {
			resultMsg = "OK";
		}
		return resultMsg;
	}

	public ModelAndView snsMessenger() {
		mav = new ModelAndView();
		String id = (String)session.getAttribute("loginId");
		MemberDTO member = mdao.memberView(id);
		List<SnsFriendDTO> friendList = sdao.snsFriendList(id);
		mav.addObject("member", member);
		mav.addObject("friendList", friendList);
		mav.setViewName("sns/SnsMessenger");
		return mav;
	}

	public ModelAndView goMessenger(String f_id) {
		mav = new ModelAndView();
		String id = f_id;
		MemberDTO friendView = mdao.memberView(id);
		id = (String)session.getAttribute("loginId");
		MemberDTO member = mdao.memberView(id);
		System.out.println(friendView.getName());
		mav.addObject("friendView", friendView);
		mav.addObject("member", member);
		mav.setViewName("sns/test");
		return mav;
	}

	public List<Object> goChat(MessageDTO message) {
		cdao.readMessage(message);
		List<MessageDTO> allMessageList = cdao.goChat(message);
		List<MessageDTO> friendMessageList = cdao.friendMessageList(message);
		List<Object> messageList = new ArrayList<Object>();
		messageList.add(allMessageList);
		messageList.add(friendMessageList);
		return messageList;
	}

	public String friendMessageCount(MessageDTO message) {
		int Count = cdao.friendMessageCount(message);
		String messageCount = Integer.toString(Count); 
		return messageCount;
	}
	
	public List<Object> friendStatus(String f_id) {
		List<MemberDTO> friendStatus = sdao.friendStatus(f_id);
		System.out.println("friendStatus>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+friendStatus);
		List<SnsDTO> friendBoard = sdao.friendBoard(f_id);
		//
		MemberDTO memberModify = mdao.memberView(f_id);
		String address = memberModify.getAddress();
		String[] array = address.split("/");
		memberModify.setAddress1(array[0]);
		memberModify.setAddress2(array[1]);
		memberModify.setAddress3(array[2]);
		memberModify.setAddress4(array[3]);
		String friendAddress = memberModify.getAddress2();
		//
		List<Object> result = new ArrayList<Object>();
		result.add(friendStatus);
		result.add(friendBoard);
		result.add(friendAddress);
		return result;
	}

}
