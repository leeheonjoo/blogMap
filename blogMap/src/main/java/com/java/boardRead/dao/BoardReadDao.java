package com.java.boardRead.dao;

import java.util.HashMap;
import java.util.List;

import com.java.board.dto.Attach_fileDto;
import com.java.board.dto.BoardDto;
import com.java.board.dto.Board_addr_infoDto;
import com.java.boardRead.dto.BoardReadDto;
import com.java.boardRead.dto.RecommandDto;
import com.java.reply.dto.ReplyDto;

public interface BoardReadDao {
	public List<String> getSidoCondition();
	
	public List<String> getHeaderCondition();
	
	public List<String> getGunLocationCondition(String siData);
	
	public List<String> getDongLocationCondition(String siData, String gunData);
	
	public List<String> getDetailCategoryCondition(String headData);

	public List<HashMap<String, Object>> getboardList(HashMap<String, Object> hashMap);

	public List<Board_addr_infoDto> blogSearchAddr(int board_no);

	public List<HashMap<String,Object>> blogListResult(HashMap<String, Object> hashMap);

	public List<HashMap<String, Object>> getReadList1(int boardNo);

	public int getreply(int boardNo);

	public List<Attach_fileDto> getblogImg(int boardNo);

	public List<Object> getRecommandBlog();

	public int blogReadReference(HashMap<String, Object> hMap);

	public int blogReadNoReference(HashMap<String, Object> hMap);

	public List<RecommandDto> referenceRefresh(int board_no);

	public int bookMark(HashMap<String, Object> hMap);

	public int NobookMark(HashMap<String, Object> hMap);

	public int blogDelete(HashMap<String, Object> hMap);


	public List<HashMap<String, Object>> blogUpdate(HashMap<String, Object> hMap);

	public int blogUpdateOk(HashMap<String, Object> hashMap);

	public int blogUpdateOk_attach(HashMap<String, Object> hashMap);

	public List<HashMap<String, Object>> getboardList_check(
			HashMap<String, Object> hashMap);

	public int blogUpdate_insert(HashMap<String, Object> hashMap);

	/*public List<BoardDto> blogListResult_check(HashMap<String, Object> hashMap);*/



}
