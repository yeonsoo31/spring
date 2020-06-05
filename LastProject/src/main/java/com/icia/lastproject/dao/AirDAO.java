package com.icia.lastproject.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.lastproject.dto.PageDTO;
import com.icia.lastproject.dto.airPageDTO;
import com.icia.lastproject.dto.air_L_DTO;
import com.icia.lastproject.dto.airreservationDTO;
import com.icia.lastproject.dto.userreservationDTO;

@Repository
public class AirDAO {
	@Autowired
	private SqlSessionTemplate sql;

	public int listCount() {
		return sql.selectOne("airReservation.listCount");
	}

	public List<air_L_DTO> airssearch(air_L_DTO airl) {
		return sql.selectList("airReservation.airssearch", airl);
	}

	public air_L_DTO airreservation(int endnum) {
		return sql.selectOne("airReservation.endnum", endnum);
	}

	public int userreservation(HashMap<String, Object> hashMap) {
		return sql.insert("airReservation.ureservation", hashMap);
	}

	public List<userreservationDTO> myReservation(String id) {
		return sql.selectList("airReservation.myReservation", id);
	}

	public int airpaymentView(int reservationnum) {
		return sql.update("airReservation.payment", reservationnum);
	}

	public userreservationDTO desion(int reservationnum) {
		return sql.selectOne("airReservation.dision", reservationnum);
	}

	public air_L_DTO arlreser(int endnum) {
		return sql.selectOne("airReservation.arlreser", endnum);
	}


	public int paymentUpdate(int no) {
		return sql.update("airReservation.paymentUpdate", no);
	}

	public userreservationDTO airport(int reservationnum) {
		return sql.selectOne("airReservation.airport", reservationnum);
	}

	public List<air_L_DTO> airListPaging(airPageDTO paging) {
		return sql.selectList("airReservation.airlistPaging", paging);
	}

	public List<air_L_DTO> airendareaListPatin(airPageDTO paging) {
		return sql.selectList("airReservation.airsearch", paging);
	}

	public int endareaListCount(String endarea) {
		return sql.selectOne("airReservation.airlistcount", endarea);
	}

	public int reservationdelete(int reservationnum) {
		return sql.update("airReservation.airdelete", reservationnum);
	}


	

	

	
	

	

}
