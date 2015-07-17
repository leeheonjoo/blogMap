package com.java.coupon.service;

import java.util.HashMap;
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
import com.java.coupon.dto.CouponDto;
import com.java.partner.dto.PartnerDto;

@Component
public class CouponServiceImpl implements CouponService {
	private final Logger logger=Logger.getLogger(this.getClass().getName());

	@Autowired
	private CouponDao couponDao;	
	
	/**
	 * @name:coupon_List_L
	 * @date:2015. 7. 14.
	 * @author:정기창
	 * @description: 쿠폰 리스트를 화면에 뿌려준다
	 */
	@Override
	public void couponList(ModelAndView mav) {
		logger.info("---------------- Coupon List ----------------");
		
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		int count=couponDao.getCouponCount();
		logger.info("count:" + count);

		PartnerDto partnerDto=null;
		CouponDto couponDto=null;
		
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("partnerDto", partnerDto);
		hMap.put("couponDto", couponDto);
		
		List<HashMap<String, Object>> couponList=null;
		if(count>0){
			couponList=couponDao.getCouponList();
			logger.info("ListSize:"+couponList.size());
		}
//		메시지 정보를 GSON 에 담고, 그 정보를 JSON 에 저장
		Gson gson=new Gson();
		String json=gson.toJson(couponList);
		logger.info("List:"+couponList);
		logger.info("json:"+json);
		
//		JSON 에 저장된 정보를 조회
		//System.out.println("json: " + json);
	
		mav.addObject("couponList",couponList);
		mav.addObject("json", json);
	}
	
	/**
	 * @name:coupon_List_S
	 * @date:2015. 7. 15.
	 * @author:정기창
	 * @description: 쿠폰 리스트를 화면에 뿌려준다
	 */
	@Override
	public void couponList_S(ModelAndView mav) {
		logger.info("---------------- Coupon Search List ----------------");
		
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		String member_id=request.getParameter("member_id");
		logger.info("CouponList member_id : " + member_id);

		String partner_name=request.getParameter("partner_name");
		logger.info("Partner_name :" + partner_name);
		
		int count=couponDao.getCouponCount();
		logger.info("count:" + count);
		
		PartnerDto partnerDto=null;
		CouponDto couponDto=null;
		
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("partnerDto", partnerDto);
		hMap.put("couponDto", couponDto);
		
		List<HashMap<String, Object>> couponList_S=null;
		if(count>0){
			couponList_S=couponDao.getCouponList_S(partner_name);
			logger.info("ListSize:"+couponList_S.size());
		}
		
	//		메시지 정보를 GSON 에 담고, 그 정보를 JSON 에 저장
		Gson gson=new Gson();
		String json=gson.toJson(couponList_S);
		logger.info("List:"+couponList_S);
		logger.info("json:"+json);
	
		mav.addObject("couponList",couponList_S);
		mav.addObject("json", json);
	}

}


