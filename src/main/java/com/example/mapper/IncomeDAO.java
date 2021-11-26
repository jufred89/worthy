package com.example.mapper;

import java.util.HashMap;
import java.util.List;

public interface IncomeDAO {
	public List<HashMap<String, Object>> getDayIncome();
	public List<HashMap<String, Object>> getDayProductIncome();
	public List<HashMap<String, Object>> getBestProduct();
	public List<HashMap<String, Object>> getWorstProduct();
	public List<HashMap<String, Object>> getMonthIncome();
	public List<HashMap<String, Object>> getBestCamping();
	public List<HashMap<String, Object>> getWorstCamping();
}
