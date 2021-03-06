package com.java.message.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.java.board.dto.BoardDto;
import com.java.message.dao.MessageDao;
import com.java.message.dto.MessageDto;
import com.java.point.dto.PointDto;

/**
 * @name:MessageServiceImp
 * @date:2015. 6. 26.
 * @author:정기창
 * @description: MessageService 에서 상속받아 실제로 모든 작업이 이루어 지는 장소
 */
@Component
public class MessageServiceImp implements MessageService {
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	
	@Autowired
	private MessageDao messageDao;

	/**
	 * @name:sendMessageOk
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description:메시지 발송
	 */
	@Override
	public void sendMessageOk(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		MessageDto messageDto=(MessageDto) map.get("messageDto");
		
		int check=messageDao.insert(messageDto);
		logger.info("check : " + check);
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(check);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @name:sendMessageListOk
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description:발신 메시지 함
	 */
	@Override
	public void sendMessageListOk(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		// 사용자 아이디 임의로 등록
		String member_id=request.getParameter("member_id");
		logger.info("SendMessage member_id" + member_id);
		
		String pageNumber=request.getParameter("pageNumber");
		if(pageNumber==null) pageNumber="1";
		
		int currentPage=Integer.parseInt(pageNumber);
		
		int boardSize=10;
		int startRow=(currentPage-1)*boardSize+1;
		int endRow=currentPage*boardSize;
		
		// 메시지 수
		int count=messageDao.sendCount(member_id);
		logger.info("count : "+count);
	
		List<MessageDto> messageList=null;
		
		if(count>0){
			messageList=messageDao.getSendMessageList(startRow,endRow,member_id);
		}
		
		// 메시지 정보를 GSON 에 담고, 그 정보를 JSON 에 저장
		Gson gson=new Gson();
		String json=gson.toJson(messageList);
		
		// JSON 에 저장된 정보를 조회
		System.out.println("json: " + json);
		
		String send_pack=json+"|"+boardSize+"|"+count+"|"+currentPage;
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(send_pack);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @name:receiveMessageListOk
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description:수신 메시지 함
	 */
	@Override
	public void receiveMessageListOk(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		String member_id=request.getParameter("member_id");
		logger.info("receive member_id : " + member_id);
		
		String pageNumber=request.getParameter("pageNumber");
		if(pageNumber==null) pageNumber="1";
		
		int currentPage=Integer.parseInt(pageNumber);
		
		int boardSize=10;
		int startRow=(currentPage-1)*boardSize+1;
		int endRow=currentPage*boardSize;
		int count=messageDao.receiveCount(member_id);

		List<MessageDto> messageList=null;
		
		if(count>0){
			messageList=messageDao.getReceiveMessageList(startRow,endRow, member_id);
		}
		
		Gson gson=new Gson();
		String json=gson.toJson(messageList);
		
		System.out.println("json: " + json);	
		
		String receive_pack=json+"|"+boardSize+"|"+count+"|"+currentPage;
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(receive_pack);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	/**
	 * @name:messageRead
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description:메시지 상세조회
	 */
	@Override
	public void messageRead(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		int message_no=Integer.parseInt(request.getParameter("message_no"));
		// DB 에 사용할 메시지 번호를 불러온다.
		
		logger.info("message_no = " + message_no);	
		
		MessageDto messageDto=messageDao.messageRead(message_no);
		logger.info("messageDto : " + messageDto);
		
		Gson gson=new Gson();
		String json=gson.toJson(messageDto);
		
		System.out.println("json: " + json);
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @name:messageRead
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description:메시지 상세조회
	 */
	@Override
	public void messageRead_S(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		int message_no=Integer.parseInt(request.getParameter("message_no"));
		//DB 에 사용할 메시지 번호를 불러온다.
		
		logger.info("message_no = " + message_no);	
		
		MessageDto messageDto=messageDao.messageRead_S(message_no);
		logger.info("messageDto : " + messageDto);
		
		Gson gson=new Gson();
		String json=gson.toJson(messageDto);
		
		System.out.println("json: " + json);
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @name:messageDelete
	 * @date:2015. 7. 03.
	 * @author:정기창
	 * @description:메시지 삭제
	 */	
	@Override
	public void messageDelete(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		String member_id=request.getParameter("member_id");
		logger.info("member_id : " + member_id);
		
		int message_no=Integer.parseInt(request.getParameter("message_no"));
		logger.info("message_no : " + message_no);
		
		int check=messageDao.messageDelete(message_no, member_id);
		logger.info("DeleteMesssage Check : " + check);
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(check);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}