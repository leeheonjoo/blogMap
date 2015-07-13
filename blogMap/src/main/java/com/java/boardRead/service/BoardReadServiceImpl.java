package com.java.boardRead.service;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.java.board.dto.Attach_fileDto;
import com.java.board.dto.BoardDto;
import com.java.board.dto.Board_addr_infoDto;
import com.java.boardRead.dao.BoardReadDao;
import com.java.boardRead.dto.BoardReadDto;
import com.java.boardRead.dto.CategoryDto;
import com.java.reply.dto.ReplyDto;

@Component
public class BoardReadServiceImpl implements BoardReadService {
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	
	@Autowired
	private BoardReadDao boardReadDao;
	
	@Override
	public void getData(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		
		BoardReadDto boardReadDto=boardReadDao.getData();
		logger.info("content : " + boardReadDto);
		
		Gson gson=new Gson();
		String json=gson.toJson(boardReadDto);
		
		System.out.println("json: " + json);
		
		mav.addObject("json", json);
	}
	
	/**
	 * @name : getBeginCondition
	 * @date : 2015. 6. 30.
	 * @author : 이헌주
	 * @description : 검색조건(시도, 대분류) 검색조건 최초 load를 위한 메소드
	 * 				    검색조건(시도, 대분류) 검색 결과를 Json 타입으로 변환하여 반환
	 */
	@Override
	public String getBeginCondition(){
		logger.info("BoardReadService getBeginCondition------------------------");
		
		HashMap<String, Object> map=new HashMap<String, Object>();
		
		List<String> sidoList=boardReadDao.getSidoCondition();
		List<String> headerList=boardReadDao.getHeaderCondition();
		
		map.put("sido", sidoList);
		map.put("header", headerList);
		
		Gson gson=new Gson();
		String json=gson.toJson(map);
		

		
		System.out.println("json: " + json);

		logger.info("getBeginCondition json: " + json);

		
		return json;
	}
	
	/**
	 * @name : getLocationCondition
	 * @date : 2015. 6. 30.
	 * @author : 이헌주
	 * @description : 주소 검색조건 선택에 따른 하위 검색조건 load를 위한 메소드
	 * 			            검색조건(시구군 또는 동면) 검색 결과를 Json 타입으로 변환하여 반환
	 */
	@Override
	public String getLocationCondition(HttpServletRequest request, HttpServletResponse response) {
		logger.info("BoardReadService getLocationCondition------------------------");
		
		String el=(String)request.getParameter("el");
		String siData=(String)request.getParameter("siData");
		String gunData=(String)request.getParameter("gunData");
		
		List<String> gunList=null;
		List<String> dongList=null;

		Gson gson=new Gson();
		String json=null;
		
		if(el.equals("si")){
			gunList=boardReadDao.getGunLocationCondition(siData);
			System.out.println("gun: " + gunList.get(0));
			if(gunList.get(0).equals("blank")){
				dongList=boardReadDao.getDongLocationCondition(siData, "%");
			}
		}else if(el.equals("gun")){
			dongList=boardReadDao.getDongLocationCondition(siData, gunData);
		}
		
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("gunList", gunList);
		map.put("dongList", dongList);
		
		json=gson.toJson(map);
		logger.info("BoardReadService getLocationCondition json: " + json);
		
		return json;
	}

	/**
	 * @name : getCategoryCondition
	 * @date : 2015. 6. 30.
	 * @author : 이헌주
	 * @description : 카테고리 검색조건 선택에 따른 하위 검색조건 load를 위한 메소드
	 * 			            검색조건(대분류) 검색 결과를 Json 타입으로 변환하여 반환
	 */
	@Override
	public String getCategoryCondition(HttpServletRequest request, HttpServletResponse response) {
		logger.info("BoardReadService getCategoryCondition------------------------");
		
		String el=(String)request.getParameter("el");
		System.out.println(el);
		String headData=(String)request.getParameter("headData");
		
		HashMap<String, Object> map=new HashMap<String, Object>();
		
		List<String> detailList=null;

		Gson gson=new Gson();
		String json=null;
		
		if(el.equals("headCategory")){
			detailList=boardReadDao.getDetailCategoryCondition(headData);
			json=gson.toJson(detailList);
		}
		
		logger.info("getCategoryCondition json: " + json);
		
		return json;
	}
	/**
	 * @name : blogListSearch
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 검색조건에 따른 블로그 작성된 리스트의 주소에 따른 네이버 지역api 이용 
	 */
	@Override
	public void blogListSearch(ModelAndView mav) {
		logger.info("BoardReadService blogListSearch------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		String sido=request.getParameter("search_sido");
		String sigugun=request.getParameter("search_sigugun");
		String dongmyunri=request.getParameter("search_dongmyunri");
		String headCategor=request.getParameter("search_headCategory");
		String detailCategory=request.getParameter("search_detailCategory");
		String search_value=request.getParameter("search_search_value");
		
		System.out.println("sido:"+sido);
		System.out.println("sigugun:"+sigugun);
		System.out.println("dongmyunri:"+dongmyunri);
		System.out.println("headCategor:"+headCategor);
		System.out.println("detailCategory:"+detailCategory);
		System.out.println("search_value:"+search_value);
	
		Board_addr_infoDto board_addr_infoDto=new Board_addr_infoDto();
		board_addr_infoDto.setAddr_sido(sido);
		board_addr_infoDto.setAddr_sigugun(sigugun);
		board_addr_infoDto.setAddr_dongri(dongmyunri);
		
		CategoryDto categoryDto=new CategoryDto();
		categoryDto.setCategory_mname(headCategor);
		categoryDto.setCategory_sname(detailCategory);
		
		
		List<BoardDto> boardList=null;
		HashMap<String , Object> hashMap=new HashMap<String, Object>();
		hashMap.put("board_addr_info", board_addr_infoDto);
		hashMap.put("category", categoryDto);
		hashMap.put("search_value", search_value);
		boardList=boardReadDao.getboardList(hashMap);
		
		if(boardList!=null){
			System.out.println("블로그조회 갯수:"+boardList.size());;
			/*hashMap.put("boardList", boardList);
			List<Board_addr_infoDto> board_Addr_infoDto=null;
			board_Addr_infoDto=boardReadDao.blogSearchAddr(hashMap);
			System.out.println("블로그조회에 검색값에 따른 주소 갯수:"+board_Addr_infoDto.size());
			*/
			Gson gson=new Gson();
			String boardList_json=gson.toJson(boardList);
			try {
				response.getWriter().println(boardList_json);
				System.out.println(boardList_json);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			/*for (int i = 0; i < board_Addr_infoDto.size(); i++) {
				query=board_Addr_infoDto.get(i).getAddr_sido()+" "
			+board_Addr_infoDto.get(i).getAddr_sigugun()+" "
			+board_Addr_infoDto.get(i).getAddr_dongri()+" "
			+board_Addr_infoDto.get(i).getAddr_bunji();
				
			
			}*/
		}
	  }

	@Override
	public void blogListResult(ModelAndView mav) {
		logger.info("BoardReadService blogListResult------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String sido=request.getParameter("sido");
		String sigugun=request.getParameter("sigugun");
		String dongri=request.getParameter("dongri");
		String bunji=request.getParameter("bunji");
		String searchValue=request.getParameter("searchValue");
		
		HashMap<String,Object> hashMap=new HashMap<String, Object>();
		hashMap.put("sido", sido);
		hashMap.put("sigugun", sigugun);
		hashMap.put("dongri", dongri);
		hashMap.put("bunji", bunji);
		hashMap.put("searchValue", searchValue);
		List<BoardDto> boardList=null;
		boardList=boardReadDao.blogListResult(hashMap);
		List<Attach_fileDto> attachList=null;
		if(boardList!=null){
			logger.info("boardList_size:"+boardList.size());
		/*	attachList = boardReadDao.blogImage(boardList);
			logger.info("boardList_size:"+boardList.size());*/
		}
		Gson gson=new Gson();
		String result=gson.toJson(boardList);
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().println(result);
			System.out.println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void blogReadDetail(ModelAndView mav) {
		logger.info("BoardReadService blogReadDetail------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int boardNo=Integer.parseInt(request.getParameter("board_no"));
		System.out.println("board_no:"+boardNo);
		
		
		List<BoardDto> boardDtoList=null;
		List<ReplyDto> replyDtoList=null;
		List<Board_addr_infoDto> board_addr_infoDtoList=null;
		List<Attach_fileDto> attach_fileDtoList=null;
		List<CategoryDto> category=null;
		
		HashMap<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("boardDtoList", boardDtoList);
		hMap.put("board_addr_infoDtoList", board_addr_infoDtoList);
		hMap.put("category", category);
		
		List<HashMap<String,Object>> boardReadList=new ArrayList<HashMap<String,Object>>();
		boardReadList.add(hMap);
	
		hMap.put("boardDtoList", boardDtoList);
		hMap.put("board_addr_infoDtoList", board_addr_infoDtoList);
		
		
		boardReadList=boardReadDao.getReadList1(boardNo);
		
		logger.info("boardReadList"+boardReadList);
		/*hMap.put("category", category);*/
		
		/*boardReadList=board*/
		
		Gson gson=new Gson();
		String boardReadList_json=gson.toJson(boardReadList);
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(boardReadList_json);
			System.out.println(boardReadList_json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void blogReadDetailImg(ModelAndView mav) {
		logger.info("BoardReadService blogReadDetailImg------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int boardNo=Integer.parseInt(request.getParameter("board_no"));
		List<Attach_fileDto> imgList=null;
		imgList=boardReadDao.getblogImg(boardNo);
		logger.info("imgList:"+imgList);
		Gson gson=new Gson();
		String imgList_json=gson.toJson(imgList);
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(imgList_json);
			System.out.println(imgList_json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

	@Override
	public void blogListSearchSub1(ModelAndView mav) {
		logger.info("BoardReadService blogListSearchSub1------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int board_no=Integer.parseInt(request.getParameter("board_no"));
		
		List<Board_addr_infoDto> board_Addr_infoDto=null;
		board_Addr_infoDto=boardReadDao.blogSearchAddr(board_no);
		if(board_Addr_infoDto!=null){
		System.out.println("블로그조회에 검색값에 따른 주소 갯수:"+board_Addr_infoDto.size());
		Gson gson=new Gson();
		String board_Addr_infoDto_json=gson.toJson(board_Addr_infoDto);
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(board_Addr_infoDto_json);
			System.out.println(board_Addr_infoDto_json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		}
			
	}

	@Override
	public void blogListSearchSub2(ModelAndView mav) {
		logger.info("BoardReadService blogListSearchSub2------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		String category_code=request.getParameter("category_code");
		String key = request.getParameter("key");
		String encoding = request.getParameter("encoding");
		String output = request.getParameter("output");
		String coord = request.getParameter("coord");
		String urls = request.getParameter("urls");
		String query=request.getParameter("query");
		
		System.out.println("ajax에 보낼 query:"+query);
		try {
				urls += "?key=" + key;
				urls += "&encoding=" + encoding;
				urls += "&coord=" + coord;
				urls += "&output=" + output;
				urls += "&query=" + URLEncoder.encode(query, "UTF-8");
				System.out.println("blogList_url:" + urls);
				
				try {
					URL urlss=new URL(urls);
					// 한글 처리를 위해 InputStreamReader를 UTF-8 인코딩으로 감싼다.
					InputStreamReader isr = new InputStreamReader(urlss.openConnection().getInputStream(), "UTF-8");
					 JSONObject object = (JSONObject)JSONValue.parseWithException(isr);
					 JSONObject result = (JSONObject)(object.get("result"));
					 response.setContentType("application/json;charset=utf-8");	
					 response.getWriter().print(result);
					 System.out.println(result);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
					
					
					
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
	}
	
}
