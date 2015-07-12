package com.java.partner.controller;

import java.io.IOException;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.java.partner.dto.PartnerDto;
import com.java.partner.service.PartnerService;

@Controller
public class PartnerController {
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	
	@Autowired
	private PartnerService partnerService;
/**
 * @name: write
 * @date:2015. 7. 5.
 * @author: 변태훈
 * @description: 제휴업체 업체등록 컨트롤러
 */
	@RequestMapping(value="/partner/write.do", method=RequestMethod.POST)
	public void write(MultipartHttpServletRequest request, HttpServletResponse response,PartnerDto partnerDto){
		logger.info("Partner write 시작!!!--------------------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		mav.addObject("partnerDto",partnerDto);

		partnerService.write(mav);
	}
	
	
	/**
	 * @name: list
	 * @date:2015. 7. 7.
	 * @author: 변태훈
	 * @description: 제휴업체 Tour리스트 컨트롤러
	 */
	@RequestMapping(value="/partner/tour_partner_List.do", method=RequestMethod.POST)
	public void list(HttpServletRequest request, HttpServletResponse response){
		logger.info("Partner tour_partner_List 시작!!!--------------------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
	
		partnerService.tourList(mav);
		
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
	 * @name: getTourPartnerListDate
	 * @date:2015. 7. 9.
	 * @author: 변태훈
	 * @description: 제휴업체 Tour업체정보 팝업
	 */
	@RequestMapping(value="/partner/getTourPartnerListDate.do", method=RequestMethod.GET)
	public void getTourPartnerListDate(HttpServletRequest request, HttpServletResponse response){
		logger.info("Partner getTourPartnerListDate 시작!!!--------------------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		partnerService.getTourPartnerListDate(mav);
		
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
	 * @name: list
	 * @date:2015. 7. 9.
	 * @author: 변태훈
	 * @description: 제휴업체 리스트 컨트롤러
	 */
	@RequestMapping(value="/partner/restaurant_partner_List.do", method=RequestMethod.POST)
	public void restaurantList(HttpServletRequest request, HttpServletResponse response){
		logger.info("Partner restaurantList 시작!!!--------------------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
	
		partnerService.restaurantList(mav);
		
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
	 * @name: getPartner
	 * @date:2015. 7. 9.
	 * @author: 변태훈
	 * @description: 제휴업체 업체정보 팝업
	 */
	@RequestMapping(value="/partner/getRestaurantPartnerListDate.do", method=RequestMethod.GET)
	public void getRestaurantPartnerListDate(HttpServletRequest request, HttpServletResponse response){
		logger.info("Partner getRestaurantPartnerListDate 시작!!!--------------------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		partnerService.getRestaurantPartnerListDate(mav);
		
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
	 * @name: getPartner
	 * @date:2015. 7. 9.
	 * @author: 변태훈
	 * @description: 제휴업체 Tour검색 
	 */
	@RequestMapping(value="partner/tourSerch.do", method=RequestMethod.GET)
	public void tourSerch(HttpServletRequest request, HttpServletResponse response){
		logger.info("Partner tourSerch 시작!!-----------------");
		ModelAndView mav = new ModelAndView();
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		partnerService.tourSerch(mav);
	}
}