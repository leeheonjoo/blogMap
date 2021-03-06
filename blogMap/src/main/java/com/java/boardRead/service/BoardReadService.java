package com.java.boardRead.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public interface BoardReadService {
	public String getBeginCondition();
	
	public String getLocationCondition(HttpServletRequest request, HttpServletResponse response);
	
	public String getCategoryCondition(HttpServletRequest request, HttpServletResponse response);

	public void blogListSearch(ModelAndView mav);

	public void blogListResult(ModelAndView mav);

	public void blogReadDetail(ModelAndView mav);

	public void blogReadDetailImg(ModelAndView mav);

	public void blogListSearchSub1(ModelAndView mav);

	public void blogListSearchSub2(ModelAndView mav);
	
	public String getRecommandBlog();

	public void blogReadReference(ModelAndView mav);

	public void blogReadNoReference(ModelAndView mav);

	public void referenceRefresh(ModelAndView mav);

	public void bookMark(ModelAndView mav);

	public void NobookMark(ModelAndView mav);

	public void blogDelete(ModelAndView mav);

	public void blogUpdate(ModelAndView mav);

	public void blogUpdateOk(ModelAndView mav);

	
}
