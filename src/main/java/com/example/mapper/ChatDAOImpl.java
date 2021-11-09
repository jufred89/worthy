package com.example.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.ChatVO;

@Repository
public class ChatDAOImpl implements ChatDAO{
	@Autowired
	SqlSession session;
	
	String namespace="com.example.mapper.ChatMapper";
	
	@Override
	public List<ChatVO> list(String chat_id) {
		return session.selectList(namespace+".list",chat_id);
	}

	@Override
	public void insert(ChatVO vo) {
		session.insert(namespace+".insert",vo);
	}

	@Override
	public void delete(int chat_no) {
		session.delete(namespace+".delete",chat_no);
	}

	@Override
	public int lastNo(String chat_id) {
		return session.selectOne(namespace+".lastNo",chat_id);
	}


	
	//------------------------°ü¸®ÀÚ---------------------------
	@Override
	public List<ChatVO> chatList() {
		return session.selectList(namespace+".chatList");
	}

}
