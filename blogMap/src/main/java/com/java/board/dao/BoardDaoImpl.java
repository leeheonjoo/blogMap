package com.java.board.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Logger;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.java.board.dto.Attach_fileDto;
import com.java.board.dto.BoardDto;
import com.java.board.dto.Board_addr_infoDto;

@Component
public class BoardDaoImpl implements BoardDao {
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/**
	 * @name : getHeaderCondition
	 * @date : 2015. 6. 23.
	 * @author : 황준
	 * @description : 데이터 테스트
	 */
	@Override
	public String getData() {
		return sqlSession.selectOne("dao.BoardReadMapper.getData");
	}
	
	/**
	 * @name : getHeaderCondition
	 * @date : 2015. 7. 02.
	 * @author : 황준
	 * @description : 블로그 작성시 불러올 카테고리 목록
	 */
	
	@Override
	public List<String> getHeaderCondition() {
		logger.info("BoardDao getHeaderCondition DAO-------------------------");
		List<String> headerList=sqlSession.selectList("dao.BoardMapper.getHeaderCondition");
		return headerList;
	}


	@Override
	public HashMap<String, Object> blogWrite(HashMap<String, Object> hashMap) {
		logger.info("BoardDao blogWrite  DAO-------------------------");
		int check=sqlSession.insert("dao.BoardMapper.blogWrite",hashMap);
		
		if(check>0){
			check=sqlSession.insert("dao.BoardMapper.blogWrite_addr",hashMap);
			if(check>0){
				check=sqlSession.insert
						("dao.BoardMapper.blogWrite_point",hashMap);
			}
		}
		hashMap.put("check", check);
		return hashMap;
	}

	/*@Override
	public int blogWrite_attach(HashMap<String, Object> hashMap) {
		// TODO Auto-generated method stub
		logger.info("BoardDao blogWrite_attach  DAO-------------------------");
		int check=sqlSession.insert("dao.BoardMapper.blogWrite_attach",hashMap);
		
		return check;
	}*/

	@Override
	public int blogWrite_attach(HashMap<String, Object> hashMap) {
		logger.info("BoardDao blogWrite_attach  DAO-------------------------");
		
		int check=sqlSession.insert("dao.BoardMapper.blogWrite_attach",hashMap);
		return check;
	}
}
