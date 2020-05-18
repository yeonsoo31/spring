package com.icia.lastproject.dto;

import org.springframework.stereotype.Service;

import lombok.Data;

public class ProductListTempDTO {

		private String color;
		private String size;
		private String saleprice;
		private String stock;
		public String getColor() {
			return color;
		}
		public void setColor(String color) {
			this.color = color;
		}
		public String getSize() {
			return size;
		}
		public void setSize(String size) {
			this.size = size;
		}
		public String getSaleprice() {
			return saleprice;
		}
		public void setSaleprice(String saleprice) {
			this.saleprice = saleprice;
		}
		public String getStock() {
			return stock;
		}
		public void setStock(String stock) {
			this.stock = stock;
		}
		
		
}
