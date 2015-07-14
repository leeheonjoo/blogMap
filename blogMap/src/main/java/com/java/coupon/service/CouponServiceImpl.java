package com.java.coupon.service;

import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.java.coupon.dao.CouponDao;
import com.java.partner.dto.PartnerDto;

@Component
public class CouponServiceImpl implements CouponService {
	private final Logger logger=Logger.getLogger(this.getClass().getName());

	@Autowired
	private CouponDao couponDao;	
	
	@Override
	public void couponList_L(ModelAndView mav) {
		logger.info("---------------- Coupon List ----------------");
		
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");

		int count=couponDao.getCouponCount();
		logger.info("count:" + count);
		
		List<PartnerDto> couponList_L=null;
		if(count>0){
			couponList_L=couponDao.getCouponList_L();
			logger.info("partnerListSize:"+couponList_L.size());
		}
//		메시지 정보를 GSON 에 담고, 그 정보를 JSON 에 저장
		Gson gson=new Gson();
		String json=gson.toJson(couponList_L);
		logger.info("partnerList:"+couponList_L);
		logger.info("json:"+json);
		
//		JSON 에 저장된 정보를 조회
		//System.out.println("json: " + json);
	
		mav.addObject("couponList",couponList_L);
		mav.addObject("json", json);
	}
	
	@Override
	public void couponList_S(ModelAndView mav) {
		logger.info("---------------- Coupon List ----------------");
		
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");

		int count=couponDao.getCouponCount();
		logger.info("count:" + count);
		
		List<PartnerDto> couponList_S=null;
		if(count>0){
			couponList_S=couponDao.getCouponList_S();
			logger.info("partnerListSize:"+couponList_S.size());
		}
//		메시지 정보를 GSON 에 담고, 그 정보를 JSON 에 저장
		Gson gson=new Gson();
		String json=gson.toJson(couponList_S);
		logger.info("partnerList:"+couponList_S);
		logger.info("json:"+json);
		
//		JSON 에 저장된 정보를 조회
		//System.out.println("json: " + json);
	
		mav.addObject("couponList",couponList_S);
		mav.addObject("json", json);
	}
		
	}


