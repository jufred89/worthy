package com.example.mapper;

import java.util.List;

import com.example.domain.ChatVO;

public interface ChatDAO {
	public List<ChatVO> list(String chat_room);
	public void insert(ChatVO vo);
	public void delete(int chat_no);
	public int lastNo(String chat_id);
	public List<ChatVO> chatList();
}
