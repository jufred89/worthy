package com.example.mapper;

import java.util.HashMap;
import java.util.List;

public interface IncomeDAO {
	public List<HashMap<String, Object>> getDayIncome();
	public List<HashMap<String, Object>> getDayProductIncome();
	public List<HashMap<String, Object>> getBestProduct();
}
