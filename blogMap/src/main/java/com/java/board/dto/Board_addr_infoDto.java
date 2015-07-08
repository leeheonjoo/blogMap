package com.java.board.dto;

//게시판 주소정보
public class Board_addr_infoDto {
	private int board_no;		//게시글번호
	private String addr_sido;   //시도
	private String addr_sigugun;//시구군
	private String addr_dongri;//동면리
	private String addr_bunji;//번지
	
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getAddr_sido() {
		return addr_sido;
	}
	public void setAddr_sido(String addr_sido) {
		this.addr_sido = addr_sido;
	}
	public String getAddr_sigugun() {
		return addr_sigugun;
	}
	public void setAddr_sigugun(String addr_sigugun) {
		this.addr_sigugun = addr_sigugun;
	}
	public String getAddr_dongri() {
		return addr_dongri;
	}
	public void setAddr_dongri(String addr_dongri) {
		this.addr_dongri = addr_dongri;
	}
	public String getAddr_bunji() {
		return addr_bunji;
	}
	public void setAddr_bunji(String addr_bunji) {
		this.addr_bunji = addr_bunji;
	}
	
	
}
