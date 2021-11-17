package com.example.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatHandler extends TextWebSocketHandler{
	List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("�����: "+session.getId());
		sessionList.add(session);
		System.out.println("����� ����: "+sessionList.size());
		super.afterConnectionEstablished(session);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("�������: "+session.getId());
		sessionList.remove(session);
		super.afterConnectionClosed(session, status);
	}
	
	//Ŭ���̾�Ʈ(������)���� ������ �޽����� ������ ��
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String strMessage = message.getPayload();
		System.out.println("�޽���: "+strMessage);
		
		//����� ���ǵ鿡�� �޽����� ���� ��
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strDate = sdf.format(new Date());
		strMessage += "|"+strDate;
		
		for(WebSocketSession webSocketSession : sessionList){
			webSocketSession.sendMessage(new TextMessage(strMessage));
		}
		super.handleTextMessage(session, message);
	}
	
}
