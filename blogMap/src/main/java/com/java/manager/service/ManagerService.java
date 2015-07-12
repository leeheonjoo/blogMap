package com.java.manager.service;

import org.springframework.web.servlet.ModelAndView;

public interface ManagerService {
	
	public void getData(ModelAndView mav);
	
	public void memberDel(ModelAndView mav);
	
	public void getPartnerDate(ModelAndView mav);
	
	public void getSearchPartnerDate(ModelAndView mav);
	
	public void getSearchPartnerYN(ModelAndView mav);
	
	public void getManagerDate(ModelAndView mav);
	
	public void getManagerLog(ModelAndView mav);
	
	public void partnerSubmit(ModelAndView mav);
	
	public void partnerDelete(ModelAndView mav);
	
	public void getCouponData(ModelAndView mav);
	
	public void couponSubmit(ModelAndView mav);
	
	public void partnerDetail(ModelAndView mav);
}
