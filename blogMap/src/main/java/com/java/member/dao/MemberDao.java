package com.java.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.java.coupon.dto.CouponDto;
import com.java.manager.dto.ManagerDto;
import com.java.member.dto.MemberDto;

public interface MemberDao {

	public MemberDto login(String id, String password);

	public int register(MemberDto memberDto);

	public int registerCheck(String member_id);

	public MemberDto fbRegisterCheck(String member_id);

	public int fbRegister(MemberDto memberDto);

	public MemberDto fbRegisterSelect(String member_id);

	public int updatePassword(String email,String password);

	public int myPageUpdate_pwdCheck(String member_id, String member_pwd);

	public int myPageUpdate(MemberDto memberDto);

	public int myPageDelete(MemberDto memberDto);

	public int totalPoint(String member_id);

	public List<HashMap<String, Object>> point_info(String member_id,int startRow,int endRow);

	public int totalBoard(String member_id);

	public List<HashMap<String, Object>> board_info(String member_id,int startRow,int endRow);

	public List<HashMap<String, Object>> favorite_info(String member_id,int startRow,int endRow);

	public int totalFavorite(String member_id);

	public int point_info_count(String member_id);

	public int totalCoupon(String member_id);

	public List<HashMap<String, Object>> coupon_info(String member_id, int startRow,
			int endRow);

	public int managerRgCheck(String member_id);

	public ManagerDto managerLogin(String id, String password);

	public int fbMemberDelete(String member_id);

	public int reRegister(MemberDto memberDto);

	public int fbReRegister(MemberDto memberDto);

	public List<HashMap<String, Object>> coupon_unusable_info(String member_id,
			int startRow, int endRow);

	
}
