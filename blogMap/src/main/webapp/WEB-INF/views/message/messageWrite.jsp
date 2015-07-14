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
							
							$.ajax({
								type : 'post',
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
						
									/*result Div 안에 listRow Div 를 복사하여 붙이면서 불러온 정보를 차례대로 담는다. */
									$.each(data, function(i) {
										var date = new Date(data[i].message_sDate);
										var sy = date.getFullYear();
										var sm = date.getMonth() + 1;
										var sd = date.getDate();

										var sdate = sy + "/" + sm + "/" + sd;

										$("#receiveMsgResult").append("<tr class='hidden-xs' style='text-align: center;' data-toggle='modal' href='#messageRead' class='btn-example' id='"+data[i].message_no+"'><td>" + data[i].message_no + "</td><td>" + data[i].message_content + "</td><td>" + data[i].member_id + "</td><td>" + sdate + "</td><td>" + data[i].message_yn + "</td></tr>");
										$("#receiveMsgResult").append("<tr class='visible-xs' style='text-align: center;' data-toggle='modal' href='#messageRead' class='btn-example' id='"+data[i].message_no+"'><td>" + data[i].member_id + "</td><td>" + data[i].message_content + "</td></tr>");
										
										$("#" + data[i].message_no).click(function() {
											msgRecieveimportData(data[i].message_no);
										});
									});
							},
								error : function(data) {
									alert("에러가 발생하였습니다.");
								}
							});

						function msgRecieveimportData(no) {
							$.ajax({
								type : 'get',
								url : '${root}/message/messageRead.do?message_no=' + no,
								contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
								success : function(responseData) {
									//	alert(responseData);
									var data = JSON.parse(responseData);
						
									var date = new Date(data.message_sDate);
									var sy = date.getFullYear();
									var sm = date.getMonth() + 1;
									var sd = date.getDate();
						
									var sdate = sy + "/" + sm + "/" + sd;
									//	alert(data.message_no);
									$("input[name='message_no']").val(data.message_no);
									$("input[name='message_receiver']").val(data.message_receiver);
									$("input[name='member_id']").val(data.member_id);
									$("input[name='message_sDate']").val(sdate);
									$("textarea[name='message_content']").val(data.message_content);
								},
								error : function(data) {
									alert("에러가 발생하였습니다.");
								}
							});
						}
						
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
	
								/*result Div 안에 listRow Div 를 복사하여 붙이면서 불러온 정보를 차례대로 담는다. */
								$.each(data,function(i) {
									var date = new Date(data[i].message_sDate);
									var sy = date.getFullYear();
									var sm = date.getMonth() + 1;
									var sd = date.getDate();
						
									var sdate = sy + "/" + sm + "/"	+ sd;
									/* alert(sdate); */
									/* alert(date.getFullYear() + "/" + date.getMonth()+1 + "/" + date.getDate() + "/" + date.getHours()); */
						
									$("#sendMsgResult").append("<tr class='hidden-xs' style='text-align: center;' data-toggle='modal' href='#messageRead' class='btn-example' id='"+data[i].message_no+"'><td>" + data[i].message_no + "</td><td>" + data[i].message_content + "</td><td>" + data[i].member_id + "</td><td>" + sdate + "</td><td>" + data[i].message_yn + "</td></tr>");
									$("#sendMsgResult").append("<tr class='visible-xs' style='text-align: center;' data-toggle='modal' href='#messageRead' class='btn-example' id='"+data[i].message_no+"'><td>" + data[i].member_id + "</td><td>" + data[i].message_content + "</td></tr>");
									
									$("#" + data[i].message_no).click(function() {
										msgSendimportData(data[i].message_no);
									});
								});
							},
							error : function(data) {
								alert("에러가 발생하였습니다.");
							}
						});
						
						function msgSendimportData(no) {
							$.ajax({
								type : 'get',
								url : '${root}/message/messageRead_S.do?message_no=' + no,
								contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
								success : function(responseData) {
									//	alert(responseData);
									var data = JSON.parse(responseData);
	
									var date = new Date(data.message_sDate);
									var sy = date.getFullYear();
									var sm = date.getMonth() + 1;
									var sd = date.getDate();
	
									var sdate = sy + "/" + sm + "/" + sd;
									//	alert(data.message_no);
									$("input[name='message_no']").val(data.message_no);
									$("input[name='message_receiver']").val(data.message_receiver);
									$("input[name='member_id']").val(data.member_id);
									$("input[name='message_sDate']").val(sdate);
									$("textarea[name='message_content']").val(data.message_content);
								},
								error : function(data) {
									alert("에러가 발생하였습니다.");
								}
							});	
						}			
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
			<br/>
			
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
	
			<div class="form-group form-group-lg">
				<input type="button" class="btn btn-primary" id="write_btn" value="작성"/>
				<input type="reset" class="btn btn-primary" value="취소" />
			</div>		
		</div>
	</form>
</body>
</html>