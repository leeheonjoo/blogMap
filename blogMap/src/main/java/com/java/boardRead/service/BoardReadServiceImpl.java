package com.java.boardRead.service;

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
import com.java.boardRead.dao.BoardReadDao;
import com.java.boardRead.dto.BoardReadDto;

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
}
