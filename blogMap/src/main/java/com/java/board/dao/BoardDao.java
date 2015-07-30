package com.java.board.dao;

import java.util.HashMap;
import java.util.List;

public interface BoardDao {
	public List<String> getHeaderCondition();

	public HashMap<String, Object> blogWrite(HashMap<String, Object> hashMap);

	public int blogWrite_attach(HashMap<String, Object> hashMap);

	public List<HashMap<String, Object>> coupon_data_list(int board_no);

	public int getCoupon(String member_id, String coupon_no);

	public int checkCoupon(String member_id, String coupon_no);
}
