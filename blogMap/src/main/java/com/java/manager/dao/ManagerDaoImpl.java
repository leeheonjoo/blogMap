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
	
	@Override
	public List<MemberDto> memberList() {
		// TODO Auto-generated method stub
		return session.selectList("dao.ManagerMapper.getmemberList"); 
	}
	
	@Override
	public List<MemberDto> getSearchMemberData(String member_name) {	// 수정해야함
		// TODO Auto-generated method stub
		return session.selectList("dao.ManagerMapper.getSearchMemberList", member_name);
	}
	
	@Override
	public List<MemberDto> getSearchMemberType(String member_jointype) {
		// TODO Auto-generated method stub
		return session.selectList("dao.ManagerMapper.getSearchMemberType", member_jointype);
	}
	
	@Override
	public int memberDel(HashMap<String, Object> hMap) {
		// TODO Auto-generated method stub
		return session.update("dao.ManagerMapper.memberDelete", hMap);
	}
	
	@Override
	public void delLog(HashMap<String, Object> hMap) {
		// TODO Auto-generated method stub
		session.insert("dao.ManagerMapper.delLog", hMap);
	}
	
	@Override
	public List<PartnerDto> getPartnerData() {
		// TODO Auto-generated method stub		
		return session.selectList("dao.ManagerMapper.getPartnerList");
	}
	
	@Override
	public List<PartnerDto> getSearchPartnerData(String partner_name) {		
		// TODO Auto-generated method stub				
		return  session.selectList("dao.ManagerMapper.getSearchPartnerList", partner_name);
	}
	
	@Override
	public List<PartnerDto> getSearchPartnerYN(String partner_yn) {
		// TODO Auto-generated method stub				
		return  session.selectList("dao.ManagerMapper.getSearchPartnerYN", partner_yn);
	}
	
	@Override
	public int partnerSubmit(int partnerNo) {
		// TODO Auto-generated method stub
		return session.update("dao.ManagerMapper.partnerSubmit", partnerNo);
	}
	
	@Override
	public void partnerSubmitLog(HashMap<String, Object> hMap) {
		// TODO Auto-generated method stub
		session.insert("dao.ManagerMapper.submitLog", hMap);
	}
	
	@Override
	public int partnerDelete(int partnerNo) {
		// TODO Auto-generated method stub
		return session.delete("dao.ManagerMapper.partnerDelete", partnerNo);
	}
	
	@Override
	public void partnerDeleteLog(HashMap<String, Object> hMap) {
		// TODO Auto-generated method stub
		session.insert("dao.ManagerMapper.partnerDeleteLog", hMap);
	}
	
	@Override
	public PartnerDto partnerDetail(int partnerNo) {
		// TODO Auto-generated method stub
		return session.selectOne("dao.ManagerMapper.partnerDetail", partnerNo);
	}
	
	@Override
	public List<HashMap<String, Object>> getCouponData() {
		// TODO Auto-generated method stub
		return session.selectList("dao.ManagerMapper.getCouponData");
	}
	
	@Override
	public List<HashMap<String, Object>> coupnSearch(String partner_name) {
		// TODO Auto-generated method stub
		return session.selectList("dao.ManagerMapper.couponSearch", partner_name);
	}
	
	@Override
	public List<HashMap<String, Object>> searchCouponYN(String coupon_yn) {
		// TODO Auto-generated method stub
		return session.selectList("dao.ManagerMapper.searchCouponYN", coupon_yn);
	}
	
	@Override
	public int couponSubmit(int couponNo) {
		// TODO Auto-generated method stub
		return session.update("dao.ManagerMapper.couponSubmit", couponNo);
	}
	
	@Override
	public void couponSubmitLog(HashMap<String, Object> hMap) {
		// TODO Auto-generated method stub
		session.insert("dao.ManagerMapper.couponSubmitLog", hMap);
	}
	
	@Override
	public int couponCancle(int couponNo) {
		// TODO Auto-generated method stub
		return session.update("dao.ManagerMapper.couponCancle", couponNo);
	}
	
	@Override
	public void couponCancleLog(HashMap<String, Object> hMap) {
		// TODO Auto-generated method stub
		session.insert("dao.ManagerMapper.couponCancleLog", hMap);
	}
	
	@Override
	public List<HashMap<String, Object>> couponDetail(int couponNo) {
		// TODO Auto-generated method stub
		return session.selectList("dao.ManagerMapper.couponDetail", couponNo);
	}
	
	@Override
	public List<ManagerDto> getManagerDate() {
		// TODO Auto-generated method stub
		return session.selectList("dao.ManagerMapper.getManagerList");
	}
	
	@Override
	public List<ManagerLogDto> getManagerLog(String id) {
		// TODO Auto-generated method stub
		return session.selectList("dao.ManagerMapper.getManagerLog", id);
	}


}
