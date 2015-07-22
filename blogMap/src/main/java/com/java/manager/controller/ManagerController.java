package com.java.manager.controller;

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

import com.java.manager.service.ManagerService;

@Controller
public class ManagerController {
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	
	@Autowired
	private ManagerService managerService;
	
	/**
	 * @name:memberList
	 * @date:2015. 7. 3.
	 * @author:이동희
	 * @description: member의 정보를 불러오는 메소드
	 */
	@RequestMapping(value="/manager/memberinfo.do", method=RequestMethod.GET)
	public void memberList(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager MemberInfo start");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.getData(mav);
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
	 * @name:memberDelete
	 * @date:2015. 7. 3.
	 * @author:이동희
	 * @description: 회원삭제를 위한 메소드
	 */
	@RequestMapping("/manager/delete.do")
	public void memberDelete(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager MemberDelete");
		
		ModelAndView mav= new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.memberDel(mav);
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
	 * @name:searchMemberList
	 * @date:2015. 7. 14.
	 * @author:이동희
	 * @description: 회원이름으로 리스트 검색하는 메소드
	 */
	@RequestMapping("/manager/searchMemberinfo.do")
	public void searchMemberList(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager searchMemberList Start");
		
		ModelAndView mav= new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.getSearchMemberDate(mav);
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
	 * @name:searchMemberType
	 * @date:2015. 7. 14.
	 * @author:이동희
	 * @description: 회원가입 유형으로 검색하는 메소드
	 */
	@RequestMapping("/manager/searchMemberType.do")
	public void searchMemberType(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager searchMemberType Start");
		
		ModelAndView mav= new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.getSearchMemberType(mav);
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
	 * @name:partnerList
	 * @date:2015. 7. 3.
	 * @author:이동희
	 * @description: 제휴업체 정보를 불러오는 메소드
	 */
	@RequestMapping("/manager/partnerInfo.do")
	public void partnerList(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager PartnerList start");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.getPartnerDate(mav);
		Map<String, Object> map=mav.getModel();
		
		String json=(String) map.get("json");
		logger.info("파트너리스트:" + json);
		
		try{
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * @name:partnerList
	 * @date:2015. 7. 3.
	 * @author:이동희
	 * @description: 검색시 제휴업체 정보를 불러오는 메소드
	 */
	@RequestMapping("/manager/searchPartnerInfo.do")
	public void searchPartnerList(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager PartnerList start");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.getSearchPartnerDate(mav);
		Map<String, Object> map=mav.getModel();
		
		String searchjson=(String) map.get("searchjson");
		logger.info("searchjson:0" + searchjson);
		
		try{
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(searchjson);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * @name:searchPartnerYN
	 * @date:2015. 7. 15.
	 * @author:이동희
	 * @description: 제휴업체 승인/미승인 여부로 제휴업체의 정보를 가지고 오는 메소드
	 */
	@RequestMapping("/manager/searchPartnerYN.do")
	public void searchPartnerYN(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager PartnerList start");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.getSearchPartnerYN(mav);
		Map<String, Object> map=mav.getModel();
		
		String searchjson=(String) map.get("searchjson");
		logger.info("searchjson:0" + searchjson);
		
		try{
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(searchjson);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	/**
	 * @name:partnerSubmit
	 * @date:2015. 7. 3.
	 * @author:이동희
	 * @description: 제휴업체 신청을 승인하는 메소드
	 */
	@RequestMapping("/manager/partnerSubmit.do")
	public void partnerSubmit(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager partnerSubmit start");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.partnerSubmit(mav);
		
		Map<String, Object> map=mav.getModel();
		String json=(String)map.get("json");
		logger.info("partnerSubmit:" + json);
		
		
		try{
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
		
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	
	/**
	 * @name:partnerDelete
	 * @date:2015. 7. 3.
	 * @author:이동희
	 * @description: 제휴업체의 정보를 삭제하는 메소드
	 */
	@RequestMapping("/manager/partnerDelete.do")
	public void partnerDelete(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager partnerDelete start");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.partnerDelete(mav);
		
		Map<String, Object> map=mav.getModel();
		String json=(String)map.get("json");
		logger.info("partnerDelete:" + json);
		
		try{
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	
	/**
	 * @name:partnerDetail
	 * @date:2015. 7. 9.
	 * @author:이동희
	 * @description: 제휴업체의 상세 정보를 가지고 오는 메소드
	 */
	@RequestMapping("/manager/partnerDetail.do")
	public void partnerDetail(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager PartnerDetail Start");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.partnerDetail(mav);
		
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
	 * @name:couponList
	 * @date:2015. 7. 7.
	 * @author:이동희
	 * @description: 쿠폰 정보를 가지고 오는 메소드
	 */
	@RequestMapping("/manager/couponInfo.do")
	public void couponList(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager CouponList Start");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.getCouponData(mav);
		
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
	 * @name:couponSubmit
	 * @date:2015. 7. 7.
	 * @author:이동희
	 * @description: 쿠폰을 승인하는 메소드
	 */
	@RequestMapping("/manager/couponSubmit.do")
	public void couponSubmit(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager ConponSubint Start");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.couponSubmit(mav);
		
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
	 * @name:couponCancle
	 * @date:2015. 7. 14.
	 * @author:이동희
	 * @description: 쿠폰발행 취소하는 메소드
	 */
	@RequestMapping("/manager/couponCancle.do")
	public void couponCancle(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager CouponCancle Start");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.couponCancle(mav);
		
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
	 * @name:couponDetail
	 * @date:2015. 7. 15.
	 * @author:이동희
	 * @description: 쿠폰 상세 정보를 가지고 오는 메소드
	 */
	@RequestMapping("/manager/couponDetail.do")
	public void couponDetail(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager CouponDetail Start");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.couponDetail(mav);
		
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
	 * @name:searchCouponList
	 * @date:2015. 7. 15.
	 * @author:이동희
	 * @description: 제휴업체 이름검색으로 발급된 쿠폰 정보를 가지고오는 메소드
	 */
	@RequestMapping("/manager/searchCouponInfo.do")
	public void searchCouponList(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager searchCouponList Start");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.searchCouponList(mav);
		
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
	 * @name:searchCouponYN
	 * @date:2015. 7. 21.
	 * @author:이동희
	 * @description: 쿠폰의 승인여부로 쿠폰을 조회하는 메소드
	 */
	@RequestMapping("/manager/searchCouponYN.do")
	public void searchCouponYN(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager searchCouponYN Start");		

		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.searchCouponYN(mav);
		
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
	 * @name:managerList
	 * @date:2015. 7. 3.
	 * @author:이동희
	 * @description: 관리자 정보를 가져오는 메소드
	 */
	@RequestMapping(value="/manager/managerInfo.do", method=RequestMethod.GET)
	public void managerList(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager ManagerList start");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.getManagerDate(mav);
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
	 * @name:managerLog
	 * @date:2015. 7. 3.
	 * @author:이동희
	 * @description: 관리자 행위로그를 가지고 오는 메소드
	 */
	@RequestMapping("/manager/managerLog.do")
	public void managerLog(HttpServletRequest request, HttpServletResponse response){
		logger.info("Manager ManagerLog start");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		managerService.getManagerLog(mav);
		
		Map<String, Object> map=mav.getModel();
		String json=(String)map.get("json");
		logger.info("managerLog:" + json);
		
		
		try{
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	
	
}
