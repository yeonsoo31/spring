package com.icia.lastproject.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.lastproject.dto.MemberDTO;
import com.icia.lastproject.dto.PagingDTO;
import com.icia.lastproject.dto.SnsDTO;
import com.icia.lastproject.dto.SnsFriendDTO;

@Repository
public class SnsDAO {

	@Autowired
	private SqlSessionTemplate sql;

	public int snsWrite(SnsDTO sns) {
		return sql.insert("Sns.snsWrite", sns);
	}

	public List<SnsDTO> snsList(PagingDTO paging) {
		return sql.selectList("Sns.snsList",paging);
	}

	public List<SnsFriendDTO> snsFriendList(String id) {
		return sql.selectList("Sns.snsFriendList", id);
	}

	public List<MemberDTO> memberSearch(String search) {
		return sql.selectList("Sns.memberSearch", search);
	}

	public List<MemberDTO> sellerSearch(String search) {
		return sql.selectList("Sns.sellerSearch", search);
	}

	public List<SnsDTO> boardSearch(String search) {
		return sql.selectList("Sns.boardSearch", search);
	}

	public int addFriend(SnsFriendDTO addFriend) {
		return sql.insert("Sns.addFriend", addFriend);
	}

	public List<SnsFriendDTO> snsFriendList2(String f_id) {
		return sql.selectList("Sns.snsFriendList2", f_id);
	}

	public Integer friendDivision(HashMap<String, Object> hash) {
		return sql.selectOne("Sns.friendDivision", hash);
	}

	public int deleteFriend(HashMap<String, Object> hash) {
		return sql.delete("Sns.deleteFriend", hash);
		
	}

	public int cancelFriend(HashMap<String, Object> hash) {
		return sql.delete("Sns.cancelFriend", hash);
	}

	public int friendRequest(String id) {
		return sql.selectOne("Sns.friendRequest",id );
	}

	public List<SnsFriendDTO> friendRequestList(String id) {
		return sql.selectList("Sns.friendRequestList",id);
	}

	public int requestAccept(SnsFriendDTO snsFriend) {
		return sql.update("Sns.requestAccept", snsFriend);
	}

	public void friendCheck(SnsFriendDTO snsFriend) {
		sql.insert("Sns.friendCheck", snsFriend);
		
	}

	public int requestReject(SnsFriendDTO snsFriend) {
		return sql.delete("Sns.requestReject", snsFriend);
	}

	public SnsDTO write() {
		return sql.selectOne("Sns.write");
	}

	public int deleteSnsPost(int s_number) {
		return sql.delete("Sns.deleteSnsPost", s_number);
	}
	
	public List<MemberDTO> friendStatus(String f_id) {
		return sql.selectList("Sns.friendStatus", f_id);
	}

	public List<SnsDTO> friendBoard(String f_name) {
		return sql.selectList("Sns.friendBoard", f_name);
	}

	
}
