package com.java.partner.dao;

import java.util.List;
import java.util.logging.Logger;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.java.partner.dto.PartnerDto;
/**
 * @name:partnerRegister
 * @date:2015. 7. 5.
 * @author: 변태훈
 * @description: 제휴업체 등록 (partnerRegister)
 */
@Component
public class PartnerDaoImpl implements PartnerDao {
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	
@Autowired
	public SqlSessionTemplate session;
	
@Override
	public int partnerRegister(PartnerDto partnerDto) {
		logger.info("PartnerMapper.partnerRegister-------------------------------------");
		int check=session.insert("dao.PartnerMapper.partnerRegister", partnerDto);
		
		return check;
	}
/**
 * @name:getPartnerList
 * @date:2015. 7. 7.
 * @author: 변태훈
 * @description: 제휴업체 리스트 (getPartnerList)
 */
@Override
	public List<PartnerDto> getPartnerList() {
		logger.info("PartnerMapper.partnerList----------------------------------");
		List<PartnerDto> list=session.selectList("dao.PartnerMapper.partnerList");
		logger.info(String.valueOf("partnerList_Size:"+list.size()) );
		
		return list;
	}
	
@Override
	public int getPartnerCount() {
		return session.selectOne("dao.PartnerMapper.partnerCount");
	}
@Override
	public PartnerDto getPartnerListDate(int partnerNo) {
		logger.info("PartnerMapper.getPartnerListDate----------------------");
		logger.info("partnerNo 맴퍼가기전 : "+ partnerNo);
		//PartnerDto getPartnerListDate=session.selectOne("dao.PartnerMapper.getPartnerListDate", partnerNo);
		
		return session.selectOne("dao.PartnerMapper.getPartnerListDate", partnerNo);
	}
}
