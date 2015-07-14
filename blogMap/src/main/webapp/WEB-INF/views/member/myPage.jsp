<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="root" value="${pageContext.request.contextPath }"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
if(sessionStorage.getItem('email')!=null){
$(function(){
	var startPage=0; 
	var endPage=0;
	var pageBlock=10;
	$.ajax({
		type:'POST',
		url:"${root}/member/myPage.do",
		data:{
			member_id:sessionStorage.getItem("email")
			//member_id:"kimjh112339@naver.com"
		},
		contentType:'application/x-www-form-urlencoded;charset=UTF-8',
		success:function(responseData){
			//alert(responseData);
		 	var data=responseData.split("|");
			
		 	memberData=JSON.parse(data[0])
			
			$("#myPage_member_id").text(memberData.member_id);
			//$("#myPage_member_id").attr("disabled","disabled");
			
			$("#myPage_member_name").text(memberData.member_name);
			//$("#myPage_member_name").attr("disabled","disabled");
			
			$("#myPage_member_joindate").text(memberData.member_joindate);
			//$("#myPage_member_joindate").attr("disabled","disabled");
			
			$("#myPage_member_point_total").text(data[1]+"points");
			/* $("#myPage_member_point").val(data[1]);
			$("#myPage_member_point").attr("disabled","disabled"); */
			
			$("#myPage_member_boardCount").val(data[2]);
			$("#myPage_member_boardCount").attr("disabled","disabled");
			
			$("#myPage_member_favoriteCount").val(data[3]);
			$("#myPage_member_favoriteCount").attr("disabled","disabled");
		}
	});
	
	/* $("#myPage_update_btn").click(function(){
		//layer_open('myPageUpdate_layer')
		$("div[id='blogmap_myPageUpdate'].modal").modal();
		
	});
	
	$("#myPage_delete_btn").click(function(){
		//layer_open('myPageDelete_layer')
		$("div[id='blogmap_myPageDelete'].modal").modal();
	}); */
	
	//$("#point_info_btn").click(function(){
		$.ajax({
			type:'POST',
			url:'${root}/member/point_info.do',
			data:{
				member_id:sessionStorage.getItem("email")
				//member_id:"kimjh112339@naver.com"
				
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				//alert(responseData);
				
				var data=responseData.split("|");
				/* alert(data[0]);
				alert(data[1]);
				alert(data[2]);
				alert(data[3]); */
				
				var boardSize=data[1];
				var count=data[2];
				var currentPage=data[3];
				
				var pageCount=count/boardSize+(count%boardSize==0 ? 0:1);
				//alert(pageCount);
				startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
				endPage=startPage+pageBlock-1;
				
				
				//$("#myPage_member_point_list").empty();
				//$("#myPage_member_point_list_title").append("<div><span>번호</span><span>발생일</span><span>내용</span><span>포인트</span></div>");
				//$("#myPage_member_point_list_title").append("<tr><td>번호</td><td>발생일</td><td>내용</td><td>포인트</td></tr>");
				$("#myPage_member_point_list_title").append("<div class='col-md-1'><div class='header'>번호</div></div><div class='col-md-3'><div class='header'>발생일</div></div><div class='col-md-6'><div class='header'>내용</div></div><div class='col-md-2'><div class='header'>포인트</div></div>");
				var point_data=JSON.parse(data[0]);
				
				
				$.each(point_data,function(i){
					//alert(data[i].BOARD_TITLE);
					//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
					//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
					$("#myPage_member_point_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+point_data[i].POINT_NO+'</div></div></div>'
					+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+point_data[i].POINT_DATE+'</code></div></div></div>'
					+'<div class="col-md-6"><div class="cell"><div class="isrequired">'+point_data[i].BOARD_TITLE+'</div></div></div>'
					+'<div class="col-md-2"><div class="cell"><div class="description">'+point_data[i].POINT_VALUE+'</div></div></div></div>');
				});
				
				if(endPage>pageCount){
					endPage=pageCount;
				}
				
				//페이징
				//$("#myPage_member_point_list_pageNum").empty();
				/* $("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
				
				//이전
				//alert("startPage"+startPage);
				//alert("pageCount"+pageCount);
				if(startPage>pageBlock){
					$("#myPage_member_point_list_before").css("display","inline-block");
				}
				
				if(startPage<=pageBlock){
					$("#myPage_member_point_list_before").css("display","none");
				}
				
				
				for(var i=startPage;i<=endPage;i++){
					$("#myPage_member_point_list_pageNum").append("<a href='#' id='point_paging_num"+i+"'>"+i+"</a>");
					$("#point_paging_num"+i).click(function(){
						//alert($(this).text());
						$.ajax({
							type:'POST',
							url:'${root}/member/point_info.do',
							data:{
								member_id:sessionStorage.getItem("email"),
								//member_id:"kimjh112339@naver.com",
								pageNumber:$(this).text()
							},
							contentType:'application/x-www-form-urlencoded;charset=UTF-8',
							success:function(responseData){
								//alert(responseData);
								
								var data=responseData.split("|");
								/* alert(data[0]);
								alert(data[1]);
								alert(data[2]);
								alert(data[3]); */
								
								var boardSize=data[1];
								var count=data[2];
								var currentPage=data[3];
								
								$("#myPage_member_point_list_title").empty();
								$("#myPage_member_point_list_content").empty();
								//$("#myPage_member_point_list_title").append("<div><span>번호</span><span>발생일</span><span>내용</span><span>포인트</span></div>");
								//$("#myPage_member_point_list_title").append("<tr><td>번호</td><td>발생일</td><td>내용</td><td>포인트</td></tr>");
								$("#myPage_member_point_list_title").append("<div class='col-md-1'><div class='header'>번호</div></div><div class='col-md-3'><div class='header'>발생일</div></div><div class='col-md-6'><div class='header'>내용</div></div><div class='col-md-2'><div class='header'>포인트</div></div>");
								var point_data=JSON.parse(data[0]);
								
								$.each(point_data,function(i){
									//alert(data[i].BOARD_TITLE);
									//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
									//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
									$("#myPage_member_point_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+point_data[i].POINT_NO+'</div></div></div>'
											+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+point_data[i].POINT_DATE+'</code></div></div></div>'
											+'<div class="col-md-6"><div class="cell"><div class="isrequired">'+point_data[i].BOARD_TITLE+'</div></div></div>'
											+'<div class="col-md-2"><div class="cell"><div class="description">'+point_data[i].POINT_VALUE+'</div></div></div></div>');
								});
							}
						});
					});
				}
				
				
				//alert("endPage:"+endPage);
				//alert("pageCount:"+pageCount);
				//다음
				if(endPage<pageCount){
					$("#myPage_member_point_list_after").css("display","inline-block");
					
					
				}
				
				if(endPage>=pageCount){
					$("#myPage_member_point_list_after").css("display","none");
				}
				
				
				/* alert($("#myPage_member_point_list").css("display"));
				if($("#myPage_member_point_list").css("display")=="none"){
					alert("aa");
					$("#myPage_member_point_list").css("display","block");
				}else if($("#myPage_member_point_list").css("display")=="block"){
					alert("bb");
					$("#myPage_member_point_list").css("display","none");
				} 			 */
			}			
		});
	//});
	
	//다음클릭시
	$("#point_paging_after").click(function(){
		alert("Aa");
		$.ajax({
			type:'POST',
			url:'${root}/member/point_info.do',
			data:{
				member_id:sessionStorage.getItem("email"),
				//member_id:"kimjh112339@naver.com",
				pageNumber:startPage+pageBlock
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				//alert(responseData);
				
				var data=responseData.split("|");
				/* alert(data[0]);
				alert(data[1]);
				alert(data[2]);
				alert(data[3]); */
				
				var boardSize=data[1];
				var count=data[2];
				var currentPage=data[3];
				var pageBlock=10;
				var pageCount=count/boardSize+(count%boardSize==0 ? 0:1);
				alert(pageCount);
				startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
				endPage=startPage+pageBlock-1;
				
				//$("#myPage_member_point_list").empty();
				$("#myPage_member_point_list_title").empty();
				$("#myPage_member_point_list_content").empty();
				//$("#myPage_member_point_list_title").append("<div><span>번호</span><span>발생일</span><span>내용</span><span>포인트</span></div>");
				//$("#myPage_member_point_list_title").append("<tr><td>번호</td><td>발생일</td><td>내용</td><td>포인트</td></tr>");
				$("#myPage_member_point_list_title").append("<div class='col-md-1'><div class='header'>번호</div></div><div class='col-md-3'><div class='header'>발생일</div></div><div class='col-md-6'><div class='header'>내용</div></div><div class='col-md-2'><div class='header'>포인트</div></div>");
				var point_data=JSON.parse(data[0]);
				
				$.each(point_data,function(i){
					//alert(data[i].BOARD_TITLE);
					//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
					//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
					$("#myPage_member_point_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+point_data[i].POINT_NO+'</div></div></div>'
							+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+point_data[i].POINT_DATE+'</code></div></div></div>'
							+'<div class="col-md-6"><div class="cell"><div class="isrequired">'+point_data[i].BOARD_TITLE+'</div></div></div>'
							+'<div class="col-md-2"><div class="cell"><div class="description">'+point_data[i].POINT_VALUE+'</div></div></div></div>');
				});
				
			/* 	$("#myPage_member_point_list_pageNum").remove();
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
				
				
				alert("다음startPage:"+startPage);
				alert("다음endPage:"+endPage);
				alert("다음pageBlock"+pageBlock)
				//이전
				if(startPage>pageBlock){
					alert("block");
					$("#myPage_member_point_list_before").css("display","inline-block");
				}
				
				if(startPage<=pageBlock){
					//alert("hidden");
					$("#myPage_member_point_list_before").css("display","none");
				}
				
				$("#myPage_member_point_list_pageNum").empty();
				for(var i=startPage;i<=endPage;i++){
					$("#myPage_member_point_list_pageNum").append("<a href='#' id='point_paging_num"+i+"'>"+i+"</a>");
					$("#point_paging_num"+i).click(function(){
						alert($(this).text());
						$.ajax({
							type:'POST',
							url:'${root}/member/point_info.do',
							data:{
								member_id:sessionStorage.getItem("email"),
								//member_id:"kimjh112339@naver.com",
								pageNumber:$(this).text()
							},
							contentType:'application/x-www-form-urlencoded;charset=UTF-8',
							success:function(responseData){
								//alert(responseData);
								
								var data=responseData.split("|");
								/* alert(data[0]);
								alert(data[1]);
								alert(data[2]);
								alert(data[3]); */
								
								var boardSize=data[1];
								var count=data[2];
								var currentPage=data[3];
								
								$("#myPage_member_point_list_title").empty();
								$("#myPage_member_point_list_content").empty();
								//$("#myPage_member_point_list_title").append("<div><span>번호</span><span>발생일</span><span>내용</span><span>포인트</span></div>");
								//$("#myPage_member_point_list_title").append("<tr><td>번호</td><td>발생일</td><td>내용</td><td>포인트</td></tr>");
								$("#myPage_member_point_list_title").append("<div class='col-md-1'><div class='header'>번호</div></div><div class='col-md-3'><div class='header'>발생일</div></div><div class='col-md-6'><div class='header'>내용</div></div><div class='col-md-2'><div class='header'>포인트</div></div>");
								var point_data=JSON.parse(data[0]);
								$.each(point_data,function(i){
									//alert(data[i].BOARD_TITLE);
									//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
									//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
									$("#myPage_member_point_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+point_data[i].POINT_NO+'</div></div></div>'
											+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+point_data[i].POINT_DATE+'</code></div></div></div>'
											+'<div class="col-md-6"><div class="cell"><div class="isrequired">'+point_data[i].BOARD_TITLE+'</div></div></div>'
											+'<div class="col-md-2"><div class="cell"><div class="description">'+point_data[i].POINT_VALUE+'</div></div></div></div>');
								});
							}
						});
					});
				}
				alert("다음endPage:"+endPage);
				alert("다음pageCount"+pageCount);
				alert("다음마지막startPage:"+startPage);
				//다음
				if(endPage<pageCount){
					alert("다음block");
					$("#myPage_member_point_list_after").css("display","inline-block");
				}
				
				if(endPage>=pageCount){
					alert("다음hidden");
					$("#myPage_member_point_list_after").css("display","none");
					alert("bbbbbb");
				}
				
			}
		});
	});
	
	
	//이전클릭시
	$("#point_paging_before").click(function(){
		alert("이전startPage:"+startPage);
		alert("이전pageBlock:"+pageBlock);
		$.ajax({
			type:'POST',
			url:'${root}/member/point_info.do',
			data:{
				member_id:sessionStorage.getItem("email"),
				//member_id:"kimjh112339@naver.com",
				pageNumber:startPage-pageBlock
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				//alert(responseData);
				
				var data=responseData.split("|");
				/* alert(data[0]);
				alert(data[1]);
				alert(data[2]);
				alert(data[3]); */
				
				var boardSize=data[1];
				var count=data[2];
				var currentPage=data[3];
				var pageBlock=10;
				var pageCount=count/boardSize+(count%boardSize==0 ? 0:1);
				alert(pageCount);
				startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
				endPage=startPage+pageBlock-1;
				
				//$("#myPage_member_point_list").empty();
				$("#myPage_member_point_list_title").empty();
				$("#myPage_member_point_list_content").empty();
				//$("#myPage_member_point_list_title").append("<div><span>번호</span><span>발생일</span><span>내용</span><span>포인트</span></div>");
				//$("#myPage_member_point_list_title").append("<tr><td>번호</td><td>발생일</td><td>내용</td><td>포인트</td></tr>");
				$("#myPage_member_point_list_title").append("<div class='col-md-1'><div class='header'>번호</div></div><div class='col-md-3'><div class='header'>발생일</div></div><div class='col-md-6'><div class='header'>내용</div></div><div class='col-md-2'><div class='header'>포인트</div></div>");
				var point_data=JSON.parse(data[0]);
				
				$.each(point_data,function(i){
					//alert(data[i].BOARD_TITLE);
					//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
					//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
					$("#myPage_member_point_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+point_data[i].POINT_NO+'</div></div></div>'
							+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+point_data[i].POINT_DATE+'</code></div></div></div>'
							+'<div class="col-md-6"><div class="cell"><div class="isrequired">'+point_data[i].BOARD_TITLE+'</div></div></div>'
							+'<div class="col-md-2"><div class="cell"><div class="description">'+point_data[i].POINT_VALUE+'</div></div></div></div>');
				});
				
			/* 	$("#myPage_member_point_list_pageNum").remove();
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
				
				alert("startPage:"+startPage);
				alert("pageBlock:"+pageBlock);
				//이전
				if(startPage>pageBlock){
					$("#myPage_member_point_list_before").css("display","inline-block");
				}
				
				if(startPage<=pageBlock){
					$("#myPage_member_point_list_before").css("display","none");
				}
				
				$("#myPage_member_point_list_pageNum").empty();
				for(var i=startPage;i<=endPage;i++){
					$("#myPage_member_point_list_pageNum").append("<a href='#' id='point_paging_num"+i+"'>"+i+"</a>");
					$("#point_paging_num"+i).click(function(){
						alert($(this).text());
						$.ajax({
							type:'POST',
							url:'${root}/member/point_info.do',
							data:{
								member_id:sessionStorage.getItem("email"),
								//member_id:"kimjh112339@naver.com",
								pageNumber:$(this).text()
							},
							contentType:'application/x-www-form-urlencoded;charset=UTF-8',
							success:function(responseData){
								//alert(responseData);
								
								var data=responseData.split("|");
								/* alert(data[0]);
								alert(data[1]);
								alert(data[2]);
								alert(data[3]); */
								
								var boardSize=data[1];
								var count=data[2];
								var currentPage=data[3];
								
								
								$("#myPage_member_point_list_title").empty();
								$("#myPage_member_point_list_content").empty();
								//$("#myPage_member_point_list_title").append("<div><span>번호</span><span>발생일</span><span>내용</span><span>포인트</span></div>");
								//$("#myPage_member_point_list_title").append("<tr><td>번호</td><td>발생일</td><td>내용</td><td>포인트</td></tr>");
								$("#myPage_member_point_list_title").append("<div class='col-md-1'><div class='header'>번호</div></div><div class='col-md-3'><div class='header'>발생일</div></div><div class='col-md-6'><div class='header'>내용</div></div><div class='col-md-2'><div class='header'>포인트</div></div>");
								var point_data=JSON.parse(data[0]);
								
								$.each(point_data,function(i){
									//alert(data[i].BOARD_TITLE);
									//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
									//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
									$("#myPage_member_point_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+point_data[i].POINT_NO+'</div></div></div>'
											+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+point_data[i].POINT_DATE+'</code></div></div></div>'
											+'<div class="col-md-6"><div class="cell"><div class="isrequired">'+point_data[i].BOARD_TITLE+'</div></div></div>'
											+'<div class="col-md-2"><div class="cell"><div class="description">'+point_data[i].POINT_VALUE+'</div></div></div></div>');
								});
							}
						});
					});
				}
				
				//다음
				if(endPage<pageCount){
					$("#myPage_member_point_list_after").css("display","inline-block");
				}
				
				if(endPage>=pageCount){
					$("#myPage_member_point_list_after").css("display","none");
				}
			}
		});
	});
	
	
	
	$("#board_info_btn").click(function(){
		$.ajax({
			type:'POST',
			url:'${root}/member/board_info.do',
			data:{
				member_id:sessionStorage.getItem("email")
				//member_id:"kimjh112339@naver.com"
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				$("#myPage_member_board_list").empty();
				$("#myPage_member_board_list").append("<div><span>게시글번호</span><span>작성일</span><span>카테고리</span><span>제목</span></div>")
				
				var data=JSON.parse(responseData);
				$.each(data,function(i){
					//alert(data[i].BOARD_TITLE);
					$("#myPage_member_board_list").append("<div><span>"+data[i].BOARD_NO+"</span><span>"+data[i].BOARD_RGDATE+"</span><span>"+data[i].CATEGORY_MNAME+"</span><span>"+data[i].BOARD_TITLE+"</span></div>");
					
				});
				
				
				alert($("#myPage_member_board_list").css("display"));
				if($("#myPage_member_board_list").css("display")=="none"){
					alert("aa");
					$("#myPage_member_board_list").css("display","block");
				}else if($("#myPage_member_board_list").css("display")=="block"){
					alert("bb");
					$("#myPage_member_board_list").css("display","none");
				} 			
			}			
		});
	});
	
	$("#favorite_info_btn").click(function(){
		$.ajax({
			type:'POST',
			url:'${root}/member/favorite_info.do',
			data:{
				member_id:sessionStorage.getItem("email")
				//member_id:"kimjh112339@naver.com"
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				$("#myPage_member_favorite_list").empty();
				$("#myPage_member_favorite_list").append("<div><span>순번</span><span>등록일</span><span>게시글번호</span><span>제목</span></div>")
				var data=JSON.parse(responseData);
				$.each(data,function(i){
					//alert(data[i].BOARD_TITLE);
					$("#myPage_member_favorite_list").append("<div><span>"+data[i].FAVORITE_NO+"</span><span>"+data[i].FAVORITE_RGDATE+"</span><span>"+data[i].BOARD_NO+"</span><span>"+data[i].BOARD_TITLE+"</span></div>");
					
				});
				
				
				alert($("#myPage_member_favorite_list").css("display"));
				if($("#myPage_member_favorite_list").css("display")=="none"){
					//alert("aa");
					$("#myPage_member_favorite_list").css("display","block");
				}else if($("#myPage_member_favorite_list").css("display")=="block"){
					//alert("bb");
					$("#myPage_member_favorite_list").css("display","none");
				} 			
			}			
		});
	});
});
}

/* function layer_open(el){
	var temp = $('#' + el);
	var temp_bg = $('#' + el + '_bg');   //dimmed 레이어를 감지하기 위한 boolean 변수
	var temp_div = $('#' + el + '_div');
	var temp_btn = $('#' + el + '_btn');
	
	// layer fadeIn
	if(temp_bg){
		temp_div.fadeIn();	//'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다. 
	}else{
		temp.fadeIn();
	}
	// layer를 화면의 중앙에 위치시킨다.
	if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
	else temp.css('top', '0px');
	if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
	else temp.css('left', '0px');
	// layer fadeOut : 종료버튼 클릭시
	temp_btn.click(function(e){
		if(temp_bg){
			temp_div.fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다. 
		}else{
			temp.fadeOut();
		}
		e.preventDefault();
	});
	
	// layer fadeOut : 바탕화면 클릭시
	temp_bg.click(function(e){
		temp_div.fadeOut();
		e.preventDefault();
	});
} */


</script>
<link rel="stylesheet" href="${root }/css/layer.css" type="text/css"/>
</head>
<body>
	<!--<div>
		 <span>계정정보<input id="myPage_member_id" type="text"/></span>&nbsp;&nbsp;&nbsp; 
		<span><input id="myPage_update_btn" type="button" value="수정"/></span>&nbsp;&nbsp;
		<span><input id="myPage_delete_btn" type="button" value="탈퇴"/></span>
	</div>
	
	<div>
		이름<input id="myPage_member_name" type="text"/>
	</div>
	
	<div>
		회원등급<input id="myPage_member_rate" type="text"/>
	</div>
	
	<div>
		가입일<input id="myPage_member_joindate" type="text"/>
	</div> -->
	
	<!-- <div>
		<span>포인트<input id="myPage_member_point" type="text"/></span>
		<span><input id="point_info_btn" type="button" value="point_info"/></span>
		<div id="myPage_member_point_list" style="display:none;">
			<div id="myPage_member_point_list_title">
			</div>
			
			<div id="myPage_member_point_list_content">
			</div>
			
			<div id="myPage_member_point_paging">
				<span id='myPage_member_point_list_before' style="display:'none';"><a href="#" id="point_paging_before">이전</a></span>
				<span id='myPage_member_point_list_pageNum'></span>
				<span id='myPage_member_point_list_after' style="display:'none';"><a href="#" id="point_paging_after">다음</a></span>
			</div>
		</div>
	</div> -->
	<input id="point_info_btn" type="button" value="point_info"/>
	<div>
		<span>게시글<input id="myPage_member_boardCount" type="text"/></span>
		<span><input id="board_info_btn" type="button" value="write_info"/></span>
		<div id="myPage_member_board_list" style="display:none;"></div>
	</div>
	
	<div>
		<span>즐겨찾기<input id="myPage_member_favoriteCount" type="text"/></span>
		<span><input id="favorite_info_btn" type="button" value="favorite_info"/></span>
		<div id="myPage_member_favorite_list" style="display:none;"></div>
	</div>
	
	<div>
		<span>쿠폰<input id="myPage_member_couponCount" type="text"/></span>
		<span><input type="button" value="coupon_info"/></span>
	</div>
	
	
	
<div class="container">
	<div class="col-sm-2">
    <nav class="nav-sidebar">
		<ul class="nav tabs">
		  <li class="active"><a href="#tab1" data-toggle="tab">회원정보</a></li>
          <li class=""><a href="#tab2" data-toggle="tab">포인트</a></li>
          <li class=""><a href="#tab3" data-toggle="tab">게시글</a></li>
          <li class=""><a href="#tab4" data-toggle="tab">즐겨찾기</a></li>  
          <li class=""><a href="#tab5" data-toggle="tab">쿠폰</a></li>                              
		</ul>
	</nav>
		<div><h2 class="add">Place for your add!</h2></div>
	</div>
<!-- tab content -->
	<div class="tab-content">
		<div class="tab-pane active text-style" id="tab1">
 			 <div class=" col-md-9 col-lg-9 "> 
                  <table class="table table-user-information">
                    <tbody>
                      <tr>
                        <td>계정정보:</td>
                        <td id="myPage_member_id"></td>
                      </tr>
                      <tr>
                        <td>이름:</td>
                        <td id="myPage_member_name"></td>
                      </tr>
                      <tr>
                        <td>회원등급:</td>
                        <td id="myPage_member_rate"></td>
                      </tr>
                 
                      <tr>
                        <td>가입일:</td>
                        <td id="myPage_member_joindate"></td>
                      </tr>
                     
                    </tbody>
                  </table>
                  
                  <a data-toggle="modal" href="#blogmap_myPageUpdate" id="myPage_update_btn" class="btn btn-primary">정보수정</a>
                  <a data-toggle="modal" href="#blogmap_myPageDelete" id="myPage_delete_btn" class="btn btn-primary">회원탈퇴</a>
                </div>
 			
 			 <!-- <h3>회원정보</h3><br/><br/>
      		 
      		 <h5>계정정보</h5><span></span>
      		 <h5>이름</h5><span></span>
      		 <h5>회원등급</h5><span></span>
      		 <h5>가입일</h5><span></span> 
      	 <hr>   -->
		</div>
		<div class="tab-pane text-style" id="tab2">
			<div class="col-md-9 col-lg-9" id="myPage_member_point_list">
				<h2 id="myPage_member_point_total"></h2>
				
		  		<!-- <table class="table table-user-information">
                    <tbody id="myPage_member_point_list_title">
	                    
                    </tbody>
                </table>
                
                
		  		<table class="table table-user-information">
                    <tbody id="myPage_member_point_list_content">
	                    
                    </tbody>
                </table> -->
                			
	
				<div class="method">
			        <div class="row margin-0 list-header hidden-sm hidden-xs" id="myPage_member_point_list_title">
			        </div>
			
					<div id="myPage_member_point_list_content">
			        </div>
			    </div>
    
    	<!-- 		<div id="myPage_member_point_paging">
					<span id='myPage_member_point_list_before' style="display:'none';"><a href="#" id="point_paging_before">이전</a></span>
					<span id='myPage_member_point_list_pageNum'></span>
					<span id='myPage_member_point_list_after' style="display:'none';"><a href="#" id="point_paging_after">다음</a></span>
				</div> -->
					
					<div id="myPage_member_point_paging" class="container">
						<ul class="pagination">
			              <li id="myPage_member_point_list_before" class="disabled" style="display:'none';"><a href="#" id="point_paging_before">«</a></li>
			              <li id="myPage_member_point_list_pageNum"></li>
			              <li id="myPage_member_point_list_after" style="display:'none';"><a href="#" id="point_paging_after">»</a></li>
	           			</ul>
					</div>
				
            </div>
		</div>
		
		<div class="tab-pane text-style" id="tab3">
  			<h2>Stet clita</h2>
			<p>Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Duis autem vel eum 
			    iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla 
			    facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit 
			    augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet,
			</p>
    		<hr>
    		
	    <div class="col-xs-6 col-md-3">
	      <img src="http://placehold.it/150x150" class="img-rounded pull-right">
	  	</div>
		</div>
	</div>
</div>
	
	<%-- <!-- 수정 -->
	<div class="container-fluid">

		<!-- 블로그 검색 레이어 -->
		<div id="myPageUpdate_layer_div" class="layer">
			<div id="myPageUpdate_layer_bg" class="bg"></div>
			<div id="myPageUpdate_layer" class="pop-layer">
				<div class="pop-container">
					<div class="pop-conts">
						<!--content // -->
						<div class="btn-r">
							<input id="myPageUpdate_layer_btn" type="button" class="cbtn" value="X"/>
						</div>
						
						<!-- 블로그 게시글 메인 -->
						<jsp:include page="myPageUpdate.jsp"/>
						<!--// content -->
					</div>
				</div>
			</div>
		</div>
	</div>	 --%>

	<%-- <!-- 탈퇴 -->
	<div class="container-fluid">

		<!-- 블로그 검색 레이어 -->
		<div id="myPageDelete_layer_div" class="layer">
			<div id="myPageDelete_layer_bg" class="bg"></div>
			<div id="myPageDelete_layer" class="pop-layer">
				<div class="pop-container">
					<div class="pop-conts">
						<!--content // -->
						<div class="btn-r">
							<input id="myPageDelete_layer_btn" type="button" class="cbtn" value="X"/>
						</div>
						
						<!-- 블로그 게시글 메인 -->
						<jsp:include page="myPageDelete.jsp"/>
						<!--// content -->
					</div>
				</div>
			</div>
		</div>
	</div>		 --%>
</body>
</html>