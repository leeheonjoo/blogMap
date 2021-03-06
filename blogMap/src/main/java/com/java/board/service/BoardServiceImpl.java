package com.java.board.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.java.board.dao.BoardDao;
import com.java.board.dto.Attach_fileDto;
import com.java.board.dto.BoardDto;
import com.java.board.dto.Board_addr_infoDto;
import com.java.board.dto.PhotoDto;
import com.java.board.dto.Point_info;
import com.java.boardRead.dto.BoardReadDto;
import com.java.coupon.dto.CouponDto;
import com.java.partner.dto.PartnerDto;

@Component
public class BoardServiceImpl implements BoardService {
	private final Logger logger = Logger.getLogger(this.getClass().getName());
	
	private String key, target, query, urls, encoding, output, coord;
	private int num, display, start;
	
	@Autowired
	private BoardDao boardDao;

	/**
	 * @name : searchMap
	 * @date : 2015. 6. 25.
	 * @author : 황준
	 * @description : 지도 검색을 위한 함수 (크롬상의 rss_xml로 인한 보안문제로 proxy로 해결)
	 */
	@Override
	public void searchMap(ModelAndView mav) {
		logger.info("BoardServiceImpl searchMap");
		
		Map<String, Object> map = mav.getModelMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpServletResponse response = (HttpServletResponse) map.get("response");

		int statusCode=0;
		GetMethod method=null;
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e2) {
			e2.printStackTrace();
		}
		
		num = Integer.parseInt(request.getParameter("num"));
		//지도API일 경우(xml)
		if (num == 1) {
			key = request.getParameter("key");
			target = request.getParameter("target");
			query = request.getParameter("query");
			urls = request.getParameter("urls");
			display = Integer.parseInt(request.getParameter("display"));
			start = Integer.parseInt(request.getParameter("start"));
			try {
				urls += "?key=" + key;
				urls += "&query=" + URLEncoder.encode(query, "UTF-8");
				urls += "&target=" + target;
				urls += "&start=" + start;
				urls += "&display=" + display;
				System.out.println("1_url:" + urls);
				HttpClient client = new HttpClient();
				method = new GetMethod(urls);
				
				statusCode = client.executeMethod(method);
				response.reset();
				response.setStatus(statusCode);
				if(statusCode == HttpStatus.SC_OK){
				String result = method.getResponseBodyAsString();
				
				response.setContentType("text/xml;charset=utf-8");
				response.getWriter().print(result);
				}
			} catch (Exception e1) {
				e1.printStackTrace();
			} finally {
				if (method != null) {
					method.releaseConnection();
				}
			}
		//검색API일 경우(xml->json으로 변경)
		} else if (num == 2) {
			key = request.getParameter("key");
			query = request.getParameter("query");
			encoding = request.getParameter("encoding");
			output = request.getParameter("output");
			coord = request.getParameter("coord");
			urls = request.getParameter("urls");
			try {
				urls += "?key=" + key;
				urls += "&encoding=" + encoding;
				urls += "&coord=" + coord;
				urls += "&output=" + output;
				urls += "&query=" + URLEncoder.encode(query, "UTF-8");
				System.out.println("2_url:" + urls);
				
				try {
					URL urlss=new URL(urls);
					// 한글 처리를 위해 InputStreamReader를 UTF-8 인코딩으로 감싼다.
					InputStreamReader isr = new InputStreamReader(urlss.openConnection().getInputStream(), "UTF-8");
					 JSONObject object = (JSONObject)JSONValue.parseWithException(isr);
					 JSONObject result = (JSONObject)(object.get("result"));
					 response.setContentType("application/json;charset=utf-8");	
					 response.getWriter().print(result);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
		}
	}

	/**
	 * @name : onePhotoUpload
	 * @date : 2015. 6. 26.
	 * @author : 황준
	 * @description : 네이버 스마트에디터 api 사용시 사진 단일 업로드시
	 */
	@Override
	public String onePhotoUpload(ModelAndView mav) {
		Map<String,Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		PhotoDto photoDto=(PhotoDto) map.get("photoDto");
		String callback=photoDto.getCallback();
		String callback_func=photoDto.getCallback_func();
		String file_result="";
		
		try {
			if(photoDto.getFileDate()!=null&&photoDto.getFileDate().getOriginalFilename()!=null&&!photoDto.getFileDate().getOriginalFilename().equals("")){
				//파일이 존재하면
				String original_name=photoDto.getFileDate().getOriginalFilename();
				System.out.println("original_name:"+original_name);
				String ext=original_name.substring(original_name.lastIndexOf(".")+1);
				System.out.println("ext:"+ext);
				
				//파일 기본 경로
				String defaultPath=request.getSession().getServletContext().getRealPath("/");
				System.out.println("defaultPath:"+defaultPath);
				
				//파일 기본경로_상세경로
				String path=defaultPath+"editor"+File.separator+"photo_upload"+File.separator;
				System.out.println("path:"+path);
				File file=new File(path);
				
				//디렉토리 존재하지 않을경우 디렉토리 생성
				if(!file.exists()){
					file.mkdir();
				}
				
				//서버에 업로드 할 파일명(한글문제로 인해 원본파일은 올리지 않는것이 좋음)
				String realname=UUID.randomUUID().toString()+"."+ext;
				
				//서버에 파일쓰기
				photoDto.getFileDate().transferTo(new File(path+realname));
				file_result+="&bNewLine=true&sFileName="+original_name+"&sFileURL=/editor/photo_upload/"+realname;
			}else{
				file_result+="&errstr=error";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:"+callback+"?callback_func="+callback_func+file_result;
	}


	/**
	 * @name : onePhotoUpload
	 * @date : 2015. 6. 26.
	 * @author : 황준
	 * @description : 네이버 스마트에디터 api 사용시 사진 다중 업로드시
	 */
	@Override
	public void multiPhotoUpload(ModelAndView mav) {
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		
		try {
			//파일정보
			String sFileInfo="";
			
			//파일명을 받는다 - 일반 원본파일명
			String filename=request.getHeader("file-name");
			
			//파일 확장자
			String filename_ext=filename.substring(filename.lastIndexOf(".")+1);
			
			//확장자를 소문자로 변경
			filename_ext=filename_ext.toLowerCase();
			
			//파일 기본경로
			String dftFilePath=request.getSession().getServletContext().getRealPath("/");
			
			//파일 기본경로_상세경로
			String filePath=dftFilePath+"editor"+File.separator+"photo_upload"+File.separator;
			File file=new File(filePath);
			if(!file.exists()){
				file.mkdir();
			}
			String realFileNm="";
			
			SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
			String today=sdf.format(new Date());
			realFileNm=today+UUID.randomUUID().toString()+filename.substring(filename.lastIndexOf("."));
			String rlFileNm=filePath+realFileNm;
			
			//서버에 파일 쓰기
			InputStream is=request.getInputStream();
			OutputStream os=new FileOutputStream(rlFileNm);
			
			int numRead;
			byte b[]=new byte[Integer.parseInt(request.getHeader("file-size"))];
			while ((numRead=is.read(b,0,b.length))!=-1) {
				os.write(b,0,numRead);
			}
			if(is!=null){
				is.close();
			}
			os.flush();
			os.close();
			
			//서버에 파일쓰기
			sFileInfo+="&bNewLine=true";
			sFileInfo+="&sFileName="+filename;
			sFileInfo+="&sFileURL="+"/editor/photo_upload/"+realFileNm;
			//realFileNm 이변수는 이미지이름으로 DB에 저장햇다가 불러오면 될것 같다.
			
			PrintWriter out=response.getWriter();
			out.print(sFileInfo);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @name : getCategory
	 * @date : 2015. 7. 02.
	 * @author : 황준
	 * @description : 블로그 작성시 카테고리 갖고오기
	 */
	@Override
	public void getCategory(ModelAndView mav) {
		
		Map<String, Object>map =mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		List<String> headerList=boardDao.getHeaderCondition();
		
		Gson gson=new Gson();
		String json=gson.toJson(headerList);
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("json: " + json);
		
		
	}
	
	/**
	 * @name : blogWrite
	 * @date : 2015. 7. 02.
	 * @author : 황준
	 * @description : 블로그 작성
	 */
	@Override
	public void blogWrite(ModelAndView mav) {
		Map<String, Object> map=mav.getModel();
		MultipartHttpServletRequest request=(MultipartHttpServletRequest) map.get("request");
		Attach_fileDto attach_fileDto=(Attach_fileDto) map.get("Attach_fileDto");
		BoardDto boardDto=(BoardDto) map.get("BoardDto");
		Board_addr_infoDto board_addr_infoDto=(Board_addr_infoDto) map.get("Board_addr_infoDto");
		BoardReadDto boardreadDto=(BoardReadDto) map.get("BoardReadDto");
		Point_info point_infoDto=new Point_info();
		
		//회원 ID만(작성자) 받아옴
		String member_id=request.getParameter("member_id");
		
		HashMap<String, Object> hashMap=new HashMap<String, Object>();
		hashMap.put("boardDto", boardDto);
		hashMap.put("board_addr_infoDto", board_addr_infoDto);
		hashMap.put("boardreadDto", boardreadDto);
		hashMap.put("member_id", member_id);
		hashMap.put("point_infoDto", point_infoDto);
		
		String content=request.getParameter("board_content");
		logger.info("DB저장값 내용:"+content);
		
		//게시판 글작성
		hashMap=boardDao.blogWrite(hashMap);
		
		//결과값
		int check=(Integer) hashMap.get("check"); //성공 1
		System.out.println("check1: " + check);
		int board_no=(Integer) hashMap.get("board_no");//방금작성한 글번호
		
		//이미지
		List<MultipartFile> upFile=request.getFiles("file");
		//이미지 코멘트
		String[] comment=request.getParameterValues("comment");
				
		String timeName=null;
		String[] originalNames = new String[5];
		long[] fileSize = new long[5];
		
		ArrayList<Attach_fileDto> attachList=new ArrayList<Attach_fileDto>();
		File file=null;
		for (int j = 0; j < upFile.size(); j++) {
			String originalName=upFile.get(j).getOriginalFilename();
			if(originalName!=null||originalName!=""){
			timeName=Long.toString(System.currentTimeMillis()) + "_" +originalName;
			originalNames[j]=timeName;
			}
			fileSize[j]=upFile.get(j).getSize();
			
			if(fileSize[j]!=0){
				attach_fileDto=new Attach_fileDto();
				try{
					//20150715_1243 이헌주 : 파일업로드 절대경로 수정
					String dir = "C:/workspace/blogMap/src/main/webapp/pds/board";
					
					file=new File(dir,originalNames[j]);
					if (!file.isDirectory()) {			//파일이 존재하지 않을 때 
						file.mkdirs();
					}
					
					upFile.get(j).transferTo(file); //입출력
					
					attach_fileDto.setFile_name(originalNames[j]);
					attach_fileDto.setFile_size(fileSize[j]);
					attach_fileDto.setFile_path(file.getAbsolutePath());
					attach_fileDto.setFile_comment(comment[j]);
					
					System.out.println("파일이름:"+originalNames[j]);
					System.out.println("파일사이즈:"+fileSize[j]);
					System.out.println("파일경로:"+file.getAbsolutePath());
					System.out.println("코맨트:"+comment[j]);
					
					if(check>0){
						//첨푸파일 DB적용
						attachList.add(j,attach_fileDto);
						
						
						System.out.println("!"+attachList.size());
						System.out.println(j+"!"+attachList.get(j).getFile_name());
					}
				}catch(Exception e){
					logger.info("파일 입출력 에러" + e);
					
				}
				
			}

		}
		hashMap.put("attachList", attachList);
		if(attachList.size()==0){
			logger.info("블로그작성_파일 추가안함:"+attachList.size());
		}else{
			check=boardDao.blogWrite_attach(hashMap);
			logger.info("첨부파일 DB추가완료:"+check);
		}
		
	}
	
	/**
	 * @name : coupon_issue
	 * @date : 2015. 7. 15.
	 * @author : 황준
	 * @description : 쿠폰 발행리스트
	 */
	@Override
	public void coupon_issue(ModelAndView mav) {
		Map<String, Object>map =mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		int board_no=Integer.parseInt(request.getParameter("board_no"));
		logger.info("board_no:"+board_no);
		
		List<PartnerDto> partnerList=null;
		List<CouponDto> couponList=null;
		
		HashMap<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("partnerList", partnerList);
		hMap.put("couponList", couponList);
		
		List<HashMap<String,Object>> coupon_issue_list=new ArrayList<HashMap<String,Object>>();
		coupon_issue_list.add(hMap);
		
		coupon_issue_list=boardDao.coupon_data_list(board_no);
		logger.info("coupon_issue_list:"+coupon_issue_list);
		
		Gson gson=new Gson();
		String coupon_data_json=gson.toJson(coupon_issue_list);
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(coupon_data_json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
	}
	
	/**
	 * @name : getCoupon
	 * @date : 2015. 7. 15.
	 * @author : 황준
	 * @description : 쿠폰 조회
	 */
	@Override
	public void getCoupon(ModelAndView mav) {
		Map<String, Object>map =mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		String member_id=request.getParameter("member_id");
		String coupon_no=request.getParameter("coupon_no");
		
		logger.info("member_id:"+member_id);
		logger.info("coupon_no:"+coupon_no);
		
		int check=0;
		
		check=boardDao.checkCoupon(member_id,coupon_no);
		
		if(check!=2){
			check=boardDao.getCoupon(member_id,coupon_no);
		}
		
		logger.info("check:"+check);
		
		try {
			response.getWriter().print(check);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}