package com.java.partner.dao;

import java.util.HashMap;
import java.util.List;
import java.util.logging.Logger;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.java.boardRead.dto.BoardReadDto;
import com.java.coupon.dto.CouponDto;
import com.java.partner.dto.PartnerDto;

@Component
public class PartnerDaoImpl implements PartnerDao {
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	
@Autowired
	public SqlSessionTemplate session;
	
/**
 * @name:partnerRegister
 * @date:2015. 7. 5.
 * @author: 변태훈
 * @description: 제휴업체 등록 (partnerRegister)
 */
@Override
	public int partnerRegister(PartnerDto partnerDto, BoardReadDto boardreadDto) {
		logger.info("PartnerMapper.partnerRegister-------------------------------------");
		HashMap<Object, Object> hMap=new HashMap<Object, Object>();
		hMap.put("partnerDto", partnerDto);
		hMap.put("boardreadDto", boardreadDto);
		
		int check=session.insert("dao.PartnerMapper.partnerRegister", hMap);
		
		return check;
	}
/**
 * @name:getwriteList
 * @date:2015. 7. 7.
 * @author: 변태훈
 * @description: 제휴업체 리스트 (getPartnerList)
 */
@Override
	public List<PartnerDto> getwriteList(String member_id) {
		logger.info("PartnerMapper.getTourPartnerList----------------------------------");
		List<PartnerDto> list=session.selectList("dao.PartnerMapper.getWriteList",member_id);
		logger.info(String.valueOf("getWriteList_Size:"+list.size()) );
		
		return list;
	}
/**
 * @name:getPartnerCount
 * @date:2015. 7. 10.
 * @author: 변태훈
 * @description: 제휴업체등록을 위한 count 반환
 */
@Override
	public int getPartnerCount() {
		return session.selectOne("dao.PartnerMapper.partnerCount");
	}
/**
 * @name:getTourPartnerListDate
 * @date:2015. 7. 11.
 * @author: 변태훈
 * @description: 제휴업체 업체 정보 데이터 등록
 */

@Override
	public List<HashMap<String, Object>> getTourPartnerListDate(HashMap<String, Object> hMap) {
		logger.info("PartnerMapper.getTourPartnerListDate----------------------");
		logger.info("partnerNo 맴퍼가기전 : "+ hMap.get("partnerNo"));
		//PartnerDto getPartnerListDate=session.selectOne("dao.PartnerMapper.getPartnerListDate", partnerNo);
		
		return session.selectList("dao.PartnerMapper.getTourPartnerListDate", hMap);
	}
/**
 * @name:couponRegister
 * @date:2015. 7. 14.
 * @author: 변태훈
 * @description: 제휴업체 쿠폰등록
 */
@Override
	public int couponRegister(CouponDto couponDto,int partner_no) {
		logger.info("CouponMapper.couponRegister-------------------------------------");
		
		HashMap<Object, Object> hMap=new HashMap<Object, Object>();
		hMap.put("couponDto", couponDto);
		hMap.put("partner_no", partner_no);
		
		int check=session.insert("dao.CouponMapper.couponRegister", hMap);
		
		return check;
	}
/**
 * @name:ggetSearchParnterData
 * @date:2015. 7. 10.
 * @author: 변태훈
 * @description: 제휴업체 이름으로 리스트 검색하는 데이터
 */
@Override
	public List<PartnerDto> getSearchParnterData(String partner_name) {
		logger.info("PartnerMapper.getSearchParnterData-------------------------------------");
		logger.info("partner_name 맴퍼가기전 : "+ partner_name);
		return session.selectList("dao.PartnerMapper.getSearchPartnerList",partner_name);
	}
/**
 * @name:coupon_Register
 * @date:2015. 7. 10.
 * @author: 변태훈
 * @description: 제휴업체 쿠폰등록
 */
@Override
	public int coupon_Register(CouponDto couponDto) {
		// TODO Auto-generated method stub
		return session.insert("dao.PartnerMapper.coupon_register",couponDto);
	}
/**
 * @name:getwriteCouponList
 * @date:2015. 7. 10.
 * @author: 변태훈
 * @description: 제휴업체 쿠폰등록을후 리스트
 */
@Override
	public List<HashMap<String, Object>> getwriteCouponList(String member_id) {
		logger.info("PartnerMapper.getWriteCouponList----------------------------------");
		List<HashMap<String, Object>> list=session.selectList("dao.PartnerMapper.getWriteCouponList",member_id);
		logger.info(String.valueOf("getWriteCouponList_Size:"+list.size()) );
		
		return list;
	}
/**
 * @name:search_partnerCouponinfo
 * @date:2015. 7. 10.
 * @author: 변태훈
 * @description: 제휴업체 이름으로 리스트 검색하는
 */
@Override
	public List<HashMap<String, Object>> search_partnerCouponinfo(String coupon_item) {
		logger.info("PartnerMapper.search_partnerCouponinfo-------------------------------------");
		logger.info("coupon_item 맴퍼가기전 : "+ coupon_item);
		
		return session.selectList("dao.PartnerMapper.search_partnerCouponinfo",coupon_item);
	}

/**
 * @name:getPartnerCouponData
 * @date:2015. 7. 10.
 * @author: 변태훈
 * @description: 쿠폰업체 쿠폰정보 데이터 등록
 */
@Override
	public List<HashMap<String, Object>> getPartnerCouponData(HashMap<String, Object> hMap) {
		logger.info("PartnerMapper.getPartnerCouponData----------------------");
		//logger.info("coupon_no 맴퍼가기전 : "+ hMap.get("coupon_no"));
		
		return session.selectList("dao.PartnerMapper.getPartnerCouponData", hMap);
	}
}
