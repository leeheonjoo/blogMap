package com.java.member.controller;

import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.java.member.dto.MemberDto;
import com.java.member.service.MemberService;

/**
 * @name:MemberController
 * @date:2015. 6. 22.
 * @author:김정훈
 * @description:클라이언트의 url주소 요청 맵핑
 */
@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;

	final Logger logger = Logger.getLogger(this.getClass().getName());

	/**
	 * @name:login
	 * @date:2015. 6. 25.
	 * @author:김정훈
	 * @description:로그인을 하기위한 메소드
	 */
	@RequestMapping(value = "/member/login.do", method = RequestMethod.POST)
	public void login(HttpServletRequest request, HttpServletResponse response) {
		logger.info("login-------------------------");

		ModelAndView mav = new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		memberService.login(mav);

	}

	/**
	 * @name:registerCheck
	 * @date:2015. 6. 25.
	 * @author:김정훈
	 * @description:회원등록전에 이전에 등록되어있는지 확인하는 메소드
	 */
	@RequestMapping(value = "/member/registerCheck.do", method = RequestMethod.POST)
	public void registerCheck(HttpServletRequest request,
			HttpServletResponse response) {
		logger.info("registerCheck-----------------------------");

		ModelAndView mav = new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		memberService.registerCheck(mav);
	}

	/**
	 * @name:register
	 * @date:2015. 6. 26.
	 * @author:김정훈
	 * @description:회원가입 메소드
	 */
	@RequestMapping(value = "/member/register.do", method = RequestMethod.POST)
	public void register(HttpServletResponse response, MemberDto memberDto) {
		logger.info("register--------------------------------");

		ModelAndView mav = new ModelAndView();
		mav.addObject("response", response);
		mav.addObject("memberDto", memberDto);
		memberService.register(mav);
	}

	/**
	 * @name:fbLogin
	 * @date:2015. 6. 26.
	 * @author:김정훈
	 * @description:facebook계정을 통한 로그인 메소드
	 */
	@RequestMapping(value = "/member/fbLogin.do", method = RequestMethod.POST)
	public void fbLogin(HttpServletResponse response, MemberDto memberDto) {
		logger.info("fbLogin--------------------------------");

		ModelAndView mav = new ModelAndView();
		mav.addObject("response", response);
		mav.addObject("memberDto", memberDto);
		memberService.fbLogin(mav);
	}
	
	/**
	 * @name:renew_pwd
	 * @date:2015. 6. 26.
	 * @author:김정훈
	 * @description:비밀번호 임시로 발급하는 메소드
	 */
	@RequestMapping(value="/member/renew_pwd.do",method=RequestMethod.POST)
	public void renew_pwd(HttpServletRequest request,HttpServletResponse response){
		logger.info("renew_pwd------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("response",response);
		mav.addObject("request",request);
		memberService.renew_pwd(mav);
		
	}
	
	/**
	 * @name:email_confirm
	 * @date:2015. 6. 30.
	 * @author:김정훈
	 * @description:회원가입시 이메일 인증하는 메소드
	 */
	@RequestMapping(value="/member/email_confirm.do",method=RequestMethod.POST)
	public void email_confirm(HttpServletRequest request,HttpServletResponse response){
		logger.info("email_confirm---------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		memberService.email_confirm(mav);
	}
	
	/**
	 * @name:myPage
	 * @date:2015. 6. 30.
	 * @author:김정훈
	 * @description:myPage의 회원정보를 가져오기 위한 메소드
	 */
	@RequestMapping(value="/member/myPage.do", method=RequestMethod.POST)
	public void myPage(HttpServletRequest request,HttpServletResponse response){
		logger.info("myPage------------------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		memberService.myPage(mav);
	}
	
	/**
	 * @name:myPageUpdate_pwdCheck
	 * @date:2015. 6. 30.
	 * @author:김정훈
	 * @description:myPage 수정을 위한 암호 확인하는 메소드
	 */
	@RequestMapping(value="/member/myPageUpdate_pwdCheck.do", method=RequestMethod.POST)
	public void myPageUpdate_pwdCheck(HttpServletRequest request,HttpServletResponse response){
		logger.info("myPageUpdate_pwdCheck-----------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		memberService.myPageUpdate_pwdCheck(mav);
	}
	
	/**
	 * @name:myPageUpdate
	 * @date:2015. 6. 30.
	 * @author:김정훈
	 * @description:myPage의 회원정보를 수정하는 메소드
	 */
	@RequestMapping(value="/member/myPageUpdate.do", method=RequestMethod.POST)
	public void myPageUpdate(HttpServletResponse response,MemberDto memberDto){
		logger.info("myPageUpdate-----------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("memberDto",memberDto);
		mav.addObject("response",response);
		
		memberService.myPageUpdate(mav);
	}
	
	/**
	 * @name:myPageDelete
	 * @date:2015. 6. 30.
	 * @author:김정훈
	 * @description:myPage의 회원탈퇴 메소드
	 */
	@RequestMapping(value="/member/myPageDelete.do",method=RequestMethod.POST)
	public void myPageDelete(MemberDto memberDto,HttpServletResponse response){
		logger.info("myPageDelete-----------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("memberDto",memberDto);
		mav.addObject("response",response);
		
		memberService.myPageDelete(mav);
	}
	
	/**
	 * @name:point_info
	 * @date:2015. 7. 2.
	 * @author:김정훈
	 * @description:myPage의 포인트에 관한 정보를 가져오는 메소드
	 */
	@RequestMapping(value="/member/point_info.do",method=RequestMethod.POST)
	public void point_info(HttpServletRequest request,HttpServletResponse response){
		logger.info("point_info-------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		memberService.point_info(mav);
	}
	
	/**
	 * @name:board_info
	 * @date:2015. 7. 3.
	 * @author:김정훈
	 * @description:myPage의 게시글에 관한 정보를 가져오는 메소드
	 */
	@RequestMapping(value="/member/board_info.do",method=RequestMethod.POST)
	public void board_info(HttpServletRequest request,HttpServletResponse response){
		logger.info("board_info-------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		memberService.board_info(mav);
	}
	
	/**
	 * @name:favorite_info
	 * @date:2015. 7. 3.
	 * @author:김정훈
	 * @description:myPage의 즐겨찾기에 관한 정보를 가져오는 메소드
	 */
	@RequestMapping(value="/member/favorite_info.do",method=RequestMethod.POST)
	public void favorite_info(HttpServletRequest request,HttpServletResponse response){
		logger.info("favorite_info-------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		memberService.favorite_info(mav);
	}
	
	
	/**
	 * @name:coupon_info
	 * @date:2015. 7. 3.
	 * @author:김정훈
	 * @description:myPage의 쿠폰에 관한 정보를 가져오는 메소드
	 */
	@RequestMapping(value="/member/coupon_info.do",method=RequestMethod.POST)
	public void coupon_info(HttpServletRequest request,HttpServletResponse response){
		logger.info("coupon_info------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		memberService.coupon_info(mav);
		
	}
	
	/**
	 * @name:fb_myPage_delete
	 * @date:2015. 7. 18.
	 * @author:김정훈
	 * @description:페이스북으로 로그인하여 회원등록된 회원 탈퇴하는 메소드
	 */
	@RequestMapping(value="/member/myPage_fb_delete.do",method=RequestMethod.POST)
	public void fb_myPage_delete(HttpServletRequest request,HttpServletResponse response){
		logger.info("fb_myPage_delete------------------------");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		memberService.fb_myPage_delete(mav);
	}
}
