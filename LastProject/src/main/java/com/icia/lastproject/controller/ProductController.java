package com.icia.lastproject.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.icia.lastproject.dto.ProductDTO;
import com.icia.lastproject.dto.ProductListTempDTO;
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
	public ModelAndView productView(@RequestParam("number") int number) {
		String userid = (String) session.getAttribute("loginId");
		System.out.println(userid);
		mav = pls.productView(number,userid); 
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
	  
	  
	  
	  
	  
	  
	  
	  @RequestMapping(value = "/product") 
	  public String product() {
		  return "product/product"; 
		  }
	  @RequestMapping(value = "/header") 
	  public String header() {
		  return "header"; 
		  }
	  @RequestMapping(value = "/imgtest") 
	  public String imgtest() {
		  return "product/imgtset"; 
		  }
	 
	  
}
