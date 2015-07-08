package com.java.boardRead.dao;

import java.util.List;

import com.java.boardRead.dto.BoardReadDto;

public interface BoardReadDao {
	public BoardReadDto getData();
	
	public List<String> getSidoCondition();
	
	public List<String> getHeaderCondition();
	
	public List<String> getGunLocationCondition(String siData);
	
	public List<String> getDongLocationCondition(String siData, String gunData);
	
	public List<String> getDetailCategoryCondition(String headData);
	
}
