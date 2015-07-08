package com.java.board.dto;

import org.springframework.web.multipart.MultipartFile;
	
/**
 * @name : PhotoDto
 * @date : 2015. 6. 23.
 * @author : 황준
 * @description :이미지 추가시 미리보기를 위한 기능
 */
public class PhotoDto {
	
	//Photo_uploader.html페이지의 form태그내에 존재하는 file 태그의 name명과 일치시켜줌
	private MultipartFile fileDate;
	//callback URL
	private String callback;
	//callback Method
	private String callback_func;
	
	public MultipartFile getFileDate() {
		return fileDate;
	}
	public void setFileDate(MultipartFile fileDate) {
		this.fileDate = fileDate;
	}
	public String getCallback() {
		return callback;
	}
	public void setCallback(String callback) {
		this.callback = callback;
	}
	public String getCallback_func() {
		return callback_func;
	}
	public void setCallback_func(String callback_func) {
		this.callback_func = callback_func;
	}
	
	
	
}
