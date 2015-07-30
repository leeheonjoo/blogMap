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
	
	/**
	 * @name : blogReadReply
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그 신규 댓글 정보 반환
	 */
	@RequestMapping(value="/board/blogReadReply.do",method=RequestMethod.POST)
	public void blogReadReply(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogReadReply-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		replyService.blogReadReply(mav);
	}
	
	/**
	 * @name : blogWriteReply
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그 댓글 정보 등록
	 */
	@RequestMapping(value="/board/blogWriteReply.do",method=RequestMethod.POST)
	public void blogWriteReply(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogWriteReply-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		replyService.blogWriteReply(mav);
	}
	
	/**
	 * @name : blogReadReplyUpdate
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그 댓글 정보 수정
	 */
	@RequestMapping(value="/board/blogReadReplyUpdate.do",method=RequestMethod.POST)
	public void blogReadReplyUpdate(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogReadReplyUpdate-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		replyService.blogReadReplyUpdate(mav);
	}
	
	/**
	 * @name : blogReadReplyDelete
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그 댓글 정보 삭제
	 */
	@RequestMapping(value="/board/blogReadReplyDelete.do",method=RequestMethod.POST)
	public void blogReadReplyDelete(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogReadReplyDelete-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		replyService.blogReadReplyDelete(mav);
	}
}
