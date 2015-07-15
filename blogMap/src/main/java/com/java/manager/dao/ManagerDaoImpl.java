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
	public List<MemberDto> getData() {
		// TODO Auto-generated method stub
		return session.selectList("dao.ManagerMapper.getmemberList"); 
	}
	
	@Override
	public int memberDel(String id) {
		// TODO Auto-generated method stub
		return session.delete("dao.ManagerMapper.memberDelete", id);
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
	public void delLog(String id) {
		// TODO Auto-generated method stub
		session.insert("dao.ManagerMapper.delLog", id);
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
	public int partnerSubmit(String id) {
		// TODO Auto-generated method stub
		return session.update("dao.ManagerMapper.partnerSubmit", id);
	}
	
	@Override
	public void submitLog(String id) {
		// TODO Auto-generated method stub
		session.insert("dao.ManagerMapper.submitLog", id);
	}
	
	@Override
	public int partnerDelete(String id) {
		// TODO Auto-generated method stub
		return session.delete("dao.ManagerMapper.partnerDelete", id);
	}
	
	@Override
	public void partnerDeleteLog(String id) {
		// TODO Auto-generated method stub
		session.insert("dao.ManagerMapper.partnerDeleteLog", id);
	}
	
	@Override
	public List<HashMap<String, Object>> getCouponData() {
		// TODO Auto-generated method stub
		return session.selectList("dao.ManagerMapper.getCouponData");
	}
	
	@Override
	public int couponSubmit(int couponNo) {
		// TODO Auto-generated method stub
		return session.update("dao.ManagerMapper.couponSubmit", couponNo);
	}
	
	@Override
	public void couponSubmitLog(int couponNo) {
		// TODO Auto-generated method stub
		session.insert("dao.ManagerMapper.couponSubmitLog", couponNo);
	}
	
	@Override
	public int couponCancle(int couponNo) {
		// TODO Auto-generated method stub
		return session.update("dao.ManagerMapper.couponCancle", couponNo);
	}
	
	@Override
	public void couponCancleLog(int couponNo) {
		// TODO Auto-generated method stub
		session.insert("dao.ManagerMapper.couponCancleLog", couponNo);
	}
	
	@Override
	public List<HashMap<String, Object>> couponDetail(int couponNo) {
		// TODO Auto-generated method stub
		return session.selectList("dao.ManagerMapper.couponDetail", couponNo);
	}
	
	@Override
	public PartnerDto partnerDetail(int partnerNo) {
		// TODO Auto-generated method stub
		return session.selectOne("dao.ManagerMapper.partnerDetail", partnerNo);
	}
	
	
	


}
