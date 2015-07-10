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
		alert("현재 로그인 중인 아이디 : " + email);
		
		$("#write_btn").click(function() {
				$.ajax({
					type : 'post',
					url : '${root}/message/messageWrite.do',
				 	data : {
				 		member_id : email,
						message_receiver : $("input[name='messageWrite_receiver']").val(),
						message_content : $("textarea#messageWrite_content").val(),
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
							
							
							$.ajax({
								type : 'post',
								url : '${root}/message/mainMessage.do',
								contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
								success : function(responseData) {
									var data = JSON.parse(responseData);
									if (!data) {
										alert("메시지가 비어있습니다.");
										return false;
									}
				 					//alert(data.category_code);
				
									$.each(data,function(i) {
										var date=new Date(data[i].message_sDate);
										var sy=date.getFullYear();
										var sm=date.getMonth()+1;
										var sd=date.getDate();
										
										var sdate=sy + "/" + sm + "/" + sd;
										$("#receiveMsgResult").append($("#receiveListRow").clone());
										$("#receiveMsgResult #receiveListRow:last-child #msg_R_no").append(data[i].message_no);
										$("#receiveMsgResult #receiveListRow:last-child #msg_R_content").append(data[i].message_content);
										$("#receiveMsgResult #receiveListRow:last-child #msg_R_id").append(data[i].member_id);
										$("#receiveMsgResult #receiveListRow:last-child #msg_R_sDate").append(sdate);
										$("#receiveMsgResult #receiveListRow:last-child #msg_R_yn").append(data[i].message_yn);
										$("#receiveMsgResult #receiveListRow:last-child a").attr("id", data[i].message_no);
										
									});
								},
								error : function(data) {
									alert("에러가 발생하였습니다.");
								}
							});
								
							$.ajax({
								type : 'get',
								url : '${root}/message/mainMessage.do',
								data : {
									member_id : email
								},
								contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
								success : function(responseData) {
									var data = JSON.parse(responseData);
									if (!data) {
										alert("메시지가 비어있습니다.");
										return false;
									}
				 					//alert(data.category_code);
				
									$.each(data,function(i) {
										var date=new Date(data[i].message_sDate);
										var sy=date.getFullYear();
										var sm=date.getMonth()+1;
										var sd=date.getDate();
										
										var sdate=sy + "/" + sm + "/" + sd;
										$("#sendMsgResult").append($("#sendListRow").clone());
										$("#sendMsgResult #sendListRow:last-child #msg_S_no").append(data[i].message_no);
										$("#sendMsgResult #sendListRow:last-child #msg_S_content").append(data[i].message_content);
										$("#sendMsgResult #sendListRow:last-child #msg_S_id").append(data[i].message_receiver);
										$("#sendMsgResult #sendListRow:last-child #msg_S_sDate").append(sdate);
										$("#sendMsgResult #sendListRow:last-child #msg_S_yn").append(data[i].message_yn);
										$("#sendMsgResult #sendListRow:last-child a").attr("id", data[i].message_no);
										
									});
								},
								error : function(data) {
									alert("에러가 발생하였습니다.");
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
			
		<div class="col-md-12 col-sm-12 col-xs-12">		<!-- Div 를 3화면에서 12 칸 모두 사용 -->
			
			<div class="form-group form-group-lg">		<!-- 크기 조절을 하기 위한 기본 틀 -->
				<div class="col-md-2 col-sm-2 col-xs-2 "><label class="control-label" for="formGroupInputLarge">받는사람</label></div> 
																	<!-- 크기 조절을 할 대상		크기 설정 (크게 / 보통 / 작게 ) -->
				<div class="col-md-10 col-sm-10 col-xs-10"><input type="text" class="form-control" id="message_receiver" name="messageWrite_receiver" placeholder="받는 사람의 아이디를 입력하세요."/></div>
			</div>																	<!-- 크기조절을 할 대상 -->
	
			<div class="form-group form-group-lg">
				<div class="col-md-2 col-sm-2 col-xs-2"><label class="control-label" for="formGroupInputLarge">내용</label></div>
				<div class="col-md-10 col-sm-10 col-xs-10"><textarea rows="5" name="messageWrite_content" class="form-control" id="messageWrite_content" placeholder="내용을 입력하세요"></textarea>
				</div>
			</div>
	
			<div class="form-group form-group-lg">
				<input type="button" class="btn btn-primary" id="write_btn" value="작성"/>
				<input type="reset" class="btn btn-primary" value="취소" />
			</div>		
		</div>
	</form>
</body>
</html>