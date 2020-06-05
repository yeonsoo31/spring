package com.icia.lastproject.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.lastproject.dto.MessageDTO;

@Repository
public class ChatDAO {

	@Autowired
	private SqlSessionTemplate sql;
	
	public void addMessage(MessageDTO addMessage) {
		sql.insert("Chat.addMessage", addMessage);
	}

	public List<MessageDTO> goChat(MessageDTO message) {
		return sql.selectList("Chat.messageList", message);
	}

	public List<MessageDTO> friendMessageList(MessageDTO message) {
		return sql.selectList("Chat.friendMessageList", message);
	}

	public int messageList(String id) {
		return sql.selectOne("Chat.messageCount", id);
	}

	public int friendMessageCount(MessageDTO message) {
		return sql.selectOne("Chat.friendMessageCount", message);
	}

	public void readMessage(MessageDTO message) {
		sql.update("Chat.readMessage", message);
		
	}

}
