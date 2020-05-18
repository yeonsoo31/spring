package com.icia.lastproject.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.lastproject.dto.CartDTO;
import com.icia.lastproject.dto.MemberDTO;
import com.icia.lastproject.dto.PageDTO;
import com.icia.lastproject.dto.ProductDTO;
import com.icia.lastproject.dto.ProductListDTO;
import com.icia.lastproject.dto.ProductListTempDTO;

@Repository
public class ProductDAO {
	@Autowired
	private SqlSessionTemplate sql;


	public int Listinsert(ProductListTempDTO plist) {
		return sql.insert("Product.listinsert", plist);
	}


	public int productAdd(ProductDTO product) {
		return sql.insert("Product.productinset", product);
	}


	public int productListAdd() {
		return sql.insert("Product.productListInsert");
	}


	public List<ProductDTO> productList(PageDTO paging) {
		return sql.selectList("Product.productList", paging);
	}


	public int listCount() {
		return sql.selectOne("Product.pageCount");
	}


	public int deleteList() {
		return sql.delete("Product.deleteList");
	}


	public ProductDTO SelectProduct(int number) {
		return sql.selectOne("Product.ProductView", number);
	}


	public List<ProductListTempDTO> SelectProductList(int number) {
		return sql.selectList("Product.ProductListView", number);
	}


	public int ProductPriceAjax(int num) {
		return sql.selectOne("Product.ProductPriceAjax", num);
	}


	public int CartInsert(Map<String, Object> map) {
		return sql.insert("Product.CartInsert", map);
	}


	public List<CartDTO> CartView(String userid) {
		return sql.selectList("Product.CartView", userid);
	}


	public ProductDTO productModifyForm(int productno) {
		return sql.selectOne("Product.productModifyForm", productno);
	}


	public List<ProductListDTO> productlistModifyForm(int productno) {
		return sql.selectList("Product.productListModifyForm", productno);
	}


	public int productModify(ProductDTO product) {
		if(product.getPhoto2() == null && product.getPhoto3() == null) {
			return sql.update("Product.productModify1", product);
		} else if(product.getPhoto2() != null && product.getPhoto3() ==null) {
			return sql.update("Product.productModify2", product);
		} else {
			return sql.update("Product.productModify3", product);
		}
	}


	public int productDelete(int productno) {
		return sql.delete("Product.productDelete", productno);
	}


	public int productListDelete(int productno) {
		return sql.delete("Product.productListDalete",productno);
	}


	public List<CartDTO> Order(List<Integer> list) {
		return sql.selectList("Product.Order", list);
	}


	public MemberDTO OrderUserid(String userid) {
		return sql.selectOne("Product.OrderUser", userid);
	}


	public int ScrollListCount(int categoryno) {
		return sql.selectOne("Product.ScrollCount", categoryno);
	}


	public List<ProductDTO> productScorll(PageDTO paging) {
		return sql.selectList("Product.ScrollSelect", paging);
	}


	public List<ProductDTO> serch(String serch) {
		return sql.selectList("Product.Serch", serch);
	}


	public int hitCount(int number) {
		return sql.update("Product.HitUpdate", number);
	}


	public List<ProductDTO> productList1() {
		return sql.selectList("Product.productList1");
	}
	public List<ProductDTO> productList2() {
		return sql.selectList("Product.productList2");
	}
	public List<ProductDTO> productList3() {
		return sql.selectList("Product.productList3");
	}




}
