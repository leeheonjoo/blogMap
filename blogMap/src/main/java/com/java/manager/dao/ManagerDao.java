package com.java.manager.dao;

import java.util.HashMap;
import java.util.List;

import com.java.coupon.dto.CouponDto;
import com.java.manager.dto.ManagerDto;
import com.java.manager.dto.ManagerLogDto;
import com.java.member.dto.MemberDto;
import com.java.partner.dto.PartnerDto;

public interface ManagerDao {
	
		public List<MemberDto> memberList();
		
		public int memberDel(HashMap<String, Object> hMap);
		
		public List<MemberDto> getSearchMemberData(String member_name);
		
		public List<MemberDto> getSearchMemberType(String member_jointype);
		
		public void delLog(HashMap<String, Object> hMap);
		
		public List<PartnerDto> getPartnerData();
		
		public List<PartnerDto> getSearchPartnerData(String partner_name);
		
		public List<PartnerDto> getSearchPartnerYN(String partner_yn);
		
		public List<ManagerDto> getManagerDate();
		
		public List<ManagerLogDto> getManagerLog(String id);
		
		public int partnerSubmit(int partnerNo);
		
		public void partnerSubmitLog(HashMap<String, Object> hMap);
		
		public int partnerDelete(int partnerNo);
		
		public void partnerDeleteLog(HashMap<String, Object> hMap);
		
		public List<HashMap<String, Object>> getCouponData();
		
		public int couponSubmit(int couponNo);
		
		public void couponSubmitLog(HashMap<String, Object> hMap);
		
		public int couponCancle(int couponNo);
		
		public void couponCancleLog(HashMap<String, Object> hMap);
		
		public List<HashMap<String, Object>> couponDetail(int coupon_no);
		
		public PartnerDto partnerDetail(int partnerNo);
		
		public List<HashMap<String, Object>> coupnSearch(String partner_name);
		
		public List<HashMap<String, Object>> searchCouponYN(String coupon_yn);
		

}
