package com.java.partner.service;

import org.springframework.web.servlet.ModelAndView;
/**
 * @name: PartnerService
 * @date:2015. 7. 5.
 * @author: 변태훈
 * @description: Controller 에서 정보를 받아 실제 작업을 하기 위한 선언 단계
 */
public interface PartnerService {
	
	public void write(ModelAndView mav);	
	
	public void writeList(ModelAndView mav);
	
	public void getTourPartnerListDate(ModelAndView mav);
	
	public void couponWrite(ModelAndView mav);
	
	public void couponWriteList(ModelAndView mav);
	
	public void getSearchPartnerDate(ModelAndView mav);
	
	public void writeCouponList(ModelAndView mav);
	
	public void search_partnerCouponinfo(ModelAndView mav);
	
	public void getPartnerCouponData(ModelAndView mav);
}
