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
	
	@RequestMapping(value="/board/blogReadReplyUpdate.do",method=RequestMethod.POST)
	public void blogReadReplyUpdate(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogReadReplyUpdate-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		replyService.blogReadReplyUpdate(mav);
	}
	@RequestMapping(value="/board/blogReadReplyDelete.do",method=RequestMethod.POST)
	public void blogReadReplyDelete(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogReadReplyDelete-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		replyService.blogReadReplyDelete(mav);
	}
}
