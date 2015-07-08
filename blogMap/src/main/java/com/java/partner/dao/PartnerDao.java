package com.java.partner.dao;

import java.util.List;

import com.java.partner.dto.PartnerDto;
/**
 * @name:PartnerDao
 * @date:2015. 7. 5.
 * @author: 변태훈
 * @description:제휴업체 등록 / 제휴업체 리스트 등록
 */
public interface PartnerDao {

	public int partnerRegister(PartnerDto partnerDto);

	public List<PartnerDto> getPartnerList();
	
}
