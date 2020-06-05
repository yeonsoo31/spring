package com.icia.lastproject.chat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.icia.lastproject.dao.ChatDAO;
import com.icia.lastproject.dto.MessageDTO;

@Component
public class EchoHandler extends TextWebSocketHandler {
	
	@Autowired
	private ChatDAO cdao;
	
	private List<WebSocketSession> users;
	private Map<String, Object> userMap;
	
	public EchoHandler() {
		users = new ArrayList<WebSocketSession>();
		userMap = new HashMap<String, Object>();
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session)throws Exception{
		System.out.println("연결생성");
		System.out.println(session);
		users.add(session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message)throws Exception{
		System.out.println("메세지수신");
		System.out.println("메세지 : "+message.getPayload());
		
		MessageDTO addMessage = new MessageDTO();
		JSONObject object = new JSONObject(message.getPayload());
		String type = object.getString("type");
		if(type != null && type.equals("register")) {
			String user = object.getString("userid");
			System.out.println("내아이디 : "+object.getString("userid"));
			userMap.put(user,session);
		}else {
			String f_id = object.getString("target");
			WebSocketSession ws = (WebSocketSession)userMap.get(f_id);
			String msg = object.getString("message");
			addMessage.setId(object.getString("id"));
			addMessage.setF_id(f_id);
			addMessage.setMessage(msg);
			System.out.println("내아이디 : "+ object.getString("id"));
			System.out.println("받는사람 아이디:" + f_id);
			System.out.println("내가 보내는 메세지 : "+ msg);
			System.out.println(userMap.keySet());
			cdao.addMessage(addMessage);
			if(ws != null) {
				ws.sendMessage(new TextMessage(msg));
			}
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status)throws Exception{
		System.out.println("연결종료");
		users.remove(session);
	}
}
