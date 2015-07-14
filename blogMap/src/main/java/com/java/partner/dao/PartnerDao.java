package com.java.partner.dao;

import java.util.List;

import com.java.coupon.dto.CouponDto;
import com.java.partner.dto.PartnerDto;
/**
 * @name:PartnerDao
 * @date:2015. 7. 5.
 * @author: 변태훈
 * @description:제휴업체 등록 / 제휴업체 리스트 등록
 */
public interface PartnerDao {

	public int partnerRegister(PartnerDto partnerDto);
	
	public int getPartnerCount();
	
	public List<PartnerDto> getTourPartnerList();
	
	public PartnerDto getTourPartnerListDate(int partnerNo);

	public List<PartnerDto> getRestaurantPartnerList();

	public PartnerDto getRestaurantPartnerListDate(int partnerNo);
	
	public int couponRegister(CouponDto couponDto,int partner_no);
}
