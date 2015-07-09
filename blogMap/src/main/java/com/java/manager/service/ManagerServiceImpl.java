package com.java.manager.service;

//import java.io.IOException;
//import java.io.PrintWriter;
//import java.util.ArrayList;
//import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import net.sf.json.JSONObject;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.java.coupon.dto.CouponDto;
import com.java.manager.dao.ManagerDao;
import com.java.manager.dto.ManagerDto;
import com.java.manager.dto.ManagerLogDto;
import com.java.member.dto.MemberDto;
import com.java.partner.dto.PartnerDto;

@Component
public class ManagerServiceImpl implements ManagerService {
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	
	@Autowired
	private ManagerDao managerDao;

	/**
	 * @name:getData
	 * @date:2015. 6. 26.
	 * @author:이동희
	 * @description: memberList 조회시 DB에서 데이타를 가지고 옴
	 */
	@Override
	public void getData(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
//		HttpServletRequest request=(HttpServletRequest)map.get("request");
//		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		List<MemberDto> memberlist=managerDao.getData();	// member의 정보를 List로 가져옴
		logger.info("memberlistSize:" + memberlist.size());
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(memberlist);	//memberList를 json으로 변환함
		
		logger.info("json: " + json);
		
		mav.addObject("json", json);
		
	}
	
/**
 * @name:memberDel
 * @date:2015. 6. 29.
 * @author:이동희
 * @description: memberList에서 member 삭제시 DB에서 삭제됨 (삭제시 관리자 로그를 저장)
 */
@Override
	public void memberDel(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		String id=request.getParameter("name");
		logger.info(id);
		
		int check=managerDao.memberDel(id);
		logger.info("memberDelete Check:" + check);
		if(check == 1){
			managerDao.delLog(id);			// 관리자 로그 저장
		}
		Gson gson=new Gson();				//Gson의 객체를 생성
		String json=gson.toJson(check);		//삭제 결과를 json으로 변환함
		logger.info("json: " + json);
		
		mav.addObject("json", json);
	}

	/**
	 * @name:getManagerDate
	 * @date:2015. 6. 30.
	 * @author:이동희
	 * @description: ManagerList 조회시 DB에서 데이타를 가지고옴
	 */
	@Override
	public void getManagerDate(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		List<ManagerDto> managerList=managerDao.getManagerDate();	// manager의 정보를 List로 가져옴
		logger.info("memberlistSize:" + managerList.size());
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(managerList);	//managerList를 json으로 변환함
		
		logger.info("json: " + json);
		
		mav.addObject("json", json);
	}
	
	/**
	 * @name:getManagerLog
	 * @date:2015. 7. 7.
	 * @author:이동희
	 * @description: ManagerLog를 조회시 DB에서 데이타를 가지고 온다.
	 */
	@Override
	public void getManagerLog(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		String id=request.getParameter("name");
		logger.info(id);
		
		List<ManagerLogDto> managerLog=managerDao.getManagerLog(id);	// Manager의 활동 Log를 가져욤
		logger.info("managerLogSize:" + managerLog.size());
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(managerLog);	//Log를 json으로 변환
		
		logger.info("json: " + json);
		
		mav.addObject("json", json);
		
	}
	
	/**
	 * @name:getPartnerDate
	 * @date:2015. 7. 1.
	 * @author:이동희
	 * @description: Partner정보를 조회시 DB에서 데이타를 가지고온다.
	 */
	@Override
	public void getPartnerDate(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		List<PartnerDto> partnerList=managerDao.getPartnerData();
		logger.info("partnerListSize : " + partnerList.size());
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(partnerList);	//Log를 json으로 변환
		
		logger.info("json: " + json);
		
		mav.addObject("json", json);
		
	}
	
	/**
	 * @name:partnerSubmit
	 * @date:2015. 7. 7.
	 * @author:이동희
	 * @description: 제휴업체를 승인하는 메소드(승인시 관리자 로그를 저장)
	 */
	@Override
	public void partnerSubmit(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		String id=request.getParameter("id");
		logger.info("partner id :" + id);
		
		int check=managerDao.partnerSubmit(id);
		logger.info("partnerSubmit check:" + check);
		if(check == 1){
			managerDao.submitLog(id);		// 관리자 로그 저장
		}
		
		Gson gson=new Gson();				//Gson의 객체를 생성
		String json=gson.toJson(check);		//Log를 json으로 변환
		
		logger.info("json: " + json);
		
		mav.addObject("json", json);
		
	}
	
	/**
	 * @name:partnerDelete
	 * @date:2015. 7. 7.
	 * @author:이동희
	 * @description: 제휴업체를 삭제하는 메소드(삭제시 관리자 로그를 저장)
	 */
	@Override
	public void partnerDelete(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		String id=request.getParameter("id");
		logger.info("partner id :"+ id);
		
		int check=managerDao.partnerDelete(id);
		logger.info("partnerDelete check :" + check);
		
		if(check == 1){
			managerDao.partnerDeleteLog(id);	// 관리자 로그 저장
		}
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(check);			//Log를 json으로 변환
		
		logger.info("json: " + json);
		
		mav.addObject("json", json);
		
	}
	
	/**
	 * @name:getCouponData
	 * @date:2015. 7. 7.
	 * @author:이동희
	 * @description: Coupon 정보를 조회시 DB에서 데이터를 가지고 옴
	 */
	@Override
	public void getCouponData(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		List<CouponDto> couponList=managerDao.getCouponData();
		logger.info("couponListSize : " + couponList.size());
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(couponList);	//Log를 json으로 변환
		
		logger.info("json: " + json);
		
		mav.addObject("json", json);
	}
	
	/**
	 * @name:couponSubmit
	 * @date:2015. 7. 7.
	 * @author:이동희
	 * @description: 쿠폰을 승인하는 메소드(승인시 관리자 로그에 저장)
	 */
	@Override
	public void couponSubmit(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int couponNo=Integer.parseInt(request.getParameter("couponNo"));
		logger.info("couponNo:" + couponNo);
		
		int check=managerDao.couponSubmit(couponNo);
		logger.info("couponSubmit check :" + check);
		
		if(check == 1){
			managerDao.couponSubmitLog(couponNo);	// 관리자 로그 저장
		}
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(check);			//Log를 json으로 변환
		
		logger.info("json: " + json);
		
		mav.addObject("json", json);
		
	}
	
	@Override
	public void partnerDetail(ModelAndView mav) {
		// TODO Auto-generated method stub
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int partnerNo=Integer.parseInt(request.getParameter("partner_no"));
		logger.info("partnerNo : " + partnerNo);
		
		PartnerDto partnerDto=managerDao.partnerDetail(partnerNo);
		logger.info("partnerDto : " + partnerDto);
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(partnerDto);			//Log를 json으로 변환
		logger.info("json: " + json);
		
		mav.addObject("json", json);
			
	}
}
