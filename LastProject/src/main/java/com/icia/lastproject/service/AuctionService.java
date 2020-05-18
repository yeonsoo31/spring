package com.icia.lastproject.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.google.gson.JsonObject;
import com.icia.lastproject.dao.AuctionDAO;
import com.icia.lastproject.dao.AuctionMemberDAO;
import com.icia.lastproject.dao.MemberDAO;
import com.icia.lastproject.dto.AuctionDTO;
import com.icia.lastproject.dto.AuctionMemberDTO;
import com.icia.lastproject.dto.AuctionQnAAnswerDTO;
import com.icia.lastproject.dto.AuctionQnADTO;
import com.icia.lastproject.dto.MemberDTO;
import com.icia.lastproject.dto.OrderDTO;
import com.icia.lastproject.dto.PagingDTO;

@Service
public class AuctionService {
	
	@Autowired
	private AuctionDAO adao;
	
	@Autowired
	private AuctionMemberDAO amdao;
	
	@Autowired
	private MemberDAO mdao;
	
	private ModelAndView mav;
	
	public static final int PAGE_LIMIT = 8;
	public static final int QNA_PAGE_LIMIT = 3;
	public static final int BLOCK_LIMIT = 5;
	public static final String PREFIX_URL = "C:\\Users\\7\\git\\springgit\\Spring\\LastProject\\src\\main\\webapp\\resources\\fileupload\\";

	public ModelAndView auctionList(int page) {
		mav = new ModelAndView();
		
		int startRow = (page-1) * PAGE_LIMIT + 1 ;
		int endRow = page * PAGE_LIMIT;
		
		PagingDTO paging = new PagingDTO();
		paging.setStartRow(startRow);
		paging.setEndRow(endRow);
		
		List<AuctionDTO> auctionList = adao.auctionList(paging);
		int listCount = adao.listCount();
		
		int maxPage = (int)(Math.ceil((double) listCount / PAGE_LIMIT));
		int startPage = (((int)(Math.ceil((double) page / BLOCK_LIMIT))) - 1) * BLOCK_LIMIT + 1 ;
		int endPage = startPage + BLOCK_LIMIT - 1 ;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		paging.setPage(page);
		paging.setMaxPage(maxPage);
		paging.setEndPage(endPage);
		paging.setStartPage(startPage);
		
		
		mav.addObject("paging", paging);
		mav.addObject("auctionList", auctionList);
		mav.setViewName("auction/AuctionList");
		
		return mav;
	}

	public ModelAndView auctionAdd(AuctionDTO auction) {
		mav = new ModelAndView();
		List<String> filesName = new ArrayList<String>();
		MultipartFile fileName = auction.getA_photo3();
		List<MultipartFile> fileList = auction.getA_photo4();
		System.out.println("왜들어가??????????????????????????"+ fileList.size());
		String realFileName = System.currentTimeMillis()+fileName.getOriginalFilename();
		String savePath = PREFIX_URL+realFileName;
		try {
			fileName.transferTo(new File(savePath));
		} catch (IllegalStateException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		for(MultipartFile mf: fileList) {
			String originFileName = System.currentTimeMillis()+mf.getOriginalFilename();
			long fileSize = mf.getSize();
			
			System.out.println("진짜파일네임>>>>>>>>>>>>>>"+originFileName);
			System.out.println("파일 사이즈 >>>>>>>>>>>>>>>" + fileSize);
			
			String saveFile = PREFIX_URL+originFileName;
			filesName.add(originFileName);
			try {
				mf.transferTo(new File(saveFile));
			} catch(IllegalStateException e){
				e.printStackTrace();
			} catch(IOException e) {
				e.printStackTrace();
			}
		}
		if(filesName.size()==2) {
			auction.setA_photo1(filesName.get(0));
			auction.setA_photo2(filesName.get(1));
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>"+filesName.get(0));
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>"+filesName.get(1));
		}else if(filesName.size()==1){
			auction.setA_photo1(filesName.get(0));
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>"+filesName.get(0));
		}else {
			System.out.println("상세사진없음");
		}
		
		auction.setA_photo(realFileName);
		
		
		int addResult = adao.auctionAdd(auction);
		if(addResult > 0) {
			mav.setViewName("redirect:/auctionList");
		}
		return mav;
	}

	public ModelAndView auctionView(int a_number, int page, int qnaPage) {
		mav = new ModelAndView();
		int startRow = (qnaPage-1) * QNA_PAGE_LIMIT + 1 ;
		int endRow = qnaPage * QNA_PAGE_LIMIT;
		
		PagingDTO paging = new PagingDTO();
		paging.setStartRow(startRow);
		paging.setEndRow(endRow);
		paging.setA_number(a_number);
		
		List<AuctionQnADTO> auctionQnA = adao.auctionQnA(paging);
		int listCount = adao.qnaListCount(a_number);
		
		int maxPage = (int)(Math.ceil((double) listCount / QNA_PAGE_LIMIT));
		int startPage = (((int)(Math.ceil((double) qnaPage / BLOCK_LIMIT))) - 1) * BLOCK_LIMIT + 1 ;
		int endPage = startPage + BLOCK_LIMIT - 1 ;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		paging.setPage(qnaPage);
		paging.setMaxPage(maxPage);
		paging.setEndPage(endPage);
		paging.setStartPage(startPage);
		AuctionDTO auctionView = adao.auctionView(a_number);
		List<AuctionQnAAnswerDTO> answer = adao.auctionQnAAnswer();
		mav.addObject("answer", answer);
		mav.addObject("auctionQnA", auctionQnA);
		mav.addObject("paging", paging);
		mav.addObject("page",page);
		mav.addObject("auctionView", auctionView);
		mav.setViewName("auction/AuctionView");
		return mav;
	}

	public AuctionDTO bidding(AuctionMemberDTO am) {
		amdao.biddingAdd(am);
		AuctionDTO auctionView = null;
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("a_number", am.getA_number());
		hashMap.put("a_price", am.getAm_price());
		int biddingResult = adao.bidding(hashMap);
		if(biddingResult > 0) {
			auctionView = adao.auctionView(am.getA_number());	
		}
		
		return auctionView;
	}

	public ModelAndView auctionModifyForm(int a_number) {
		mav = new ModelAndView();
		AuctionDTO auction = adao.auctionView(a_number);
		mav.addObject("auction", auction);
		mav.setViewName("auction/AuctionModifyForm");
		return mav;
	}

	public ModelAndView auctionModify(AuctionDTO auction) {
		mav = new ModelAndView();
		String savePath = null;
		List<String> filesName = new ArrayList<String>();
		MultipartFile fileName = auction.getA_photo3();
		System.out.println("어떻게 이게 있어 ????????????????????>>>>>>>>>"+fileName.getOriginalFilename());
		if(!fileName.isEmpty()) {
			String realFileName = System.currentTimeMillis() + fileName.getOriginalFilename();
			savePath = PREFIX_URL + realFileName;
			try {
				fileName.transferTo(new File(savePath));
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			auction.setA_photo(realFileName);
			System.out.println("바뀐파일 >>>>>>>>>>>>>>>>>>>>>>>>>>" + realFileName);
		} else {
			auction.setA_photo(auction.getA_photo5());
			System.out.println("있던파일 >>>>>>>>>>>>>>>>>>>>>>>>>> "+auction.getA_photo5());
		}
		
		
		
		List<MultipartFile> filesList = auction.getA_photo4();
		
		if(filesList.size() == 1) {
			for(MultipartFile mf: filesList) {
				String originFileName = System.currentTimeMillis() + mf.getOriginalFilename();
				if(originFileName.contains(".")) {
					String saveFile = PREFIX_URL + originFileName;
					filesName.add(originFileName);
					try {
						mf.transferTo(new File(saveFile));
					} catch (IllegalStateException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					auction.setA_photo1(originFileName);
					System.out.println("여기로왔나ㅏㅏㅏㅏㅏ11111111111?" + originFileName);
					
				}else {
					if(auction.getA_photo7() != null) {
					auction.setA_photo1(auction.getA_photo6());
					auction.setA_photo2(auction.getA_photo7());
					System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>." + auction.getA_photo6());
					System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>." + auction.getA_photo7());
					} else {
						auction.setA_photo1(auction.getA_photo6());
						System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>." + auction.getA_photo6());
					}
				}
				
			}
		}else{
			for(MultipartFile mf:filesList) {
				String OriginFileName = System.currentTimeMillis() + mf.getOriginalFilename();
				String saveFile = PREFIX_URL + OriginFileName;
				filesName.add(OriginFileName);
				try {
					mf.transferTo(new File(saveFile));
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			auction.setA_photo1(filesName.get(0));
			auction.setA_photo2(filesName.get(1));
		}
		
		int modifyResult = adao.auctionModify(auction);
		
		if(modifyResult > 0) {
			mav.setViewName("redirect:/auctionList");
		}
		
		return mav;
	}

	public ModelAndView auctionDelete(int a_number) {
		mav = new ModelAndView();
		int deleteResult = adao.auctionDelete(a_number);
		if(deleteResult > 0) {
			mav.setViewName("redirect:/auctionList");
		}
		return mav;
	}

	public ModelAndView biddingList(int a_number, int page, int paging2) {
		mav = new ModelAndView();
		int startRow = (page-1) * PAGE_LIMIT + 1 ;
		int endRow = page * PAGE_LIMIT;
		
		PagingDTO paging = new PagingDTO();
		paging.setStartRow(startRow);
		paging.setEndRow(endRow);
		paging.setA_number(a_number);
		
		List<AuctionMemberDTO> biddingList = amdao.biddingList(paging);
		int listCount = amdao.listCount(a_number);
		
		int maxPage = (int)(Math.ceil((double) listCount / PAGE_LIMIT));
		int startPage = (((int)(Math.ceil((double) page / BLOCK_LIMIT))) - 1) * BLOCK_LIMIT + 1 ;
		int endPage = startPage + BLOCK_LIMIT - 1 ;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		paging.setPage(page);
		paging.setMaxPage(maxPage);
		paging.setEndPage(endPage);
		paging.setStartPage(startPage);
		
		mav.addObject("page",paging2);
		mav.addObject("paging", paging);
		mav.addObject("biddingList", biddingList);
		mav.setViewName("auction/BiddingList");
		return mav;
	}

	public ModelAndView bidSuccess(int a_number, String id, int page) {
		mav = new ModelAndView();
		HashMap<String,Object> hash = new HashMap<String,Object>();
		hash.put("a_number", a_number);
		hash.put("id",id);
		int result = amdao.bidSuccess(hash);
		if(result > 0) {
			mav.addObject("page", page);
			mav.setViewName("redirect:/auctionView?a_number="+a_number);
		}
		return mav;
	}

	public String bidCheck(int a_number) {
		int result = amdao.bidCheck(a_number);
		String resultMsg = null;
		if(result == 0) {
			resultMsg = "OK";
		}else {
			resultMsg = "NO";
		}
		return resultMsg;
	}

	public ModelAndView auctionOrder(int a_number, String id) {
		mav = new ModelAndView();
		AuctionDTO auction = adao.auctionView(a_number);
		MemberDTO member = mdao.memberView(id);
		String address = member.getAddress();
		String[] array = address.split("/");
		member.setAddress1(array[0]);
		member.setAddress2(array[1]);
		member.setAddress3(array[2]);
		member.setAddress4(array[3]);
		mav.addObject("auction", auction);
		mav.addObject("member", member);
		mav.setViewName("auction/AuctionOrder");
		return mav;
	}

	public ModelAndView payment(OrderDTO order) {
		mav = new ModelAndView();
		int a_number = order.getA_number();
		AuctionDTO auction = adao.auctionView(a_number);
		order.setO_address(order.getO_address1()+"/"+order.getO_address2()+"/"+order.getO_address3()+"/"+order.getO_address4());
		
		int orderResult = adao.payment(order);
		if(orderResult > 0) {
			mav.addObject("auction", auction);
			mav.addObject("order", order);
			mav.setViewName("auction/Payment");
		}
		return mav;
	}

	public JsonObject uploadSummernoteImageFile(MultipartFile file){
		JsonObject jsonObject = new JsonObject();
		String fileRoot = "C:\\summernoteImg\\";
		String originalFileName = file.getOriginalFilename();
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
		
		String saveFileName = UUID.randomUUID()+extension;
		
		System.out.println(originalFileName);
		System.out.println(saveFileName);
		
		File targetFile = new File(fileRoot+saveFileName);
		
		try {
			InputStream fileStream = file.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);
			jsonObject.addProperty("url", "/summernoteImg/"+saveFileName);
			jsonObject.addProperty("responseCode", "success");
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		
		return jsonObject;
		
	}

	public String auctionQnA(AuctionQnADTO auctionQnA) {
		String resultMsg = null;
		int resultQnA = adao.auctionQnAWrite(auctionQnA);
		if(resultQnA > 0) {
			resultMsg = "OK";
		}else {
			resultMsg = "NO";
		}
		return resultMsg;
	}

	public List<Object> qnaList(int a_number, int addpage) {
		int startRow = (addpage-1) * QNA_PAGE_LIMIT + 1 ;
		int endRow = addpage * QNA_PAGE_LIMIT;
		System.out.println(a_number);
		System.out.println(addpage);
		PagingDTO paging = new PagingDTO();
		paging.setStartRow(startRow);
		paging.setEndRow(endRow);
		paging.setA_number(a_number);
		
		List<AuctionQnADTO> auctionQnA = adao.auctionQnA(paging);
		int listCount = adao.qnaListCount(a_number);
		
		int maxPage = (int)(Math.ceil((double) listCount / QNA_PAGE_LIMIT));
		int startPage = (((int)(Math.ceil((double) addpage / BLOCK_LIMIT))) - 1) * BLOCK_LIMIT + 1 ;
		int endPage = startPage + BLOCK_LIMIT - 1 ;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		List<AuctionQnAAnswerDTO> auctionQnAAnswer = adao.auctionQnAAnswer();
		List<Object> aaaa = new ArrayList<Object>();
		aaaa.add(auctionQnA);
		aaaa.add(auctionQnAAnswer);
		return aaaa;
	}
	

}
