package com.java.board.service;

import org.springframework.web.servlet.ModelAndView;

public interface BoardService {
	public void searchMap(ModelAndView mav);

	public String onePhotoUpload(ModelAndView mav);

	public void multiPhotoUpload(ModelAndView mav);

	public void getCategory(ModelAndView mav);

	public void blogWrite(ModelAndView mav);

	public void coupon_issue(ModelAndView mav);

	public void getCoupon(ModelAndView mav);
	
}
