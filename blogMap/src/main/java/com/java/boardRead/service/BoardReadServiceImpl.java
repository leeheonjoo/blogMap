package com.java.boardRead.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.dsig.spec.HMACParameterSpec;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.omg.CORBA.OBJ_ADAPTER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.java.board.dto.Attach_fileDto;
import com.java.board.dto.BoardDto;
import com.java.board.dto.Board_addr_infoDto;
import com.java.boardRead.dao.BoardReadDao;
import com.java.boardRead.dto.BoardReadDto;
import com.java.boardRead.dto.CategoryDto;
import com.java.boardRead.dto.RecommandDto;
import com.java.reply.dto.ReplyDto;

@Component
public class BoardReadServiceImpl implements BoardReadService {
	private final Logger logger=Logger.getLogger(this.getClass().getName());
	
	@Autowired
	private BoardReadDao boardReadDao;
	
	/**
	 * @name : getRecommandBlog
	 * @date : 2015. 7. 19.
	 * @author : 이헌주
	 * @description : 추천 블로그게시물을 조회하기위한 메소드
	 * 				    검색 결과를 Json 타입으로 변환하여 반환
	 */
	@Override
	public String getRecommandBlog() {
		logger.info("BoardReadService getRecommandBlog------------------------");
		
		List<Object> resultList= boardReadDao.getRecommandBlog();
		
		Gson gson=new Gson();
		String json=gson.toJson(resultList);

		logger.info("getRecommandBlog json: " + json);

		return json;
	}
	
	@Override
	public void getData(ModelAndView mav) {
		Map<String, Object> map=mav.getModelMap();
		
		BoardReadDto boardReadDto=boardReadDao.getData();
		logger.info("content : " + boardReadDto);
		
		Gson gson=new Gson();
		String json=gson.toJson(boardReadDto);
		
		System.out.println("json: " + json);
		
		mav.addObject("json", json);
	}
	
	/**
	 * @name : getBeginCondition
	 * @date : 2015. 6. 30.
	 * @author : 이헌주
	 * @description : 검색조건(시도, 대분류) 검색조건 최초 load를 위한 메소드
	 * 				    검색조건(시도, 대분류) 검색 결과를 Json 타입으로 변환하여 반환
	 */
	@Override
	public String getBeginCondition(){
		logger.info("BoardReadService getBeginCondition------------------------");
		
		HashMap<String, Object> map=new HashMap<String, Object>();
		
		List<String> sidoList=boardReadDao.getSidoCondition();
		List<String> headerList=boardReadDao.getHeaderCondition();
		
		map.put("sido", sidoList);
		map.put("header", headerList);
		
		Gson gson=new Gson();
		String json=gson.toJson(map);
		

		
		System.out.println("json: " + json);

		logger.info("getBeginCondition json: " + json);

		
		return json;
	}
	
	/**
	 * @name : getLocationCondition
	 * @date : 2015. 6. 30.
	 * @author : 이헌주
	 * @description : 주소 검색조건 선택에 따른 하위 검색조건 load를 위한 메소드
	 * 			            검색조건(시구군 또는 동면) 검색 결과를 Json 타입으로 변환하여 반환
	 */
	@Override
	public String getLocationCondition(HttpServletRequest request, HttpServletResponse response) {
		logger.info("BoardReadService getLocationCondition------------------------");
		
		String el=(String)request.getParameter("el");
		String siData=(String)request.getParameter("siData");
		String gunData=(String)request.getParameter("gunData");
		
		List<String> gunList=null;
		List<String> dongList=null;

		Gson gson=new Gson();
		String json=null;
		
		if(el.equals("si")){
			gunList=boardReadDao.getGunLocationCondition(siData);
			System.out.println("gun: " + gunList.get(0));
			if(gunList.get(0).equals("blank")){
				dongList=boardReadDao.getDongLocationCondition(siData, "%");
			}
		}else if(el.equals("gun")){
			dongList=boardReadDao.getDongLocationCondition(siData, gunData);
		}
		
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("gunList", gunList);
		map.put("dongList", dongList);
		
		json=gson.toJson(map);
		logger.info("BoardReadService getLocationCondition json: " + json);
		
		return json;
	}

	/**
	 * @name : getCategoryCondition
	 * @date : 2015. 6. 30.
	 * @author : 이헌주
	 * @description : 카테고리 검색조건 선택에 따른 하위 검색조건 load를 위한 메소드
	 * 			            검색조건(대분류) 검색 결과를 Json 타입으로 변환하여 반환
	 */
	@Override
	public String getCategoryCondition(HttpServletRequest request, HttpServletResponse response) {
		logger.info("BoardReadService getCategoryCondition------------------------");
		
		String el=(String)request.getParameter("el");
		System.out.println(el);
		String headData=(String)request.getParameter("headData");
		
		HashMap<String, Object> map=new HashMap<String, Object>();
		
		List<String> detailList=null;

		Gson gson=new Gson();
		String json=null;
		
		if(el.equals("headCategory")){
			detailList=boardReadDao.getDetailCategoryCondition(headData);
			json=gson.toJson(detailList);
		}
		
		logger.info("getCategoryCondition json: " + json);
		
		return json;
	}
	/**
	 * @name : blogListSearch
	 * @date : 2015. 7. 8.
	 * @author : 황준
	 * @description : 검색조건에 따른 블로그 작성된 리스트의 주소에 따른 네이버 지역api 이용 
	 */
	@Override
	public void blogListSearch(ModelAndView mav) {
		logger.info("BoardReadService blogListSearch------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		String sido=request.getParameter("search_sido");
		String sigugun=request.getParameter("search_sigugun");
		String dongmyunri=request.getParameter("search_dongmyunri");
		String headCategor=request.getParameter("search_headCategory");
		String detailCategory=request.getParameter("search_detailCategory");
		String search_value=request.getParameter("search_search_value");
		
		/*System.out.println("sido:"+sido);
		System.out.println("sigugun:"+sigugun);
		System.out.println("dongmyunri:"+dongmyunri);
		System.out.println("headCategor:"+headCategor);
		System.out.println("detailCategory:"+detailCategory);
		System.out.println("search_value:"+search_value);*/
	
		Board_addr_infoDto board_addr_infoDto=new Board_addr_infoDto();
		board_addr_infoDto.setAddr_sido(sido);
		board_addr_infoDto.setAddr_sigugun(sigugun);
		board_addr_infoDto.setAddr_dongri(dongmyunri);
		
		CategoryDto categoryDto=new CategoryDto();
		categoryDto.setCategory_mname(headCategor);
		categoryDto.setCategory_sname(detailCategory);
		
		
		List<BoardDto> boardList=null;
		List<Board_addr_infoDto> boar_addr_infoList=null;
		HashMap<String , Object> hashMap=new HashMap<String, Object>();
		hashMap.put("board_addr_info", board_addr_infoDto);
		hashMap.put("category", categoryDto);
		hashMap.put("search_value", search_value);
		hashMap.put("boardList", boardList);
		hashMap.put("boar_addr_infoList", boar_addr_infoList);
		List<HashMap<String, Object>> boardLists=new ArrayList<HashMap<String, Object>>();
		
		boardLists=boardReadDao.getboardList(hashMap);
		
		
		
		if(boardList!=null){
			System.out.println("블로그조회 갯수:"+boardList.size());;
			/*hashMap.put("boardList", boardList);
			List<Board_addr_infoDto> board_Addr_infoDto=null;
			board_Addr_infoDto=boardReadDao.blogSearchAddr(hashMap);
			System.out.println("블로그조회에 검색값에 따른 주소 갯수:"+board_Addr_infoDto.size());
			*/
			Gson gson=new Gson();
			String boardList_json=gson.toJson(boardList);
			try {
				response.getWriter().println(boardList_json);
				System.out.println("여기"+boardList_json);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			/*for (int i = 0; i < board_Addr_infoDto.size(); i++) {
				query=board_Addr_infoDto.get(i).getAddr_sido()+" "
			+board_Addr_infoDto.get(i).getAddr_sigugun()+" "
			+board_Addr_infoDto.get(i).getAddr_dongri()+" "
			+board_Addr_infoDto.get(i).getAddr_bunji();
				
			
			}*/
		}
	  }

	@Override
	public void blogListResult(ModelAndView mav) {
		logger.info("BoardReadService blogListResult------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String sido=request.getParameter("sido");
		String sigugun=request.getParameter("sigugun");
		String dongri=request.getParameter("dongri");
		String bunji=request.getParameter("bunji");
		String searchValue=request.getParameter("searchValue");
		
		HashMap<String,Object> hashMap=new HashMap<String, Object>();
		hashMap.put("sido", sido);
		hashMap.put("sigugun", sigugun);
		hashMap.put("dongri", dongri);
		hashMap.put("bunji", bunji);
		hashMap.put("searchValue", searchValue);
		List<BoardDto> boardList=null;
		boardList=boardReadDao.blogListResult(hashMap);
		List<Attach_fileDto> attachList=null;
		if(boardList!=null){
			logger.info("boardList_size:"+boardList.size());
		/*	attachList = boardReadDao.blogImage(boardList);
			logger.info("boardList_size:"+boardList.size());*/
		}
		Gson gson=new Gson();
		String result=gson.toJson(boardList);
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().println(result);
			System.out.println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void blogReadDetail(ModelAndView mav) {
		logger.info("BoardReadService blogReadDetail------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int boardNo=Integer.parseInt(request.getParameter("board_no"));
		
		
		List<BoardDto> boardDtoList=null;
		List<ReplyDto> replyDtoList=null;
		List<Board_addr_infoDto> board_addr_infoDtoList=null;
		List<Attach_fileDto> attach_fileDtoList=null;
		List<CategoryDto> category=null;
		
		HashMap<String,Object> hMap=new HashMap<String,Object>();
		hMap.put("boardDtoList", boardDtoList);
		hMap.put("board_addr_infoDtoList", board_addr_infoDtoList);
		hMap.put("category", category);
		
		List<HashMap<String,Object>> boardReadList=new ArrayList<HashMap<String,Object>>();
		boardReadList.add(hMap);
	
		hMap.put("boardDtoList", boardDtoList);
		hMap.put("board_addr_infoDtoList", board_addr_infoDtoList);
		
		
		boardReadList=boardReadDao.getReadList1(boardNo);
		
		logger.info("boardReadList"+boardReadList);
		/*hMap.put("category", category);*/
		
		/*boardReadList=board*/
		
		Gson gson=new Gson();
		String boardReadList_json=gson.toJson(boardReadList);
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(boardReadList_json);
			System.out.println(boardReadList_json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void blogReadDetailImg(ModelAndView mav) {
		logger.info("BoardReadService blogReadDetailImg------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int boardNo=Integer.parseInt(request.getParameter("board_no"));
		List<Attach_fileDto> imgList=null;
		imgList=boardReadDao.getblogImg(boardNo);
		logger.info("imgList:"+imgList);
		Gson gson=new Gson();
		String imgList_json=gson.toJson(imgList);
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(imgList_json);
			System.out.println(imgList_json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

	@Override
	public void blogListSearchSub1(ModelAndView mav) {
		logger.info("BoardReadService blogListSearchSub1------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int board_no=Integer.parseInt(request.getParameter("board_no"));
		
		List<Board_addr_infoDto> board_Addr_infoDto=null;
		board_Addr_infoDto=boardReadDao.blogSearchAddr(board_no);
		if(board_Addr_infoDto!=null){
		System.out.println("블로그조회에 검색값에 따른 주소 갯수:"+board_Addr_infoDto.size());
		Gson gson=new Gson();
		String board_Addr_infoDto_json=gson.toJson(board_Addr_infoDto);
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(board_Addr_infoDto_json);
			System.out.println(board_Addr_infoDto_json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		}
			
	}

	@Override
	public void blogListSearchSub2(ModelAndView mav) {
		logger.info("BoardReadService blogListSearchSub2------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		String category_code=request.getParameter("category_code");
		String key = request.getParameter("key");
		String encoding = request.getParameter("encoding");
		String output = request.getParameter("output");
		String coord = request.getParameter("coord");
		String urls = request.getParameter("urls");
		String query=request.getParameter("query");
		
		System.out.println("ajax에 보낼 query:"+query);
		try {
				urls += "?key=" + key;
				urls += "&encoding=" + encoding;
				urls += "&coord=" + coord;
				urls += "&output=" + output;
				urls += "&query=" + URLEncoder.encode(query, "UTF-8");
				System.out.println("blogList_url:" + urls);
				
				try {
					URL urlss=new URL(urls);
					// 한글 처리를 위해 InputStreamReader를 UTF-8 인코딩으로 감싼다.
					InputStreamReader isr = new InputStreamReader(urlss.openConnection().getInputStream(), "UTF-8");
					 JSONObject object = (JSONObject)JSONValue.parseWithException(isr);
					 JSONObject result = (JSONObject)(object.get("result"));
					 response.setContentType("application/json;charset=utf-8");	
					 response.getWriter().print(result);
					 System.out.println(result);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
					
					
					
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
	}

	@Override
	public void blogReadReference(ModelAndView mav) {
		logger.info("BoardReadService blogReadReference------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int board_no=Integer.parseInt(request.getParameter("board_no"));
		String member_id = request.getParameter("member_id");
		
		
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("board_no", board_no);
		hMap.put("member_id", member_id);
		
		int check=boardReadDao.blogReadReference(hMap);
		System.out.println(check);
		if(check > 0){
			logger.info("blogReadReference_check:"+check);
			 try {
				response.getWriter().print(check);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	@Override
	public void blogReadNoReference(ModelAndView mav) {
		logger.info("BoardReadService blogReadReference------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int board_no=Integer.parseInt(request.getParameter("board_no"));
		String member_id = request.getParameter("member_id");
		
		
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("board_no", board_no);
		hMap.put("member_id", member_id);
		
		int check=boardReadDao.blogReadNoReference(hMap);
		System.out.println(check);
		if(check > 0){
			logger.info("blogReadNoReference_check:"+check);
			 try {
				response.getWriter().print(check);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	@Override
	public void referenceRefresh(ModelAndView mav) {
		logger.info("BoardReadService blogReadReference------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int board_no=Integer.parseInt(request.getParameter("board_no"));
		List<RecommandDto> recommandDto=null;
	    recommandDto=boardReadDao.referenceRefresh(board_no);
	    logger.info("referenceRefresh:"+recommandDto);
	    Gson gson=new Gson();
		String recommandDto_json=gson.toJson(recommandDto);
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(recommandDto_json);
			System.out.println(recommandDto_json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

	@Override
	public void bookMark(ModelAndView mav) {
		logger.info("BoardReadService bookMark------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int board_no=Integer.parseInt(request.getParameter("board_no"));
		String member_id=request.getParameter("member_id");
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("board_no", board_no);
		hMap.put("member_id", member_id);
		int check=boardReadDao.bookMark(hMap);
		if(check>0){
			logger.info("bookMark_check:"+check);
			 try {
					response.getWriter().print(check);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
		
	}

	@Override
	public void NobookMark(ModelAndView mav) {
		logger.info("BoardReadService NobookMark------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int board_no=Integer.parseInt(request.getParameter("board_no"));
		String member_id=request.getParameter("member_id");
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("board_no", board_no);
		hMap.put("member_id", member_id);
		int check=boardReadDao.NobookMark(hMap);
		if(check>0){
			logger.info("NobookMark_check:"+check);
			 try {
					response.getWriter().print(check);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
		
	}

	@Override
	public void blogDelete(ModelAndView mav) {
		logger.info("BoardReadService blogDelete------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int board_no=Integer.parseInt(request.getParameter("board_no"));
		String member_id=request.getParameter("member_id");
		
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("board_no", board_no);
		hMap.put("member_id", member_id);
		int check=boardReadDao.blogDelete(hMap);
		if(check>0){
			logger.info("blogDelete_check:"+check);
			 try {
					response.getWriter().print(check);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
	}

	@Override
	public void blogUpdate(ModelAndView mav) {
		logger.info("BoardReadService blogUpdate------------------------");
		Map<String, Object> map=mav.getModel();
		HttpServletRequest request=(HttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		int board_no=Integer.parseInt(request.getParameter("board_no"));
		
		HashMap<String, Object> hMap=new HashMap<String, Object>();
		hMap.put("board_no", board_no);
		
		

		List<BoardDto> boardDtoList=null;
		List<Board_addr_infoDto> boardAddrInfoDtoList=null;
		List<CategoryDto> categoryDtoList=null;
		List<Attach_fileDto> attachFileDto=null;
		hMap.put("boardDtoList", boardDtoList);
		hMap.put("boardAddrInfoDtoList", boardAddrInfoDtoList);
		hMap.put("categoryDtoList", categoryDtoList);
		hMap.put("attachFileDto", attachFileDto);
		
		List<HashMap<String,Object>> boardReadList=new ArrayList<HashMap<String,Object>>();
		
		
		boardReadList=boardReadDao.blogUpdate(hMap);
		
		 Gson gson=new Gson();
			String boardReadList_json=gson.toJson(boardReadList);
			
			try {
				response.setCharacterEncoding("utf-8");
				response.getWriter().print(boardReadList_json);
				System.out.println(boardReadList_json);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}

	@Override
	public void blogUpdateOk(ModelAndView mav) {
		logger.info("BoardReadService blogUpdate------------------------");
		Map<String, Object> map=mav.getModel();
		MultipartHttpServletRequest request=(MultipartHttpServletRequest) map.get("request");
		HttpServletResponse response=(HttpServletResponse) map.get("response");
		
		Attach_fileDto attach_fileDto=(Attach_fileDto) map.get("Attach_fileDto");
		BoardDto boardDto=(BoardDto) map.get("BoardDto");
		Board_addr_infoDto board_addr_infoDto=(Board_addr_infoDto) map.get("Board_addr_infoDto");
		BoardReadDto boardreadDto=(BoardReadDto) map.get("BoardReadDto");
		
		//회원 ID만(작성자) 받아옴
		String member_id=request.getParameter("member_id");
				
		HashMap<String, Object> hashMap=new HashMap<String, Object>();
		hashMap.put("boardDto", boardDto);
		hashMap.put("board_addr_infoDto", board_addr_infoDto);
		hashMap.put("boardreadDto", boardreadDto);
		hashMap.put("member_id", member_id);
	
		System.out.println(boardDto.getBoard_title());
		System.out.println(boardDto.getBoard_grade());
		System.out.println(boardreadDto.getCategory_mname());
		System.out.println(boardreadDto.getCategory_sname());
		
		//게시판 글작성
		int check=boardReadDao.blogUpdateOk(hashMap);
		
		System.out.println("check1: " + check);
		
		//이미지
		List<MultipartFile> upFile=request.getFiles("file");
		//이미지 코멘트
		String[] comment=request.getParameterValues("comment");
		String file_no=request.getParameter("file_nos");
		String[] fileNo=file_no.split(",");
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
					
					String dir = "C:/workspace/blogMap/src/main/webapp/pds/board";
					
					file=new File(dir,originalNames[j]);
					if (!file.isDirectory()) {			//파일이 존재하지 않을 때 
						file.mkdirs();
					}
					upFile.get(j).transferTo(file); //입출력
					if(fileNo[j].equals("")||fileNo[j]==null){
						
					}else{
					attach_fileDto.setFile_no(Integer.parseInt(fileNo[j]));
					attach_fileDto.setFile_name(originalNames[j]);
					attach_fileDto.setFile_size(fileSize[j]);
					attach_fileDto.setFile_path(file.getAbsolutePath());
					attach_fileDto.setFile_comment(comment[j]);
					
//					System.out.println("파일이름:"+originalNames[j]);
//					System.out.println("파일사이즈:"+fileSize[j]);
//					System.out.println("파일경로:"+file.getAbsolutePath());
//					System.out.println("코맨트:"+comment[j]);
					}
					if(check>0){
						//첨푸파일 DB적용
						attachList.add(j,attach_fileDto);
						
						
//						System.out.println("!"+attachList.size());
//						System.out.println(j+"!"+attachList.get(j).getFile_name());
					}
					
				}catch(Exception e){
					logger.info("파일 입출력 에러" + e);
					
				}
				
			}

		}
		hashMap.put("attachList", attachList);
	/*	attachList=(ArrayList<Attach_fileDto>) hashMap.get("attachList");
		for (int i = 0; i < attachList.size(); i++) {
			System.out.println("j"+attachList.get(i).getFile_name());
		}*/
		check=boardReadDao.blogUpdateOk_attach(hashMap);
	}
	
}
