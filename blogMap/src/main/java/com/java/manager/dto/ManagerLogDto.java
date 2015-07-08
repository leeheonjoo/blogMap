package com.java.manager.dto;

import java.util.Date;

public class ManagerLogDto {
	private int log_no;
	private String manager_id;
	private Date log_date;
	private String log_code;
	private String log_content;
	
	public int getLog_no() {
		return log_no;
	}
	
	public void setLog_no(int log_no) {
		this.log_no = log_no;
	}
	
	public String getManager_id() {
		return manager_id;
	}
	
	public void setManager_id(String manager_id) {
		this.manager_id = manager_id;
	}
	
	public Date getLog_date() {
		return log_date;
	}
	
	public void setLog_date(Date log_date) {
		this.log_date = log_date;
	}
	
	public String getLog_code() {
		return log_code;
	}
	
	public void setLog_code(String log_code) {
		this.log_code = log_code;
	}
	
	public String getLog_content() {
		return log_content;
	}
	
	public void setLog_content(String log_content) {
		this.log_content = log_content;
	}
}