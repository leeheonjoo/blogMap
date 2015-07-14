package com.java.coupon.controller;

import java.io.IOException;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.java.coupon.service.CouponService;

@Controller
public class CouponController {
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	
	@Autowired
	private CouponService couponService;
	
	@RequestMapping(value="/coupon/couponMain.do", method=RequestMethod.POST)
	public void coupon_List_L(HttpServletRequest request, HttpServletResponse response){
		logger.info("Partner tour_partner_List 시작!!!--------------------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
	
		couponService.couponList_L(mav);
		
		Map<String, Object> map=mav.getModel();
		
		String json=(String)map.get("json");
		
		try{
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
		}catch(IOException e){
			e.printStackTrace();
		}

	}
	
	@RequestMapping(value="/coupon/couponMain.do", method=RequestMethod.GET)
	public void coupon_List_S(HttpServletRequest request, HttpServletResponse response){
		logger.info("Partner tour_partner_List 시작!!!--------------------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
	
		couponService.couponList_S(mav);
		
		Map<String, Object> map=mav.getModel();
		
		String json=(String)map.get("json");
		
		try{
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
		}catch(IOException e){
			e.printStackTrace();
		}

	}
}
