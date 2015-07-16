package com.java.partner.dao;

import java.util.HashMap;
import java.util.List;
import java.util.logging.Logger;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.java.coupon.dto.CouponDto;
import com.java.partner.dto.PartnerDto;
/**
 * @name:partnerRegister
 * @date:2015. 7. 5.
 * @author: 변태훈
 * @description: 제휴업체 등록 (partnerRegister)
 */
@Component
public class PartnerDaoImpl implements PartnerDao {
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	
@Autowired
	public SqlSessionTemplate session;
	
@Override
	public int partnerRegister(PartnerDto partnerDto) {
		logger.info("PartnerMapper.partnerRegister-------------------------------------");
		
		int check=session.insert("dao.PartnerMapper.partnerRegister", partnerDto);
		
		return check;
	}
/**
 * @name:getPartnerList
 * @date:2015. 7. 7.
 * @author: 변태훈
 * @description: 제휴업체 리스트 (getPartnerList)
 */
@Override
	public List<PartnerDto> getwriteList() {
		logger.info("PartnerMapper.getTourPartnerList----------------------------------");
		List<PartnerDto> list=session.selectList("dao.PartnerMapper.getWriteList");
		logger.info(String.valueOf("getWriteList_Size:"+list.size()) );
		
		return list;
	}
	
@Override
	public int getPartnerCount() {
		return session.selectOne("dao.PartnerMapper.partnerCount");
	}
@Override
	public PartnerDto getTourPartnerListDate(int partnerNo) {
		logger.info("PartnerMapper.getTourPartnerListDate----------------------");
		logger.info("partnerNo 맴퍼가기전 : "+ partnerNo);
		//PartnerDto getPartnerListDate=session.selectOne("dao.PartnerMapper.getPartnerListDate", partnerNo);
		
		return session.selectOne("dao.PartnerMapper.getTourPartnerListDate", partnerNo);
	}
@Override
	public int couponRegister(CouponDto couponDto,int partner_no) {
		logger.info("CouponMapper.couponRegister-------------------------------------");
		
		HashMap<Object, Object> hMap=new HashMap<Object, Object>();
		hMap.put("couponDto", couponDto);
		hMap.put("partner_no", partner_no);
		
		int check=session.insert("dao.CouponMapper.couponRegister", hMap);
		
		return check;
	}
@Override
	public List<PartnerDto> getSearchParnterData(String partner_name) {
		logger.info("PartnerMapper.getSearchParnterData-------------------------------------");
		logger.info("partner_name 맴퍼가기전 : "+ partner_name);
		return session.selectList("dao.PartnerMapper.getSearchPartnerList",partner_name);
	}
}
