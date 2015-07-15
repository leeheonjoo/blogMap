package com.java.reply.dao;

import java.util.HashMap;
import java.util.List;
import java.util.logging.Logger;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.java.reply.dto.ReplyDto;

@Repository
public class ReplyDaoImpl implements ReplyDao {
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	
	@Autowired
	private  SqlSessionTemplate sqlSession;
	
	public List<ReplyDto> getreplyList(int boardNo) {
		logger.info("BoardReadDao getreplyList-------------------------");
		return sqlSession.selectList("dao.ReplyMapper.getreplyList",boardNo);
	}
	
	public int blogWriteReply(HashMap<String, Object> hMap) {
		logger.info("BoardReadDao blogWriteReply-------------------------");
		return sqlSession.insert("dao.ReplyMapper.blogWriteReply",hMap);
		
	}

	public int blogReadReplyUpdate(HashMap<String, Object> hMap) {
		logger.info("BoardReadDao blogReadReplyUpdate-------------------------");
		return sqlSession.insert("dao.ReplyMapper.blogReadReplyUpdate",hMap);
	}

	public int blogReadReplyDelete(HashMap<String, Object> hMap) {
		logger.info("BoardReadDao blogReadReplyDelete-------------------------");
		return sqlSession.insert("dao.ReplyMapper.blogReadReplyDelete",hMap);
	}
	

}
