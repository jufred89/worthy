package com.example.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.domain.NoticeVO;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	@Autowired
	SqlSession session;
	String namespace="com.example.mapper.NoticeMapper";
	
	@Override
	public List<NoticeVO> list() {
		return session.selectList(namespace + ".list");
	}

	@Override
	public NoticeVO read(int nb_no) {
		return session.selectOne(namespace + ".read", nb_no);
	}

	@Override
	public void insert(NoticeVO vo) {
		session.insert(namespace + ".insert", vo);
	}

	@Override
	public void delete(int nb_no) {
		session.delete(namespace + ".delete", nb_no);		
	}

}
