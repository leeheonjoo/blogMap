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
	
	/**
	 * @name : blogWrite
	 * @date : 2015. 7. 02.
	 * @author : 황준
	 * @description : 블로그 작성
	 */
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

	/**
	 * @name : blogWrite_attach
	 * @date : 2015. 7. 02.
	 * @author : 황준
	 * @description : 블로그 작성(첨부이미지)
	 */
	@Override
	public int blogWrite_attach(HashMap<String, Object> hashMap) {
		logger.info("BoardDao blogWrite_attach  DAO-------------------------");
		
		ArrayList<Attach_fileDto> attachList=(ArrayList<Attach_fileDto>) hashMap.get("attachList");
		logger.info("attachList:"+attachList.size());
		for (int i = 0; i < attachList.size(); i++) {
			logger.info(attachList.get(i).getFile_path()); 
		}
		
		int check=sqlSession.insert("dao.BoardMapper.blogWrite_attach",hashMap);
		return check;
	}
	
	/**
	 * @name : coupon_data_list
	 * @date : 2015. 7. 15.
	 * @author : 황준
	 * @description :쿠폰 리스트 조회
	 */
	@Override
	public List<HashMap<String, Object>> coupon_data_list(int board_no) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("dao.BoardMapper.coupon_data_list",board_no);
	}
	
	/**
	 * @name : getCoupon
	 * @date : 2015. 7. 15.
	 * @author : 황준
	 * @description :쿠폰 조회
	 */
	@Override
	public int getCoupon(String member_id, String coupon_no) {
		HashMap<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("member_id", member_id);
		hMap.put("coupon_no", coupon_no);
		return sqlSession.insert("dao.BoardMapper.insertCouponIssue",hMap);
	}
	
	/**
	 * @name : checkCoupon
	 * @date : 2015. 7. 15.
	 * @author : 황준
	 * @description :쿠폰 등록한 업체 체크 
	 */
	@Override
	public int checkCoupon(String member_id, String coupon_no) {
		HashMap<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("member_id", member_id);
		hMap.put("coupon_no", coupon_no);
		
		int check=0;
		String checkId=sqlSession.selectOne("dao.BoardMapper.checkCoupon",hMap);
		if(checkId!=null) check=2;
		
		return check;
	}
}
