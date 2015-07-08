package com.java.member.dto;

import java.util.Date;

public class MemberDto {
	private String member_id;
	private String member_pwd;
	private String member_name;
	private Date member_joindate;
	private String member_jointype;
	private int member_point;
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pwd() {
		return member_pwd;
	}
	public void setMember_pwd(String member_pwd) {
		this.member_pwd = member_pwd;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public Date getMember_joindate() {
		return member_joindate;
	}
	public void setMember_joindate(Date member_joindate) {
		this.member_joindate = member_joindate;
	}

	public String getMember_jointype() {
		return member_jointype;
	}
	public void setMember_jointype(String member_jointype) {
		this.member_jointype = member_jointype;
	}
	public int getMember_point() {
		return member_point;
	}
	public void setMember_point(int member_point) {
		this.member_point = member_point;
	}
}