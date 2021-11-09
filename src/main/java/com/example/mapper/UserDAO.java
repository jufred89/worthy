package com.example.mapper;

import com.example.domain.UserVO;

public interface UserDAO {
	public UserVO login(String uid);
	public void insert(UserVO vo);
	public void update(UserVO vo);
}
