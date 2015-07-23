<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set var="root" value="${pageContext.request.contextPath}" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>Home</title>
<script type="text/javascript">
	$(document).ready(function() {
		var email=sessionStorage.getItem('email');
		/* alert("현재 로그인 중인 아이디 : " + email); */
		
		$("#write_btn").click(function() {
			if(!  $("input[name='messageWrite_receiver']").val()){
				alert("수신자 아이디를 입력하세요.");
				$("#message_receiver").focus();
				return false;
			}
			
			if(!  $("textarea#messageWrite_content").val()){
				alert("내용을 입력하세요.");
				$("#messageWrite_content").focus();
				return false;
			}
			
				$.ajax({
					type : 'post',
					url : '${root}/message/messageWrite.do',
				 	data : {
				 		member_id : email,
						message_receiver : $("input[name='messageWrite_receiver']").val(),
						message_content : $("textarea#messageWrite_content").val()
				 	}, 
					contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
					success : function(responseData) {
					//	alert(responseData);
						if(responseData == 1){
							$("input[name='messageWrite_receiver']").val("");
							$("textarea#messageWrite_content").val("");
							$('#myTab a:first').tab('show');
							
							$("#receiveMsgResult").empty();
							$("#sendMsgResult").empty();

							var pageBlock=2;
							
							var r_startPage=0;
							var r_endPage=0;

							var s_startPage=0;
							var s_endPage=0;
							
							$.ajax({
								type:'GET',
								url:'${root}/message/mainMessage.do',
								data:{
									member_id:sessionStorage.getItem("email")
									
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									//alert(responseData);
									
									var data=responseData.split("|");
									
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
									
									var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
									
									s_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
									s_endPage=s_startPage+pageBlock-1;
									
									var send_data=JSON.parse(data[0]);
									
									
									$.each(send_data,function(i){
										var d = new Date(send_data[i].message_sDate);
						          		var sdate = leadingZeros(d.getFullYear(), 4) + '/' + leadingZeros(d.getMonth() + 1, 2) + '/' + leadingZeros(d.getDate(), 2);				

										$("#sendMsgResult").append("<tr class='hidden-xs " + "s" +send_data[i].message_no+"' style='text-align: center;' data-toggle='modal' href='#messageRead'><td>" + send_data[i].message_no + "</td><td>" + send_data[i].message_content + "</td><td>" + send_data[i].member_id + "</td><td>" + sdate + "</td><td>" + send_data[i].message_yn + "</td></tr>");
										$("#sendMsgResult").append("<tr class='visible-xs " + "s" +send_data[i].message_no+"' style='text-align: center;' data-toggle='modal' href='#messageRead'><td>" + send_data[i].member_id + "</td><td>" + send_data[i].message_content + "</td></tr>");
										
										$(".s" + send_data[i].message_no).click(function() {
											msgSendimportData(send_data[i].message_no);
										});
									});
									
									if(s_endPage>pageCount){
										s_endPage=pageCount;
									}

									if(s_startPage>pageBlock){
										$("#send_list_before").css("display","inline-block");
										
									}
									
									if(s_startPage<=pageBlock){
										$("#send_list_before").css("display","none");
									}
									
									$("#send_list_pageNum").empty();
									for(var i=s_startPage;i<=s_endPage;i++){
										$("#send_list_pageNum").append("<a href='#' id='send_paging_num"+i+"'>"+i+"</a>");
										$("#send_paging_num"+i).click(function(){
											$.ajax({
												type:'GET',
												url:'${root}/message/mainMessage.do',
												data:{
													member_id:sessionStorage.getItem("email"),
													pageNumber:$(this).text()
												},
												contentType:'application/x-www-form-urlencoded;charset=UTF-8',
												success:function(responseData){
													
													var data=responseData.split("|");
													
													var boardSize=data[1];
													var count=data[2];
													var currentPage=data[3];
													
													
													$("#sendMsgResult").empty();
													var send_data=JSON.parse(data[0]);
													
													$.each(send_data,function(i){
														var d = new Date(send_data[i].message_sDate);
										          		var sdate = leadingZeros(d.getFullYear(), 4) + '/' + leadingZeros(d.getMonth() + 1, 2) + '/' + leadingZeros(d.getDate(), 2);				

														$("#sendMsgResult").append("<tr class='hidden-xs " + "s" +send_data[i].message_no+"' style='text-align: center;' data-toggle='modal' href='#messageRead'><td>" + send_data[i].message_no + "</td><td>" + send_data[i].message_content + "</td><td>" + send_data[i].member_id + "</td><td>" + sdate + "</td><td>" + send_data[i].message_yn + "</td></tr>");
														$("#sendMsgResult").append("<tr class='visible-xs " + "s" +send_data[i].message_no+"' style='text-align: center;' data-toggle='modal' href='#messageRead'><td>" + send_data[i].member_id + "</td><td>" + send_data[i].message_content + "</td></tr>");
														
														$(".s" + send_data[i].message_no).click(function() {
															msgSendimportData(send_data[i].message_no);
														});
													});
												}
											});
										});
									}
									if(s_endPage<pageCount){
										//alert("aaaaa");
										$("#send_list_after").css("display","inline-block");
									}
									
									if(s_endPage>=pageCount){
										$("#send_list_after").css("display","none");
									}
								}			
							});
							
							//다음클릭시
							$("#send_paging_after").click(function(){
//					 		alert("Aa");
								$.ajax({
									type:'GET',
									url:'${root}/message/mainMessage.do',
									data:{
										member_id:sessionStorage.getItem("email"),
										pageNumber:s_startPage+pageBlock
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
//					 					alert(pageCount);
										s_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
										s_endPage=s_startPage+pageBlock-1;
										
										$("#sendMsgResult").empty();
										var send_data=JSON.parse(data[0]);
										
										$.each(send_data,function(i){
											var d = new Date(send_data[i].message_sDate);
							          		var sdate = leadingZeros(d.getFullYear(), 4) + '/' + leadingZeros(d.getMonth() + 1, 2) + '/' + leadingZeros(d.getDate(), 2);				

											$("#sendMsgResult").append("<tr class='hidden-xs " + "s" +send_data[i].message_no+"' style='text-align: center;' data-toggle='modal' href='#messageRead'><td>" + send_data[i].message_no + "</td><td>" + send_data[i].message_content + "</td><td>" + send_data[i].member_id + "</td><td>" + sdate + "</td><td>" + send_data[i].message_yn + "</td></tr>");
											$("#sendMsgResult").append("<tr class='visible-xs " + "s" +send_data[i].message_no+"' style='text-align: center;' data-toggle='modal' href='#messageRead'><td>" + send_data[i].member_id + "</td><td>" + send_data[i].message_content + "</td></tr>");
											
											$(".s" + send_data[i].message_no).click(function() {
												msgSendimportData(send_data[i].message_no);
											});
										});
										
										
										if(s_endPage>pageCount){
											s_endPage=pageCount;
										}
//						 				alert("다음startPage:"+r_startPage);
//						 				alert("다음endPage:"+r_endPage);
//						 				alert("다음pageBlock"+pageBlock)
										
										//이전
										if(s_startPage>pageBlock){
//					 						alert("block");
											$("#send_list_before").css("display","inline-block");
											$("#send_list_pageNum").css("display","none");
											$("#send_list_pageNum").css("display","inline-block");
										}
										
										if(s_startPage<=pageBlock){
											//alert("hidden");
											$("#send_list_before").css("display","none");
										}
										
										$("#send_list_pageNum").empty();
										for(var i=s_startPage;i<=s_endPage;i++){
											$("#send_list_pageNum").append("<a href='#' id='send_paging_num"+i+"'>"+i+"</a>");
											$("#send_paging_num"+i).click(function(){
//					 							alert($(this).text());
												$.ajax({
													type:'GET',
													url:'${root}/message/mainMessage.do',
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
														
														$("#sendMsgResult").empty();
														var send_data=JSON.parse(data[0]);
														
														$.each(send_data,function(i){
															var d = new Date(send_data[i].message_sDate);
											          		var sdate = leadingZeros(d.getFullYear(), 4) + '/' + leadingZeros(d.getMonth() + 1, 2) + '/' + leadingZeros(d.getDate(), 2);				

															$("#sendMsgResult").append("<tr class='hidden-xs " + "s" +send_data[i].message_no+"' style='text-align: center;' data-toggle='modal' href='#messageRead'><td>" + send_data[i].message_no + "</td><td>" + send_data[i].message_content + "</td><td>" + send_data[i].member_id + "</td><td>" + sdate + "</td><td>" + send_data[i].message_yn + "</td></tr>");
															$("#sendMsgResult").append("<tr class='visible-xs " + "s" +send_data[i].message_no+"' style='text-align: center;' data-toggle='modal' href='#messageRead'><td>" + send_data[i].member_id + "</td><td>" + send_data[i].message_content + "</td></tr>");
															
															$(".s" + send_data[i].message_no).click(function() {
																msgSendimportData(send_data[i].message_no);
															});
														});
													}
												});
											});
										}
//					 					alert("다음endPage:"+s_endPage);
//					 					alert("다음pageCount"+pageCount);
//					 					alert("다음마지막startPage:"+s_startPage);
										//다음
										if(s_endPage<pageCount){
//					 						alert("다음block");
											$("#send_list_after").css("display","inline-block");
										}
										
										if(s_endPage>=pageCount){
//					 						alert("다음hidden");
											$("#send_list_after").css("display","none");
//					 						alert("bbbbbb");
										}
										
									}
								});
							});
							
							
							//이전클릭시
							$("#send_paging_before").click(function(){
//					 			alert("이전startPage:"+r_startPage);
//					 			alert("이전pageBlock:"+pageBlock);
								$.ajax({
									type:'GET',
									url:'${root}/message/mainMessage_info.do',
									data:{
										member_id:sessionStorage.getItem("email"),
										pageNumber:s_startPage-pageBlock
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
//					 					alert(pageCount);
										s_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
										s_endPage=s_startPage+pageBlock-1;
										
										$("#sendMsgResult").empty();
										var send_data=JSON.parse(data[0]);
										
										$.each(send_data,function(i){
											var d = new Date(send_data[i].message_sDate);
							          		var sdate = leadingZeros(d.getFullYear(), 4) + '/' + leadingZeros(d.getMonth() + 1, 2) + '/' + leadingZeros(d.getDate(), 2);				

											$("#sendMsgResult").append("<tr class='hidden-xs " + "s" +send_data[i].message_no+"' style='text-align: center;' data-toggle='modal' href='#messageRead'><td>" + send_data[i].message_no + "</td><td>" + send_data[i].message_content + "</td><td>" + send_data[i].member_id + "</td><td>" + sdate + "</td><td>" + send_data[i].message_yn + "</td></tr>");
											$("#sendMsgResult").append("<tr class='visible-xs " + "s" +send_data[i].message_no+"' style='text-align: center;' data-toggle='modal' href='#messageRead'><td>" + send_data[i].member_id + "</td><td>" + send_data[i].message_content + "</td></tr>");
											
											$(".s" + send_data[i].message_no).click(function() {
												msgSendimportData(send_data[i].message_no);
											});
										});
										
//					 					alert("startPage:"+r_startPage);
//					 					alert("pageBlock:"+pageBlock);
										//이전
										if(s_startPage>pageBlock){
											$("#send_list_before").css("display","inline-block");
											
										}
										
										if(r_startPage<=pageBlock){
											$("#send_list_before").css("display","none");
										}
										
										$("#send_list_pageNum").empty();
										for(var i=r_startPage;i<=r_endPage;i++){
											$("#send_list_pageNum").append("<a href='#' id='send_paging_num"+i+"'>"+i+"</a>");
											$("#send_paging_num"+i).click(function(){
//					 							alert($(this).text());
												$.ajax({
													type:'GET',
													url:'${root}/message/mainMessage.do',
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
														
														
														$("#sendMsgResult").empty();
														var send_data=JSON.parse(data[0]);
														
														$.each(send_data,function(i){
															var d = new Date(send_data[i].message_sDate);
											          		var sdate = leadingZeros(d.getFullYear(), 4) + '/' + leadingZeros(d.getMonth() + 1, 2) + '/' + leadingZeros(d.getDate(), 2);				

															$("#sendMsgResult").append("<tr class='hidden-xs " + "s" +send_data[i].message_no+"' style='text-align: center;' data-toggle='modal' href='#messageRead'><td>" + send_data[i].message_no + "</td><td>" + send_data[i].message_content + "</td><td>" + send_data[i].member_id + "</td><td>" + sdate + "</td><td>" + send_data[i].message_yn + "</td></tr>");
															$("#sendMsgResult").append("<tr class='visible-xs " + "s" +send_data[i].message_no+"' style='text-align: center;' data-toggle='modal' href='#messageRead'><td>" + send_data[i].member_id + "</td><td>" + send_data[i].message_content + "</td></tr>");
															
															$(".s" + send_data[i].message_no).click(function() {
																msgSendimportData(send_data[i].message_no);
															});
														});
													}
												});
											});
										}
										
										//다음
										if(s_endPage<pageCount){
											$("#send_list_after").css("display","inline-block");
										}
										
										if(s_endPage>=pageCount){
											$("#send_list_after").css("display","none");
										}
									}
								});
							});		
					 	}
						
						function msgSendimportData(no) {
							$.ajax({
								type : 'get',
								url : '${root}/message/messageRead_S.do?message_no=' + no,
								contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
								success : function(responseData) {
									//	alert(responseData);
									var data = JSON.parse(responseData);

									var d = new Date(data.message_sDate);
					          		var sdate = leadingZeros(d.getFullYear(), 4) + '/' + leadingZeros(d.getMonth() + 1, 2) + '/' + leadingZeros(d.getDate(), 2);				
					          		
									//	alert(data.message_no);
									$("input[name='message_no']").val(data.message_no);
									$("input[name='message_receiver']").val(data.message_receiver);
									$("input[name='member_id']").val(data.member_id);
									$("input[name='message_sDate']").val(sdate);
									$("textarea[name='message_content']").val(data.message_content);
								},
								error : function(data) {
									alert("로그인을 해 주세요.");
								}
							});
						}	
					}
				});
			});
		});
</script>
</head>
<body>
	<form class="form-horizontal">		<!-- 전체적인 폼 내에서 Label / Text 창의 크기를 조절하기 위해 필요한 폼 -->
		<!-- <input type="hidden" name="member_id"/> -->
		
		<div class="thumbnail">	
		<div class="caption">
		<div class="col-md-12 col-sm-12 col-xs-12">		<!-- Div 를 3화면에서 12 칸 모두 사용 -->
			<br/>
		</div>
			
			<div class="form-group form-group-lg">		<!-- 크기 조절을 하기 위한 기본 틀 -->
				<div class="col-md-2 col-sm-2 col-xs-2"><label class="control-label" for="formGroupInputLarge">받는사람</label></div> 
																	<!-- 크기 조절을 할 대상		크기 설정 (크게 / 보통 / 작게 ) -->
				<div class="col-md-10 col-sm-10 col-xs-10"><input type="text" class="form-control" id="message_receiver" name="messageWrite_receiver" placeholder="받는 사람의 아이디를 입력하세요."/></div>
			</div>																	<!-- 크기조절을 할 대상 -->
	
			<div class="form-group form-group-lg">
				<div class="col-md-2 col-sm-2 col-xs-2"><label class="control-label" for="formGroupInputLarge">내용</label></div>
				<div class="col-md-10 col-sm-10 col-xs-10"><textarea rows="5" name="messageWrite_content" class="form-control" id="messageWrite_content" placeholder="내용을 입력하세요"></textarea>
				</div>
			</div>
	
			<div class="form-group form-group-lg" style="text-align: right;">
				<div style="display: inline-block; margin-right: 15px;">
					<input type="button" class="btn btn-primary" id="write_btn" value="작성"/>
					<input type="reset" class="btn btn-primary" value="취소" />
				</div>
			</div>		
		</div>
		
		</div>
	</form>
</body>
</html>