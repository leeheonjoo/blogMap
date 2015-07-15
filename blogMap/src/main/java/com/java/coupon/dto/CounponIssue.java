package com.java.coupon.dto;

import java.util.Date;

public class CounponIssue {
	private int couponissue_no;
	private int coupon_no;
	private String member_id;
	private Date couponissue_date;
	
	public int getCouponissue_no() {
		return couponissue_no;
	}
	public void setCouponissue_no(int couponissue_no) {
		this.couponissue_no = couponissue_no;
	}
	public int getCoupon_no() {
		return coupon_no;
	}
	public void setCoupon_no(int coupon_no) {
		this.coupon_no = coupon_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public Date getCouponissue_date() {
		return couponissue_date;
	}
	public void setCouponissue_date(Date couponissue_date) {
		this.couponissue_date = couponissue_date;
	}
	
	
}
