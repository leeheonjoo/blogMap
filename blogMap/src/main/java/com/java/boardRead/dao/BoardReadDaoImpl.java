package com.java.boardRead.dao;

import java.util.HashMap;
import java.util.List;
import java.util.logging.Logger;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.java.board.dto.BoardDto;
import com.java.board.dto.Board_addr_infoDto;
import com.java.boardRead.dto.BoardReadDto;
import com.java.boardRead.dto.CategoryDto;

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

	/**
	 * @name : getboardList
	 * @date : 2015. 7. 09.
	 * @author : 황준
	 * @description : 블로그 리스트 카테고리 검색 조건에 따른 검색결과 반환
	 */
	@Override
	public List<BoardDto> getboardList(HashMap<String, Object> hashMap) {
		logger.info("BoardReadDao getboardList-------------------------");
		
		/*Board_addr_infoDto board_addr_info=(Board_addr_infoDto) hashMap.get("board_addr_info");
		CategoryDto category=(CategoryDto) hashMap.get("category"); 
		String search_value=(String) hashMap.get("search_value"); 
		System.out.println(board_addr_info.getAddr_sido());
		System.out.println(board_addr_info.getAddr_sigugun());
		System.out.println(board_addr_info.getAddr_dongri());
		System.out.println(category.getCategory_mname());
		System.out.println(category.getCategory_sname());
		System.out.println(search_value);*/
		
		
		List<BoardDto> boardList=sqlSession.selectList("dao.BoardReadMapper.getboardList",hashMap);
		return boardList;
	}

	@Override
	public List<Board_addr_infoDto> blogSearchAddr(HashMap<String, Object> hashMap) {
		logger.info("BoardReadDao blogSearchAddr-------------------------");
		/*List<BoardDto> boardList= (List<BoardDto>) hashMap.get("boardList");
		System.out.println(boardList.get(0).getBoard_no());*/
		List<Board_addr_infoDto> board_addr_infoList=null;
		board_addr_infoList=sqlSession.selectList("dao.BoardReadMapper.blogSearchAddr",hashMap);
		return board_addr_infoList;
	}

	@Override
	public List<BoardDto> blogListResult(HashMap<String, Object> hashMap) {
		logger.info("BoardReadDao blogSearchAddr-------------------------");
		List<BoardDto> boardList=sqlSession.selectList("dao.BoardReadMapper.blogListResult",hashMap);
		return boardList;
	}

	@Override
	public List<HashMap<String, Object>> getReadList1(int board_no) {
		logger.info("BoardReadDao getReadList1-------------------------");
		return sqlSession.selectList("dao.BoardReadMapper.getReadList1",board_no);
	}

	@Override
	public int getreply(int board_no) {
		logger.info("BoardReadDao getreply-------------------------");
		
		return sqlSession.selectOne("dao.BoardReadMapper.getreply");
	}

	@Override
	public List<HashMap<String, Object>> getReadList2(int board_no) {
		logger.info("BoardReadDao getReadList2-------------------------");
		return sqlSession.selectList("dao.BoardReadMapper.getReadList2",board_no);
	}
}
