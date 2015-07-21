package com.java.board.controller;

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
import com.java.board.dto.PhotoDto;
import com.java.board.service.BoardService;
import com.java.boardRead.dto.BoardReadDto;

@Controller
public class BoardController {
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	
	@Autowired
	private BoardService boardService;
	
	/**
	 * @name : search
	 * @date : 2015. 6. 25.
	 * @author : 황준
	 * @description : 업체명,여행지 검색을 통한 결과 지도에 반영
	 */
	@RequestMapping(value="/board/search.do",method=RequestMethod.GET)
	public void search(HttpServletRequest request,HttpServletResponse response){
		logger.info("search come ok");
		ModelAndView mav=new ModelAndView();
		mav.addObject("request",request);
		mav.addObject("response", response);
		boardService.searchMap(mav);
		
		
		
	}
	/**
	 * @name : photoUpload
	 * @date : 2015. 6. 26.
	 * @author : 황준
	 * @description : 블록그 작성시 내용의 단일파입업로드
	 */
	//단일파일업로드
	@RequestMapping("/photoUpload")
	public String photoUpload(HttpServletRequest request,PhotoDto photoDto){
		logger.info("photoUpload ok");
		ModelAndView mav=new ModelAndView();
		mav.addObject("request",request);
		mav.addObject("photoDto", photoDto);
		String fileResult=boardService.onePhotoUpload(mav);
		
		System.out.println(fileResult);
		return fileResult;
	}
	
	/**
	 * @name : multiplePhotoUpload
	 * @date : 2015. 6. 26.
	 * @author : 황준
	 * @description : 블록그 작성시 내용의 다중파입업로드
	 */
	//다중파일업로드
		@RequestMapping("/multiplePhotoUpload")
		public void multiplePhotoUpload(HttpServletRequest request,HttpServletResponse response){
			logger.info("multiplePhotoUpload ok");
			ModelAndView mav=new ModelAndView();
			mav.addObject("request",request);
			mav.addObject("response", response);
			boardService.multiPhotoUpload(mav);
			
		}
		/**
		 * @name : getCategory
		 * @date : 2015. 7. 02.
		 * @author : 황준
		 * @description : 블로그 작성시 클릭후 바로 Select창에 로드될 카테고리 목록
		 */
		@RequestMapping("/board/getCategory.do")
		public void getCategory(HttpServletRequest request,HttpServletResponse response){
			logger.info("getCategory ok");
			ModelAndView mav=new ModelAndView();
			mav.addObject("request",request);
			mav.addObject("response", response);
			boardService.getCategory(mav);
			
		}
		/**
		 * @name : blogTest
		 * @date : 2015. 7. 02.
		 * @author : 황준
		 * @description : 블로그 작성 처리
		 */
		@RequestMapping(value="/board/blogWrite", method=RequestMethod.POST)
		public ModelAndView blogWrite(MultipartHttpServletRequest request,HttpServletResponse response,
				Attach_fileDto attach_fileDto,BoardDto boardDto,Board_addr_infoDto board_addr_infoDto,BoardReadDto boardreadDto){
			logger.info("blogTest ok");
			
			ModelAndView mav=new ModelAndView();
			mav.addObject("request",request);
			mav.addObject("response", response);
			
			mav.addObject("Attach_fileDto",attach_fileDto);
			mav.addObject("Board_addr_infoDto",board_addr_infoDto);
			mav.addObject("BoardDto",boardDto);
			mav.addObject("BoardReadDto",boardreadDto);
			
			boardService.blogWrite(mav);
			mav.setViewName("redirect:/");
			
			return mav;
			
		}
		
		
}