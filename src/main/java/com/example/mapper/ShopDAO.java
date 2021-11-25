package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import com.example.domain.AttachVO;
import com.example.domain.Criteria;
import com.example.domain.Shop_payVO;
import com.example.domain.ShopVO;
import com.example.domain.Shop_cartVO;
import com.example.domain.Shop_orderVO;
import com.example.domain.Shop_previewVO;

public interface ShopDAO {
	public List<HashMap<String, Object>> prod_list(Criteria cri);
	public ShopVO prod_read(String prod_id);
	public int totalCount(Criteria cri);
	public void prod_insert(ShopVO vo);
	public void prod_update(ShopVO vo);
	public String prod_maxID();
	public void prod_delete(String prod_id);
	public List<HashMap<String, Object>> prod_slide();
	
	//attach
	public AttachVO attach(String shop_pid);
	public void att_insert(AttachVO avo);
	public void att_update(AttachVO avo);
	
	//preview
	public List<HashMap<String, Object>> pre_list(Criteria cri, String prod_rid);
	public void pre_insert(Shop_previewVO pvo);
	public int pre_totalCount(String prod_rid);
	public void pre_delete(int prod_rno);
	
	//cart
	public void cart_insert(Shop_cartVO cvo);
	public List<HashMap<String, Object>> cart_list(String cart_uid);
	public void cart_delete(int cart_no);
	public int cart_price_sum(String cart_uid);
	public int prodQty(String prod_id);
	
	//admin
	public List<HashMap<String, Object>> adminListJSON(Criteria cri);
	public void adminQtyUpdate(ShopVO vo);
	public void adminHideUpdate(ShopVO vo);
	public int adminTotalCount(Criteria cri);
	public List<HashMap<String, Object>> adminShopJSON(Criteria cri);
	public int adminOrderCount(Criteria cri);
	public void adminStatusUpdate(int pay_no);
	
	//payment
	public void pay_insert(Shop_payVO pvo);
	public void order_insert(Shop_orderVO ovo);
	public void orderProdUpdate(ShopVO vo);
	public void orderCartUpdate(Shop_cartVO cvo);
	public Shop_payVO payRead(int pay_no);
	public void payUpdate(Shop_payVO pvo);
	public void pay_success(Shop_payVO pvo);
	public Shop_payVO pay_Allread(int pay_no);
	public int user_maxNo(String pay_uid);
	
	//myshop
	public List<HashMap<String, Object>> myshopList2(String cart_uid);
	public List<HashMap<String, Object>> myshopList3(String cart_uid);
	public List<HashMap<String, Object>> myshopList4(String cart_uid);
	public void order_cancel(int pay_no);
	public List<HashMap<String, Object>> orderInfo(int pay_no, int cart_no);
}
