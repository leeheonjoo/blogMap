package com.java.coupon.dao;

import java.util.List;
import java.util.logging.Logger;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.java.partner.dto.PartnerDto;

@Component
public class CouponDaoImpl implements CouponDao {
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	
@Autowired
	public SqlSessionTemplate session;

@Override
public int getCouponCount() {
	return session.selectOne("dao.CouponMapper.couponCount");
}

@Override
public List<PartnerDto> getCouponList() {
	logger.info("PartnerMapper.getTourPartnerList----------------------------------");
	List<PartnerDto> list=session.selectList("dao.CouponMapper.couponList");
	logger.info(String.valueOf("getCouponList:"+list.size()));
	
	return list;
}


}
