package com.java.member.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Logger;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.java.board.dto.BoardDto;
import com.java.boardRead.dto.BoardReadDto;
import com.java.coupon.dto.CouponDto;
import com.java.manager.dto.ManagerDto;
import com.java.member.dao.MemberDao;
import com.java.member.dto.MemberDto;
import com.java.partner.dto.PartnerDto;
import com.java.point.dto.PointDto;

/**
 * @name:MemberServiceImpl
 * @date:2015. 6. 26.
 * @author:김정훈
 * @description:MemberController에서 받아서 구체적인 작업을 함
 */
@Component
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	final Logger logger = Logger.getLogger(this.getClass().getName());

	/**
	 * @name:login
	 * @date:2015. 6. 23.
	 * @author:김정훈
	 * @description:요청받은 id와 password를 DB에 정보가 있는지를 확인
	 */
	@Override
	public void login(ModelAndView mav) {
		Map<String, Object> map = mav.getModelMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		logger.info("id:" + id);
		logger.info("password:" + password);
		
		
		String loginData=null;
		ManagerDto managerDto=memberDao.managerLogin(id,password);
		Gson gson=new Gson();
		
		if(managerDto==null){
			MemberDto memberDto=memberDao.login(id, password);
			loginData=gson.toJson(memberDto);
		}else{
			loginData=gson.toJson(managerDto);
		}
		
		logger.info("loginData:" + loginData);

		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(loginData);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @name:registerCheck
	 * @date:2015. 6. 23.
	 * @author:김정훈
	 * @description:member_id가 DB에 있는지 확인
	 */
	@Override
	public void registerCheck(ModelAndView mav) {
		Map<String, Object> map = mav.getModelMap();
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		String member_id = request.getParameter("member_id");
		logger.info("member_id:" + member_id);
		
		int managerCheck=memberDao.managerRgCheck(member_id);
		
		int check=0;
		if(managerCheck==0){
			MemberDto deleteMemberDto=memberDao.fbRegisterSelect(member_id);
			
			if(deleteMemberDto!=null){
				if(deleteMemberDto.getMember_jointype().equals("0003")){
					check=0;
				}else{
					check=1;
				}
			}else{
				check = memberDao.registerCheck(member_id);
			}
			
		}else{
			check=1;
		}
		
		try {
			response.getWriter().print(check);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @name:register
	 * @date:2015. 6. 25.
	 * @author:김정훈
	 * @description:회원등록
	 */
	@Override
	public void register(ModelAndView mav) {
		Map<String, Object> map = mav.getModelMap();
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		MemberDto memberDto = (MemberDto) map.get("memberDto");

		logger.info("member_name:" + memberDto.getMember_name());
		logger.info("서비스 member_pwd:" + memberDto.getMember_pwd());

		memberDto.setMember_jointype("0001");		
		int check=0;
		
		MemberDto deleteMemberDto=null;
		//삭제했다가 다시 가입했을때
		deleteMemberDto=memberDao.fbRegisterCheck(memberDto.getMember_id());
		if(deleteMemberDto!=null){
			if(deleteMemberDto.getMember_jointype().equals("0003")){
				System.out.println("bbbbbbb");
				check=memberDao.reRegister(memberDto);
			}
		}else{
			check=memberDao.register(memberDto);
		}
		
		logger.info("check:" + check);

		try {
			response.getWriter().print(check);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @name:fbLogin
	 * @date:2015. 6. 25.
	 * @author:김정훈
	 * @description:페이스북 계정으로 로그인한 회원등록과 회원탈퇴했던 아이디로 다시 회원등록 및 로그인
	 */
	@Override
	public void fbLogin(ModelAndView mav) {
		Map<String, Object> map = mav.getModelMap();
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		MemberDto memberDto = (MemberDto) map.get("memberDto");

		logger.info("member_id:" + memberDto.getMember_id());

		MemberDto selectMemberDtoCheck = memberDao.fbRegisterCheck(memberDto.getMember_id());
		logger.info("selectMemberDto:" + selectMemberDtoCheck);
		memberDto.setMember_jointype("0002");
		
		if (selectMemberDtoCheck==null) {
			int fbRegisterCheck = memberDao.fbRegister(memberDto);
			logger.info("fbRegisterCheck:" + fbRegisterCheck);
		}else if(selectMemberDtoCheck.getMember_jointype().equals("0003")){
			int fbReRegisterCheck = memberDao.fbReRegister(memberDto);
			logger.info("fbReRegisterCheck:"+fbReRegisterCheck);
		}

		MemberDto memberDtoSelect = memberDao.fbRegisterSelect(memberDto.getMember_id());
		Gson gson = new Gson();
		String json = gson.toJson(memberDtoSelect);
		logger.info("json:" + json);
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @name:renew_pwd
	 * @date:2015. 6. 29.
	 * @author:김정훈
	 * @description:기존 아이디의 비밀번호 재발급을 위한 메소드
	 */
	@Override
	public void renew_pwd(ModelAndView mav) {
		Map<String, Object> map = mav.getModelMap();
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		String member_id=request.getParameter("member_id");
		logger.info("member_id:"+member_id);
		
		
		MemberDto memberDto=memberDao.fbRegisterSelect(member_id);
		
		if(memberDto!=null&&!memberDto.getMember_jointype().equals("0003")){	
			String email=memberDto.getMember_id();
			logger.info("email:"+email);
			  // 메일 관련 정보

	        Properties p = System.getProperties();
	        p.put("mail.smtp.user", "blogmapmanager@gmail.com"); 
	        p.put("mail.smtp.starttls.enable", "true");     // gmail은 무조건 true 고정
	        p.put("mail.smtp.host", "smtp.gmail.com");      // smtp 서버 주소
	        p.put("mail.smtp.auth","true");                 // gmail은 무조건 true 고정
	        p.put("mail.smtp.port", "465");                 // gmail 포트
	        
	        p.put("mail.smtp.debug", "true");
	        p.put("mail.smtp.socketFactory.port", "465"); 
	        p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); 
	        p.put("mail.smtp.socketFactory.fallback", "false");

	        Authenticator auth = new MyAuthentication();
	         
	        //session 생성 및  MimeMessage생성
	        Session session = Session.getDefaultInstance(p, auth);
	        MimeMessage msg = new MimeMessage(session);
	         
	        try{
	            //편지보낸시간
	            msg.setSentDate(new Date());
	             
	            InternetAddress from = new InternetAddress() ;
	             
	             
	            from = new InternetAddress("blogmapmanger@gmail.com");
	             
	            // 이메일 발신자
	            msg.setFrom(from);
	             
	             
	            // 이메일 수신자
	            InternetAddress to = new InternetAddress(email);
	            msg.setRecipient(Message.RecipientType.TO, to);
	             
	            // 이메일 제목
	            msg.setSubject("BlogMap 임시비밀번호 입니다.", "UTF-8");
	             
	            // 이메일 내용 
	            String password="";
	            
	            for (int i = 1; i <= 8; i++) {
	    		      char ch = (char) ((Math.random() * 26) + 97);
	    		      password+=ch;
	    		    }
	            
	            int check=memberDao.updatePassword(email,password);
	            logger.info("check:"+check);
	            
	            try {
					response.getWriter().print(check);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	            
	            String text="귀하의 임시 비밀번호는 "+password+" 입니다.";
	            msg.setText(text, "UTF-8");
	             
	            // 이메일 헤더 
	            msg.setHeader("content-Type", "text/html");
	             
	            //메일보내기
	            javax.mail.Transport.send(msg);
	             
	        }catch (AddressException addr_e) {
	            addr_e.printStackTrace();
	        }catch (MessagingException msg_e) {
	            msg_e.printStackTrace();
	        }

		}else{
			try {
				response.getWriter().print("0");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * @name:email_confirm
	 * @date:2015. 6. 30.
	 * @author:김정훈
	 * @description:해당 아이디(이메일)로 인증문자를 보내는 메소드
	 */
	@Override
	public void email_confirm(ModelAndView mav) {
		Map<String,Object> map=mav.getModelMap();
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		String email=request.getParameter("member_id");
		logger.info("email:"+email);
		  
		// 메일 관련 정보
        Properties p = System.getProperties();
        p.put("mail.smtp.user", "blogmapmanager@gmail.com"); 
        p.put("mail.smtp.starttls.enable", "true");     // gmail은 무조건 true 고정
        p.put("mail.smtp.host", "smtp.gmail.com");      // smtp 서버 주소
        p.put("mail.smtp.auth","true");                 // gmail은 무조건 true 고정
        p.put("mail.smtp.port", "465");                 // gmail 포트
        
        p.put("mail.smtp.debug", "true");
        p.put("mail.smtp.socketFactory.port", "465"); 
        p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); 
        p.put("mail.smtp.socketFactory.fallback", "false");

        Authenticator auth = new MyAuthentication();
         
        //session 생성 및  MimeMessage생성
        Session session = Session.getDefaultInstance(p, auth);
        MimeMessage msg = new MimeMessage(session);
         
        try{
            //편지보낸시간
            msg.setSentDate(new Date());
             
            InternetAddress from = new InternetAddress() ;
                          
            from = new InternetAddress("blogmapmanger@gmail.com");
             
            // 이메일 발신자
            msg.setFrom(from);
             
             
            // 이메일 수신자
            InternetAddress to = new InternetAddress(email);
            msg.setRecipient(Message.RecipientType.TO, to);
             
            // 이메일 제목
            msg.setSubject("BlogMap 아이디 인증번호 입니다.", "UTF-8");
             
            // 이메일 내용 
            String confirm_num="";
            
            for (int i = 1; i <= 8; i++) {
		      char ch = (char) ((Math.random() * 26) + 97);
		      confirm_num+=ch;
    		}
            
            try {
				response.getWriter().print(confirm_num);
			} catch (IOException e) {
				e.printStackTrace();
			}
            
            String text="BlogMap 인증번호는 "+confirm_num+" 입니다.";
            msg.setText(text, "UTF-8");
             
            // 이메일 헤더 
            msg.setHeader("content-Type", "text/html");
             
            //메일보내기
            javax.mail.Transport.send(msg);
             
        }catch (AddressException addr_e) {
            addr_e.printStackTrace();
        }catch (MessagingException msg_e) {
            msg_e.printStackTrace();
        }

	}

	/**
	 * @name:myPage
	 * @date:2015. 6. 30.
	 * @author:김정훈
	 * @description:회원정보를 불러오는 메소드
	 */
	@Override
	public void myPage(ModelAndView mav) {
		Map<String,Object> map=mav.getModelMap();
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		String member_id=request.getParameter("member_id");
		logger.info("member_id:"+member_id);
		
		MemberDto memberDto=memberDao.fbRegisterSelect(member_id);
		String totalPoint=String.valueOf(memberDao.totalPoint(member_id));
		String totalBoard=String.valueOf(memberDao.totalBoard(member_id));
		String totalFavorite=String.valueOf(memberDao.totalFavorite(member_id));
		String totalCoupon=String.valueOf(memberDao.totalCoupon(member_id));
		
		logger.info("totalPoint:"+totalPoint);
		logger.info("totalBoard:"+totalBoard);
		logger.info("totalFavorite:"+totalFavorite);
		logger.info("totalCoupon:"+totalCoupon);
		
		Gson gson=new Gson();
		String json=gson.toJson(memberDto);
		
		String info=json+"|"+totalPoint+"|"+totalBoard +"|"+totalFavorite+"|"+totalCoupon;
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(info);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	/**
	 * @name:myPageUpdate_pwdCheck
	 * @date:2015. 6. 30.
	 * @author:김정훈
	 * @description:myPage의 회원정보 수정을위해 해당아이디의 암호 확인하는 메소드
	 */
	@Override
	public void myPageUpdate_pwdCheck(ModelAndView mav) {
		Map<String,Object> map=mav.getModelMap();
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		String member_id=request.getParameter("member_id");
		String member_pwd=request.getParameter("member_pwd");
		
		logger.info("member_id:"+member_id);
		logger.info("member_pwd:"+member_pwd);
		
		int check=memberDao.myPageUpdate_pwdCheck(member_id,member_pwd);
		
		logger.info("check"+check);
		
		try {
			response.getWriter().print(check);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @name:myPageUpdate
	 * @date:2015. 6. 30.
	 * @author:김정훈
	 * @description:myPage의 회원정보 수정
	 */
	@Override
	public void myPageUpdate(ModelAndView mav) {
		Map<String,Object> map=mav.getModelMap();
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		MemberDto memberDto=(MemberDto)map.get("memberDto");
		
		logger.info("member_pwd:"+memberDto.getMember_pwd());
		
		int check=memberDao.myPageUpdate(memberDto);
		logger.info("check:"+check);
		
		try {
			response.getWriter().print(check);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @name:myPageDelete
	 * @date:2015. 6. 30.
	 * @author:김정훈
	 * @description:해당 아이디의 회원탈퇴
	 */
	@Override
	public void myPageDelete(ModelAndView mav) {
		Map<String,Object> map=mav.getModelMap();
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		MemberDto memberDto=(MemberDto)map.get("memberDto");
		
		logger.info("member_pwd:"+memberDto.getMember_pwd());
		
		int check=memberDao.myPageDelete(memberDto);
		logger.info("check:"+check);
		
		try {
			response.getWriter().print(check);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @name:point_info
	 * @date:2015. 7. 2.
	 * @author:김정훈
	 * @description:해당 아이디의 포인트 정보를 호출하기위한 메소드
	 */
	@Override
	public void point_info(ModelAndView mav) {
		Map<String,Object> map=mav.getModelMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		
		String member_id=request.getParameter("member_id");
		logger.info("member_id:"+member_id);
		
		String pageNumber=request.getParameter("pageNumber");
		if(pageNumber==null) pageNumber="1";
		
		int currentPage=Integer.parseInt(pageNumber);
		
		int boardSize=10;
		int startRow=(currentPage-1)*boardSize+1;
		int endRow=currentPage*boardSize;
		int count=memberDao.point_info_count(member_id);
		
		logger.info("count:"+count);
		
		List<PointDto> pointDtoList=null;
		List<BoardDto> boardDtoList=null;
		HashMap<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("pointDtoList", pointDtoList);
		hMap.put("boardDtoList", boardDtoList);
		
		List<HashMap<String,Object>> pointMap=new ArrayList<HashMap<String,Object>>();
		pointMap.add(hMap);
				
		pointMap=memberDao.point_info(member_id,startRow,endRow);
		logger.info("pointMap:"+pointMap);
		
		Gson gson=new Gson();
		String pointMap_json=gson.toJson(pointMap);
				
		String point_info_pack=pointMap_json+"|"+boardSize+"|"+count+"|"+currentPage;
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(point_info_pack);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @name:board_info
	 * @date:2015. 7. 3.
	 * @author:김정훈
	 * @description:해당 아이디의 게시글 정보를 호출하기위한 메소드
	 */
	@Override
	public void board_info(ModelAndView mav) {
		Map<String,Object> map=mav.getModelMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		
		String member_id=request.getParameter("member_id");
		logger.info("member_id:"+member_id);
		
		String pageNumber=request.getParameter("pageNumber");
		if(pageNumber==null) pageNumber="1";
		
		int currentPage=Integer.parseInt(pageNumber);
		
		int boardSize=10;
		int startRow=(currentPage-1)*boardSize+1;
		int endRow=currentPage*boardSize;
		int count=memberDao.totalBoard(member_id);
		
		List<BoardDto> boardDtoList=null;
		List<BoardReadDto> boardReadDtoList=null;
		
		HashMap<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("boardDtoList", boardDtoList);
		hMap.put("boardReadDtoList", boardReadDtoList);
		
		List<HashMap<String,Object>> boardInfoList=new ArrayList<HashMap<String,Object>>();
		boardInfoList.add(hMap);
		
		boardInfoList=memberDao.board_info(member_id,startRow,endRow);
		logger.info("boardInfoList"+boardInfoList);
		
		Gson gson=new Gson();
		String boardInfo_json=gson.toJson(boardInfoList);
		
		String board_info_pack=boardInfo_json+"|"+boardSize+"|"+count+"|"+currentPage;
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(board_info_pack);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @name:favorite_info
	 * @date:2015. 7. 3.
	 * @author:김정훈
	 * @description:해당 아이디의 즐겨찾기 정보를 호출하기위한 메소드
	 */
	@Override
	public void favorite_info(ModelAndView mav) {
		Map<String,Object> map=mav.getModelMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpServletResponse response = (HttpServletResponse) map.get("response");

		String member_id=request.getParameter("member_id");
		logger.info("member_id:"+member_id);
		
		String pageNumber=request.getParameter("pageNumber");
		if(pageNumber==null) pageNumber="1";
		
		int currentPage=Integer.parseInt(pageNumber);
		
		int boardSize=10;
		int startRow=(currentPage-1)*boardSize+1;
		int endRow=currentPage*boardSize;
		int count=memberDao.totalFavorite(member_id);
		
		List<BoardDto> boardDtoList=null;
		List<BoardReadDto> favoriteList=null;
		
		HashMap<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("boardDtoList", boardDtoList);
		hMap.put("favoriteList", favoriteList);
		
		List<HashMap<String,Object>> favoriteInfoList=new ArrayList<HashMap<String,Object>>();
		favoriteInfoList.add(hMap);
		
		favoriteInfoList=memberDao.favorite_info(member_id,startRow,endRow);
		logger.info("favoriteInfoList"+favoriteInfoList);
		
		Gson gson=new Gson();
		String favoriteInfo_json=gson.toJson(favoriteInfoList);
		
		String favorite_info_pack=favoriteInfo_json+"|"+boardSize+"|"+count+"|"+currentPage;
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(favorite_info_pack);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @name:coupon_info
	 * @date:2015. 7. 3.
	 * @author:김정훈
	 * @description:해당 아이디의 쿠폰 정보를 호출하기위한 메소드
	 */
	@Override
	public void coupon_info(ModelAndView mav) {
		Map<String,Object> map=mav.getModelMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		
		String member_id=request.getParameter("member_id");
		logger.info("member_id:"+member_id);
		
		String pageNumber=request.getParameter("pageNumber");
		if(pageNumber==null) pageNumber="1";
		
		int currentPage=Integer.parseInt(pageNumber);
		
		int boardSize=10;
		int startRow=(currentPage-1)*boardSize+1;
		int endRow=currentPage*boardSize;
		int count=memberDao.totalCoupon(member_id);
		
		logger.info("count:"+count);
		List<PartnerDto> partnerList=null;
		List<CouponDto> couponList=null;
		HashMap<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("partnerList", partnerList);
		hMap.put("couponList", couponList);
		
		List<HashMap<String,Object>> coupon_info_list=new ArrayList<HashMap<String,Object>>();
		
		String coupon_use=request.getParameter("coupon_use");
		logger.info("coupon_use:"+coupon_use);
		
		if(coupon_use.equals("usable")){
			coupon_info_list=memberDao.coupon_info(member_id,startRow,endRow);
		}else if(coupon_use.equals("unusable")){
			coupon_info_list=memberDao.coupon_unusable_info(member_id, startRow, endRow);
		}
		
		Gson gson=new Gson();
		String couponInfo_json=gson.toJson(coupon_info_list);
		System.out.println(couponInfo_json);
		
		String coupon_info_pack=couponInfo_json+"|"+boardSize+"|"+count+"|"+currentPage;
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(coupon_info_pack);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @name:fb_myPage_delete
	 * @date:2015. 7. 18.
	 * @author:김정훈
	 * @description:페이스북으로 등록한 회원의 탈퇴
	 */
	@Override
	public void fb_myPage_delete(ModelAndView mav) {
		Map<String,Object> map=mav.getModelMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		
		String member_id=request.getParameter("member_id");
		logger.info("member_id:"+member_id);
		
		int check=memberDao.fbMemberDelete(member_id);
		logger.info("check:"+check);
		
		try {
			response.getWriter().print(check);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}