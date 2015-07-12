package com.java.boardRead.dto;

public class CategoryDto {
	String category_code;	//카테고리코드
	String category_main;	//대분류코드
	String category_mname;	//대분류명
	String category_sub;	//소분류코드
	String category_sname;	//소분류명
	
	public String getCategory_code() {
		return category_code;
	}
	public void setCategory_code(String category_code) {
		this.category_code = category_code;
	}
	public String getCategory_main() {
		return category_main;
	}
	public void setCategory_main(String category_main) {
		this.category_main = category_main;
	}
	public String getCategory_mname() {
		return category_mname;
	}
	public void setCategory_mname(String category_mname) {
		this.category_mname = category_mname;
	}
	public String getCategory_sub() {
		return category_sub;
	}
	public void setCategory_sub(String category_sub) {
		this.category_sub = category_sub;
	}
	public String getCategory_sname() {
		return category_sname;
	}
	public void setCategory_sname(String category_sname) {
		this.category_sname = category_sname;
	}
	
	
}
