package com.java.partner.dao;

import java.util.HashMap;
import java.util.List;

import com.java.boardRead.dto.BoardReadDto;
import com.java.coupon.dto.CouponDto;
import com.java.partner.dto.PartnerDto;
/**
 * @name:PartnerDao
 * @date:2015. 7. 5.
 * @author: 변태훈
 * @description:제휴업체 등록 / 제휴업체 리스트 등록
 */
public interface PartnerDao {

	public int partnerRegister(PartnerDto partnerDto, BoardReadDto boardreadDto);
	
	public int getPartnerCount();
	
	public List<PartnerDto> getwriteList(String member_id);
	
	public List<HashMap<String, Object>> getTourPartnerListDate(HashMap<String, Object> hMap);
	
	public int couponRegister(CouponDto couponDto,int partner_no);

	public List<PartnerDto> getSearchParnterData(String partner_name);

	public int coupon_Register(CouponDto couponDto);
	
	public List<HashMap<String, Object>> getwriteCouponList(String member_id);
	
	public List<HashMap<String, Object>> search_partnerCouponinfo(String coupon_item);
	
	public List<HashMap<String,Object>> getPartnerCouponData(HashMap<String,Object> hMap);

}
