package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class IncomeDAOImpl implements IncomeDAO {

	@Autowired
	SqlSession session;
	
	String namespace="com.example.mapper.IncomeMapper";
	
	@Override
	public List<HashMap<String, Object>> getDayIncome() {
		return session.selectList(namespace+".getDayIncome");
	}

	@Override
	public List<HashMap<String, Object>> getDayProductIncome() {
		return session.selectList(namespace+".getDayProductIncome");
	}

	@Override
	public List<HashMap<String, Object>> getBestProduct() {
		return session.selectList(namespace+".getBestProduct");
	}

	@Override
	public List<HashMap<String, Object>> getWorstProduct() {
		return session.selectList(namespace+".getWorstProduct");
	}

	@Override
	public List<HashMap<String, Object>> getMonthIncome() {
		return session.selectList(namespace+".getMonthIncome");
	}

	@Override
	public List<HashMap<String, Object>> getBestCamping() {
		return session.selectList(namespace+".getBestCamping");
	}

	@Override
	public List<HashMap<String, Object>> getWorstCamping() {
		return session.selectList(namespace+".getWorstCamping");
	}

}
