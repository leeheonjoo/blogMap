package com.java.coupon.dao;

import java.util.List;

import com.java.partner.dto.PartnerDto;

public interface CouponDao {

	public int getCouponCount();

	public List<PartnerDto> getCouponList_L(String member_id);

	public List<PartnerDto> getCouponList_S(String member_id);

}
