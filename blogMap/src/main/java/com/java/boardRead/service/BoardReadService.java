package com.java.boardRead.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public interface BoardReadService {
	public void getData(ModelAndView mav);
	
	public String getBeginCondition();
	
	public String getLocationCondition(HttpServletRequest request, HttpServletResponse response);
	
	public String getCategoryCondition(HttpServletRequest request, HttpServletResponse response);

	public void blogListSearch(ModelAndView mav);

	public void blogListResult(ModelAndView mav);

	public void blogReadDetail(ModelAndView mav);

	public void blogReadDetailImg(ModelAndView mav);
}
