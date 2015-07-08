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
		$("#write_btn").click(function() {
				$.ajax({
					type : 'post',
					url : '${root}/message/messageWrite.do',
				 	data : {
				 		member_id : $("input[name='member_id']").val(),
						message_receiver : $("input[name='message_receiver']").val(),
						message_content : $("textarea#message_content").val(),
				 	}, 
					contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
					success : function(responseData) {
					//	alert(responseData);
						if(responseData == 1){
							$("input[name='message_receiver']").val("");
							$("textarea#message_content").val("");
							$('#myTab a:first').tab('show');
							$("#result").empty();
							$("#result1").empty();
							
							
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
										$("#result").append($("#listRow").clone().css("display","block"));
										$("#result #listRow:last-child #no").append(data[i].message_no);
										$("#result #listRow:last-child #content").append(data[i].message_content);
										$("#result #listRow:last-child #id").append(data[i].member_id);
										$("#result #listRow:last-child #sDate").append(data[i].message_sDate);
										$("#result #listRow:last-child #yn").append(data[i].message_yn);
										$("#result #listRow:last-child a").attr("id", data[i].message_no);
										
										$("#" + data[i].message_no).click(function(){
											importData(data[i].message_no);	
										});
									});
								},
								error : function(data) {
									alert("에러가 발생하였습니다.");
								}
							});
								
							$.ajax({
								type : 'get',
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
										$("#result1").append($("#listRow1").clone().css("display","block"));
										$("#result1 #listRow1:last-child #no1").append(data[i].message_no);
										$("#result1 #listRow1:last-child #content1").append(data[i].message_content);
										$("#result1 #listRow1:last-child #id1").append(data[i].message_receiver);
										$("#result1 #listRow1:last-child #sDate1").append(data[i].message_sDate);
										$("#result1 #listRow1:last-child #yn1").append(data[i].message_yn);
										$("#result1 #listRow1:last-child a").attr("id", data[i].message_no);
										
										$("#" + data[i].message_no).click(function(){
											importData(data[i].message_no);	
										});
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
		<input type="hidden" name="member_id"/>
			
		<div class="col-md-12 col-sm-12 col-xs-12">		<!-- Div 를 3화면에서 12 칸 모두 사용 -->
			
			<div class="form-group form-group-lg">		<!-- 크기 조절을 하기 위한 기본 틀 -->
				<div class="col-md-2 col-sm-2 col-xs-2 "><label class="control-label" for="formGroupInputLarge">받는사람</label></div> 
																	<!-- 크기 조절을 할 대상		크기 설정 (크게 / 보통 / 작게 ) -->
				<div class="col-md-10 col-sm-10 col-xs-10"><input type="text" class="form-control" id="message_receiver" name="message_receiver" placeholder="받는 사람의 아이디를 입력하세요."/></div>
			</div>																	<!-- 크기조절을 할 대상 -->
	
			<div class="form-group form-group-lg">
				<div class="col-md-2 col-sm-2 col-xs-2"><label class="control-label" for="formGroupInputLarge">내용</label></div>
				<div class="col-md-10 col-sm-10 col-xs-10"><textarea rows="5" name="message_content" class="form-control" id="message_content" placeholder="내용을 입력하세요"></textarea>
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