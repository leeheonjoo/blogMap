package com.java.coupon.dao;

import java.util.List;

import com.java.partner.dto.PartnerDto;

public interface CouponDao {

	public int getCouponCount();

	public List<PartnerDto> getCouponList();

}
