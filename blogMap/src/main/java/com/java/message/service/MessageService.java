package com.java.message.service;

import org.springframework.web.servlet.ModelAndView;

/**
 * @name:MessageSevice
 * @date:2015. 6. 26.
 * @author:정기창
 * @description: Controller 에서 정보를 받아 실제 작업을 하기 위한 선언 단계
 */
public interface MessageService {
	
	public void sendMessageOk(ModelAndView mav);

	public void sendMessageListOk(ModelAndView mav);
	
	public void receiveMessageListOk(ModelAndView mav);

	public void messageRead(ModelAndView mav);

	public void messageDelete(ModelAndView mav);
/*
	public void messageDeleteOk(ModelAndView mav);*/

}
