package com.icia.lastproject.dao;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.lastproject.dto.GroupBuyDTO;
import com.icia.lastproject.dto.PageDTO;

@Repository
public class GroupBuyDAO {

	@Autowired
	private SqlSessionTemplate sql;

	public int groupBuyingAdd(GroupBuyDTO groupBuy) {
		System.out.println(groupBuy.toString());
		return sql.insert("GroupBuy.groupBuyingAdd", groupBuy);
	}

	public int listCount() {
		return sql.selectOne("GroupBuy.listCount");
	}

	public List<GroupBuyDAO> groupBuyListPaging(PageDTO paging) {
		return sql.selectList("GroupBuy.groupBuyListPaging", paging);
	}

	public int groupBuyHit(int g_number) {
		return sql.update("GroupBuy.groupBuyHit", g_number);
	}

	public GroupBuyDTO groupBuyView(int g_number) {
		return sql.selectOne("GroupBuy.groupBuyView", g_number);
	}

}
