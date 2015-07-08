package com.java.boardRead.dao;

import java.util.HashMap;
import java.util.List;
import java.util.logging.Logger;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.java.boardRead.dto.BoardReadDto;

/**
 * @name : BoardReadDaoImpl
 * @date : 2015. 6. 26.
 * @author : 이헌주
 * @description : BoardRead관련 디비 정보 select, insert, update
 */
@Component
public class BoardReadDaoImpl implements BoardReadDao {
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public BoardReadDto getData() {
		return sqlSession.selectOne("dao.BoardReadMapper.getData");
	}
	
	/**
	 * @name : getSidoCondition
	 * @date : 2015. 6. 26.
	 * @author : 이헌주
	 * @description : DB에서 블로그게시물 조회조건(시도) 리스트를 반환
	 */
	@Override
	public List<String> getSidoCondition() {
		logger.info("BoardReadDao getSidoCondition-------------------------");
		List<String> sidoList=sqlSession.selectList("dao.BoardReadMapper.getSidoCondition");
		
		return sidoList;
	}
	
	
	/**
	 * @name : getHeaderCondition
	 * @date : 2015. 6. 26.
	 * @author : 이헌주
	 * @description : 블로그게시물 조회조건(대분류카테고리) 리스트를 반환
	 */
	@Override
	public List<String> getHeaderCondition() {
		logger.info("BoardReadDao getHeaderCondition-------------------------");
		List<String> headerList=sqlSession.selectList("dao.BoardReadMapper.getHeaderCondition");
		
		return headerList;
	}
	
	/**
	 * @name : getGunLocationCondition
	 * @date : 2015. 6. 30.
	 * @author : 이헌주
	 * @description : 시도 조회조건 선택에 따른 시구군 조회조건 리스트 get
	 */
	@Override
	public List<String> getGunLocationCondition(String siData) {
		logger.info("BoardReadDao getGunLocationCondition-------------------------");
		List<String> gunList=sqlSession.selectList("dao.BoardReadMapper.getGunLocationCondition", siData);
		return gunList;
	}
	
	/**
	 * @name : getDongLocationCondition
	 * @date : 2015. 6. 30.
	 * @author : 이헌주
	 * @description : 시구군 조회조건 선택에 따른 동면 조회조건 리스트 get
	 */
	@Override
	public List<String> getDongLocationCondition(String siData, String gunData) {
		logger.info("BoardReadDao getDongLocationCondition-------------------------");
		HashMap<String, Object> map=new HashMap<String, Object>();
		System.out.println("siData: " + siData + " gunData: " + gunData);
		map.put("siData", siData);
		map.put("gunData", gunData);
		
		List<String> dongList=sqlSession.selectList("dao.BoardReadMapper.getDongLocationCondition", map);
		
		return dongList;
	}
	
	@Override
	public List<String> getDetailCategoryCondition(String headData) {
		logger.info("BoardReadDao getDetailCategoryCondition-------------------------");
		List<String> detailList=sqlSession.selectList("dao.BoardReadMapper.getDetailCategoryCondition", headData);
		
		return detailList;
	}
}
