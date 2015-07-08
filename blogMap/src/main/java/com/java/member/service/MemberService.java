package com.java.member.service;

import org.springframework.web.servlet.ModelAndView;

public interface MemberService {

	public void login(ModelAndView mav);

	public void register(ModelAndView mav);

	public void registerCheck(ModelAndView mav);

	public void fbLogin(ModelAndView mav);

	public void renew_pwd(ModelAndView mav);

	public void email_confirm(ModelAndView mav);

	public void myPage(ModelAndView mav);

	public void myPageUpdate_pwdCheck(ModelAndView mav);

	public void myPageUpdate(ModelAndView mav);

	public void myPageDelete(ModelAndView mav);

	public void point_info(ModelAndView mav);

	public void board_info(ModelAndView mav);

	public void favorite_info(ModelAndView mav);

	
}
