package com.java.boardRead.dao;

import java.util.HashMap;
import java.util.List;

import com.java.board.dto.BoardDto;
import com.java.board.dto.Board_addr_infoDto;
import com.java.boardRead.dto.BoardReadDto;

public interface BoardReadDao {
	public BoardReadDto getData();
	
	public List<String> getSidoCondition();
	
	public List<String> getHeaderCondition();
	
	public List<String> getGunLocationCondition(String siData);
	
	public List<String> getDongLocationCondition(String siData, String gunData);
	
	public List<String> getDetailCategoryCondition(String headData);

	public List<BoardDto> getboardList(HashMap<String, Object> hashMap);

	public List<Board_addr_infoDto> blogSearchAddr(HashMap<String, Object> hashMap);

	public List<BoardDto> blogListResult(HashMap<String, Object> hashMap);

	public List<HashMap<String, Object>> getReadList1(int board_no);

	public int getreply(int board_no);

	public List<HashMap<String, Object>> getReadList2(int board_no);
	
}
