package com.java.member.service;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/**
 * @name:
 * @date:2015. 6. 29.
 * @author:김정훈
 * @description:
 */
public class MyAuthentication extends Authenticator {

	   PasswordAuthentication pa;
	    
	   
	    public MyAuthentication(){
	         
	        String id = "blogmapmanager";       // 구글 ID
	        String pw = "123!@#123";          // 구글 비밀번호
	 
	        // ID와 비밀번호를 입력한다.
	        pa = new PasswordAuthentication(id, pw);
	      
	    }
	 
	    // 시스템에서 사용하는 인증정보
	    public PasswordAuthentication getPasswordAuthentication() {
	        return pa;
	    }

}
