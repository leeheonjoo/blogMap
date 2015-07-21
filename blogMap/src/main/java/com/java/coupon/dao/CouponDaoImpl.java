package com.java.coupon.dao;

import java.util.HashMap;
import java.util.List;
import java.util.logging.Logger;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CouponDaoImpl implements CouponDao {
	
	@Autowired
		public SqlSessionTemplate session;
	
	@Override
	public int getCouponCount() {
		return session.selectOne("dao.CouponMapper.couponCount");
	}
	
	@Override
	public List<HashMap<String, Object>> getCouponList() {
		List<HashMap<String, Object>> list=session.selectList("dao.CouponMapper.couponList_L");
		return list;
	}
	
	@Override
	public List<HashMap<String, Object>> getCouponList_S(String partner_name) {
		List<HashMap<String, Object>> list=session.selectList("dao.CouponMapper.couponList_S", partner_name);
		return list;
	}
}
