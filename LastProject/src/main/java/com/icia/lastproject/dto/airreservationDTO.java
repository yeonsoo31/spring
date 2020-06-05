package com.icia.lastproject.dto;

public class airreservationDTO {
	private int reservationnunm;
	private int endnum;
	private String id;
	private String gender;
	private String kname;
	private String Ename;
	private String birth;
	public int getReservationnunm() {
		return reservationnunm;
	}
	public void setReservationnunm(int reservationnunm) {
		this.reservationnunm = reservationnunm;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getKname() {
		return kname;
	}
	public void setKname(String kname) {
		this.kname = kname;
	}
	public String getEname() {
		return Ename;
	}
	public void setEname(String ename) {
		Ename = ename;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public int getEndnum() {
		return endnum;
	}
	public void setEndnum(int endnum) {
		this.endnum = endnum;
	}
	@Override
	public String toString() {
		return "airreservationDTO [reservationnunm=" + reservationnunm + ", gender=" + gender + ", kname=" + kname
				+ ", Ename=" + Ename + ", birth=" + birth + "]";
	}
}
