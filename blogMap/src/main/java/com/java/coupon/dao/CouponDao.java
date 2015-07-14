package com.java.coupon.dao;

import java.util.List;

import com.java.coupon.dto.CouponDto;

public interface CouponDao {

	public int getCouponCount();

	public List<CouponDto> getCouponList_L(String member_id);

	public List<CouponDto> getCouponList_S(String member_id);

}
