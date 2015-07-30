package com.java.manager.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.java.coupon.dto.CouponDto;
import com.java.manager.dto.ManagerDto;
import com.java.manager.dto.ManagerLogDto;
import com.java.member.dto.MemberDto;
import com.java.partner.dto.PartnerDto;

@Component
public class ManagerDaoImpl implements ManagerDao {
	
	@Autowired
	public SqlSessionTemplate session;
	
	/**
	 * @name:memberList
	 * @date:2015. 6. 26.
	 * @author:이동희
	 * @description: memberList 조회시 DB에서 데이타를 가지고 옴
	 */
	@Override
	public List<MemberDto> memberList() {
		return session.selectList("dao.ManagerMapper.getmemberList"); 
	}
	
	/**
	 * @name:getSearchMemberData
	 * @date:2015. 7. 14.
	 * @author:이동희
	 * @description: 조회한 이름으로 DB에서 Member 리스트 데이타를 가지고 온다.
	 */
	@Override
	public List<MemberDto> getSearchMemberData(String member_name) {	// 수정해야함
		return session.selectList("dao.ManagerMapper.getSearchMemberList", member_name);
	}
	
	/**
	 * @name:getSearchMemberType
	 * @date:2015. 7. 14.
	 * @author:이동희
	 * @description: 회원가입타입으로 검색 결과를 반환하는 메소드
	 */
	@Override
	public List<MemberDto> getSearchMemberType(String member_jointype) {
		return session.selectList("dao.ManagerMapper.getSearchMemberType", member_jointype);
	}
	
	/**
	 * @name:memberDel
	 * @date:2015. 6. 29.
	 * @author:이동희
	 * @description: memberList에서 member 삭제시 DB에서 삭제
	 */
	@Override
	public int memberDel(HashMap<String, Object> hMap) {
		return session.update("dao.ManagerMapper.memberDelete", hMap);
	}
	
	/**
	 * @name:delLog
	 * @date:2015. 6. 29.
	 * @author:이동희
	 * @description: memberList에서 member 삭제시 DB에서 해당 로그를 저장
	 */
	@Override
	public void delLog(HashMap<String, Object> hMap) {
		session.insert("dao.ManagerMapper.delLog", hMap);
	}
	
	/**
	 * @name:getPartnerData
	 * @date:2015. 7. 1.
	 * @author:이동희
	 * @description: Partner정보 리스트를 반환
	 */
	@Override
	public List<PartnerDto> getPartnerData() {
		return session.selectList("dao.ManagerMapper.getPartnerList");
	}
	
	/**
	 * @name:getSearchPartnerDate
	 * @date:2015. 7. 8.
	 * @author:이동희
	 * @description: 이름에 해당하는 Partner정보 반환
	 */
	@Override
	public List<PartnerDto> getSearchPartnerData(String partner_name) {
		return  session.selectList("dao.ManagerMapper.getSearchPartnerList", partner_name);
	}
	
	/**
	 * @name:getSearchPartnerYN
	 * @date:2015. 7. 10.
	 * @author:이동희
	 * @description: Partner 승인/미승인에 따른 Partner정보 리스트를 반환
	 */
	@Override
	public List<PartnerDto> getSearchPartnerYN(String partner_yn) {
		return  session.selectList("dao.ManagerMapper.getSearchPartnerYN", partner_yn);
	}
	
	/**
	 * @name:partnerSubmit
	 * @date:2015. 7. 7.
	 * @author:이동희
	 * @description: 제휴업체의 승인여부 update
	 */
	@Override
	public int partnerSubmit(int partnerNo) {
		return session.update("dao.ManagerMapper.partnerSubmit", partnerNo);
	}
	
	/**
	 * @name:partnerSubmitLog
	 * @date:2015. 7. 7.
	 * @author:이동희
	 * @description: 제휴업체 승인 로그기록 insert
	 */
	@Override
	public void partnerSubmitLog(HashMap<String, Object> hMap) {
		session.insert("dao.ManagerMapper.submitLog", hMap);
	}
	
	/**
	 * @name:partnerDelete
	 * @date:2015. 7. 7.
	 * @author:이동희
	 * @description: 제휴업체를 삭제
	 */
	@Override
	public int partnerDelete(int partnerNo) {
		return session.delete("dao.ManagerMapper.partnerDelete", partnerNo);
	}
	
	/**
	 * @name:partnerDeleteLog
	 * @date:2015. 7. 7.
	 * @author:이동희
	 * @description: 제휴업체 삭제로그를 insert
	 */
	@Override
	public void partnerDeleteLog(HashMap<String, Object> hMap) {
		session.insert("dao.ManagerMapper.partnerDeleteLog", hMap);
	}
	
	/**
	 * @name:partnerDetail
	 * @date:2015. 7. 9.
	 * @author:이동희
	 * @description: 선택 제휴업체의 세부 정보를 반환
	 */
	@Override
	public PartnerDto partnerDetail(int partnerNo) {
		return session.selectOne("dao.ManagerMapper.partnerDetail", partnerNo);
	}
	
	/**
	 * @name:getCouponData
	 * @date:2015. 7. 7.
	 * @author:이동희
	 * @description: Coupon 정보 리스트를 반환
	 */
	@Override
	public List<HashMap<String, Object>> getCouponData() {
		return session.selectList("dao.ManagerMapper.getCouponData");
	}
	
	/**
	 * @name:coupnSearch
	 * @date:2015. 7. 15.
	 * @author:이동희
	 * @description: 쿠폰 검색 리스트를 반환
	 */
	@Override
	public List<HashMap<String, Object>> coupnSearch(String partner_name) {
		return session.selectList("dao.ManagerMapper.couponSearch", partner_name);
	}
	
	/**
	 * @name:searchCouponYN
	 * @date:2015. 7. 21.
	 * @author:이동희
	 * @description: 쿠폰 승인여부 Y/N 에 따른 쿠폰 리스트를 반환
	 */
	@Override
	public List<HashMap<String, Object>> searchCouponYN(String coupon_yn) {
		return session.selectList("dao.ManagerMapper.searchCouponYN", coupon_yn);
	}
	
	/**
	 * @name:couponSubmit
	 * @date:2015. 7. 7.
	 * @author:이동희
	 * @description: 쿠폰의 승인여부 update(승인처리)
	 */
	@Override
	public int couponSubmit(int couponNo) {
		return session.update("dao.ManagerMapper.couponSubmit", couponNo);
	}
	
	/**
	 * @name:couponSubmitLog
	 * @date:2015. 7. 7.
	 * @author:이동희
	 * @description: 쿠폰을 승인 로그 insert
	 */
	@Override
	public void couponSubmitLog(HashMap<String, Object> hMap) {
		session.insert("dao.ManagerMapper.couponSubmitLog", hMap);
	}
	
	/**
	 * @name:couponCancle
	 * @date:2015. 7. 14.
	 * @author:이동희
	 * @description: 쿠폰 승인여부 update(취소처리)
	 */
	@Override
	public int couponCancle(int couponNo) {
		return session.update("dao.ManagerMapper.couponCancle", couponNo);
	}
	
	/**
	 * @name:couponCancleLog
	 * @date:2015. 7. 14.
	 * @author:이동희
	 * @description: 쿠폰 승인취소 로그 insert
	 */
	@Override
	public void couponCancleLog(HashMap<String, Object> hMap) {
		session.insert("dao.ManagerMapper.couponCancleLog", hMap);
	}
	
	/**
	 * @name:couponDetail
	 * @date:2015. 7. 15.
	 * @author:이동희
	 * @description: 쿠폰의 상세정보를 반환
	 */
	@Override
	public List<HashMap<String, Object>> couponDetail(int couponNo) {
		return session.selectList("dao.ManagerMapper.couponDetail", couponNo);
	}
	
	/**
	 * @name:getManagerDate
	 * @date:2015. 7. 3.
	 * @author:이동희
	 * @description: 관리자 리스트를 반환
	 */
	@Override
	public List<ManagerDto> getManagerDate() {
		return session.selectList("dao.ManagerMapper.getManagerList");
	}
	
	/**
	 * @name:getManagerLog
	 * @date:2015. 7. 7.
	 * @author:이동희
	 * @description: 관리자 액션 로그 리스트를 반환
	 */
	@Override
	public List<ManagerLogDto> getManagerLog(String id) {
		return session.selectList("dao.ManagerMapper.getManagerLog", id);
	}
}