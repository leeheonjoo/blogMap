package com.java.manager.dto;

import java.util.Date;

public class ManagerDto {
	private String manager_id;
	private String manager_pwd;
	private String manager_name;
	private String manager_email;
	private Date manager_rgdate;
	private Date manager_exdate;
	private String manager_yn;
	
	public String getManager_id() {
		return manager_id;
	}
	
	public void setManager_id(String manager_id) {
		this.manager_id = manager_id;
	}
	
	public String getManager_pwd() {
		return manager_pwd;
	}
	
	public void setManager_pwd(String manager_pwd) {
		this.manager_pwd = manager_pwd;
	}
	
	public String getManager_name() {
		return manager_name;
	}
	
	public void setManager_name(String manager_name) {
		this.manager_name = manager_name;
	}
	
	public String getManager_email() {
		return manager_email;
	}
	
	public void setManager_email(String manager_email) {
		this.manager_email = manager_email;
	}
	
	public Date getManager_rgdate() {
		return manager_rgdate;
	}
	
	public void setManager_rgdate(Date manager_rgdate) {
		this.manager_rgdate = manager_rgdate;
	}
	
	public Date getManager_exdate() {
		return manager_exdate;
	}
	
	public void setManager_exdate(Date manager_exdate) {
		this.manager_exdate = manager_exdate;
	}
	
	public String getManager_yn() {
		return manager_yn;
	}
	
	public void setManager_yn(String manager_yn) {
		this.manager_yn = manager_yn;
	}
	
}