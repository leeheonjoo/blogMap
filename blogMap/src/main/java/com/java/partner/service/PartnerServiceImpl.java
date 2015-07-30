package com.java.partner.service;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.java.boardRead.dto.BoardReadDto;
import com.java.coupon.dto.CouponDto;
import com.java.partner.dao.PartnerDao;
import com.java.partner.dto.PartnerDto;

/**
 * @name: PartnerServiceImpl
 * @date:2015. 7. 5.
 * @author: 변태훈
 * @description: partnerService 에서 상속받아 실제로 모든 작업이 이루어 지는 장소
 */
@Component
public class PartnerServiceImpl implements PartnerService {
	private final Logger logger=Logger.getLogger(this.getClass().getName());

	@Autowired
	private PartnerDao partnerDao;
	
	/**
	 * @name: write
	 * @date:2015. 7. 5.
	 * @author: 변태훈
	 * @description:  제휴업체 등록
	 */
	@Override
	public void write(ModelAndView mav) {
		logger.info("PartnerServiceImp write----------------");
		
		Map<String, Object> map=mav.getModelMap();
		MultipartHttpServletRequest request=(MultipartHttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		PartnerDto partnerDto=(PartnerDto)map.get("partnerDto");
		BoardReadDto boardreadDto=(BoardReadDto)map.get("boardreadDto");
		
		logger.info(partnerDto.getMember_id());
		logger.info(boardreadDto.getCategory_mname());
		logger.info(boardreadDto.getCategory_sname());
		logger.info(partnerDto.getPartner_name());
		logger.info(partnerDto.getPartner_phone());
		logger.info(partnerDto.getPartner_addr());
	
		Iterator<String> iter=request.getFileNames();
		while(iter.hasNext()){
			String uploadFileName=iter.next();
			MultipartFile mFile = request.getFile(uploadFileName);
			String originalFileName = mFile.getOriginalFilename();
			String saveFileName = originalFileName;
			
			String uploadPath = "C:/workspace/blogMap/src/main/webapp/pds/partner/";
			File dir = new File(uploadPath,originalFileName);
			
			if (!dir.isDirectory()) {			//파일이 존재하지 않을 때 
				dir.mkdirs();
			}
			
			if(saveFileName != null && !saveFileName.equals("")) {
				if(new File(uploadPath + saveFileName).exists()) {
					saveFileName = System.currentTimeMillis()+ "_" +saveFileName;
				}
				try {
					mFile.transferTo(new File(uploadPath + saveFileName));
					partnerDto.setPartner_pic_path(uploadPath);
					partnerDto.setPartner_pic_name(saveFileName);
					long fileImgSize=mFile.getSize();
					partnerDto.setPartner_pic_size(fileImgSize);
					
					logger.info("파일이름:"+partnerDto.getPartner_pic_name());
					logger.info("파일경로:"+partnerDto.getPartner_pic_path());
					long lo=partnerDto.getPartner_pic_size();
					logger.info("파일사이즈:"+String.valueOf(lo));
				
					int check=partnerDao.partnerRegister(partnerDto,boardreadDto);
					logger.info("partner_check:"+check);
					
					response.getWriter().print(check);
					
					
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			} // if end
		} // while end
	}
	
	/**
	 * @name: writeList
	 * @date:2015. 7. 5.
	 * @author: 변태훈
	 * @description:  제휴업체 리스트
	 */
	@Override
	public void writeList(ModelAndView mav) {
		logger.info("PartnerServiceImp writeList----------------");
	
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");

		String member_id=request.getParameter("member_id");
		logger.info("PartnerService writeList member_id:"+member_id);
		
		int count=partnerDao.getPartnerCount();
		logger.info("count:" + count);
		
		List<PartnerDto> writeList=null;
		if(count>0){
			writeList=partnerDao.getwriteList(member_id);
			logger.info("partnerWriteListSize:"+writeList.size());
		}
		// 메시지 정보를 GSON 에 담고, 그 정보를 JSON 에 저장
		Gson gson=new Gson();
		String json=gson.toJson(writeList);
		logger.info("writeList:"+writeList);
		logger.info("json:"+json);
		
		// JSON 에 저장된 정보를 조회
		// System.out.println("json: " + json);
	
		mav.addObject("writeList",writeList);
		mav.addObject("json", json);
	}
	
	/**
	 * @name: getTourPartnerListDate
	 * @date:2015. 7. 5.
	 * @author: 변태훈
	 * @description:  제휴업체 Tour&Restaurant 업체정보 데이터 반환
	 */	
	@Override
	public void getTourPartnerListDate(ModelAndView mav) {
		logger.info("Partner getTourPartnerListDate start----------------");
		
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		int partnerNo=Integer.parseInt(request.getParameter("partnerNo"));
		logger.info("partnerNo : " + partnerNo);
	
		List<BoardReadDto> boardReadList=null;
		List<PartnerDto> partnerList=null;
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("boardReadList", boardReadList);
		hMap.put("partnerList", partnerList);
		hMap.put("partnerNo", partnerNo);
		
		List<HashMap<String, Object>> partner_List=new ArrayList<HashMap<String,Object>>();
		
		partner_List=partnerDao.getTourPartnerListDate(hMap);
		logger.info("맵퍼 갔다와서:"+partner_List);
		
		Gson gson=new Gson();
		String json=gson.toJson(partner_List);
		logger.info("json으로 담은후에" + json);

		mav.addObject("json",json);
	}
	
	/**
	 * @name: couponWrite
	 * @date:2015. 7. 5.
	 * @author: 변태훈
	 * @description:  제휴업체 쿠폰등록
	 */
	@Override
	public void couponWrite(ModelAndView mav) {
		logger.info("PartnerServiceImp couponWrite----------------");

		Map<String, Object> map=mav.getModelMap();
		MultipartHttpServletRequest request=(MultipartHttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		CouponDto couponDto=new CouponDto();
		
		System.out.println("aaa"+request.getParameter("partner_no"));
		couponDto.setPartner_no(Integer.parseInt(request.getParameter("partner_no")));
		couponDto.setCoupon_item(request.getParameter("coupon_item"));
		couponDto.setCoupon_discount(Float.parseFloat(request.getParameter("coupon_discount")));
		
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		Date coupon_bymd=null;
		Date coupon_eymd=null;
		try {
			coupon_bymd = format.parse(request.getParameter("coupon_bymd"));
			coupon_eymd=format.parse(request.getParameter("coupon_eymd"));
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		couponDto.setCoupon_bymd(coupon_bymd);
		couponDto.setCoupon_eymd(coupon_eymd);
		
		Iterator<String> iter=request.getFileNames();
		while(iter.hasNext()){
			String uploadFileName=iter.next();
			MultipartFile mFile = request.getFile(uploadFileName);
			String originalFileName = mFile.getOriginalFilename();
			String saveFileName = originalFileName;
			
			String uploadPath = "C:/workspace/blogMap/src/main/webapp/pds/coupon/";
			File dir = new File(uploadPath,originalFileName);
			
			if (!dir.isDirectory()) {			//파일이 존재하지 않을 때 
				dir.mkdirs();
			}
			
			if(saveFileName != null && !saveFileName.equals("")) {
				if(new File(uploadPath + saveFileName).exists()) {
					saveFileName = System.currentTimeMillis()+ "_" +saveFileName;
				}
				try {
					mFile.transferTo(new File(uploadPath + saveFileName));
					couponDto.setCoupon_pic_path(uploadPath);
					couponDto.setCoupon_pic_name(saveFileName);
					long fileImgSize=mFile.getSize();
					couponDto.setCoupon_pic_size(fileImgSize);
					
					logger.info("파일이름이 뭐냐!!!!:"+couponDto.getCoupon_pic_name());
					logger.info("파일경로가 뭐냐!!!!:"+couponDto.getCoupon_pic_path());
					long lo=couponDto.getCoupon_pic_size();
					logger.info(String.valueOf(lo));
					int check=partnerDao.coupon_Register(couponDto);
					logger.info("partner_check:"+check);
					
					response.getWriter().print(check);

				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			} // if end
		} // while end
	}
	
	/**
	 * @name:getSearchPartnerDate
	 * @date:2015. 7. 16.
	 * @author:변태훈
	 * @description: partnerList 조회시 조회한 이름으로 DB에서 데이타를 가지고 온다.
	 */
	@Override
	public void getSearchPartnerDate(ModelAndView mav) {
		
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		String partner_name=request.getParameter("name");
		logger.info("partner_name:" + partner_name);
		
		List<PartnerDto> searchPartnerList=partnerDao.getSearchParnterData(partner_name);
		logger.info("searchPartnerList : " + searchPartnerList);
		
		Gson gson=new Gson();								//Gson의 객체를 생성
		String searchjson=gson.toJson(searchPartnerList);	//Log를 json으로 변환
		
		logger.info("searchjson: " + searchjson);
		
		mav.addObject("searchjson", searchjson);
	}
	
	/**
	 * @name: writeCouponList
	 * @date:2015. 7. 22.
	 * @author: 변태훈
	 * @description:  제휴업체 writeCouponList 리스트
	 */
	@Override
		public void writeCouponList(ModelAndView mav) {
			logger.info("PartnerServiceImp writeCouponList----------------");
		
			Map<String, Object> map=mav.getModelMap();
			HttpServletRequest request=(HttpServletRequest)map.get("request");
			HttpServletResponse response=(HttpServletResponse)map.get("response");

			String member_id=request.getParameter("member_id");
			logger.info("PartnerService writeCouponList member_id:"+member_id);

			CouponDto couponDto=null;
			PartnerDto partnerDto=null;
			
			HashMap<String,Object> hMap=new  HashMap<String,Object>();
			hMap.put("couponDto",couponDto);
			hMap.put("partnreDto", partnerDto);
			
			List<HashMap<String, Object>> writeCouponList=partnerDao.getwriteCouponList(member_id);
			logger.info("partnerWriteListSize:"+writeCouponList.size());
			
			// 메시지 정보를 GSON 에 담고, 그 정보를 JSON 에 저장
			Gson gson=new Gson();
			String json=gson.toJson(writeCouponList);
			logger.info("writeCouponList:"+writeCouponList);
			logger.info("json:"+json);
			
			// JSON 에 저장된 정보를 조회
			// System.out.println("json: " + json);
		
			mav.addObject("json", json);
		}
	
	/**
	 * @name: search_partnerCouponinfo
	 * @date:2015. 7. 22.
	 * @author: 변태훈
	 * @description:  제휴업체 검색 리스트
	 */			
	@Override
	public void search_partnerCouponinfo(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		String coupon_item=request.getParameter("coupon_item");
		logger.info("coupon_item:" + coupon_item);
		
		CouponDto couponDto=null;
		PartnerDto partnerDto=null;
		
		HashMap<String,Object> hMap=new  HashMap<String,Object>();
		hMap.put("couponDto",couponDto);
		hMap.put("partnreDto", partnerDto);
		
		List<HashMap<String, Object>> search_partnerCouponinfo=partnerDao.search_partnerCouponinfo(coupon_item);
		logger.info("search_partnerCouponinfo : " + search_partnerCouponinfo);
		
		Gson gson=new Gson();								//Gson의 객체를 생성
		String searchCouponJson=gson.toJson(search_partnerCouponinfo);	//Log를 json으로 변환
		
		logger.info("searchCouponJson: " + searchCouponJson);
		
		mav.addObject("searchCouponJson", searchCouponJson);
		
	}
	
	/**
	 * @name: getPartnerCouponData
	 * @date:2015. 7. 22.
	 * @author: 변태훈
	 * @description:  제휴업체 쿠폰 데이터 등록
	 */		
	@Override
	public void getPartnerCouponData(ModelAndView mav) {
		logger.info("Partner getPartnerCouponData start----------------");
		
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		int coupon_no=Integer.parseInt(request.getParameter("coupon_no"));
		logger.info("coupon_no : " + coupon_no);
	
		List<CouponDto> couponList=null;
		List<PartnerDto> partnerList=null;
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("couponList", couponList);
		hMap.put("partnerList", partnerList);
		hMap.put("coupon_no", coupon_no);
		
		List<HashMap<String, Object>> coupon_List=new ArrayList<HashMap<String,Object>>();
		
		coupon_List=partnerDao.getPartnerCouponData(hMap);
		logger.info("맵퍼 갔다와서:"+coupon_List);
		
		Gson gson=new Gson();
		String json=gson.toJson(coupon_List);
		logger.info("json으로 담은후에" + json);

		mav.addObject("json",json);
	}	
}
