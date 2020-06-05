package com.icia.lastproject.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.icia.lastproject.dto.CrawlingDTO;
import com.icia.lastproject.dto.OrderDTO;
import com.icia.lastproject.dto.PageDTO;
import com.icia.lastproject.dto.ProductAnswerDTO;
import com.icia.lastproject.dto.ProductDTO;
import com.icia.lastproject.dto.ProductListTempDTO;
import com.icia.lastproject.dto.ProductOrderDTO;
import com.icia.lastproject.dto.ProductQnaDTO;
import com.icia.lastproject.dto.ReviewDTO;
import com.icia.lastproject.service.ProductListService;

@Controller
public class ProductController {
	
	@Autowired
	private ProductListService pls;
	
	@Autowired
	private HttpSession session;
	
	private ModelAndView mav;

	
	@RequestMapping(value ="/productlist" , method = RequestMethod.POST)
	public @ResponseBody String productlist(@ModelAttribute ProductListTempDTO plist){
		 String resultMsg = pls.ListInsert(plist); 
		 return resultMsg;
	}
	
	@RequestMapping(value ="/imagetest" , method = RequestMethod.POST)
	public @ResponseBody String imagetest(){ 
		 System.out.println("1");
		 System.out.println("2");
		 return "OK";
	}
	

	@RequestMapping(value="productAdd" , method = RequestMethod.POST)
	public ModelAndView auctionAdd(@ModelAttribute ProductDTO product,MultipartHttpServletRequest mtfRequest) {
		String id = (String) session.getAttribute("loginId");
		product.setId(id);
		mav = pls.productAdd(product,mtfRequest);
		return mav;
	}
	
	@RequestMapping(value="productView" , method = RequestMethod.GET)
	public ModelAndView productView(@RequestParam("number") int number,
									@RequestParam(value = "page", required=false, defaultValue="1") int page) {
		mav = new ModelAndView();
		String userid = (String) session.getAttribute("loginId");
		System.out.println(userid);
		mav = pls.productView(number,userid ,page); 
		return mav;
	}
	

	  @RequestMapping(value = "/productlistpage") 
	  public ModelAndView  productlistpage(@RequestParam(value = "page", required=false, defaultValue="1") int page) {
		  mav = pls.productList(page);
		  System.out.println(page);
		  return mav;
		  }
	  
	  
	  @RequestMapping(value = "/CartView") 
	  public ModelAndView CartList() {
		  String userid = (String) session.getAttribute("loginId");
		  mav = pls.CartView(userid);
		  return mav;
		  }
	  
	  @RequestMapping(value="ProductPriceAjax" , method = RequestMethod.GET)
		public @ResponseBody int ProductPriceAjax(@RequestParam("number") int num) {

			int result = pls.ProductPriceAjax(num);
			return result;
		}
	  
	  @RequestMapping(value="CartInsert" , method = RequestMethod.GET)
		public @ResponseBody int CartInsert(@RequestParam("listno") int listno, @RequestParam("productno") int productno,
											@RequestParam("cur") int cur	) {
		  Map<String, Object> map = new HashMap<String, Object>();
		  String userid = (String) session.getAttribute("loginId");
		  map.put("listno", listno);
		  map.put("productno", productno);
		  map.put("cur", cur);
		  map.put("userid", userid);
			int result = pls.CartInsert(map);
			return result;
		}

	
	  
	  
	  @RequestMapping(value="PricePlusAjax" , method = RequestMethod.GET)
	  public @ResponseBody int PricePlusAjax(@RequestParam("number") int
	  number, @RequestParam("price") int price) {
		  int total;	  
		  if(number==2) {
				total=0;
			  total = price * 2;
				}
				else {
				total=0;	
				total = number*(price/(number-1));	
				}
		  return total; 
	  }
	  
	  @RequestMapping(value="PriceMinusAjax" , method = RequestMethod.GET)
	  public @ResponseBody int PriceMinusAjax(@RequestParam("number") int
	  number, @RequestParam("price") int price) {
		  int total;	  
		  if(number ==1) {
			  total=0;
				total = price/2;
				}
				else {
				total=0;	
				total = number*(price/(number+1));	
				}
		  return total; 
	  }
	 
	  @RequestMapping(value="SummerNoteImageFile" , method = RequestMethod.POST)
		public @ResponseBody JsonObject SummerNoteImageFile(@RequestParam("file") MultipartFile file) {
			JsonObject jsonObject = pls.SummerNoteImageFile(file);
			 System.out.println(jsonObject);
			return jsonObject;
		}
	  
	  
	  
	  @RequestMapping(value = "/productModifyForm") 
	  public ModelAndView  productModifyForm(@RequestParam("productno") int productno) {
		  mav = pls.productModifyForm(productno);
		  return mav;
		  }
	  
	  @RequestMapping(value = "/productModify"  , method = RequestMethod.POST) 
	  public ModelAndView productModify(@ModelAttribute ProductDTO product) {
		  mav = pls.productModify(product);
		  return mav;
		  }
	  
	  @RequestMapping(value = "/productDelete"  , method = RequestMethod.GET) 
	  public ModelAndView productDelete(@RequestParam("productno") int productno) {
		  mav = pls.productDelete(productno);
		  return mav;
		  }
	  
	  @RequestMapping(value = "/Order", method = RequestMethod.GET) 
	  public ModelAndView Order(@RequestParam("arr") List<Integer> list) {
		  mav = pls.order(list);
		  return mav;
		  }
	  
	  
	  @RequestMapping(value = "/ProductScroll") 
	  public ModelAndView  ProductScroll(@RequestParam("categoryno") int categoryno,
			  							 @RequestParam(value = "page", required=false, defaultValue="1") int page) {
		  mav = pls.productScroll(categoryno,page);
		  return mav;
		  }
	  
	  
	  @RequestMapping(value = "/ScrollPage" , method = RequestMethod.GET) 
	  public @ResponseBody List<ProductDTO> ScrollPage(@RequestParam("categoryno") int categoryno,
			  							 @RequestParam(value = "page", required=false, defaultValue="1") int page) {
		  List<ProductDTO> result = pls.ScrollPage(categoryno,page);
		  
		  return result;
		  }
	  
	  @RequestMapping(value = "/serch") 
	  public ModelAndView  ProductScroll(@RequestParam("serch") String serch) {
		  mav = pls.Serch(serch);
		  return mav;
		  }
	  
	  @RequestMapping(value = "/Review" , method = RequestMethod.GET) 
	  public @ResponseBody List<ReviewDTO> Review(@RequestParam("rating") int rating,
			  							 	@RequestParam("contents") String contents,
			  							 	@RequestParam("number") int number,
			  							 	@RequestParam(value = "page",required=false, defaultValue="1") int page
			  							 	) {

		  String userid = (String) session.getAttribute("loginId");
		  ReviewDTO review = new ReviewDTO();
		  review.setProductno(number);
		  review.setContents(contents);
		  review.setId(userid);
		  review.setRating(rating);
		  List<ReviewDTO> list = pls.ReviewInsert(review,page);
		  return list;
		  }
	  
	  @RequestMapping(value = "/ReviewAjax" , method = RequestMethod.GET) 
	  public @ResponseBody List<ReviewDTO> Review(@RequestParam("page") int page ,
			  									@RequestParam("productno") int productno) {
		  List<ReviewDTO> list = pls.ReviewAjax(page,productno);
		  return list;
		  }
	  
	  @RequestMapping(value = "/ProductPriceList" , method = RequestMethod.GET) 
	  public ModelAndView ProductPriceList(@RequestParam("categoryno") int categoryno,
			  							 @RequestParam(value = "page", required=false, defaultValue="1") int page) {
		  mav = pls.ProductPriceList(categoryno,page);
		  
		  return mav;
		  }
	  
	  @RequestMapping(value = "/PriceScrollPage" , method = RequestMethod.GET) 
	  public @ResponseBody List<ProductDTO> PriceScrollPage(@RequestParam("categoryno") int categoryno,
			  							 @RequestParam(value = "page", required=false, defaultValue="1") int page) {
		  List<ProductDTO> result = pls.PriceScrollPage(categoryno,page);
		  return result;
		  }
	  
	  @RequestMapping(value = "/ProductHitList" , method = RequestMethod.GET) 
	  public ModelAndView ProductHitList(@RequestParam("categoryno") int categoryno,
			  							 @RequestParam(value = "page", required=false, defaultValue="1") int page) {
		  mav = pls.ProductHitList(categoryno,page);  
		  return mav;
		  }
	  
	  @RequestMapping(value = "/HitScrollPage" , method = RequestMethod.GET) 
	  public @ResponseBody List<ProductDTO> HitScrollPage(@RequestParam("categoryno") int categoryno,
			  							 @RequestParam(value = "page", required=false, defaultValue="1") int page) {
		  List<ProductDTO> result = pls.HitScrollPage(categoryno,page);
		  return result;
		  }
	  
	  @RequestMapping(value = "/ProductQna" , method = RequestMethod.GET) 
	  public @ResponseBody List<ProductQnaDTO> ProductQna(@RequestParam("qnacontents") String qnacontents,
			  							 	@RequestParam("number") int number,
			  							 	@RequestParam("password") int password,
			  							 	@RequestParam("qnacheck") int qnacheck,
			  							 	@RequestParam(value = "page",required=false, defaultValue="1") int page
			  							 	) {

		  String userid = (String) session.getAttribute("loginId");
		  ProductQnaDTO qna = new ProductQnaDTO();
		  qna.setProductno(number);
		  qna.setContents(qnacontents);
		  qna.setId(userid);
		  qna.setQnacheck(qnacheck);
		  qna.setPassword(password);
		  List<ProductQnaDTO> list = pls.ProductQnaInsert(qna,page);
		  return list;
		  }
	  
	  @RequestMapping(value = "/QnaView" , method = RequestMethod.GET) 
	  public @ResponseBody ProductQnaDTO QnaView(@RequestParam("inputString") int inputString,
			  							 	@RequestParam("qnano") int qnano
			  							 	) {

		  ProductQnaDTO qna = new ProductQnaDTO();
		  qna.setQnano(qnano);
		  qna.setPassword(inputString);
		  ProductQnaDTO list = pls.QnaView(qna);
		  return list;
		  }
	  
	  
	  @RequestMapping(value = "/Qnareply" , method = RequestMethod.GET) 
	  public @ResponseBody List <ProductAnswerDTO> Qnareply(@RequestParam("qnaanswer") String qnaanswer,
			  							 	@RequestParam("qnano") int qnano
			  							 	) {
		  String userid = (String) session.getAttribute("loginId");
		  ProductAnswerDTO answer = new ProductAnswerDTO();
		  answer.setQnano(qnano);
		  answer.setContents(qnaanswer);
		  answer.setId(userid);
		  List <ProductAnswerDTO> list = new ArrayList<ProductAnswerDTO>();
		  list = pls.Qnareply(answer);
		  return list;
		  }
	  
	  @RequestMapping(value = "/QnaRereply" , method = RequestMethod.GET) 
	  public @ResponseBody List <ProductAnswerDTO> QnaRereply( @RequestParam("qnano") int qnano
			  							 	) {

		  List <ProductAnswerDTO> list = new ArrayList<ProductAnswerDTO>();
		  list = pls.QnaRereply(qnano);
		  return list;
		  }
	  
	  
	  @RequestMapping(value = "/QnaAjax" , method = RequestMethod.GET) 
	  public @ResponseBody List<ProductQnaDTO> QnaAjax(@RequestParam("page") int page ,
			  									@RequestParam("productno") int productno) {
		  List<ProductQnaDTO> list = pls.QnaAjax(page,productno);
		  return list;
		  }
	  
	  
	  @RequestMapping(value = "/CartDel" , method = RequestMethod.GET) 
	  public ModelAndView CartDel(@RequestParam("cartno") int cartno) {
		  mav = pls.CartDel(cartno);
		  
		  return mav;
		  }
	  
	  @RequestMapping(value = "/ProductPayment" , method = RequestMethod.POST) 
	  public ModelAndView ProductPayment() {
		  mav = pls.ProductPayment();
		  return mav;
		  }
	  @RequestMapping(value = "/buyList" , method = RequestMethod.GET) 
	  public ModelAndView buyList() {
		  String userid = (String) session.getAttribute("loginId");
		  mav = pls.buyList(userid);
		  return mav;
		  }
	  
	  @RequestMapping(value="OrderInsert" , method = RequestMethod.GET)
		public @ResponseBody String OrderInsert(@ModelAttribute ProductOrderDTO order) {
			String userid = (String) session.getAttribute("loginId");
			order.setId(userid);
		  	String result = pls.OrderInsert(order);
			return result;
		}
	  @RequestMapping(value = "/SalesBuyList" , method = RequestMethod.GET) 
	  public ModelAndView SalesBuyList() {
		  String userid = (String) session.getAttribute("loginId");
		  mav = pls.SalesBuyList(userid);
		  return mav;
		  }

	  
	  @RequestMapping(value = "/hotelCrawling" , method = RequestMethod.GET) 
	  public ModelAndView hotelCrawling() throws IOException {
		  mav = new ModelAndView();
		  String url = "https://www.airbnb.co.kr/s/%EC%A0%9C%EC%A3%BC%EB%8F%84/homes?tab_id=home_tab&refinement_paths%5B%5D=%2Fhomes&place_id=ChIJRUDITFTjDDURMb8emNI2vGY&source=structured_search_input_header&search_type=unknown&query=%EC%A0%9C%EC%A3%BC%EB%8F%84%2C%20%ED%95%9C%EA%B5%AD&checkin=2020-06-07&checkout=2020-07-03&adults=2&map_toggle=false";
		  System.out.println("-----------");
		  System.out.println("url" + url);
		  Document doc = Jsoup.connect(url).get();
		/* System.out.println(doc); */
		
		  List<CrawlingDTO> list = new ArrayList<CrawlingDTO>();
		  CrawlingDTO craw = null;
		  Elements element = doc.select("div._sh35u3h");
		  Elements img = doc.select("div._4626ulj img[src]");
		  Elements price = doc.select("div._o60r27k");
		  Elements link = doc.select("div._1wz0grtk a[href]");
		  int idx=0;
		  for(int i=0 ; i<element.size() ; i++) {
			  craw = new CrawlingDTO();
			  craw.setSrc(img.get(i).attr("src"));
			  String money = price.get(i).text();
			  idx = money.indexOf("할인");
			  System.out.println(money+"idx qjsghhhhh" +idx);
			  if(idx == -1) {
				  craw.setPrice(money);
			  } else {
				  String lang = money.substring(idx, money.length());
				  craw.setPrice(lang);
			  }
			  System.out.println(money+idx+money.length());
			  craw.setText(element.get(i).text());
			/* craw.setPrice(price.get(i).text()); */
			  craw.setLink("https://www.airbnb.co.kr"+link.get(i).attr("href"));
			  System.out.println(link.get(i).attr("href"));
			  list.add(craw);
			  }
		  System.out.println(list.get(0));
		  mav.addObject("list", list);
		  mav.setViewName("product/hotelCrawling");
		  return mav;
		  }
	  
	  @RequestMapping(value = "/product_recentlist" , method = RequestMethod.GET) 
	  public ModelAndView product_recentlist() {
		  String userid = (String) session.getAttribute("loginId");
		  mav = pls.product_recentlist(userid);
		  return mav;
		  }
	  @RequestMapping(value = "/ProductSalesOrder" , method = RequestMethod.GET) 
	  public ModelAndView ProductSalesOrder(@RequestParam("no") int no) {
		  mav = pls.ProductSalesOrder(no);
		  return mav;
		  }
	  
	  
	  
	  @RequestMapping(value = "/product") 
	  public String product() {
		  return "product/product"; 
		  }
	  @RequestMapping(value = "/room") 
	  public String room() {
		  System.out.println("132test");
		  return "chat/room"; 
		  }
	  @RequestMapping(value = "/header") 
	  public String header() {
		  return "header"; 
		  }
	  @RequestMapping(value = "/imgtest") 
	  public String imgtest() {
		  return "product/imgtset"; 
		  }
	  @RequestMapping(value = "/kakaomap") 
	  public String kakaomap() {
		  return "product/kakaomap"; 
		  }
	 
	  
}
