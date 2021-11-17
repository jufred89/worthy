package com.example.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.Criteria;
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

	@Override
	public UserVO read(String uid) {
		return session.selectOne(namespace+".read", uid);
	}

	@Override
	public List<UserVO> list(Criteria cri) {
		return session.selectList(namespace+".list",cri);
	}

	@Override
	public void adminupdate(UserVO vo) {
		session.update(namespace+".adminupdate",vo);
		
	}

}
