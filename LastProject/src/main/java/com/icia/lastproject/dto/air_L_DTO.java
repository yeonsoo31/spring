package com.icia.lastproject.dto;


import lombok.Data;


public class air_L_DTO {
	private String airportname;
	private String airname;
	private String time;
	private String starttime;
	private String endtime;
	private String startarea;
	private String endarea;
	private int endprice;
	private int endnum;
	private int airuser;
	public String getAirportname() {
		return airportname;
	}
	public void setAirportname(String airportname) {
		this.airportname = airportname;
	}
	public String getAirname() {
		return airname;
	}
	public void setAirname(String airname) {
		this.airname = airname;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getStartarea() {
		return startarea;
	}
	public void setStartarea(String startarea) {
		this.startarea = startarea;
	}
	public String getEndarea() {
		return endarea;
	}
	public void setEndarea(String endarea) {
		this.endarea = endarea;
	}
	public int getEndprice() {
		return endprice;
	}
	public void setEndprice(int endprice) {
		this.endprice = endprice;
	}
	public int getEndnum() {
		return endnum;
	}
	public void setEndnum(int endnum) {
		this.endnum = endnum;
	}
	public int getAiruser() {
		return airuser;
	}
	public void setAiruser(int airuser) {
		this.airuser = airuser;
	}
	@Override
	public String toString() {
		return "air_L_DTO [airportname=" + airportname + ", airname=" + airname + ", time=" + time + ", starttime="
				+ starttime + ", endtime=" + endtime + ", startarea=" + startarea + ", endarea=" + endarea
				+ ", endprice=" + endprice + ", endnum=" + endnum + ", airuser=" + airuser + "]";
	}
	
}
