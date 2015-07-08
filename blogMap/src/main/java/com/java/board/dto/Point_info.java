package com.java.board.dto;

import java.util.Date;

public class Point_info {
	private int point_no;			//포인트번호
	private String member_id;		//회원아이디(이메일)
	private int board_no;			//게시글번호
	private Date point_date;		//포인트발생일
	private int point_value;		//포인트 값
	
	
	public int getPoint_no() {
		return point_no;
	}
	public void setPoint_no(int point_no) {
		this.point_no = point_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public Date getPoint_date() {
		return point_date;
	}
	public void setPoint_date(Date point_date) {
		this.point_date = point_date;
	}
	public int getPoint_value() {
		return point_value;
	}
	public void setPoint_value(int point_value) {
		this.point_value = point_value;
	}
	
	
	
	
}
