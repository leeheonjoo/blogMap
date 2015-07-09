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
 * @description: 제휴업체 등록 컨트롤러
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
	 * @description: 제휴업체 리스트 컨트롤러
	 */
	@RequestMapping(value="/partner/partnerList.do", method=RequestMethod.POST)
	public void list(HttpServletRequest request, HttpServletResponse response){
		logger.info("Partner partnerList 시작!!!--------------------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
	
		partnerService.list(mav);
		
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
	@RequestMapping(value="/partner/getPartnerListDate.do", method=RequestMethod.GET)
	public void getPartnerListDate(HttpServletRequest request, HttpServletResponse response){
		logger.info("Partner getPartnerListDate 시작!!!--------------------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		partnerService.getPartnerListDate(mav);
		
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