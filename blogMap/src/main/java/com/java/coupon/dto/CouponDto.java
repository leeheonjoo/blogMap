package com.java.coupon.dto;

import java.util.Date;

public class CouponDto {
	private int coupon_no;
	private int partner_no;
	private String coupon_item;
	private float coupon_discount;
	private Date coupon_bymd;
	private Date coupon_eymd;
	private String coupon_pic_name;
	private String coupon_pic_path;
	private long coupon_pic_size;
	private String coupon_yn;
	
	public int getCoupon_no() {
		return coupon_no;
	}
	
	public void setCoupon_no(int coupon_no) {
		this.coupon_no = coupon_no;
	}
	
	public int getPartner_no() {
		return partner_no;
	}
	
	public void setPartner_no(int partner_no) {
		this.partner_no = partner_no;
	}
	
	public String getCoupon_item() {
		return coupon_item;
	}
	
	public void setCoupon_item(String coupon_item) {
		this.coupon_item = coupon_item;
	}
	
	public float getCoupon_discount() {
		return coupon_discount;
	}
	
	public void setCoupon_discount(float coupon_discount) {
		this.coupon_discount = coupon_discount;
	}
	
	public Date getCoupon_bymd() {
		return coupon_bymd;
	}
	
	public void setCoupon_bymd(Date coupon_bymd) {
		this.coupon_bymd = coupon_bymd;
	}
	
	public Date getCoupon_eymd() {
		return coupon_eymd;
	}
	
	public void setCoupon_eymd(Date coupon_eymd) {
		this.coupon_eymd = coupon_eymd;
	}
	
	public String getCoupon_pic_name() {
		return coupon_pic_name;
	}
	
	public void setCoupon_pic_name(String coupon_pic_name) {
		this.coupon_pic_name = coupon_pic_name;
	}
	
	public String getCoupon_pic_path() {
		return coupon_pic_path;
	}
	
	public void setCoupon_pic_path(String coupon_pic_path) {
		this.coupon_pic_path = coupon_pic_path;
	}
	
	public long getCoupon_pic_size() {
		return coupon_pic_size;
	}
	
	public void setCoupon_pic_size(long coupon_pic_size) {
		this.coupon_pic_size = coupon_pic_size;
	}

	public String getCoupon_yn() {
		return coupon_yn;
	}

	public void setCoupon_yn(String coupon_yn) {
		this.coupon_yn = coupon_yn;
	}
	
	
	
}
