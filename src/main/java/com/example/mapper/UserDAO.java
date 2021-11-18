package com.example.mapper;

import java.util.List;

import com.example.domain.Criteria;
import com.example.domain.UserVO;

public interface UserDAO {
	public UserVO login(String uid);
	public void insert(UserVO vo);
	public void update(UserVO vo);
	public void adminupdate(UserVO vo);
	public List<UserVO> list(Criteria cri);
	public UserVO read(String uid);
	public int userTotcount(Criteria cri);
}
