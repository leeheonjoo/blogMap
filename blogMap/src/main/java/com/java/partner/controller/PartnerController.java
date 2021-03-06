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

import com.java.boardRead.dto.BoardReadDto;
import com.java.coupon.dto.CouponDto;
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
	public void write(MultipartHttpServletRequest request, HttpServletResponse response,PartnerDto partnerDto,BoardReadDto boardreadDto){
		logger.info("Partner write 시작!!!--------------------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		mav.addObject("partnerDto",partnerDto);
		mav.addObject("boardreadDto",boardreadDto);

		partnerService.write(mav);
	}
	
	/**
	 * @name: writeList
	 * @date:2015. 7. 7.
	 * @author: 변태훈
	 * @description: 제휴업체 리스트 컨트롤러
	 */
	@RequestMapping(value="/partner/writeList.do", method=RequestMethod.POST)
	public void writeList(HttpServletRequest request, HttpServletResponse response,PartnerDto partnerDto,BoardReadDto boardreadDto){
		logger.info("Partner writeList 시작!!!--------------------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		mav.addObject("partnerDto",partnerDto);
		mav.addObject("boardreadDto",boardreadDto);
	
		partnerService.writeList(mav);
		
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
	 * @description: 제휴업체 상세정보 반환
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
	 * @name: couponWrite
	 * @date:2015. 7. 5.
	 * @author: 변태훈
	 * @description: 제휴업체 쿠폰등록 컨트롤러
	 */
	@RequestMapping(value="/partner/couponWrite.do", method=RequestMethod.POST)
	public void couponWrite(MultipartHttpServletRequest request, HttpServletResponse response){
		logger.info("Partner couponWrite 시작!!!--------------------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);

		partnerService.couponWrite(mav);
	}
	
	/**
	 * @name: list
	 * @date:2015. 7. 13.
	 * @author: 변태훈
	 * @description: 쿠폰 리스트 반환 컨트롤러
	 */
	@RequestMapping(value="/partner/coupon_List.do", method=RequestMethod.POST)
	public void couponList(HttpServletRequest request, HttpServletResponse response){
		logger.info("Partner couponList 시작!!!--------------------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
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
	 * @name:searchPartnerList
	 * @date:2015. 7. 16.
	 * @author:변태훈
	 * @description: 제휴업체이름으로 리스트 검색하는 메소드
	 */
	@RequestMapping("/partner/search_Partnerinfo.do")
	public void search_PartnerList(HttpServletRequest request, HttpServletResponse response){
		logger.info("partner search_PartnerList Start-----------------------------------");
		
		ModelAndView mav= new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		partnerService.getSearchPartnerDate(mav);
		Map<String, Object> map=mav.getModel();
		
		String json=(String)map.get("searchjson");
		
		try{
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	
	/**
	 * @name: writeCouponList
	 * @date:2015. 7. 22.
	 * @author: 변태훈
	 * @description: 제휴업체 Coupon리스트 반환 컨트롤러
	 */
	@RequestMapping(value="/partner/writeCouponList.do", method=RequestMethod.POST)
	public void writeCouponList(HttpServletRequest request, HttpServletResponse response,PartnerDto partnerDto,BoardReadDto boardreadDto){
		logger.info("Partner writeCouponList 시작!!!--------------------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
	
		partnerService.writeCouponList(mav);
		
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
	 * @name:search_partnerCouponinfo
	 * @date:2015. 7. 23.
	 * @author:변태훈
	 * @description: 쿠폰업체이름으로 리스트 검색하는 메소드
	 */
	@RequestMapping("/partner/search_partnerCouponinfo.do")
	public void search_partnerCouponinfo(HttpServletRequest request, HttpServletResponse response){
		logger.info("partner search_partnerCouponinfo Start");
		
		ModelAndView mav= new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		partnerService.search_partnerCouponinfo(mav);
		Map<String, Object> map=mav.getModel();
		
		String json=(String)map.get("searchCouponJson");
		
		try{
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	
	/**
	 * @name:getPartnerCouponData
	 * @date:2015. 7. 23.
	 * @author:변태훈
	 * @description: 쿠폰 상세 정보 데이터 반환
	 */
	@RequestMapping(value="/partner/getPartnerCouponData.do", method=RequestMethod.GET)
	public void getPartnerCouponData(HttpServletRequest request, HttpServletResponse response){
		logger.info("Partner getPartnerCouponData 시작!!!--------------------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		partnerService.getPartnerCouponData(mav);
		
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