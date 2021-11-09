package com.example.mapper;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.UserVO;

@Repository
public class UserDAOImpl implements UserDAO{
	@Autowired
	SqlSession session;
	String namespace="com.example.mapper.UserMapper";
	
	@Override
	public UserVO login(String uid) {
		return session.selectOne(namespace + ".login", uid);
	}

	@Override
	public void insert(UserVO vo) {
		session.insert(namespace+".join", vo);
	}

	@Override
	public void update(UserVO vo) {
		session.update(namespace+".update",vo);
	}

}
