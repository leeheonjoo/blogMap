package com.java.partner.service;

import java.io.File;
import java.io.IOException;
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
		
		logger.info(partnerDto.getMember_id());
		logger.info(partnerDto.getCategory_code());
		logger.info(partnerDto.getPartner_name());
		logger.info(partnerDto.getPartner_phone());
		logger.info(partnerDto.getPartner_addr());
	
//		String uploadPath = "C:/workspace/blogMap/blogMap/src/main/webapp/pds/partner";
//		File dir = new File(uploadPath,originalFileName);
//		if (!dir.isDirectory()) {			//파일이 존재하지 않을 때 
//			dir.mkdirs();
//		}
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
					
					logger.info("파일이름이 뭐냐!!!!:"+partnerDto.getPartner_pic_name());
					logger.info("파일경로가 뭐냐!!!!:"+partnerDto.getPartner_pic_path());
					long lo=partnerDto.getPartner_pic_size();
					logger.info(String.valueOf(lo));
					int check=partnerDao.partnerRegister(partnerDto);
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

		int count=partnerDao.getPartnerCount();
		logger.info("count:" + count);
		
		List<PartnerDto> writeList=null;
		if(count>0){
			writeList=partnerDao.getwriteList();
			logger.info("partnerWriteListSize:"+writeList.size());
		}
//		메시지 정보를 GSON 에 담고, 그 정보를 JSON 에 저장
		Gson gson=new Gson();
		String json=gson.toJson(writeList);
		logger.info("writeList:"+writeList);
		logger.info("json:"+json);
		
//		JSON 에 저장된 정보를 조회
		//System.out.println("json: " + json);
	
		mav.addObject("writeList",writeList);
		mav.addObject("json", json);
	}
	
	@Override
	public void getTourPartnerListDate(ModelAndView mav) {
		logger.info("Partner getTourPartnerListDate start----------------");
		
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		int partnerNo=Integer.parseInt(request.getParameter("partnerNo"));
		logger.info("partnerNo : " + partnerNo);
	
		PartnerDto getTourPartnerListDate=partnerDao.getTourPartnerListDate(partnerNo);
		logger.info("맵퍼 갔다와서:"+getTourPartnerListDate);
		
		Gson gson=new Gson();
		String json=gson.toJson(getTourPartnerListDate);
		logger.info("json으로 담은후에" + json);
			
		//mav.addObject("getPartnerListDate",getPartnerListDate);
		mav.addObject("json",json);
	}
	
/**
 * @name: couponWrite
 * @date:2015. 7. 5.
 * @author: 변태훈
 * @description:  제휴업체 쿠폰등록
 */
	@Override
	public boolean couponWrite(ModelAndView mav) {
		logger.info("PartnerServiceImp couponWrite----------------");
		
		Map<String, Object> map=mav.getModelMap();
		MultipartHttpServletRequest request=(MultipartHttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		logger.info("111111111111111111111111111111");

		CouponDto couponDto=(CouponDto)map.get("couponDto");
		logger.info("222222222222222222222222222222222");
		
		String partner=(String) request.getSession().getAttribute("partner_no");
		int partner_no=Integer.parseInt(partner);
		
		logger.info("33333333333333333333333333333333333");
		logger.info("partner_no : " + partner_no);
		logger.info("" +couponDto.getPartner_no());
		logger.info(couponDto.getCoupon_item());
		logger.info("" +couponDto.getCoupon_discount());
		logger.info("" +couponDto.getCoupon_eymd());
	
		boolean isSuccess = false;			//성공했는지 실패했는지 여부 확인한다
		
		String uploadPath = "C:\\workspace\\blogMap\\src\\main\\webapp\\pds\\partner";
		File dir = new File(uploadPath);
			if (!dir.isDirectory()) {			//파일이 존재하지 않을 때 
				dir.mkdirs();
			}
			
		Iterator<String> iter=request.getFileNames();
		while(iter.hasNext()){
			String uploadFileName=iter.next();
			MultipartFile mFile = request.getFile(uploadFileName);
			String originalFileName = mFile.getOriginalFilename();
			String saveFileName = originalFileName;
			if(saveFileName != null && !saveFileName.equals("")) {
				if(new File(uploadPath + saveFileName).exists()) {
					saveFileName = saveFileName + "_" + System.currentTimeMillis();
				}
				try {
					mFile.transferTo(new File(uploadPath + saveFileName));
					couponDto.setCoupon_pic_path(uploadPath);
					couponDto.setCoupon_pic_name(saveFileName);
					long fileImgSize=mFile.getSize();
					couponDto.setCoupon_pic_size(fileImgSize);
					
					logger.info(couponDto.getCoupon_pic_path());
					logger.info(couponDto.getCoupon_pic_name());
					long lo=couponDto.getCoupon_pic_size();
					logger.info(String.valueOf(lo));
					int check=partnerDao.couponRegister(couponDto, partner_no);
					logger.info("coupon_check:"+check);
					
					isSuccess = true;
					
				} catch (IllegalStateException e) {
					e.printStackTrace();
					isSuccess = false;
				} catch (IOException e) {
					e.printStackTrace();
					isSuccess = false;
				}
			} // if end
		} // while end
		return isSuccess;
	}
	@Override
	public void couponWriteList(ModelAndView mav) {
		// TODO Auto-generated method stub
		
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
}
