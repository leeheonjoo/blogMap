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
	
	/**
	 * @name:coupon_List_L
	 * @date:2015. 7. 14.
	 * @author:정기창
	 * @description: 쿠폰 리스트를 화면에 뿌려준다
	 */
	@RequestMapping(value="/coupon/couponMain.do", method=RequestMethod.POST)
	public void coupon_List(HttpServletRequest request, HttpServletResponse response){
		logger.info("-------------------------- Coupon List --------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
	
		couponService.couponList(mav);
		
		Map<String, Object> map=mav.getModel();
		
		String json=(String)map.get("json");
		
		try{
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
		}catch(IOException e){
			e.printStackTrace();
		}

	}
	
	/**
	 * @name:coupon_List_S
	 * @date:2015. 7. 15.
	 * @author:정기창
	 * @description: 제휴업제 검색을 통한 쿠폰 리스트를 화면에 뿌려준다
	 */
	@RequestMapping(value="/coupon/couponMain.do", method=RequestMethod.GET)
	public void coupon_List_S(HttpServletRequest request, HttpServletResponse response){
		logger.info("-------------------------- Coupon Search --------------------------");
		
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
