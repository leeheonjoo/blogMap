package com.java.boardRead.dao;

import java.util.HashMap;
import java.util.List;
import java.util.logging.Logger;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.google.gson.Gson;
import com.java.board.dto.Attach_fileDto;
import com.java.board.dto.BoardDto;
import com.java.board.dto.Board_addr_infoDto;
import com.java.boardRead.dto.BoardReadDto;
import com.java.boardRead.dto.CategoryDto;
import com.java.boardRead.dto.RecommandDto;
import com.java.reply.dto.ReplyDto;

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
	
	/**
	 * @name : getRecommandBlog
	 * @date : 2015. 7. 19.
	 * @author : 이헌주
	 * @description : DB에서 추천 블로그게시물을 조회하여 리스트를 반환
	 */
	@Override
	public List<Object> getRecommandBlog() {
		logger.info("BoardReadDao getRecommandBlog-------------------------");
		List<Object> resultList=sqlSession.selectList("dao.BoardReadMapper.getRecommandBlog");
		
		return resultList;
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
	
	/**
	 * @name : getDetailCategoryCondition
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 세부카테고리 조회조건 리스트 get
	 */
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
	 * @description : 검색조건에 따른 블로그리스트를 반환
	 */
	@Override
	public List<HashMap<String, Object>> getboardList(HashMap<String, Object> hashMap) {
		logger.info("BoardReadDao getboardList-------------------------");

		List<HashMap<String, Object>> boardList=sqlSession.selectList("dao.BoardReadMapper.getboardList",hashMap);
		return boardList;
	}

	/**
	 * @name : blogSearchAddr
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 해당 게시물의 주소정보를 반환
	 */
	@Override
	public List<Board_addr_infoDto> blogSearchAddr(int board_no) {
		logger.info("BoardReadDao blogSearchAddr-------------------------");
		/*List<BoardDto> boardList= (List<BoardDto>) hashMap.get("boardList");
		System.out.println(boardList.get(0).getBoard_no());*/
		List<Board_addr_infoDto> board_addr_infoList=null;
		board_addr_infoList=sqlSession.selectList("dao.BoardReadMapper.blogSearchAddr",board_no);
		return board_addr_infoList;
	}

	/**
	 * @name : blogListResult
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 네이버 api의 주소정보에 해당하는 블로그 리스트를 반환 
	 */
	@Override
	public List<HashMap<String,Object>> blogListResult(HashMap<String, Object> hashMap) {
		logger.info("BoardReadDao blogListResult-------------------------");
		
		return sqlSession.selectList("dao.BoardReadMapper.blogListResult",hashMap);
	}

	/**
	 * @name : getReadList1
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그번호에 해당하는 블로그 DTO를 반환
	 */
	@Override
	public List<HashMap<String, Object>> getReadList1(int boardNo) {
		logger.info("BoardReadDao getReadList1-------------------------");
		int check=0;
		List<HashMap<String, Object>> list=null;
		check=sqlSession.update("dao.BoardReadMapper.readCount",boardNo);
		if(check>0){
			list=sqlSession.selectList("dao.BoardReadMapper.getReadList1",boardNo);
		}
		return list;
	}

	/**
	 * @name : getreply
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 게시글의 댓글정보를 반환
	 */
	@Override
	public int getreply(int boardNo) {
		logger.info("BoardReadDao getreply-------------------------");
		
		return sqlSession.selectOne("dao.BoardReadMapper.getreply",boardNo);
	}

	/**
	 * @name : getblogImg
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그의 이미지 정보 리스트를 반환
	 */
	@Override
	public List<Attach_fileDto> getblogImg(int boardNo) {
		logger.info("BoardReadDao getblogImg-------------------------");
		return sqlSession.selectList("dao.BoardReadMapper.getblogImg",boardNo);
	}

	/**
	 * @name : blogReadReference
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그의 추천정보를 반환
	 */
	@Override
	public int blogReadReference(HashMap<String, Object> hMap) {
		logger.info("BoardReadDao blogReadReference-------------------------");
		return sqlSession.update("dao.BoardReadMapper.blogReadReference",hMap);
	}

	/**
	 * @name : blogReadNoReference
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그의 비추천정보를 반환
	 */
	@Override
	public int blogReadNoReference(HashMap<String, Object> hMap) {
		logger.info("BoardReadDao blogReadNoReference-------------------------");
		return sqlSession.update("dao.BoardReadMapper.blogReadNoReference",hMap);
	}

	/**
	 * @name : referenceRefresh
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그의 추천/비추천 수를 반환
	 */
	@Override
	public List<RecommandDto> referenceRefresh(int board_no) {
		logger.info("BoardReadDao referenceRefresh-------------------------");
		return sqlSession.selectList("dao.BoardReadMapper.referenceRefresh",board_no);
	}

	/**
	 * @name : bookMark
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그를 즐겨찾기 추가
	 */
	@Override
	public int bookMark(HashMap<String, Object> hMap) {
		logger.info("BoardReadDao bookMark-------------------------");
		return sqlSession.insert("dao.BoardReadMapper.bookMark",hMap);
	}

	/**
	 * @name : NobookMark
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그 즐겨찾기를 삭제
	 */
	@Override
	public int NobookMark(HashMap<String, Object> hMap) {
		logger.info("BoardReadDao NobookMark-------------------------");
		return sqlSession.insert("dao.BoardReadMapper.NobookMark",hMap);
	}

	/**
	 * @name : blogDelete
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그를 삭제
	 */
	@Override
	public int blogDelete(HashMap<String, Object> hMap) {
		logger.info("BoardReadDao blogDelete-------------------------");
		return sqlSession.delete("dao.BoardReadMapper.blogDelete",hMap);
	}

	/**
	 * @name : blogUpdate
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그 수정을 위한 원본 데이터를 반환
	 */
	@Override
	public List<HashMap<String, Object>> blogUpdate(HashMap<String, Object> hMap) {
		logger.info("BoardReadDao blogUpdate-------------------------");
		return sqlSession.selectList("dao.BoardReadMapper.blogUpdate",hMap);
	}

	/**
	 * @name : blogUpdateOk
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그 수정정보를 update
	 */
	@Override
	public int blogUpdateOk(HashMap<String, Object> hashMap) {
		logger.info("BoardReadDao blogUpdateOk-------------------------");
		int check= sqlSession.update("dao.BoardReadMapper.blogUpdateOk",hashMap);

		if(check>0){
			check=sqlSession.insert("dao.BoardReadMapper.blogUpdateOk_addr",hashMap);
		}
		return check;
		 
	}

	/**
	 * @name : blogUpdateOk_attach
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그 첨부파일 수정정보를 update
	 */
	@Override
	public int blogUpdateOk_attach(HashMap<String, Object> hashMap) {
		logger.info("BoardReadDao blogUpdateOk_attach-------------------------");
		int check= sqlSession.update("dao.BoardReadMapper.blogUpdateOk_attach",hashMap);
		return check;
	}

	/**
	 * @name : getboardList_check
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그 검색 리스트 반환
	 */
	@Override
	public List<HashMap<String, Object>> getboardList_check(
			HashMap<String, Object> hashMap) {
		logger.info("BoardReadDao getboardList_check-------------------------");
		
		List<HashMap<String, Object>> boardList=sqlSession.selectList("dao.BoardReadMapper.getboardList_check",hashMap);
		return boardList;
	}

	/**
	 * @name : blogUpdate_insert
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 블로그 수정시 신규 첨부파일 데이터 insert
	 */
	@Override
	public int blogUpdate_insert(HashMap<String, Object> hashMap) {
		logger.info("BoardReadDao blogUpdate_insert-------------------------");
		
		return sqlSession.insert("dao.BoardReadMapper.blogUpdate_insert",hashMap);
	}	
}
