package com.java.message.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.java.message.dto.MessageDto;

/**
 * @name:MessageDaoImpl
 * @date:2015. 6. 26.
 * @author:정기창
 * @description: MessageDao 를 상속 받아서 DB 정보를 Mapper 로 전송 시키는 작업
 */
@Component
public class MessageDaoImpl implements MessageDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	/**
	 * @name:insert
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description: 메시지 등록
	 */
	@Override
	public int insert(MessageDto messageDto) {
		return sqlSession.insert("dao.MessageMapper.messageSendInsert", messageDto);
	}

	/**
	 * @name:sendCount
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description: 총 송신 메시지의 개수를 조회
	 */
	@Override	
	public int sendCount(String member_id) {
		return sqlSession.selectOne("dao.MessageMapper.sendMessageCount", member_id);
	}
	
	/**
	 * @name:receiveCount
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description: 수신함 메시지의 개수를 조회
	 */
	@Override
	public int receiveCount(String member_id) {
		return sqlSession.selectOne("dao.MessageMapper.receiveMessageCount", member_id);
	}
	
	/**
	 * @name:getSendMessageList
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description: List 에 해당 ID 를 가진 사용자가 발신한 메시지 내용을 조회
	 */
	@Override
	public List<MessageDto> getSendMessageList(int startRow, int endRow, String member_id) {
		Map<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("startRow",startRow);
		hMap.put("endRow", endRow);
		hMap.put("member_id", member_id);
		return sqlSession.selectList("dao.MessageMapper.sendmessageList",hMap);
	}
	
	/**
	 * @name:getReceiveMessageList
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description: List 에 해당 ID 를 가진 사용자가 수신한 메시지 내용을 저장
	 */
	@Override
	public List<MessageDto> getReceiveMessageList(int startRow, int endRow, String member_id) {
		Map<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("startRow",startRow);
		hMap.put("endRow", endRow);
		hMap.put("member_id", member_id);
		return sqlSession.selectList("dao.MessageMapper.receivemessageList",hMap);
	}

	/**
	 * @name:messageRead
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description: List 에 저장된 메시지 정보 중에서 한가지를 검색하여 상세 조회
	 */
	@Override
	public MessageDto messageRead(int message_no) {
		MessageDto message=null;
		int check=0;
				
		check=sqlSession.update("dao.MessageMapper.read_yn",message_no);
		message=sqlSession.selectOne("dao.MessageMapper.read",message_no);
		
		return message;
	}
	
	/**
	 * @name:messageRead
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description: List 에 저장된 메시지 정보 중에서 한가지를 검색하여 상세 조회
	 */
	@Override
	public MessageDto messageRead_S(int message_no) {
		MessageDto message=null;
	
		message=sqlSession.selectOne("dao.MessageMapper.read",message_no);
		
		return message;
	}

	/**
	 * @name:messageDelete
	 * @date:2015. 6. 26.
	 * @author:정기창
	 * @description: List 에 저장된 메시지 정보 중에서 한가지를 삭제
	 */
	@Override
	public int messageDelete(int message_no, String member_id) {
		Map<Object, Object> hMap=new HashMap<Object, Object>();
		hMap.put("message_no", message_no);
		hMap.put("member_id", member_id);

		return sqlSession.delete("dao.MessageMapper.delete", hMap);
	}
}
