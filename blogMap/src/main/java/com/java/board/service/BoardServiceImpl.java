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

@Component
public class BoardServiceImpl implements BoardService {
	private final Logger logger = Logger.getLogger(this.getClass().getName());
	
	private String key, target, query, urls, encoding, output, coord;
	private int num, display, start;
	
	@Autowired
	private BoardDao boardDao;
	
	/**
	 * @name : getData
	 * @date : 2015. 6. 23.
	 * @author : 황준
	 * @description : 데이터 테스트
	 */
	@Override
	public void getData(ModelAndView mav) {
		Map<String, Object> map = mav.getModelMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		String content = boardDao.getData();

		logger.info("content : " + content);

		request.setAttribute("content", content);
		mav.addObject("content", content);
	}

	/**
	 * @name : searchMap
	 * @date : 2015. 6. 25.
	 * @author : 황준
	 * @description : 지도 검색을 위한 함수 (크롬상의 rss_xml로 인한 보안문제로 proxy로 해결)
	 */
	
	@Override
	public void searchMap(ModelAndView mav) {
		logger.info("searchMap!!!!!!!!!!");
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
		
		
		/*
		 * xml에서 json 파싱으로 변경 밑에는 xml파싱시 CDATA부분의 파싱을 위한 부분
		 */
	/*	try {
			
			//성공시
			if (statusCode == HttpStatus.SC_OK) {
				
				
				if (num == 1) {// 검색api일 경우
					
				} else if (num == 2) { // 지도api일 경우
					response.setContentType("text/xml;charset=utf-8");
					System.out.println("1-------------------");
					//System.out.println(result);
					
					DocumentBuilderFactory documentBuilderFactory=DocumentBuilderFactory.newInstance();
					DocumentBuilder documentBuilder=documentBuilderFactory.newDocumentBuilder();
					Document xml=null;
					xml=documentBuilder.parse(urls);
					Element element=xml.getDocumentElement();
					
					//xml=><result>태그
					Node channelNode=(Node) element.getElementsByTagName("result").item(0);
					NodeList list=channelNode.getChildNodes();
					
						
					//items tag
					NodeList itemsList=list.item(5).getChildNodes();
					//item tag
					NodeList itemList=itemsList.item(1).getChildNodes();
					//adrdetail tag
					NodeList adrdetailList=itemList.item(3).getChildNodes();
					
					NodeList sidoList=adrdetailList.item(3).getChildNodes();
					NodeList sigugunList=adrdetailList.item(5).getChildNodes();
					NodeList dongmyunList=adrdetailList.item(7).getChildNodes();
					NodeList restList=adrdetailList.item(9).getChildNodes();
					
					System.out.println("2-------------------");
					System.out.println("시도:"+sidoList.item(0).getNodeValue());
					System.out.println("시구군:"+sigugunList.item(0).getNodeValue());
					System.out.println("동면:"+dongmyunList.item(0).getNodeValue());
					System.out.println("번지:"+restList.item(0).getNodeValue());
				
					String addr=list.item(1).getChildNodes().item(0).getNodeValue();
					
					map.put(addr+k, addr);
						
					k++;
					mav.addObject("map",map);
					
					
					//response.getWriter().print(result);
				}
				
			
			
			}
			
		} catch (Exception e) {
			try {
				response.getWriter().print(e.toString());
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}*/
	}

	/**
	 * @name : onePhotoUpload
	 * @date : 2015. 6. 26.
	 * @author : 황준
	 * @description : 네이버 스마트에디터 api 사용시 사진 단일 업로드시
	 */
	//단일파일 업로드
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
	//다중파일 업로드
	@Override
	public void multiPhotoUpload(ModelAndView mav) {
		// TODO Auto-generated method stub
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
	 * @name : blogTest
	 * @date : 2015. 7. 02.
	 * @author : 황준
	 * @description : 블로그 작성시 데이터 잘갖고오는 테스트
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
					String dir = "c:/images/board";
					
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
		attachList=(ArrayList<Attach_fileDto>) hashMap.get("attachList");
		for (int i = 0; i < attachList.size(); i++) {
			System.out.println("j"+attachList.get(i).getFile_name());
		}
		
		check=boardDao.blogWrite_attach(hashMap);
		
		
		
		/*//카테고리
		String category_mname=request.getParameter("category_mname");
		String category_sname=request.getParameter("category_sname");
		System.out.println("카테고리1:"+category_mname);
		System.out.println("카테고리2:"+category_sname);
		//작성사
		
		//주소
		String sido=request.getParameter("addr_sido");
		String sigugun=request.getParameter("addr_sigugun");
		String dongmyun=request.getParameter("addr_dongri");
		String rest=request.getParameter("addr_bunji");
		
		
		
			
		//평점
		String grade=request.getParameter("board_grade");		
		
		//데이터 확인
		logger.info("DB저장값 작성자:"+member_id);
		logger.info("DB저장값 시도:"+sido);
		logger.info("DB저장값 시구군:"+sigugun);
		logger.info("DB저장값 동면:"+dongmyun);
		logger.info("DB저장값 번지:"+rest);
		logger.info("DB저장값 내용:"+content);
		logger.info("DB저장값 코멘트:"+comment);
		logger.info("DB저장값 평점:"+grade);
		
		for (int i = 0; i < upFile.size(); i++) {
			logger.info("DB저장값 이미지파일:"+upFile.get(i).getOriginalFilename());
		}*/
		
	}
}