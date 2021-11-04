package com.example.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.example.mapper.MysqlMapper;
import com.example.mapper.NoticeDAO;
import com.example.mapper.RecipeDAO;
import com.example.mapper.TipDAO;

@RunWith(SpringJUnit4ClassRunner.class) //먼저 SpringJUnit4ClassRunner.class import한다. 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class MysqlTest2 {

	@Autowired
	private TipDAO mapper;

	@Test
	public void getTime() { 
		mapper.list();
	}
}
