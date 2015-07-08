package com.java.partner.service;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.java.partner.dao.PartnerDao;
import com.java.partner.dto.PartnerDto;
/**
 * @name: PartnerServiceImpl
 * @date:2015. 7. 5.
 * @author: 변태훈
 * @description: partnerService 에서 상속받아 실제로 모든 작업이 이루어 지는 장소
 */
@Component
public class PartnerServiceImpl implements PartnerService {
	private final Logger logger=Logger.getLogger(this.getClass().getName());

	@Autowired
	private PartnerDao partnerDao;
/**
 * @name: write
 * @date:2015. 7. 5.
 * @author: 변태훈
 * @description:  제휴업체 등록
 */
	@Override
	public boolean write(ModelAndView mav) {
		logger.info("PartnerServiceImp write----------------");
		
		Map<String, Object> map=mav.getModelMap();
		MultipartHttpServletRequest request=(MultipartHttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		PartnerDto partnerDto=(PartnerDto)map.get("partnerDto");
		logger.info(partnerDto.getMember_id());
		logger.info(partnerDto.getCategory_code());
		logger.info(partnerDto.getPartner_name());
		logger.info(partnerDto.getPartner_phone());
		logger.info(partnerDto.getPartner_addr());
	
		boolean isSuccess = false;			//성공했는지 실패했는지 여부 확인한다
		String uploadPath = "c:/file/";
		File dir = new File(uploadPath);
		if (!dir.isDirectory()) {			//파일이 존재하지 않을 때 
			dir.mkdirs();
		}
		Iterator<String> iter=request.getFileNames();
		while(iter.hasNext()){
			String uploadFileName=iter.next();
			MultipartFile mFile = request.getFile(uploadFileName);
			String originalFileName = mFile.getOriginalFilename();
			String saveFileName = originalFileName;
			if(saveFileName != null && !saveFileName.equals("")) {
				if(new File(uploadPath + saveFileName).exists()) {
					saveFileName = saveFileName + "_" + System.currentTimeMillis();
				}
				try {
					mFile.transferTo(new File(uploadPath + saveFileName));
					partnerDto.setPartner_pic_path(uploadPath);
					partnerDto.setPartner_pic_name(saveFileName);
					long fileImgSize=mFile.getSize();
					partnerDto.setPartner_pic_size(fileImgSize);
					
					logger.info(partnerDto.getPartner_pic_name());
					logger.info(partnerDto.getPartner_pic_path());
					long lo=partnerDto.getPartner_pic_size();
					logger.info(String.valueOf(lo));
					int check=partnerDao.partnerRegister(partnerDto);
					logger.info("partner_check:"+check);
					
					isSuccess = true;
					
				} catch (IllegalStateException e) {
					e.printStackTrace();
					isSuccess = false;
				} catch (IOException e) {
					e.printStackTrace();
					isSuccess = false;
				}
			} // if end
		} // while end
		return isSuccess;
	}
/**
 * @name: write
 * @date:2015. 7. 5.
 * @author: 변태훈
 * @description:  제휴업체 리스트
 */
	@Override
	public void list(ModelAndView mav) {
		logger.info("PartnerServiceImp list----------------");
		
		Map<String, Object> map=mav.getModelMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		HttpServletResponse response=(HttpServletResponse)map.get("response");
		
		List<PartnerDto> partnerList=partnerDao.getPartnerList();
			
	}
}
