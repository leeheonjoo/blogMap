package com.java.boardRead.dto;

import java.util.Date;

public class RecommandDto {
	private int recommand_no; //추천번호(pk)
	private int board_no;     //게시판번호(fk)
	private String member_id; //회원이메일(fk)
	private String recommand_yn; //추천여부(y,n)
	private Date recommand_date; //추천한날짜
	
	
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getRecommand_yn() {
		return recommand_yn;
	}
	public void setRecommand_yn(String recommand_yn) {
		this.recommand_yn = recommand_yn;
	}
	public int getRecommand_no() {
		return recommand_no;
	}
	public void setRecommand_no(int recommand_no) {
		this.recommand_no = recommand_no;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public Date getRecommand_date() {
		return recommand_date;
	}
	public void setRecommand_date(Date recommand_date) {
		this.recommand_date = recommand_date;
	}
	
}
