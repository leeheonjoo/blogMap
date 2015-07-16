package com.java.coupon.dao;

import java.util.HashMap;
import java.util.List;

public interface CouponDao {

	public int getCouponCount();

	public List<HashMap<String, Object>> getCouponList();

	public List<HashMap<String, Object>> getCouponList_S(String partner_name);

}
