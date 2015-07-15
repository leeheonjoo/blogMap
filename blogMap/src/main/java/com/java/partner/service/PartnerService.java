package com.java.partner.service;

import org.springframework.web.servlet.ModelAndView;
/**
 * @name: PartnerService
 * @date:2015. 7. 5.
 * @author: 변태훈
 * @description: Controller 에서 정보를 받아 실제 작업을 하기 위한 선언 단계
 */
public interface PartnerService {
	
	public boolean write(ModelAndView mav);	
	
	public void writeList(ModelAndView mav);
	
	public void getTourPartnerListDate(ModelAndView mav);
	
	public boolean couponWrite(ModelAndView mav);
	
	public void couponWriteList(ModelAndView mav);
	
}
