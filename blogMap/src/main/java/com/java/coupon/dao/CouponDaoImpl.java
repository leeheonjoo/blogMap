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
	
	/**
	 * @name:getCouponCount
	 * @date:2015. 7. 14.
	 * @author:정기창
	 * @description: 쿠폰 count를 반환
	 */
	@Override
	public int getCouponCount() {
		return session.selectOne("dao.CouponMapper.couponCount");
	}
	
	/**
	 * @name:getCouponList
	 * @date:2015. 7. 14.
	 * @author:정기창
	 * @description: 전체 쿠폰 리스트를 반환
	 */
	@Override
	public List<HashMap<String, Object>> getCouponList() {
		List<HashMap<String, Object>> list=session.selectList("dao.CouponMapper.couponList_L");
		return list;
	}
	
	/**
	 * @name:coupon_List_S
	 * @date:2015. 7. 15.
	 * @author:정기창
	 * @description: 조건에 해당하는 쿠폰 리스트를 반환
	 */
	@Override
	public List<HashMap<String, Object>> getCouponList_S(String partner_name) {
		List<HashMap<String, Object>> list=session.selectList("dao.CouponMapper.couponList_S", partner_name);
		return list;
	}
}
