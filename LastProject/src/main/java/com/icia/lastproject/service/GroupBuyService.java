package com.icia.lastproject.service;
import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.icia.lastproject.dao.GroupBuyDAO;
import com.icia.lastproject.dto.GroupBuyDTO;
import com.icia.lastproject.dto.PageDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class GroupBuyService {

	@Autowired
	private GroupBuyDAO gdao;

	//프로퍼티 파일 위치지정(파일 업로드 위치를 효과적으로 관리할 수 있게끔 해줌. > 현장 필수
	@Value("${file.path}")
	private String savePath;

	private ModelAndView mav;

	public ModelAndView groupBuyingAdd(GroupBuyDTO groupBuy) throws IllegalStateException, IOException {
		mav = new ModelAndView();

		MultipartFile photo1 = groupBuy.getPhoto1();
		MultipartFile photo2 = groupBuy.getPhoto2();
		MultipartFile photo3 = groupBuy.getPhoto3();

		if(!photo1.isEmpty()) {
			photo1.transferTo(new File(savePath+photo1.getOriginalFilename()));
			groupBuy.setG_photo1name(photo1.getOriginalFilename());
		}
		if(!photo2.isEmpty()) {
			photo2.transferTo(new File(savePath+photo2.getOriginalFilename()));
			groupBuy.setG_photo2name(photo2.getOriginalFilename());
		}
		if(!photo3.isEmpty()) {
			photo3.transferTo(new File(savePath+photo3.getOriginalFilename()));
			groupBuy.setG_photo3name(photo3.getOriginalFilename());
		}

		log.info(">>>>>> groupBuy 체크 :" + groupBuy.toString());
		int groupbuyWriteResult = gdao.groupBuyingAdd(groupBuy);
		if(groupbuyWriteResult > 0)
			mav.setViewName("redirect:/groupbuylistpaging");
		else
			mav.setViewName("groupbuy/writeFail");


		return mav;
	}

	// 한 페이지에 몇 개씩?
	private static final int PAGE_LIMIT = 3;
	// 이전 1~5 다음
	private static final int BLOCK_LIMIT = 5;

	public ModelAndView groupBuyListPaging(int page) {
		mav = new ModelAndView();

		//1p 1~3
			int startRow = (page-1) * PAGE_LIMIT + 1;
		//2p 4~5
			int endRow = page * PAGE_LIMIT;

			PageDTO paging = new PageDTO();
			paging.setStartrow(startRow);
			paging.setEndrow(endRow);
			List<GroupBuyDAO> groupBuyList = gdao.groupBuyListPaging(paging);

			int listCount = gdao.listCount();

			// 최대로 필요한 페이지 갯수 계산
//			int maxPage = (int) ((double) listCount / PAGE_LIMIT + 0.9);
									//올림을 하는 메소드
			int maxPage = (int) (Math.ceil((double) listCount / PAGE_LIMIT));

			// 현재 페이지에 보여줄 시작 페이지 번호
			int startPage =
			(((int)(Math.ceil((double) page / BLOCK_LIMIT))) - 1) * BLOCK_LIMIT + 1;

			// 현재 페이지에 보여줄 끝 페이지 번호(10, 20, 30, 40 ~~~)
			int endPage = startPage + BLOCK_LIMIT - 1;

			if (endPage > maxPage) {
					endPage = maxPage;
			}

			paging.setMaxpage(maxPage);
			paging.setStartpage(startPage);
			paging.setEndpage(endPage);
			paging.setPage(page);

			mav.addObject("paging", paging);
			mav.addObject("groupBuyListPaging", groupBuyList);
			mav.setViewName("groupbuy/GroupBuyListPaging.tiles");

			return mav;
	}


	public ModelAndView groupBuyView(int g_number) {
		gdao.groupBuyHit(g_number);
		mav = new ModelAndView();
		GroupBuyDTO groupBuyView = gdao.groupBuyView(g_number);

		//List<CommentDTO> commentList = cdao.commentList(g_number);

		//mav.addObject("commentList", commentList);
		mav.addObject("groupBuyView",groupBuyView);
		mav.setViewName("groupbuy/GroupBuyView.tiles");
		return mav;

	}



}