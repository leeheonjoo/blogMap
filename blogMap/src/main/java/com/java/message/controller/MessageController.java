package com.java.message.controller;

import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.java.message.dto.MessageDto;
import com.java.message.service.MessageService;


/**
 * @author GiChang
 *
 */
@Controller
public class MessageController {
private final Logger logger=Logger.getLogger(this.getClass().getName());
	
	@Autowired
	private MessageService messageService;
	
	/**
	 * @name:sendMessageOk
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description:메시지 전송시 필요한 Controller
	 */
	
	@RequestMapping(value="/message/messageWrite.do", method=RequestMethod.POST)
	public void sendMessageOk(HttpServletRequest request, HttpServletResponse response, MessageDto messageDto){
		
		logger.info("--------------- Message Write ---------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request", request);
		mav.addObject("response", response);
		mav.addObject("messageDto", messageDto);
		
		messageService.sendMessageOk(mav);
	}

	/**
	 * @name:sendMessageListOk
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description:전송한 메시지 목록을 조회시 필요한 Controller
	 */
	@RequestMapping(value="/message/mainMessage.do",method=RequestMethod.GET)
	public void sendMessageListOk(HttpServletRequest request, HttpServletResponse response){
		
		logger.info("------------------- Send Message List ------------------");
	
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		messageService.sendMessageListOk(mav);
	}
	
	/**
	 * @name:receiveMessageListOk
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description:수신한 메시지 목록을 조회시 필요한 Controller
	 */
	/*@RequestMapping("/message/receiveMessageList.do")*/
	@RequestMapping(value="/message/mainMessage.do",method=RequestMethod.POST)
	public void receiveMessageListOk(HttpServletRequest request, HttpServletResponse response){
		
		logger.info("------------------- Receive Message List ------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		messageService.receiveMessageListOk(mav);
	}

	/**
	 * @name:messageReadOk
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description:수신한 메시지 목록 중에서 한가지를 상세조회시 필요한 Controller
	 */
	@RequestMapping("/message/messageRead.do")
	public void messageReadOk(HttpServletRequest request, HttpServletResponse response){
		
		logger.info("------------------- Message Read ------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		messageService.messageRead(mav);	
	
	}
	
	/**
	 * @name:withDrawOk
	 * @date:2015. 7. 03.
	 * @author:정기창
	 * @description:수신한 메시지 목록 중에서 한가지를 상세조회후 삭제시 필요한 Controller
	 */
	@RequestMapping(value="/message/messageDelete.do", method=RequestMethod.POST)
	public void withDrawOk(HttpServletRequest request, HttpServletResponse response, MessageDto messageDto){
		
		logger.info("----------------------- Message Delete ---------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		messageService.messageDelete(mav);
	}
}
