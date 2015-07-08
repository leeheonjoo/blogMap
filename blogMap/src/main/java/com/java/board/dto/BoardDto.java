package com.java.board.dto;

import java.util.Date;

public class BoardDto {

	private int board_no;//게시글 번호
	private String member_id;//회원아이디(이메일)
	private int category_code;//카테고리 코드
	private Date board_rgdate;//작성일
	private String board_content;//내용
	private int board_grade;	//평점
	private int board_count;	//조회수
	
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
	public int getCategory_code() {
		return category_code;
	}
	public void setCategory_code(int category_code) {
		this.category_code = category_code;
	}
	public Date getBoard_rgdate() {
		return board_rgdate;
	}
	public void setBoard_rgdate(Date board_rgdate) {
		this.board_rgdate = board_rgdate;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public int getBoard_grade() {
		return board_grade;
	}
	public void setBoard_grade(int board_grade) {
		this.board_grade = board_grade;
	}
	public int getBoard_count() {
		return board_count;
	}
	public void setBoard_count(int board_count) {
		this.board_count = board_count;
	}
	

	
}
