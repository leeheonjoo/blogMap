package com.java.board.dto;

public class Attach_fileDto {
	
	private int file_no;	  //첨부파일 구분번호
	private int board_no;	  //게시판 번호
	private int file_type;    //첨부파일 유형
	private String file_name; //파일 이름
	private long file_size;   //파일 사이즈
	private String file_path; //파일 경로
	private String file_comment;//파일 코멘트
	public int getFile_no() {
		return file_no;
	}
	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public int getFile_type() {
		return file_type;
	}
	public void setFile_type(int file_type) {
		this.file_type = file_type;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public long getFile_size() {
		return file_size;
	}
	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}
	public String getFile_comment() {
		return file_comment;
	}
	public void setFile_comment(String file_comment) {
		this.file_comment = file_comment;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	
	
	
}
