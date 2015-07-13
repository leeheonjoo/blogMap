package com.java.reply.controller;

import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.java.reply.service.ReplyService;

@Controller
public class ReplyController {
private final Logger logger=Logger.getLogger(this.getClass().getName());
	
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping(value="/board/blogReadReply.do",method=RequestMethod.POST)
	public void blogReadReply(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogReadReply-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		replyService.blogReadReply(mav);
	}
	
	@RequestMapping(value="/board/blogWriteReply.do",method=RequestMethod.POST)
	public void blogWriteReply(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogWriteReply-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		replyService.blogWriteReply(mav);
	}
}
