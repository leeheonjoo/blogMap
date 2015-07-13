package com.java.message.dao;

import java.util.List;

import com.java.message.dto.MessageDto;

/**
 * @name:MessageDao
 * @date:2015. 6. 26.
 * @author:정기창
 * @description:메시지를 송.수신 / 조회를 하기 위한 DB 기초 작업
 */
public interface MessageDao {

	public int insert(MessageDto messageDto);

	public int getMessageCount();

	public List<MessageDto> getSendMessageList(int startRow, int endRow, String member_id);
	
	public List<MessageDto> getReceiveMessageList(int startRow, int endRow, String member_id);

	public MessageDto messageRead(int message_no);
	
	public MessageDto messageRead_S(int message_no);

	public int messageDelete(int message_no, String member_id);

}
