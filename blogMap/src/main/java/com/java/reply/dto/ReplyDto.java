package com.java.reply.dto;

import java.util.Date;

public class ReplyDto {
	private int reply_no;	//댓글 번호(pk)
	private int board_no;	//게시판 번호(fk)
	private String member_id;//회원아이디
	private String reply_content;//댓글 내용
	private Date reply_date; //댓글 작성일
	
	public int getReply_no() {
		return reply_no;
	}
	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public Date getReply_date() {
		return reply_date;
	}
	public void setReply_date(Date reply_date) {
		this.reply_date = reply_date;
	}
	
	
	
	
}
