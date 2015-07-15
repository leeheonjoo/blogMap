package com.java.reply.service;

import org.springframework.web.servlet.ModelAndView;

public interface ReplyService {

	void blogWriteReply(ModelAndView mav);

	void blogReadReply(ModelAndView mav);

	void blogReadReplyUpdate(ModelAndView mav);

	void blogReadReplyDelete(ModelAndView mav);

}
