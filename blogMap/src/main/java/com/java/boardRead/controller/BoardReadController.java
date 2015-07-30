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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.java.board.dto.Attach_fileDto;
import com.java.board.dto.BoardDto;
import com.java.board.dto.Board_addr_infoDto;
import com.java.boardRead.dto.BoardReadDto;
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
	 * @name : getRecommandBlog
	 * @date : 2015. 7. 19.
	 * @author : 이헌주
	 * @description : 추천 블로그게시물 load를 위한 메소드
	 * 				  boardReadService에서 전달받은 게시물 정보 json을 print
	 */
	@RequestMapping(value="/board/getRecommandBlog.do", method=RequestMethod.GET)
	public void getRecommandBlog(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController getRecommandBlog--------------------------");
		
		String json=boardReadService.getRecommandBlog();

		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
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
	/**
	 * @name : getCategoryCondition
	 * @date : 2015. 7. 01.
	 * @author : 황준
	 * @description : 검색조건 선택에 따른 하위 검색조건 
	 */
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
	/**
	 * @name : getget
	 * @date : 2015. 7. 01.
	 * @author : 황준
	 * @description : 검색조건 선택에 따른 하위 검색조건 
	 */
	@RequestMapping(value="/board/blogListMain1.do", method=RequestMethod.GET)
	public ModelAndView getget(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController getCategoryCondition-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.setViewName("board/blogListMain");
		
		return mav;
	}
	/**
	 * @name : blogListSearch
	 * @date : 2015. 7. 03.
	 * @author : 황준
	 * @description : 블로그 조회 
	 */

	@RequestMapping(value="/board/blogListSearch.do",method=RequestMethod.POST)
	public void blogListSearch(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogListSearch-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogListSearch(mav);
	}
	/**
	 * @name : blogListResult
	 * @date : 2015. 7. 03.
	 * @author : 황준
	 * @description : 블로그 조회 결과
	 */
	@RequestMapping(value="/board/blogListResult.do",method=RequestMethod.POST)
	public void blogListResult(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogListResult-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogListResult(mav);	
	}
	/**
	 * @name : blogReadDetail
	 * @date : 2015. 7. 03.
	 * @author : 황준
	 * @description : 블로그 상세보기
	 */
	@RequestMapping(value="/board/blogReadDetail.do",method=RequestMethod.POST)
	public void blogReadDetail(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogReadDetail-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogReadDetail(mav);	
	}
	/**
	 * @name : blogReadDetailImg
	 * @date : 2015. 7. 03.
	 * @author : 황준
	 * @description : 블로그 상세보기 이미지
	 */
	@RequestMapping(value="/board/blogReadDetailImg",method=RequestMethod.POST)
	public void blogReadDetailImg(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogReadDetailImg-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogReadDetailImg(mav); 	
	}
	/**
	 * @name : blogListSearchSub1
	 * @date : 2015. 7. 10
	 * @author : 황준
	 * @description : 검색조건에 따른 블로그 리스트
	 */
	@RequestMapping(value="/board/blogListSearchSub1",method=RequestMethod.POST)
	public void blogListSearchSub1(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogListSearchSub1-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogListSearchSub1(mav);
	}
	/**
	 * @name : blogListSearchSub2
	 * @date : 2015. 7. 10
	 * @author : 황준
	 * @description : 검색조건에 따른 블로그 리스트
	 */
	@RequestMapping(value="/board/blogListSearchSub2",method=RequestMethod.POST)
	public void blogListSearchSub2(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogListSearchSub2-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogListSearchSub2(mav);
	}
	/**
	 * @name : blogReadReference
	 * @date : 2015. 7. 08.
	 * @author : 황준
	 * @description : 추천기능
	 */
	@RequestMapping(value="/board/blogReadReference",method=RequestMethod.POST)
	public void blogReadReference(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogReadReference-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogReadReference(mav);	
	}
	/**
	 * @name : blogReadNoreference
	 * @date : 2015. 7. 08.
	 * @author : 황준
	 * @description : 비추천기능
	 */
	@RequestMapping(value="/board/blogReadNoreference",method=RequestMethod.POST)
	public void blogReadNoreference(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogReadNoreference-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogReadNoReference(mav);	
	}
	/**
	 * @name : referenceRefresh
	 * @date : 2015. 7. 08.
	 * @author : 황준
	 * @description : 추천 재조회
	 */
	@RequestMapping(value="/board/referenceRefresh.do",method=RequestMethod.POST)
	public void referenceRefresh(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController referenceRefresh-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.referenceRefresh(mav);	
	}
	/**
	 * @name : bookMark
	 * @date : 2015. 7. 08.
	 * @author : 황준
	 * @description : 즐겨찾기 추가 
	 */
	@RequestMapping(value="/board/bookMark.do",method=RequestMethod.POST)
	public void bookMark(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController bookMark-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.bookMark(mav);		
	}
	/**
	 * @name : NobookMark
	 * @date : 2015. 7. 08.
	 * @author : 황준
	 * @description : 즐겨찾기 해제
	 */
	@RequestMapping(value="/board/NobookMark.do",method=RequestMethod.POST)
	public void NobookMark(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController NobookMark-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.NobookMark(mav);
	}
	/**
	 * @name : blogDelete
	 * @date : 2015. 7. 08.
	 * @author : 황준
	 * @description : 블로그 삭제 
	 */
	@RequestMapping(value="/board/blogDelete.do",method=RequestMethod.POST)
	public void blogDelete(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogDelete-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogDelete(mav);
	}
	/**
	 * @name : blogUpdate
	 * @date : 2015. 7. 08.
	 * @author : 황준
	 * @description : 블로그 수정 
	 */
	@RequestMapping(value="/board/blogUpdate.do",method=RequestMethod.POST)
	public void blogUpdate(HttpServletRequest request, HttpServletResponse response){
		logger.info("BoardReadController blogUpdate-------------------------");
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("request",request);
		mav.addObject("response",response);
		
		boardReadService.blogUpdate(mav);
	}
	/**
	 * @name : blogUpdateOk
	 * @date : 2015. 7. 08.
	 * @author : 황준
	 * @description : 블로그 수정 
	 */
	@RequestMapping(value="/board/blogUpdateOk",method=RequestMethod.POST)
	public ModelAndView blogUpdateOk(MultipartHttpServletRequest request, HttpServletResponse response,
			Attach_fileDto attach_fileDto,BoardDto boardDto,Board_addr_infoDto board_addr_infoDto,BoardReadDto boardreadDto){
		logger.info("BoardReadController blogUpdateOk-------------------------");
		
		ModelAndView mav=new ModelAndView();

		mav.addObject("Attach_fileDto",attach_fileDto);
		mav.addObject("Board_addr_infoDto",board_addr_infoDto);
		mav.addObject("BoardDto",boardDto);
		mav.addObject("BoardReadDto",boardreadDto);
		
		mav.addObject("request",request);
		mav.addObject("response",response);
			
		boardReadService.blogUpdateOk(mav);
		
		mav.setViewName("redirect:/");
		return mav;
	}	
}
