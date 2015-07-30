package com.java.reply.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.java.reply.dao.ReplyDaoImpl;
import com.java.reply.dto.ReplyDto;

@Service
public class ReplyServiceImpl implements ReplyService{
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	
	@Autowired
	private ReplyDaoImpl replyDao;

	/**
	 * @name : blogReadReply
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그 신규 댓글 정보 반환
	 */
	@Override
	public void blogReadReply(ModelAndView mav) {
		logger.info("BoardReadService blogReadReply------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int boardNo=Integer.parseInt(request.getParameter("board_no"));
		
		List<ReplyDto> replyList=null;
		
		replyList=replyDao.getreplyList(boardNo);
		logger.info("replyList:"+replyList.size());
		Gson gson=new Gson();
		String replyList_json=gson.toJson(replyList);
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(replyList_json);
			logger.info("replyList_json:"+replyList_json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	/**
	 * @name : blogWriteReply
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그 댓글 정보 작성
	 */
	@Override
	public void blogWriteReply(ModelAndView mav) {
		logger.info("BoardReadService blogWriteReply------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int boardNo=Integer.parseInt(request.getParameter("board_no"));
		String reply_content=request.getParameter("reply_content");
		String member_id=request.getParameter("reply_member_id");
		
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("boardNo", boardNo);
		hMap.put("reply_content", reply_content);
		hMap.put("member_id", member_id);
		
		int check=0;
		check=replyDao.blogWriteReply(hMap);
		if(check>0){
			logger.info("replyWrite_check:"+check);
				try {
					response.getWriter().print(check);
				} catch (IOException e) {
					e.printStackTrace();
				}
		}
		
	}

	/**
	 * @name : blogReadReplyUpdate
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그 댓글 정보 수정
	 */
	@Override
	public void blogReadReplyUpdate(ModelAndView mav) {
		logger.info("BoardReadService blogReadReplyUpdate------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int reply_no=Integer.parseInt(request.getParameter("reply_no"));
		String reply_content=request.getParameter("reply_content");
		String member_id=request.getParameter("member_id");
		
		System.out.println(reply_no);
		System.out.println(reply_content);
		System.out.println(member_id);
		
		HashMap<String , Object> hMap=new HashMap<String, Object>();
		hMap.put("reply_no", reply_no);
		hMap.put("member_id", member_id);
		hMap.put("reply_content", reply_content);
		
		int check=0;
		check=replyDao.blogReadReplyUpdate(hMap);
		if(check>0){
			logger.info("blogReadReplyUpdate_check:"+check);
				try {
					response.getWriter().print(check);
				} catch (IOException e) {
					e.printStackTrace();
				}
		}
		
		
	}

	/**
	 * @name : blogReadReplyDelete
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그 댓글 정보 삭제
	 */
	@Override
	public void blogReadReplyDelete(ModelAndView mav) {
		logger.info("BoardReadService blogReadReplyDelete------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int reply_no=Integer.parseInt(request.getParameter("reply_no"));
		String member_id=request.getParameter("member_id");
		
		HashMap<String , Object> hMap=new HashMap<String, Object>();
		hMap.put("reply_no", reply_no);
		hMap.put("member_id", member_id);
		
		int check=0;
		check=replyDao.blogReadReplyDelete(hMap);
		if(check>0){
			logger.info("blogReadReplyDelete_check:"+check);
				try {
					response.getWriter().print(check);
				} catch (IOException e) {
					e.printStackTrace();
				}
		}
	}
}
