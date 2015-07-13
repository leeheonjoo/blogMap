package com.java.manager.dao;

import java.util.List;

import com.java.coupon.dto.CouponDto;
import com.java.manager.dto.ManagerDto;
import com.java.manager.dto.ManagerLogDto;
import com.java.member.dto.MemberDto;
import com.java.partner.dto.PartnerDto;

public interface ManagerDao {
	
		public List<MemberDto> getData();
		
		public int memberDel(String id);
		
		public List<MemberDto> getSearchMemberData(String member_name);
		
		public List<MemberDto> getSearchMemberType(String member_jointype);
		
		public void delLog(String id);
		
		public List<PartnerDto> getPartnerData();
		
		public List<PartnerDto> getSearchPartnerData(String partner_name);
		
		public List<PartnerDto> getSearchPartnerYN(String partner_yn);
		
		public List<ManagerDto> getManagerDate();
		
		public List<ManagerLogDto> getManagerLog(String id);
		
		public int partnerSubmit(String id);
		
		public void submitLog(String id);
		
		public int partnerDelete(String id);
		
		public void partnerDeleteLog(String id);
		
		public List<CouponDto> getCouponData();
		
		public int couponSubmit(int couponNo);
		
		public void couponSubmitLog(int couponNo);
		
		public PartnerDto partnerDetail(int partnerNo);
		

}
