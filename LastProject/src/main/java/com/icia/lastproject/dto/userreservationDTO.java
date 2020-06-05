package com.icia.lastproject.dto;

public class userreservationDTO {
	private int reservationnum;
	private int endnum;
	private String id;
	private String name;
	private String phone;
	private String phone1;
	private String naverid;
	private String kakaoid;
	private String facebookid;
	private String googleid;
	private String email;
	private int resultprice;
	private int airuser;
	private int payment;
	public int getReservationnum() {
		return reservationnum;
	}
	public void setReservationnum(int reservationnum) {
		this.reservationnum = reservationnum;
	}
	public int getEndnum() {
		return endnum;
	}
	public void setEndnum(int endnum) {
		this.endnum = endnum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPhone1() {
		return phone1;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public String getNaverid() {
		return naverid;
	}
	public void setNaverid(String naverid) {
		this.naverid = naverid;
	}
	public String getKakaoid() {
		return kakaoid;
	}
	public void setKakaoid(String kakaoid) {
		this.kakaoid = kakaoid;
	}
	public String getFacebookid() {
		return facebookid;
	}
	public void setFacebookid(String facebookid) {
		this.facebookid = facebookid;
	}
	public String getGoogleid() {
		return googleid;
	}
	public void setGoogleid(String googleid) {
		this.googleid = googleid;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getResultprice() {
		return resultprice;
	}
	public void setResultprice(int resultprice) {
		this.resultprice = resultprice;
	}
	public int getAiruser() {
		return airuser;
	}
	public void setAiruser(int airuser) {
		this.airuser = airuser;
	}
	public int getPayment() {
		return payment;
	}
	public void setPayment(int payment) {
		this.payment = payment;
	}
	@Override
	public String toString() {
		return "userreservationDTO [reservationnum=" + reservationnum + ", endnum=" + endnum + ", id=" + id + ", name="
				+ name + ", phone=" + phone + ", phone1=" + phone1 + ", naverid=" + naverid + ", kakaoid=" + kakaoid
				+ ", facebookid=" + facebookid + ", googleid=" + googleid + ", email=" + email + ", resultprice="
				+ resultprice + ", airuser=" + airuser + ", payment=" + payment + "]";
	}
	
	
	
}
