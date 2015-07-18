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
		
		if(sessionStorage.getItem('jointype')!=null){
			$("#myPage_update_btn").css("display","none");
			$("#myPage_delete_btn").css("display","none");
			$("#myPage_fb_delete_btn").show();
		}
		//페북으로 등록한 인원이 회원탈퇴버튼누를때
		$("#myPage_fb_delete_btn").click(function(){
			$.ajax({
				type:'post',
				url:'${root}/member/email_confirm.do',
				data:{
					member_id:sessionStorage.getItem("email")
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					//alert(responseData);
					//alert("aaaa");
					email_confirm_check(responseData);
				}
			});
		});
		
		$("#blogmap_main_myPage").click(function(){
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
					
					$("#myPage_member_point_total").click(function(){
						$(".abc").attr("class","abc");
						$("#bbb").attr("class","active");
						
					});
					
					if(data[1]>20){
						$("#myPage_member_rate").text("새싹");
					}
					
					$("#myPage_member_board_total").text(data[2]+" EA");
					//$("#myPage_member_boardCount").attr("disabled","disabled");
					$("#myPage_member_board_total").click(function(){
						$(".abc").attr("class","abc");
						$("#ccc").attr("class","active");
						
					});
					
					$("#myPage_member_favorite_total").text(data[3]+ " EA");
					//$("#myPage_member_favoriteCount").attr("disabled","disabled");
					$("#myPage_member_favorite_total").click(function(){
						$(".abc").attr("class","abc");
						$("#ddd").attr("class","active");
						
					});
					
					$("#myPage_member_coupon_total").text(data[4]+ " EA");
					//$("#myPage_member_couponCount").attr("disabled","disabled");
					$("#myPage_member_coupon_total").click(function(){
						$(".abc").attr("class","abc");
						$("#eee").attr("class","active");
						
					});
				}
			});
			
			myPagePointInfo();
			myPageBoardInfo();
			myPageFavoriteInfo();
			myPageCouponInfo();
		});
		
		var p_startPage=0; 
		var p_endPage=0;
		var pageBlock=2;
		
		var b_startPage=0;
		var b_endPage=0;
		
		var c_startPage=0;
		var c_endPage=0;
		
		var f_startPage=0;
		var f_endPage=0;
		
		
// 		$("#member_info_tabBtn").click(function(){
// 			$.ajax({
// 				type:'POST',
// 				url:"${root}/member/myPage.do",
// 				data:{
// 					member_id:sessionStorage.getItem("email")
// 					//member_id:"kimjh112339@naver.com"
// 				},
// 				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
// 				success:function(responseData){
// 					//alert(responseData);
// 				 	var data=responseData.split("|");
					
// 				 	memberData=JSON.parse(data[0])
					
// 					$("#myPage_member_id").text(memberData.member_id);
// 					//$("#myPage_member_id").attr("disabled","disabled");
					
// 					$("#myPage_member_name").text(memberData.member_name);
// 					//$("#myPage_member_name").attr("disabled","disabled");
					
// 					$("#myPage_member_joindate").text(memberData.member_joindate);
// 					//$("#myPage_member_joindate").attr("disabled","disabled");
					
// 					$("#myPage_member_point_total").text(data[1]+"points");
// 					/* $("#myPage_member_point").val(data[1]);
// 					$("#myPage_member_point").attr("disabled","disabled"); */
					
// 					if(data[1]>20){
// 						$("#myPage_member_rate").text("새싹(my point:"+data[1]+")");
// 					}
// 					$("#myPage_member_boardCount").val(data[2]+" EA");
// 					$("#myPage_member_boardCount").attr("disabled","disabled");
					
// 					$("#myPage_member_favoriteCount").val(data[3]+ " EA");
// 					$("#myPage_member_favoriteCount").attr("disabled","disabled");
					
// 					$("#myPage_member_couponCount").val(data[4] + " EA");
// 					$("#myPage_member_couponCount").attr("disabled","disabled");
// 				}
// 			});
// 		});
		
		
		/* $("#myPage_update_btn").click(function(){
			//layer_open('myPageUpdate_layer')
			$("div[id='blogmap_myPageUpdate'].modal").modal();
			
		});
		
		$("#myPage_delete_btn").click(function(){
			//layer_open('myPageDelete_layer')
			$("div[id='blogmap_myPageDelete'].modal").modal();
		}); */
		
		//포인트정보클릭시
		//$("#myPage_point_info_tabBtn").click(function(){
			
		//});
		
		function myPagePointInfo(){
			$("#myPage_member_point_list_title").empty();
			$("#myPage_member_point_list_content").empty();
			$("#myPage_member_point_list_pageNum").empty();
			
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
					
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					//alert(pageCount);
					p_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					p_endPage=p_startPage+pageBlock-1;
					
					
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
					
					if(p_endPage>pageCount){
						p_endPage=pageCount;
					}
					//
					//페이징
					//$("#myPage_member_point_list_pageNum").empty();
					/* $("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
					
					//이전
					//alert("startPage"+startPage);
					//alert("pageCount"+pageCount);
					if(p_startPage>pageBlock){
						$("#myPage_member_point_list_before").css("display","inline-block");
						
					}
					
					if(p_startPage<=pageBlock){
						$("#myPage_member_point_list_before").css("display","none");
					}
					
					
					for(var i=p_startPage;i<=p_endPage;i++){
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
					//alert(p_endPage+","+pageCount);
					if(p_endPage<pageCount){
						//alert("aaaaa");
						$("#myPage_member_point_list_after").css("display","inline-block");
						
						
					}
					
					if(p_endPage>=pageCount){
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
		};
		
		//다음클릭시
		$("#point_paging_after").click(function(){
			//alert("Aa");
			$.ajax({
				type:'POST',
				url:'${root}/member/point_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					//member_id:"kimjh112339@naver.com",
					pageNumber:p_startPage+pageBlock
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
					//var pageBlock=1;
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					//alert(pageCount);
					p_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					p_endPage=p_startPage+pageBlock-1;
					
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
					
					if(p_endPage>pageCount){
						p_endPage=pageCount;
					}
					//alert("다음startPage:"+p_startPage);
					//alert("다음endPage:"+p_endPage);
					//alert("다음pageBlock"+pageBlock)
					
					//이전
					if(p_startPage>pageBlock){
						//alert("block");
						$("#myPage_member_point_list_before").css("display","inline-block");
						$("#myPage_member_point_list_pageNum").css("display","none");
						$("#myPage_member_point_list_pageNum").css("display","inline-block");
					}
					
					if(p_startPage<=pageBlock){
						//alert("hidden");
						$("#myPage_member_point_list_before").css("display","none");
					}
					
					$("#myPage_member_point_list_pageNum").empty();
					for(var i=p_startPage;i<=p_endPage;i++){
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
					//alert("다음endPage:"+p_endPage);
					//alert("다음pageCount"+pageCount);
					//alert("다음마지막startPage:"+p_startPage);
					//다음
					if(p_endPage<pageCount){
						//alert("다음block");
						$("#myPage_member_point_list_after").css("display","inline-block");
					}
					
					if(p_endPage>=pageCount){
						//alert("다음hidden");
						$("#myPage_member_point_list_after").css("display","none");
						alert("bbbbbb");
					}
					
				}
			});
		});
		
		
		//이전클릭시
		$("#point_paging_before").click(function(){
			//alert("이전startPage:"+p_startPage);
			//alert("이전pageBlock:"+pageBlock);
			$.ajax({
				type:'POST',
				url:'${root}/member/point_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					//member_id:"kimjh112339@naver.com",
					pageNumber:p_startPage-pageBlock
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
					//var pageBlock=1;
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					//alert(pageCount);
					p_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					p_endPage=p_startPage+pageBlock-1;
					
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
					
					//alert("startPage:"+p_startPage);
					//alert("pageBlock:"+pageBlock);
					//이전
					if(p_startPage>pageBlock){
						$("#myPage_member_point_list_before").css("display","inline-block");
						
					}
					
					if(p_startPage<=pageBlock){
						$("#myPage_member_point_list_before").css("display","none");
					}
					
					$("#myPage_member_point_list_pageNum").empty();
					for(var i=p_startPage;i<=p_endPage;i++){
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
					if(p_endPage<pageCount){
						$("#myPage_member_point_list_after").css("display","inline-block");
					}
					
					if(p_endPage>=pageCount){
						$("#myPage_member_point_list_after").css("display","none");
					}
				}
			});
		});
		
		
		
		/* $("#board_info_btn").click(function(){
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
		}); */
		
		//쿠폰정보클릭시
		//$("#myPage_coupon_info_tabBtn").click(function(){
		function myPageCouponInfo(){	
			$("#myPage_member_coupon_list_content").empty();
			$("#myPage_member_coupon_list_pageNum").empty();
			$.ajax({
				type:'post',
				url:'${root}/member/coupon_info.do',
				data:{
					member_id:sessionStorage.getItem("email")
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					var couponData=responseData.split("|");
					
					var couponInfo=JSON.parse(couponData[0]);
					var boardSize=couponData[1];
					var count=couponData[2];
					var currentPage=couponData[3];
					
					
					$.each(couponInfo,function(i){
						var getbymd = new Date(couponInfo[i].COUPON_BYMD);	// 등록일 날짜 변환
						var byear = getbymd.getFullYear();
						var bmonth = getbymd.getMonth() + 1;
						var bday = getbymd.getDate();
						var bymd = byear + "년 " + bmonth + "월 "	+ bday + "일";
						//alert(bymd);
						
						var geteymd = new Date(couponInfo[i].COUPON_EYMD);	// 승인일 날짜 변환
						var eyear = geteymd.getFullYear();
						var emonth = geteymd.getMonth() + 1;
						var eday = geteymd.getDate();
						var eymd = eyear + "년 " + emonth + "월 "	+ eday + "일";
						//alert(eymd);
						
						//$("#myPage_member_coupon_list_content").append('<li class="col-sm-3"><div class="fff"><div class="thumbnail"><img src="${root}/css/coupon/images/'+couponInfo[i].COUPON_PIC_NAME+'" alt=""><div class="caption"><h4>'+couponInfo[i].PARTNER_NAME+'</h4><div>할인상품:'+couponInfo[i].COUPON_ITEM+'</div><div>유효기간:'+couponInfo[i].COUPON_EYMD+'</div></div></div></div></li>');
						$("#myPage_member_coupon_list_content").append('<h4 class="text-center"><span class="label label-info">'+couponInfo[i].PARTNER_NAME+'</span></h4><img src="${root}/pds/coupon/'+couponInfo[i].COUPON_PIC_NAME+'" class="img-responsive"><div class="caption"><div class="row"><div class="col-md-6 col-xs-6"><h4>'+couponInfo[i].COUPON_ITEM+'</h4></div><div class="col-md-6 col-xs-6 price"><h4><label>'+couponInfo[i].COUPON_DISCOUNT+'%</label></h4></div></div><p style="font-size:14px;">'+ bymd +' ~ '+ eymd +'</p><p style="font-size:14px;">'+couponInfo[i].PARTNER_PHONE+'</p></div>');
					});
					
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					//alert(pageCount);
					c_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					c_endPage=c_startPage+pageBlock-1;
	
					if(c_endPage>pageCount){
						c_endPage=pageCount;
					}
					
					//이전
					//alert("startPage"+startPage);
					//alert("pageCount"+pageCount);
					if(c_startPage>pageBlock){
						$("#myPage_member_coupon_list_before").css("display","inline-block");
					}
					
					if(c_startPage<=pageBlock){
						$("#myPage_member_coupon_list_before").css("display","none");
					}
					
					
					for(var i=c_startPage;i<=c_endPage;i++){
						$("#myPage_member_coupon_list_pageNum").append("<a href='#' id='coupon_paging_num"+i+"'>"+i+"</a>");
						$("#coupon_paging_num"+i).click(function(){
							//alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/coupon_info.do',
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
									
									$("#myPage_member_coupon_list_content").empty();
									var couponInfo=JSON.parse(data[0]);
									
									$.each(couponInfo,function(i){
										var getbymd = new Date(couponInfo[i].COUPON_BYMD);	// 등록일 날짜 변환
										var byear = getbymd.getFullYear();
										var bmonth = getbymd.getMonth() + 1;
										var bday = getbymd.getDate();
										var bymd = byear + "년 " + bmonth + "월 "	+ bday + "일";
										//alert(bymd);
										
										var geteymd = new Date(couponInfo[i].COUPON_EYMD);	// 승인일 날짜 변환
										var eyear = geteymd.getFullYear();
										var emonth = geteymd.getMonth() + 1;
										var eday = geteymd.getDate();
										var eymd = eyear + "년 " + emonth + "월 "	+ eday + "일";
										//alert(eymd);
										
										//$("#myPage_member_coupon_list_content").append('<li class="col-sm-3"><div class="fff"><div class="thumbnail"><img src="${root}/css/coupon/images/'+couponInfo[i].COUPON_PIC_NAME+'" alt=""><div class="caption"><h4>'+couponInfo[i].PARTNER_NAME+'</h4><div>할인상품:'+couponInfo[i].COUPON_ITEM+'</div><div>유효기간:'+couponInfo[i].COUPON_EYMD+'</div></div></div></div></li>');
										$("#myPage_member_coupon_list_content").append('<h4 class="text-center"><span class="label label-info">'+couponInfo[i].PARTNER_NAME+'</span></h4><img src="${root}/pds/coupon/'+couponInfo[i].COUPON_PIC_NAME+'" class="img-responsive"><div class="caption"><div class="row"><div class="col-md-6 col-xs-6"><h4>'+couponInfo[i].COUPON_ITEM+'</h4></div><div class="col-md-6 col-xs-6 price"><h4><label>'+couponInfo[i].COUPON_DISCOUNT+'%</label></h4></div></div><p style="font-size:14px;">'+ bymd +' ~ '+ eymd +'</p><p style="font-size:14px;">'+couponInfo[i].PARTNER_PHONE+'</p></div>');
									});
								}
							});
						});
					}
					
					
					
					//alert("endPage:"+endPage);
					//alert("pageCount:"+pageCount);
					//다음
					if(c_endPage<pageCount){
						$("#myPage_member_coupon_list_after").css("display","inline-block");
						
						
					}
					
					if(c_endPage>=pageCount){
						$("#myPage_member_coupon_list_after").css("display","none");
					}
				}
			});
		};
		
		//다음클릭시
		$("#coupon_paging_after").click(function(){
			//alert("Aa");
			$.ajax({
				type:'POST',
				url:'${root}/member/coupon_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					//member_id:"kimjh112339@naver.com",
					pageNumber:c_startPage+pageBlock
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
					//var pageBlock=1;
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					//alert(pageCount);
					c_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					c_endPage=c_startPage+pageBlock-1;
					
					$("#myPage_member_coupon_list_content").empty();
					var couponInfo=JSON.parse(data[0]);
					
					$.each(couponInfo,function(i){
						var getbymd = new Date(couponInfo[i].COUPON_BYMD);	// 등록일 날짜 변환
						var byear = getbymd.getFullYear();
						var bmonth = getbymd.getMonth() + 1;
						var bday = getbymd.getDate();
						var bymd = byear + "년 " + bmonth + "월 "	+ bday + "일";
						//alert(bymd);
						
						var geteymd = new Date(couponInfo[i].COUPON_EYMD);	// 승인일 날짜 변환
						var eyear = geteymd.getFullYear();
						var emonth = geteymd.getMonth() + 1;
						var eday = geteymd.getDate();
						var eymd = eyear + "년 " + emonth + "월 "	+ eday + "일";
						//alert(eymd);
						
						//$("#myPage_member_coupon_list_content").append('<li class="col-sm-3"><div class="fff"><div class="thumbnail"><img src="${root}/css/coupon/images/'+couponInfo[i].COUPON_PIC_NAME+'" alt=""><div class="caption"><h4>'+couponInfo[i].PARTNER_NAME+'</h4><div>할인상품:'+couponInfo[i].COUPON_ITEM+'</div><div>유효기간:'+couponInfo[i].COUPON_EYMD+'</div></div></div></div></li>');
						$("#myPage_member_coupon_list_content").append('<h4 class="text-center"><span class="label label-info">'+couponInfo[i].PARTNER_NAME+'</span></h4><img src="${root}/pds/coupon/'+couponInfo[i].COUPON_PIC_NAME+'" class="img-responsive"><div class="caption"><div class="row"><div class="col-md-6 col-xs-6"><h4>'+couponInfo[i].COUPON_ITEM+'</h4></div><div class="col-md-6 col-xs-6 price"><h4><label>'+couponInfo[i].COUPON_DISCOUNT+'%</label></h4></div></div><p style="font-size:14px;">'+ bymd +' ~ '+ eymd +'</p><p style="font-size:14px;">'+couponInfo[i].PARTNER_PHONE+'</p></div>');
					});
					
				/* 	$("#myPage_member_point_list_pageNum").remove();
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
					
					if(c_endPage>pageCount){
						c_endPage=pageCount;
					}
					//alert("다음startPage:"+c_startPage);
					//alert("다음endPage:"+c_endPage);
					//alert("다음pageBlock"+pageBlock)
					//이전
					if(c_startPage>pageBlock){
						//alert("block");
						$("#myPage_member_coupon_list_before").css("display","inline-block");
						$("#myPage_member_coupon_list_pageNum").css("display","none");
						$("#myPage_member_coupon_list_pageNum").css("display","inline-block");
					}
					
					if(c_startPage<=pageBlock){
						//alert("hidden");
						$("#myPage_member_coupon_list_before").css("display","none");
					}
					
					$("#myPage_member_coupon_list_pageNum").empty();
					for(var i=c_startPage;i<=c_endPage;i++){
						$("#myPage_member_coupon_list_pageNum").append("<a href='#' id='coupon_paging_num"+i+"'>"+i+"</a>");
						$("#coupon_paging_num"+i).click(function(){
							alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/coupon_info.do',
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
									
									$("#myPage_member_coupon_list_content").empty();
									var couponInfo=JSON.parse(data[0]);
									
									$.each(couponInfo,function(i){
										var getbymd = new Date(couponInfo[i].COUPON_BYMD);	// 등록일 날짜 변환
										var byear = getbymd.getFullYear();
										var bmonth = getbymd.getMonth() + 1;
										var bday = getbymd.getDate();
										var bymd = byear + "년 " + bmonth + "월 "	+ bday + "일";
										//alert(bymd);
										
										var geteymd = new Date(couponInfo[i].COUPON_EYMD);	// 승인일 날짜 변환
										var eyear = geteymd.getFullYear();
										var emonth = geteymd.getMonth() + 1;
										var eday = geteymd.getDate();
										var eymd = eyear + "년 " + emonth + "월 "	+ eday + "일";
										//alert(eymd);
										
										//$("#myPage_member_coupon_list_content").append('<li class="col-sm-3"><div class="fff"><div class="thumbnail"><img src="${root}/css/coupon/images/'+couponInfo[i].COUPON_PIC_NAME+'" alt=""><div class="caption"><h4>'+couponInfo[i].PARTNER_NAME+'</h4><div>할인상품:'+couponInfo[i].COUPON_ITEM+'</div><div>유효기간:'+couponInfo[i].COUPON_EYMD+'</div></div></div></div></li>');
										$("#myPage_member_coupon_list_content").append('<h4 class="text-center"><span class="label label-info">'+couponInfo[i].PARTNER_NAME+'</span></h4><img src="${root}/pds/coupon/'+couponInfo[i].COUPON_PIC_NAME+'" class="img-responsive"><div class="caption"><div class="row"><div class="col-md-6 col-xs-6"><h4>'+couponInfo[i].COUPON_ITEM+'</h4></div><div class="col-md-6 col-xs-6 price"><h4><label>'+couponInfo[i].COUPON_DISCOUNT+'%</label></h4></div></div><p style="font-size:14px;">'+ bymd +' ~ '+ eymd +'</p><p style="font-size:14px;">'+couponInfo[i].PARTNER_PHONE+'</p></div>');
									});
								}
							});
						});
					}
// 					alert("다음endPage:"+c_endPage);
// 					alert("다음pageCount"+pageCount);
// 					alert("다음마지막startPage:"+c_startPage);
					//다음
					if(c_endPage<pageCount){
						//alert("다음block");
						$("#myPage_member_coupon_list_after").css("display","inline-block");
					}
					
					if(c_endPage>=pageCount){
						//alert("다음hidden");
						$("#myPage_member_coupon_list_after").css("display","none");
						//alert("bbbbbb");
					}
					
				}
			});
		});
		
		
		//이전클릭시
		$("#coupon_paging_before").click(function(){
			//alert("이전startPage:"+c_startPage);
			//alert("이전pageBlock:"+pageBlock);
			$.ajax({
				type:'POST',
				url:'${root}/member/coupon_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					//member_id:"kimjh112339@naver.com",
					pageNumber:c_startPage-pageBlock
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
					//var pageBlock=1;
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					//alert(pageCount);
					c_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					c_endPage=c_startPage+pageBlock-1;
					
					$("#myPage_member_coupon_list_content").empty();
					var couponInfo=JSON.parse(data[0]);
					
					$.each(couponInfo,function(i){
						var getbymd = new Date(couponInfo[i].COUPON_BYMD);	// 등록일 날짜 변환
						var byear = getbymd.getFullYear();
						var bmonth = getbymd.getMonth() + 1;
						var bday = getbymd.getDate();
						var bymd = byear + "년 " + bmonth + "월 "	+ bday + "일";
						//alert(bymd);
						
						var geteymd = new Date(couponInfo[i].COUPON_EYMD);	// 승인일 날짜 변환
						var eyear = geteymd.getFullYear();
						var emonth = geteymd.getMonth() + 1;
						var eday = geteymd.getDate();
						var eymd = eyear + "년 " + emonth + "월 "	+ eday + "일";
						//alert(eymd);
						
						//$("#myPage_member_coupon_list_content").append('<li class="col-sm-3"><div class="fff"><div class="thumbnail"><img src="${root}/css/coupon/images/'+couponInfo[i].COUPON_PIC_NAME+'" alt=""><div class="caption"><h4>'+couponInfo[i].PARTNER_NAME+'</h4><div>할인상품:'+couponInfo[i].COUPON_ITEM+'</div><div>유효기간:'+couponInfo[i].COUPON_EYMD+'</div></div></div></div></li>');
						$("#myPage_member_coupon_list_content").append('<h4 class="text-center"><span class="label label-info">'+couponInfo[i].PARTNER_NAME+'</span></h4><img src="${root}/pds/coupon/'+couponInfo[i].COUPON_PIC_NAME+'" class="img-responsive"><div class="caption"><div class="row"><div class="col-md-6 col-xs-6"><h4>'+couponInfo[i].COUPON_ITEM+'</h4></div><div class="col-md-6 col-xs-6 price"><h4><label>'+couponInfo[i].COUPON_DISCOUNT+'%</label></h4></div></div><p style="font-size:14px;">'+ bymd +' ~ '+ eymd +'</p><p style="font-size:14px;">'+couponInfo[i].PARTNER_PHONE+'</p></div>');
					});
					
				/* 	$("#myPage_member_point_list_pageNum").remove();
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
					
					//alert("startPage:"+c_startPage);
					//alert("pageBlock:"+pageBlock);
					//이전
					if(c_startPage>pageBlock){
						$("#myPage_member_coupon_list_before").css("display","inline-block");
					}
					
					if(c_startPage<=pageBlock){
						$("#myPage_member_coupon_list_before").css("display","none");
					}
					
					$("#myPage_member_coupon_list_pageNum").empty();
					for(var i=c_startPage;i<=c_endPage;i++){
						$("#myPage_member_coupon_list_pageNum").append("<a href='#' id='coupon_paging_num"+i+"'>"+i+"</a>");
						$("#coupon_paging_num"+i).click(function(){
							alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/coupon_info.do',
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
									
									$("#myPage_member_coupon_list_content").empty();
									var couponInfo=JSON.parse(data[0]);
									
									$.each(couponInfo,function(i){
										var getbymd = new Date(couponInfo[i].COUPON_BYMD);	// 등록일 날짜 변환
										var byear = getbymd.getFullYear();
										var bmonth = getbymd.getMonth() + 1;
										var bday = getbymd.getDate();
										var bymd = byear + "년 " + bmonth + "월 "	+ bday + "일";
										//alert(bymd);
										
										var geteymd = new Date(couponInfo[i].COUPON_EYMD);	// 승인일 날짜 변환
										var eyear = geteymd.getFullYear();
										var emonth = geteymd.getMonth() + 1;
										var eday = geteymd.getDate();
										var eymd = eyear + "년 " + emonth + "월 "	+ eday + "일";
										//alert(eymd);
										
										//$("#myPage_member_coupon_list_content").append('<li class="col-sm-3"><div class="fff"><div class="thumbnail"><img src="${root}/css/coupon/images/'+couponInfo[i].COUPON_PIC_NAME+'" alt=""><div class="caption"><h4>'+couponInfo[i].PARTNER_NAME+'</h4><div>할인상품:'+couponInfo[i].COUPON_ITEM+'</div><div>유효기간:'+couponInfo[i].COUPON_EYMD+'</div></div></div></div></li>');
										$("#myPage_member_coupon_list_content").append('<h4 class="text-center"><span class="label label-info">'+couponInfo[i].PARTNER_NAME+'</span></h4><img src="${root}/pds/coupon/'+couponInfo[i].COUPON_PIC_NAME+'" class="img-responsive"><div class="caption"><div class="row"><div class="col-md-6 col-xs-6"><h4>'+couponInfo[i].COUPON_ITEM+'</h4></div><div class="col-md-6 col-xs-6 price"><h4><label>'+couponInfo[i].COUPON_DISCOUNT+'%</label></h4></div></div><p style="font-size:14px;">'+ bymd +' ~ '+ eymd +'</p><p style="font-size:14px;">'+couponInfo[i].PARTNER_PHONE+'</p></div>');
									});
								}
							});
						});
					}
					
					//다음
					if(c_endPage<pageCount){
						$("#myPage_member_coupon_list_after").css("display","inline-block");
					}
					
					if(c_endPage>=pageCount){
						$("#myPage_member_coupon_list_after").css("display","none");
					}
				}
			});
		});
		
		//게시글 정보
		//$("#myPage_board_info_tabBtn").click(function(){
		function myPageBoardInfo(){	
			$("#myPage_member_board_list_title").empty();
			$("#myPage_member_board_list_content").empty();
			$("#myPage_member_board_list_pageNum").empty();
			$.ajax({
				type:'POST',
				url:'${root}/member/board_info.do',
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
					
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					//alert(pageCount);
					b_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					b_endPage=b_startPage+pageBlock-1;
					
					
					//$("#myPage_member_point_list").empty();
					//$("#myPage_member_point_list_title").append("<div><span>번호</span><span>발생일</span><span>내용</span><span>포인트</span></div>");
					//$("#myPage_member_point_list_title").append("<tr><td>번호</td><td>발생일</td><td>내용</td><td>포인트</td></tr>");
					$("#myPage_member_board_list_title").append("<div class='col-md-2'><div class='header'>게시글번호</div></div><div class='col-md-3'><div class='header'>작성일</div></div><div class='col-md-2'><div class='header'>카테고리</div></div><div class='col-md-5'><div class='header'>제목</div></div>");
					var board_data=JSON.parse(data[0]);
					
					
					$.each(board_data,function(i){
						//alert(data[i].BOARD_TITLE);
						//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
						//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
						$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-2"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
						+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+board_data[i].BOARD_RGDATE+'</code></div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="isrequired">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
						+'<div class="col-md-5"><div class="cell"><div class="description">'+board_data[i].BOARD_TITLE+'</div></div></div></div>');
					});
					
					if(b_endPage>pageCount){
						b_endPage=pageCount;
					}
					//
					//페이징
					//$("#myPage_member_point_list_pageNum").empty();
					/* $("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
					
					//이전
					//alert("startPage"+startPage);
					//alert("pageCount"+pageCount);
					if(b_startPage>pageBlock){
						$("#myPage_member_board_list_before").css("display","inline-block");
					}
					
					if(b_startPage<=pageBlock){
						$("#myPage_member_board_list_before").css("display","none");
					}
					
					
					for(var i=b_startPage;i<=b_endPage;i++){
						$("#myPage_member_board_list_pageNum").append("<a href='#' id='board_paging_num"+i+"'>"+i+"</a>");
						$("#board_paging_num"+i).click(function(){
							//alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/board_info.do',
								data:{
									member_id:sessionStorage.getItem("email"),
									pageNumber:$(this).text()
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									//alert(responseData);
									
									var data=responseData.split("|");
									
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
									
									$("#myPage_member_board_list_title").empty();
									$("#myPage_member_board_list_content").empty();
									$("#myPage_member_board_list_title").append("<div class='col-md-2'><div class='header'>게시글번호</div></div><div class='col-md-3'><div class='header'>작성일</div></div><div class='col-md-2'><div class='header'>카테고리</div></div><div class='col-md-5'><div class='header'>제목</div></div>");
									var board_data=JSON.parse(data[0]);
									
									
									$.each(board_data,function(i){
										//alert(data[i].BOARD_TITLE);
										//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
										//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
										$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-2"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
										+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+board_data[i].BOARD_RGDATE+'</code></div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="isrequired">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
										+'<div class="col-md-5"><div class="cell"><div class="description">'+board_data[i].BOARD_TITLE+'</div></div></div></div>');
									});
								}
							});
						});
					}
					
					
					//alert("endPage:"+endPage);
					//alert("pageCount:"+pageCount);
					//다음
					if(b_endPage<pageCount){
						$("#myPage_member_board_list_after").css("display","inline-block");
						
						
					}
					
					if(b_endPage>=pageCount){
						$("#myPage_member_board_list_after").css("display","none");
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
		};
		
		//다음클릭시
		$("#board_paging_after").click(function(){
			//alert("Aa");
			$.ajax({
				type:'POST',
				url:'${root}/member/board_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					//member_id:"kimjh112339@naver.com",
					pageNumber:b_startPage+pageBlock
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
					//var pageBlock=1;
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					//alert(pageCount);
					b_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					b_endPage=b_startPage+pageBlock-1;
					
					$("#myPage_member_board_list_title").empty();
					$("#myPage_member_board_list_content").empty();
					$("#myPage_member_board_list_title").append("<div class='col-md-2'><div class='header'>게시글번호</div></div><div class='col-md-3'><div class='header'>작성일</div></div><div class='col-md-2'><div class='header'>카테고리</div></div><div class='col-md-5'><div class='header'>제목</div></div>");
					var board_data=JSON.parse(data[0]);
					
					
					$.each(board_data,function(i){
						//alert(data[i].BOARD_TITLE);
						//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
						//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
						$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-2"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
						+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+board_data[i].BOARD_RGDATE+'</code></div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="isrequired">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
						+'<div class="col-md-5"><div class="cell"><div class="description">'+board_data[i].BOARD_TITLE+'</div></div></div></div>');
					});
					
				/* 	$("#myPage_member_point_list_pageNum").remove();
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
					
					if(b_endPage>pageCount){
						b_endPage=pageCount;
					}
					
// 					alert("다음startPage:"+b_startPage);
// 					alert("다음endPage:"+b_endPage);
// 					alert("다음pageBlock"+pageBlock)
					//이전
					if(b_startPage>pageBlock){
						alert("block");
						$("#myPage_member_board_list_before").css("display","inline-block");
						$("#myPage_member_board_list_pageNum").css("display","none");
						$("#myPage_member_board_list_pageNum").css("display","inline-block");
					}
					
					if(b_startPage<=pageBlock){
						//alert("hidden");
						$("#myPage_member_board_list_before").css("display","none");
					}
					
					$("#myPage_member_board_list_pageNum").empty();
					for(var i=b_startPage;i<=b_endPage;i++){
						$("#myPage_member_board_list_pageNum").append("<a href='#' id='board_paging_num"+i+"'>"+i+"</a>");
						$("#board_paging_num"+i).click(function(){
							alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/board_info.do',
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
									
									$("#myPage_member_board_list_title").empty();
									$("#myPage_member_board_list_content").empty();
									$("#myPage_member_board_list_title").append("<div class='col-md-2'><div class='header'>게시글번호</div></div><div class='col-md-3'><div class='header'>작성일</div></div><div class='col-md-2'><div class='header'>카테고리</div></div><div class='col-md-5'><div class='header'>제목</div></div>");
									var board_data=JSON.parse(data[0]);
									
									
									$.each(board_data,function(i){
										//alert(data[i].BOARD_TITLE);
										//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
										//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
										$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-2"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
										+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+board_data[i].BOARD_RGDATE+'</code></div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="isrequired">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
										+'<div class="col-md-5"><div class="cell"><div class="description">'+board_data[i].BOARD_TITLE+'</div></div></div></div>');
									});
								}
							});
						});
					}
// 					alert("다음endPage:"+b_endPage);
// 					alert("다음pageCount"+pageCount);
// 					alert("다음마지막startPage:"+b_startPage);
					//다음
					if(b_endPage<pageCount){
						//alert("다음block");
						$("#myPage_member_board_list_after").css("display","inline-block");
					}
					
					if(b_endPage>=pageCount){
						//alert("다음hidden");
						$("#myPage_member_board_list_after").css("display","none");
						//alert("bbbbbb");
					}
					
				}
			});
		});
		
		
		//이전클릭시
		$("#board_paging_before").click(function(){
			//alert("이전startPage:"+b_startPage);
			//alert("이전pageBlock:"+pageBlock);
			$.ajax({
				type:'POST',
				url:'${root}/member/board_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					//member_id:"kimjh112339@naver.com",
					pageNumber:b_startPage-pageBlock
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
					//var pageBlock=1;
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					alert(pageCount);
					b_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					b_endPage=b_startPage+pageBlock-1;
					
					$("#myPage_member_board_list_title").empty();
					$("#myPage_member_board_list_content").empty();
					$("#myPage_member_board_list_title").append("<div class='col-md-2'><div class='header'>게시글번호</div></div><div class='col-md-3'><div class='header'>작성일</div></div><div class='col-md-2'><div class='header'>카테고리</div></div><div class='col-md-5'><div class='header'>제목</div></div>");
					var board_data=JSON.parse(data[0]);
					
					
					$.each(board_data,function(i){
						//alert(data[i].BOARD_TITLE);
						//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
						//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
						$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-2"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
						+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+board_data[i].BOARD_RGDATE+'</code></div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="isrequired">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
						+'<div class="col-md-5"><div class="cell"><div class="description">'+board_data[i].BOARD_TITLE+'</div></div></div></div>');
					});
					
				/* 	$("#myPage_member_point_list_pageNum").remove();
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
					
					alert("startPage:"+b_startPage);
					alert("pageBlock:"+pageBlock);
					//이전
					if(b_startPage>pageBlock){
						$("#myPage_member_board_list_before").css("display","inline-block");
						
					}
					
					if(b_startPage<=pageBlock){
						$("#myPage_member_board_list_before").css("display","none");
					}
					
					$("#myPage_member_board_list_pageNum").empty();
					for(var i=b_startPage;i<=b_endPage;i++){
						$("#myPage_member_board_list_pageNum").append("<a href='#' id='board_paging_num"+i+"'>"+i+"</a>");
						$("#board_paging_num"+i).click(function(){
							alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/board_info.do',
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
									
									
									$("#myPage_member_board_list_title").empty();
									$("#myPage_member_board_list_content").empty();
									$("#myPage_member_board_list_title").append("<div class='col-md-2'><div class='header'>게시글번호</div></div><div class='col-md-3'><div class='header'>작성일</div></div><div class='col-md-2'><div class='header'>카테고리</div></div><div class='col-md-5'><div class='header'>제목</div></div>");
									var board_data=JSON.parse(data[0]);
									
									
									$.each(board_data,function(i){
										//alert(data[i].BOARD_TITLE);
										//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
										//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
										$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-2"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
										+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+board_data[i].BOARD_RGDATE+'</code></div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="isrequired">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
										+'<div class="col-md-5"><div class="cell"><div class="description">'+board_data[i].BOARD_TITLE+'</div></div></div></div>');
									});
								}
							});
						});
					}
					
					
					//다음
					if(b_endPage<pageCount){
						$("#myPage_member_board_list_after").css("display","inline-block");
					}
					
					if(b_endPage>=pageCount){
						$("#myPage_member_board_list_after").css("display","none");
					}
				}
			});
		});
		
		/* $("#favorite_info_btn").click(function(){
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
		}); */
		
		
		//즐겨찾기정보클릭시
		//$("#myPage_favorite_info_tabBtn").click(function(){
		function myPageFavoriteInfo(){	
			$("#myPage_member_favorite_list_title").empty();
			$("#myPage_member_favorite_list_content").empty();
			$("#myPage_member_favorite_list_pageNum").empty();
			$.ajax({
				type:'POST',
				url:'${root}/member/favorite_info.do',
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
					
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					//alert(pageCount);
					f_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					f_endPage=f_startPage+pageBlock-1;
					
					
					//$("#myPage_member_point_list").empty();
					//$("#myPage_member_point_list_title").append("<div><span>번호</span><span>발생일</span><span>내용</span><span>포인트</span></div>");
					//$("#myPage_member_point_list_title").append("<tr><td>번호</td><td>발생일</td><td>내용</td><td>포인트</td></tr>");
					$("#myPage_member_favorite_list_title").append("<div class='col-md-2'><div class='header'>순번</div></div><div class='col-md-3'><div class='header'>등록일</div></div><div class='col-md-2'><div class='header'>게시글번호</div></div><div class='col-md-5'><div class='header'>제목</div></div>");
					var favorite_data=JSON.parse(data[0]);
					$.each(favorite_data,function(i){
						$("#myPage_member_favorite_list_content").append('<div class="row margin-0"><div class="col-md-2"><div class="cell"><div class="propertyname">'+favorite_data[i].FAVORITE_NO+'</div></div></div>'
						+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+favorite_data[i].FAVORITE_RGDATE+'</code></div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="isrequired">'+favorite_data[i].BOARD_NO+'</div></div></div>'
						+'<div class="col-md-5"><div class="cell"><div class="description">'+favorite_data[i].BOARD_TITLE+'</div></div></div></div>');
					});
					//alert(f_endPage+","+pageCount);
					if(f_endPage>pageCount){
						f_endPage=pageCount;
					}
					//
					//페이징
					//$("#myPage_member_point_list_pageNum").empty();
					/* $("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
					
					//이전
					//alert("startPage"+startPage);
					//alert("pageCount"+pageCount);
					if(f_startPage>pageBlock){
						$("#myPage_member_favorite_list_before").css("display","inline-block");
					}
					
					if(f_startPage<=pageBlock){
						$("#myPage_member_favorite_list_before").css("display","none");
					}
					
					
					for(var i=f_startPage;i<=f_endPage;i++){
						$("#myPage_member_favorite_list_pageNum").append("<a href='#' id='favorite_paging_num"+i+"'>"+i+"</a>");
						$("#favorite_paging_num"+i).click(function(){
							//alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/favorite_info.do',
								data:{
									member_id:sessionStorage.getItem("email"),
									pageNumber:$(this).text()
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									//alert(responseData);
									
									var data=responseData.split("|");
									
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
									
									$("#myPage_member_favorite_list_title").empty();
									$("#myPage_member_favorite_list_content").empty();
									$("#myPage_member_favorite_list_title").append("<div class='col-md-2'><div class='header'>순번</div></div><div class='col-md-3'><div class='header'>등록일</div></div><div class='col-md-2'><div class='header'>게시글번호</div></div><div class='col-md-5'><div class='header'>제목</div></div>");
									var favorite_data=JSON.parse(data[0]);
									$.each(favorite_data,function(i){
										$("#myPage_member_favorite_list_content").append('<div class="row margin-0"><div class="col-md-2"><div class="cell"><div class="propertyname">'+favorite_data[i].FAVORITE_NO+'</div></div></div>'
										+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+favorite_data[i].FAVORITE_RGDATE+'</code></div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="isrequired">'+favorite_data[i].BOARD_NO+'</div></div></div>'
										+'<div class="col-md-5"><div class="cell"><div class="description">'+favorite_data[i].BOARD_TITLE+'</div></div></div></div>');
									});
								}
							});
						});
					}
					
					
					//alert("endPage:"+endPage);
					//alert("pageCount:"+pageCount);
					//다음
					if(f_endPage<pageCount){
						$("#myPage_member_favorite_list_after").css("display","inline-block");
						
						
					}
					
					if(f_endPage>=pageCount){
						$("#myPage_member_favorite_list_after").css("display","none");
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
		};
		
		//다음클릭시
		$("#favorite_paging_after").click(function(){
			//alert("Aa");
			$.ajax({
				type:'POST',
				url:'${root}/member/favorite_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					//member_id:"kimjh112339@naver.com",
					pageNumber:f_startPage+pageBlock
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
					//var pageBlock=1;
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					alert(pageCount);
					f_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					f_endPage=f_startPage+pageBlock-1;
					
					$("#myPage_member_favorite_list_title").empty();
					$("#myPage_member_favorite_list_content").empty();
					$("#myPage_member_favorite_list_title").append("<div class='col-md-2'><div class='header'>순번</div></div><div class='col-md-3'><div class='header'>등록일</div></div><div class='col-md-2'><div class='header'>게시글번호</div></div><div class='col-md-5'><div class='header'>제목</div></div>");
					var favorite_data=JSON.parse(data[0]);
					$.each(favorite_data,function(i){
						$("#myPage_member_favorite_list_content").append('<div class="row margin-0"><div class="col-md-2"><div class="cell"><div class="propertyname">'+favorite_data[i].FAVORITE_NO+'</div></div></div>'
						+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+favorite_data[i].FAVORITE_RGDATE+'</code></div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="isrequired">'+favorite_data[i].BOARD_NO+'</div></div></div>'
						+'<div class="col-md-5"><div class="cell"><div class="description">'+favorite_data[i].BOARD_TITLE+'</div></div></div></div>');
					});
					
				/* 	$("#myPage_member_point_list_pageNum").remove();
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
					
					if(f_endPage>pageCount){
						f_endPage=pageCount;
					}
					
// 					alert("다음startPage:"+f_startPage);
// 					alert("다음endPage:"+f_endPage);
// 					alert("다음pageBlock"+pageBlock)
					//이전
					if(f_startPage>pageBlock){
						//alert("block");
						$("#myPage_member_favorite_list_before").css("display","inline-block");
						$("#myPage_member_favorite_list_pageNum").css("display","none");
						$("#myPage_member_favorite_list_pageNum").css("display","inline-block");
					}
					
					if(f_startPage<=pageBlock){
						//alert("hidden");
						$("#myPage_member_favorite_list_before").css("display","none");
					}
					
					$("#myPage_member_favorite_list_pageNum").empty();
					for(var i=f_startPage;i<=f_endPage;i++){
						$("#myPage_member_favorite_list_pageNum").append("<a href='#' id='favorite_paging_num"+i+"'>"+i+"</a>");
						$("#favorite_paging_num"+i).click(function(){
							alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/favorite_info.do',
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
									
									$("#myPage_member_favorite_list_title").empty();
									$("#myPage_member_favorite_list_content").empty();
									$("#myPage_member_favorite_list_title").append("<div class='col-md-2'><div class='header'>순번</div></div><div class='col-md-3'><div class='header'>등록일</div></div><div class='col-md-2'><div class='header'>게시글번호</div></div><div class='col-md-5'><div class='header'>제목</div></div>");
									var favorite_data=JSON.parse(data[0]);
									$.each(favorite_data,function(i){
										$("#myPage_member_favorite_list_content").append('<div class="row margin-0"><div class="col-md-2"><div class="cell"><div class="propertyname">'+favorite_data[i].FAVORITE_NO+'</div></div></div>'
										+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+favorite_data[i].FAVORITE_RGDATE+'</code></div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="isrequired">'+favorite_data[i].BOARD_NO+'</div></div></div>'
										+'<div class="col-md-5"><div class="cell"><div class="description">'+favorite_data[i].BOARD_TITLE+'</div></div></div></div>');
									});
								}
							});
						});
					}
// 					alert("다음endPage:"+f_endPage);
// 					alert("다음pageCount"+pageCount);
// 					alert("다음마지막startPage:"+f_startPage);
					//다음
					if(f_endPage<pageCount){
						//alert("다음block");
						$("#myPage_member_favorite_list_after").css("display","inline-block");
					}
					
					if(f_endPage>=pageCount){
						//alert("다음hidden");
						$("#myPage_member_favorite_list_after").css("display","none");
						//alert("bbbbbb");
					}
					
				}
			});
		});
		
		
		//이전클릭시
		$("#favorite_paging_before").click(function(){
// 			alert("이전startPage:"+f_startPage);
// 			alert("이전pageBlock:"+pageBlock);
			$.ajax({
				type:'POST',
				url:'${root}/member/favorite_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					//member_id:"kimjh112339@naver.com",
					pageNumber:f_startPage-pageBlock
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
					//var pageBlock=1;
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					//alert(pageCount);
					f_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					f_endPage=f_startPage+pageBlock-1;
					
					$("#myPage_member_favorite_list_title").empty();
					$("#myPage_member_favorite_list_content").empty();
					$("#myPage_member_favorite_list_title").append("<div class='col-md-2'><div class='header'>순번</div></div><div class='col-md-3'><div class='header'>등록일</div></div><div class='col-md-2'><div class='header'>게시글번호</div></div><div class='col-md-5'><div class='header'>제목</div></div>");
					var favorite_data=JSON.parse(data[0]);
					$.each(favorite_data,function(i){
						$("#myPage_member_favorite_list_content").append('<div class="row margin-0"><div class="col-md-2"><div class="cell"><div class="propertyname">'+favorite_data[i].FAVORITE_NO+'</div></div></div>'
						+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+favorite_data[i].FAVORITE_RGDATE+'</code></div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="isrequired">'+favorite_data[i].BOARD_NO+'</div></div></div>'
						+'<div class="col-md-5"><div class="cell"><div class="description">'+favorite_data[i].BOARD_TITLE+'</div></div></div></div>');
					});
					
				/* 	$("#myPage_member_point_list_pageNum").remove();
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
					
					//alert("startPage:"+f_startPage);
					//alert("pageBlock:"+pageBlock);
					//이전
					if(f_startPage>pageBlock){
						$("#myPage_member_favorite_list_before").css("display","inline-block");
					}
					
					if(f_startPage<=pageBlock){
						$("#myPage_member_favorite_list_before").css("display","none");
					}
					
					$("#myPage_member_favorite_list_pageNum").empty();
					for(var i=f_startPage;i<=f_endPage;i++){
						$("#myPage_member_favorite_list_pageNum").append("<a href='#' id='favorite_paging_num"+i+"'>"+i+"</a>");
						$("#favorite_paging_num"+i).click(function(){
							alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/favorite_info.do',
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
									
									
									$("#myPage_member_favorite_list_title").empty();
									$("#myPage_member_favorite_list_content").empty();
									$("#myPage_member_favorite_list_title").append("<div class='col-md-2'><div class='header'>순번</div></div><div class='col-md-3'><div class='header'>등록일</div></div><div class='col-md-2'><div class='header'>게시글번호</div></div><div class='col-md-5'><div class='header'>제목</div></div>");
									var favorite_data=JSON.parse(data[0]);
									$.each(favorite_data,function(i){
										$("#myPage_member_favorite_list_content").append('<div class="row margin-0"><div class="col-md-2"><div class="cell"><div class="propertyname">'+favorite_data[i].FAVORITE_NO+'</div></div></div>'
										+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+favorite_data[i].FAVORITE_RGDATE+'</code></div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="isrequired">'+favorite_data[i].BOARD_NO+'</div></div></div>'
										+'<div class="col-md-5"><div class="cell"><div class="description">'+favorite_data[i].BOARD_TITLE+'</div></div></div></div>');
									});
									
								}
							});
						});
					}
					
					//다음
					if(f_endPage<pageCount){
						$("#myPage_member_favorite_list_after").css("display","inline-block");
					}
					
					if(f_endPage>=pageCount){
						$("#myPage_member_favorite_list_after").css("display","none");
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
<!-- myPage_boardInfo -->

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
	<!-- <input id="point_info_btn" type="button" value="point_info"/>
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
	</div> -->
	
	
	
<div class="container">
	<div class="col-sm-2">
    <nav class="nav-sidebar">
		<ul class="nav tabs">
		  <li id="aaa" class="abc active"><a id="member_info_tabBtn" href="#tab1" data-toggle="tab">회원정보</a></li>
          <li id="bbb" class="abc"><a id="myPage_point_info_tabBtn" href="#tab2" data-toggle="tab">포인트</a></li>
          <li id="ccc" class="abc"><a id="myPage_board_info_tabBtn" href="#tab3" data-toggle="tab">게시글</a></li>
          <li id="ddd" class="abc"><a id="myPage_favorite_info_tabBtn" href="#tab4" data-toggle="tab">즐겨찾기</a></li>  
          <li id="eee" class="abc"><a id="myPage_coupon_info_tabBtn" href="#tab5" data-toggle="tab">쿠폰</a></li>                              
		</ul>
	</nav>
		<!-- <div><h2 class="add">Place for your add!</h2></div> -->
	</div>
<!-- tab content -->
	<div class="tab-content">
		<div class="tab-pane active text-style" id="tab1">
 			 <div class=" col-md-7 col-lg-7 "> 
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
                     
                      <tr>
                        <td>포인트:</td>
                        <td><a href="#tab2" data-toggle="tab" id="myPage_member_point_total"></a></td>
                      </tr>
                      
                      <tr>
                        <td>게시글:</td>
                        <td><a href="#tab3" data-toggle="tab" id="myPage_member_board_total"></a></td>
                      </tr>
                      
                      <tr>
                        <td>즐겨찾기:</td>
                        <td><a href="#tab4" data-toggle="tab" id="myPage_member_favorite_total"></a></td>
                      </tr>
                      
                      <tr>
                        <td>쿠폰:</td>
                        <td><a href="#tab5" data-toggle="tab" id="myPage_member_coupon_total"></a></td>
                      </tr>
                    </tbody>
                  </table>
                  
                  <a data-toggle="modal" href="#blogmap_myPageUpdate" id="myPage_update_btn" class="btn btn-primary">정보수정</a>
                  <a data-toggle="modal" href="#blogmap_myPageDelete" id="myPage_delete_btn" class="btn btn-primary">회원탈퇴</a>
                  <a data-toggle="modal" href="#blogmap_fb_myPageDelete" id="myPage_fb_delete_btn" class="btn btn-primary" style="display:'none';">회원탈퇴</a>
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
				<h4>나의 포인트 정보</h4>
			
				<div class="method">
			        <div class="row margin-0 list-header hidden-sm hidden-xs" id="myPage_member_point_list_title">
			        </div>
			
					<div id="myPage_member_point_list_content">
			        </div>
			    </div>
    
    		<!-- 	<div id="myPage_member_point_paging">
					<span id='myPage_member_point_list_before' style="display:'none';"><a href="#" id="point_paging_before">이전</a></span>
					<span id='myPage_member_point_list_pageNum'></span>
					<span id='myPage_member_point_list_after' style="display:'none';"><a href="#" id="point_paging_after">다음</a></span>
				</div> -->
					
					<div id="myPage_member_point_paging" class="container">
						<ul class="pagination">
			              <li id="myPage_member_point_list_before" style="display:'none';"><a href="#" id="point_paging_before">«</a></li>
			              <li id="myPage_member_point_list_pageNum"></li>
			              <li id="myPage_member_point_list_after" style="display:'none';"><a href="#" id="point_paging_after">»</a></li>
	           			</ul>
					</div> 
				
            </div>
		</div>
		
		<div class="tab-pane text-style" id="tab3">
  			<div class="col-md-9 col-lg-9" id="myPage_member_board_list">
				<h4>나의 게시글 정보</h4>
			
				<div class="method">
			        <div class="row margin-0 list-header hidden-sm hidden-xs" id="myPage_member_board_list_title">
			        </div>
			
					<div id="myPage_member_board_list_content">
			        </div>
			    </div>
    
    		<!-- 	<div id="myPage_member_point_paging">
					<span id='myPage_member_point_list_before' style="display:'none';"><a href="#" id="point_paging_before">이전</a></span>
					<span id='myPage_member_point_list_pageNum'></span>
					<span id='myPage_member_point_list_after' style="display:'none';"><a href="#" id="point_paging_after">다음</a></span>
				</div> -->
					
					<div id="myPage_member_board_paging" class="container">
						<ul class="pagination">
			              <li id="myPage_member_board_list_before" style="display:'none';"><a href="#" id="board_paging_before">«</a></li>
			              <li id="myPage_member_board_list_pageNum"></li>
			              <li id="myPage_member_board_list_after" style="display:'none';"><a href="#" id="board_paging_after">»</a></li>
	           			</ul>
					</div> 
				
            </div>
		</div>
		
		<div class="tab-pane text-style" id="tab4">
  			<div class="col-md-9 col-lg-9" id="myPage_member_favorite_list">
				<h4>내 즐겨찾기 정보</h4>
			
				<div class="method">
			        <div class="row margin-0 list-header hidden-sm hidden-xs" id="myPage_member_favorite_list_title">
			        </div>
			
					<div id="myPage_member_favorite_list_content">
			        </div>
			    </div>
    
    		<!-- 	<div id="myPage_member_point_paging">
					<span id='myPage_member_point_list_before' style="display:'none';"><a href="#" id="point_paging_before">이전</a></span>
					<span id='myPage_member_point_list_pageNum'></span>
					<span id='myPage_member_point_list_after' style="display:'none';"><a href="#" id="point_paging_after">다음</a></span>
				</div> -->
					
					<div id="myPage_member_favorite_paging" class="container">
						<ul class="pagination">
			              <li id="myPage_member_favorite_list_before" style="display:'none';"><a href="#" id="favorite_paging_before">«</a></li>
			              <li id="myPage_member_favorite_list_pageNum"></li>
			              <li id="myPage_member_favorite_list_after" style="display:'none';"><a href="#" id="favorite_paging_after">»</a></li>
	           			</ul>
					</div> 
				
            </div>
		</div>
		
		
		<!-- 쿠폰정보 -->
		<div class="tab-pane text-style" id="tab5">
			<!-- <div class="col-md-9 col-lg-9">
			<h4>내 쿠폰 정보</h4>
          		 <div class="item active" id="myPage_member_coupon_list">
          		 	<div>
	          		 	<ul class="thumbnails" id="myPage_member_coupon_list_content">
		                	<li class="col-sm-3">
		   						<div class="fff">
									<div class="thumbnail">
										<img src="http://placehold.it/360x240" alt="">
										<div class="caption">
											<h4>Praesent commodo</h4>
											<p>Nullam Condimentum Nibh Etiam Sem</p>
										</div> 	
									</div>
		                         </div>
		                     </li> 
		                 </ul>
	                 </div>   
	                 
	             </div>
             </div> -->
        
             
	        <div class="row">
		    	<div class="col-md-8">
					<div class="col-sm-6 col-md-4">
						<div class="thumbnail" id="myPage_member_coupon_list">
							<div id="myPage_member_coupon_list_content">
								<!-- <h4 class="text-center"><span class="label label-info">업체명</span></h4>
								<img src="http://placehold.it/650x450&text=Galaxy S5" class="img-responsive">
								<div class="caption">
									<div class="row">
										<div class="col-md-6 col-xs-6">
											<h4>할인품목</h4>
										</div>
										
										<div class="col-md-6 col-xs-6 price">
											<h4><label>할인율</label></h4>
										</div>
									</div>
									
									<p style="font-size:14px;">사용기한</p>
								
									<p style="font-size:14px;">업체 전화번호</p>
								</div> -->
							</div>
							
						</div>
					</div>
					
		        </div> 
		        
				
			</div>
	        
	        <div class="row">
	        	<center>
	        	<div id="myPage_member_coupon_paging" class="container">
						<ul class="pagination">
			              <li id="myPage_member_coupon_list_before" style="display:'none';"><a href="#" id="coupon_paging_before">«</a></li>
			              <li id="myPage_member_coupon_list_pageNum"></li>
			              <li id="myPage_member_coupon_list_after" style="display:'none';"><a href="#" id="coupon_paging_after">»</a></li>
	           			</ul>
				</div> 
				</center>
	        </div>     
        </div>	
        
        
	    

	</div>
</div>
	
</body>
</html>