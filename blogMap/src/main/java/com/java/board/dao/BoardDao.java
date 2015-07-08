package com.java.board.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.java.board.dto.Attach_fileDto;
import com.java.board.dto.BoardDto;
import com.java.board.dto.Board_addr_infoDto;

public interface BoardDao {
	/**
	 * @name : getHeaderCondition
	 * @date : 2015. 6. 23.
	 * @author : 황준
	 * @description : 데이터 테스트
	 */
	public String getData();
	
	/**
	 * @name : getHeaderCondition
	 * @date : 2015. 7. 02.
	 * @author : 황준
	 * @description : 블로그 작성시 불러올 카테고리 목록
	 */
	public List<String> getHeaderCondition();
	
	/**
	 * @name : getHeaderCondition
	 * @date : 2015. 7. 03.
	 * @author : 황준
	 * @description : 블로그 작성
	 */

	public HashMap<String, Object> blogWrite(HashMap<String, Object> hashMap);

	//public int blogWrite_attach(HashMap<String, Object> hashMap);

	public int blogWrite_attach(HashMap<String, Object> hashMap);
}
