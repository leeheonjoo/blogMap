package com.java.manager.service;

//import java.io.IOException;
//import java.io.PrintWriter;
//import java.util.ArrayList;
//import java.util.HashMap;
import java.util.HashMap;
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
	 * @name:memberList
	 * @date:2015. 6. 26.
	 * @author:이동희
	 * @description: memberList 조회시 DB에서 데이타를 가지고 옴
	 */
	@Override
	public void memberList(ModelAndView mav){
		Map<String, Object> map=mav.getModelMap();
//		HttpServletRequest request=(HttpServletRequest)map.get("request");
//		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		List<MemberDto> memberlist=managerDao.memberList();	// member의 정보를 List로 가져옴
		logger.info("memberlistSize:" + memberlist.size());
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(memberlist);	//memberList를 json으로 변환함
		
		logger.info("json: " + json);
		
		mav.addObject("json", json);
		
	}
	
	/**
	 * @name:getSearchMemberDate
	 * @date:2015. 7. 14.
	 * @author:이동희
	 * @description: MemberList 조회시 조회한 이름으로 DB에서 데이타를 가지고 온다.
	 */
	@Override
	public void getSearchMemberDate(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		String member_name=request.getParameter("name");
		logger.info("member_name:" + member_name);
		
		
		List<MemberDto> searchMemberList=managerDao.getSearchMemberData(member_name);
		logger.info("searchMemberList : " + searchMemberList);
		
		Gson gson=new Gson();								//Gson의 객체를 생성
		String searchjson=gson.toJson(searchMemberList);	//Log를 json으로 변환
		
		logger.info("searchjson: " + searchjson);
		
		mav.addObject("searchjson", searchjson);
	}
	
	/**
	 * @name:getSearchMemberType
	 * @date:2015. 7. 14.
	 * @author:이동희
	 * @description: 회원가입타입으로 검색 결과를 반환하는 메소드
	 */
	@Override
	public void getSearchMemberType(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		String member_jointype=request.getParameter("member_jointype");
		logger.info("member_jointype:" + member_jointype);
		
		
		List<MemberDto> searchMemberList=managerDao.getSearchMemberType(member_jointype);
		logger.info("searchPartnerList : " + searchMemberList);
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(searchMemberList);	//Log를 json으로 변환
		
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
			
			String member=request.getParameter("member_id");
			logger.info(member);
			String manager=request.getParameter("manager_id");
			logger.info(manager);
			
			HashMap<String, Object> hMap=new HashMap<String, Object>();
			hMap.put("member",member);
			hMap.put("manager",manager);
			
			int check=managerDao.memberDel(hMap);
			logger.info("memberDelete Check:" + check);
			if(check == 1){
				managerDao.delLog(hMap);			// 삭제 성공시 관리자 로그 저장
			}
			Gson gson=new Gson();				//Gson의 객체를 생성
			String json=gson.toJson(check);		//삭제 결과를 json으로 변환함
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
	 * @name:getSearchPartnerDate
	 * @date:2015. 7. 8.
	 * @author:이동희
	 * @description: Partner정보를 조회시 이름으로 DB에서 데이타를 가지고온다.
	 */
	@Override
	public void getSearchPartnerDate(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		String partner_name=request.getParameter("name");
		logger.info("partner_name:" + partner_name);
		
		
		List<PartnerDto> searchPartnerList=managerDao.getSearchPartnerData(partner_name);
		logger.info("searchPartnerList : " + searchPartnerList);
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String searchjson=gson.toJson(searchPartnerList);	//Log를 json으로 변환
		
		logger.info("searchjson: " + searchjson);
		
		mav.addObject("searchjson", searchjson);
		
	}
	
	/**
	 * @name:getSearchPartnerYN
	 * @date:2015. 7. 10.
	 * @author:이동희
	 * @description: Partner 승인/미승인 여부로 Partner정보를 조회시 DB에서 데이타를 가지고온다.
	 */
	@Override
	public void getSearchPartnerYN(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		String partner_yn=request.getParameter("partner_yn");
		logger.info("partner_yn:" + partner_yn);
		
		
		List<PartnerDto> searchPartnerList=managerDao.getSearchPartnerYN(partner_yn);
		logger.info("searchPartnerList : " + searchPartnerList);
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String searchjson=gson.toJson(searchPartnerList);	//Log를 json으로 변환
		
		logger.info("searchjson: " + searchjson);
		
		mav.addObject("searchjson", searchjson);
		
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
		
		int partnerNo=Integer.parseInt(request.getParameter("partner_no"));
		logger.info("partner_nO :" + partnerNo);
		
		String manager=request.getParameter("manager_id");
		logger.info(manager);
		
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("partnerNo",partnerNo);
		hMap.put("manager",manager);
		
		int check=managerDao.partnerSubmit(partnerNo);
		logger.info("partnerSubmit check:" + check);
		if(check == 1){
			managerDao.partnerSubmitLog(hMap);		// 관리자 로그 저장
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
		
		int partnerNo=Integer.parseInt(request.getParameter("partner_no"));
		logger.info("partner_No :" + partnerNo);
		
		String manager=request.getParameter("manager_id");
		logger.info(manager);
		
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("partnerNo",partnerNo);
		hMap.put("manager",manager);
		
		int check=managerDao.partnerDelete(partnerNo);
		logger.info("partnerDelete check :" + check);
		
		if(check == 1){
			managerDao.partnerDeleteLog(hMap);	// 삭제 성공시 관리자 로그 저장
		}
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(check);			//Log를 json으로 변환
		
		logger.info("json: " + json);
		
		mav.addObject("json", json);
		
	}
	
	/**
	 * @name:partnerDetail
	 * @date:2015. 7. 9.
	 * @author:이동희
	 * @description: 선택한 제휴업체의 정보를 DB에서 가져와 반환
	 */
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
		
		CouponDto couponDto=null;
		PartnerDto partnerDto=null;
		
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("couponDto", couponDto);
		hMap.put("partnerDto", partnerDto);		
		
		List<HashMap<String, Object>> couponList=managerDao.getCouponData();
		logger.info("couponListSize : " + couponList.size());
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(couponList);	//Log를 json으로 변환
		
		logger.info("json: " + json);
		
		mav.addObject("json", json);
	}
	
	/**
	 * @name:searchCouponList
	 * @date:2015. 7. 15.
	 * @author:이동희
	 * @description:
	 */
	@Override
	public void searchCouponList(ModelAndView mav) {
		// TODO Auto-generated method stub
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		String partner_name=request.getParameter("name");
		logger.info("coupon Search : " + partner_name);
		
		CouponDto couponDto=null;
		PartnerDto partnerDto=null;
		
		HashMap<String, Object> hMap=new HashMap<String,Object>();
		hMap.put("couponDto", couponDto);
		hMap.put("partnerDto", partnerDto);
		
		List<HashMap<String, Object>> couponSearch=managerDao.coupnSearch(partner_name);
		logger.info("couponSearch : "+couponSearch);
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(couponSearch);			//Log를 json으로 변환
		logger.info("json: " + json);
		
		mav.addObject("json", json);
	}
	
	/**
	 * @name:searchCouponYN
	 * @date:2015. 7. 21.
	 * @author:이동희
	 * @description:
	 */
	@Override
	public void searchCouponYN(ModelAndView mav) {
		// TODO Auto-generated method stub
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		String coupon_yn=request.getParameter("coupon_yn");
		logger.info("coupon_yn : " + coupon_yn);
		
		CouponDto couponDto=null;
		PartnerDto partnerDto=null;
		
		HashMap<String, Object> hMap=new HashMap<String,Object>();
		hMap.put("couponDto", couponDto);
		hMap.put("partnerDto", partnerDto);
		
		List<HashMap<String, Object>> searchCouponYN=managerDao.searchCouponYN(coupon_yn);
		logger.info("searchCouponYN" + searchCouponYN);
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(searchCouponYN);			//Log를 json으로 변환
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
		String manager=request.getParameter("manager_id");
		logger.info("manager : " + manager);
		
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("couponNo", couponNo);
		hMap.put("manager", manager);
		
		int check=managerDao.couponSubmit(couponNo);
		logger.info("couponSubmit check :" + check);
		
		if(check == 1){
			managerDao.couponSubmitLog(hMap);	// 관리자 로그 저장
		}
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(check);			//Log를 json으로 변환
		
		logger.info("json: " + json);
		
		mav.addObject("json", json);
		
	}
	
	/**
	 * @name:couponCancle
	 * @date:2015. 7. 14.
	 * @author:이동희
	 * @description: 쿠폰을 취소하는 메소드(취소 성공시 관리자 로그에 저장)
	 */
	@Override
	public void couponCancle(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int couponNo=Integer.parseInt(request.getParameter("couponNo"));
		logger.info("couponNo:" + couponNo);
		String manager=request.getParameter("manager_id");
		logger.info("manager : " + manager);
		
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("couponNo", couponNo);
		hMap.put("manager", manager);
		
		int check=managerDao.couponCancle(couponNo);
		logger.info("couponCancle check :" + check);
		
		if(check == 1){
			managerDao.couponCancleLog(hMap);	// 관리자 로그 저장
		}
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(check);			//Log를 json으로 변환
		
		logger.info("json: " + json);
		
		mav.addObject("json", json);
		
		
	}
	
	/**
	 * @name:couponDetail
	 * @date:2015. 7. 15.
	 * @author:이동희
	 * @description: 선택한 쿠폰의 정보를 DB에서 가져와 반환
	 */
	@Override
	public void couponDetail(ModelAndView mav){
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int coupon_no=Integer.parseInt(request.getParameter("coupon_no"));
		logger.info("coupon_no : " + coupon_no);
		
		CouponDto couponDto=null;
		PartnerDto partnerDto=null;
		
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("couponDto", couponDto);
		hMap.put("partnerDto", partnerDto);
		
		List<HashMap<String, Object>> couponInfo = managerDao.couponDetail(coupon_no);
		logger.info("couponInfo:" + couponInfo);
		
		Gson gson=new Gson();					//Gson의 객체를 생성
		String json=gson.toJson(couponInfo);			//Log를 json으로 변환
		logger.info("json: " + json);
		
		mav.addObject("json", json);			
	}
	
	/**
	 * @name:getManagerDate
	 * @date:2015. 7. 3.
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
	
}
