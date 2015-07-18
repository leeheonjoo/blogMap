package com.java.boardRead.controller;

import java.io.IOException;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.java.boardRead.service.BoardReadService;


/**
 * @name : BoardReadController
 * @date : 2015. 6. 26.
 * @author : 이헌주
 * @description : 블로그 게시물 검색, 읽기 메소드 mapping 컨트롤러
 */
@Controller
public class BoardReadController {
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	
	@Autowired
	private BoardReadService boardReadService;
	
	@RequestMapping(value="/board/test.do", method=RequestMethod.GET)
	public void test(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController test");
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("request", request);
		mav.addObject("response", response);
		
		boardReadService.getData(mav);
		Map<String, Object> map=mav.getModel();
		
		String json=(String)map.get("json");
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print("test");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @name : categoryBegin
	 * @date : 2015. 6. 26.
	 * @author : 이헌주
	 * @description : 검색조건(시도, 대분류) 검색조건 최초 load를 위한 메소드
	 * 				    boardReadService에서 전달받은 검색조건 json을 print
	 */
	@RequestMapping(value="/board/getBeginCondition.do", method=RequestMethod.GET)
	public void getBeginCondition(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController getBeginCondition-------------------------");
		
		String json=boardReadService.getBeginCondition();

		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @name : getLocationCondition
	 * @date : 2015. 6. 29.
	 * @author : 이헌주
	 * @description : 주소 검색조건 선택에 따른 하위 검색조건 load를 위한 메소드
	 *  			   boardReadService에서 전달받은 검색조건 json을 print
	 */
	@RequestMapping(value="/board/getLocationCondition.do", method=RequestMethod.GET)
	public void getLocationCondition(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController getLocationCondition-------------------------");
		
		String json=boardReadService.getLocationCondition(request, response);

		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/board/getCategoryCondition.do", method=RequestMethod.GET)
	public void getCategoryCondition(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController getCategoryCondition-------------------------");
		
		String json=boardReadService.getCategoryCondition(request, response);

		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/board/blogListMain1.do", method=RequestMethod.GET)
	public ModelAndView getget(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController getCategoryCondition-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.setViewName("board/blogListMain");
		
		return mav;
	}
	@RequestMapping(value="/board/blogListSearch.do",method=RequestMethod.POST)
	public void blogListSearch(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogListSearch-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogListSearch(mav);
		
		
	}
	@RequestMapping(value="/board/blogListResult.do",method=RequestMethod.POST)
	public void blogListResult(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogListResult-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogListResult(mav);
		
		
	}
	@RequestMapping(value="/board/blogReadDetail.do",method=RequestMethod.POST)
	public void blogReadDetail(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogReadDetail-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogReadDetail(mav);
		
		
	}
	@RequestMapping(value="/board/blogReadDetailImg",method=RequestMethod.POST)
	public void blogReadDetailImg(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogReadDetailImg-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogReadDetailImg(mav); 
		
		
	}
	@RequestMapping(value="/board/blogListSearchSub1",method=RequestMethod.POST)
	public void blogListSearchSub1(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogListSearchSub1-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogListSearchSub1(mav);
		
		
	}
	
	@RequestMapping(value="/board/blogListSearchSub2",method=RequestMethod.POST)
	public void blogListSearchSub2(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogListSearchSub2-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogListSearchSub2(mav);
		
		
	}
	
	@RequestMapping(value="/board/blogReadReference",method=RequestMethod.POST)
	public void blogReadReference(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogReadReference-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogReadReference(mav);
		
		
	}
	@RequestMapping(value="/board/blogReadNoreference",method=RequestMethod.POST)
	public void blogReadNoreference(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogReadNoreference-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogReadNoReference(mav);
		
		
	}
	@RequestMapping(value="/board/referenceRefresh.do",method=RequestMethod.POST)
	public void referenceRefresh(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController referenceRefresh-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.referenceRefresh(mav);
		
		
	}
	@RequestMapping(value="/board/bookMark.do",method=RequestMethod.POST)
	public void bookMark(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController bookMark-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.bookMark(mav);
		
		
	}
	@RequestMapping(value="/board/NobookMark.do",method=RequestMethod.POST)
	public void NobookMark(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController NobookMark-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.NobookMark(mav);
	}
	
	@RequestMapping(value="/board/blogDelete.do",method=RequestMethod.POST)
	public void blogDelete(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogDelete-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogDelete(mav);
	}
	
	
}
