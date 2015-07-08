package com.java.message.dto;

import java.util.Date;

/**
 * @name:MessageDto
 * @date:2015. 6. 26.
 * @author:정기창
 * @description:DB에 사용할 변수를 설정한다.
 */
public class MessageDto {
	public int message_no;				// 메시지 번호
	public String member_id;			// 사용자 아이디
	public String message_content;		// 메시지 내용
	public String message_receiver;		// 메시지 수신자
	public Date message_sDate;			// 메시지 발신일
	public Date message_rDate;			// 메시지 수신일
	public String message_yn;			// 메시지 수신여부
	
	public int getMessage_no() {
		return message_no;
	}
	public void setMessage_no(int message_no) {
		this.message_no = message_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMessage_content() {
		return message_content;
	}
	public void setMessage_content(String message_content) {
		this.message_content = message_content;
	}
	public String getMessage_receiver() {
		return message_receiver;
	}
	public void setMessage_receiver(String message_receiver) {
		this.message_receiver = message_receiver;
	}
	public Date getMessage_sDate() {
		return message_sDate;
	}
	public void setMessage_sDate(Date message_sDate) {
		this.message_sDate = message_sDate;
	}
	public Date getMessage_rDate() {
		return message_rDate;
	}
	public void setMessage_rDate(Date message_rDate) {
		this.message_rDate = message_rDate;
	}
	public String getMessage_yn() {
		return message_yn;
	}
	public void setMessage_yn(String message_yn) {
		this.message_yn = message_yn;
	}
}
