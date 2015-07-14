package com.java.reply.dao;

import java.util.HashMap;
import java.util.List;

import com.java.reply.dto.ReplyDto;

public interface ReplyDao {

	
	public List<ReplyDto> getreplyList(int boardNo);
	
	public int blogWriteReply(HashMap<String, Object> hMap);
}
