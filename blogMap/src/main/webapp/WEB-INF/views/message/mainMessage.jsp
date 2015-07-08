<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<c:set var="root" value="${pageContext.request.contextPath }"/>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>BLOG MAP</title>
<script type="text/javascript">
	function msgSendList(){
		 $("#result").empty();
		/* alert("1"); */
		// 발신메시지 로드하는 부분
		// 발신 메시지 로드 -> jquery로 해당 리스트에 뿌려준다.
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
	
				/*result Div 안에 listRow Div 를 복사하여 붙이면서 불러온 정보를 차례대로 담는다. */
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
	
	function importData(no){
			$.ajax({
				type:'get',
				url:'${root}/message/messageRead.do?message_no=' + no,
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
				//	alert(responseData);
					var data=JSON.parse(responseData);
				//	alert(data.message_no);
					$("input[name='message_no']").val(data.message_no);
			 		$("input[name='message_receiver']").val(data.message_receiver);
			 		$("input[name='member_id']").val(data.member_id); 
			 		$("input[name='message_sDate']").val(data.message_sDate); 
			 		$("textarea[name='message_content']").val(data.message_content); 
				},
				error:function(data){
					alert("에러가 발생하였습니다.");
			} 
		}); 
		}
	}
	
	function msgReceiveList(){
			// 메시지 창을 비워준다.
			$("#result").empty();
			/* alert("1"); */
			// 수신메시지 로드하는 부분
			// 수신 메시지 로드 -> jquery로 해당 리스트에 뿌려준다.
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
	
					/*result Div 안에 listRow Div 를 복사하여 붙이면서 불러온 정보를 차례대로 담는다. */
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
		}
	
	function importData(no){
			$.ajax({
				type:'get',
				url:'${root}/message/messageRead.do?message_no=' + no,
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
				//	alert(responseData);
					var data=JSON.parse(responseData);
				//	alert(data.message_no);
					$("input[name='message_no']").val(data.message_no);
			 		$("input[name='message_receiver']").val(data.message_receiver);
			 		$("input[name='member_id']").val(data.member_id); 
			 		$("input[name='message_sDate']").val(data.message_sDate); 
			 		$("textarea[name='message_content']").val(data.message_content); 
				},
				error:function(data){
					alert("에러가 발생하였습니다.");
			} 
		}); 
	}
	
	$(function(){
		$("#mainMessageLink").click(function(){
			messageView();
		});
	});
	
	function messageView(){
		// 메시지 창을 비워준다.
		$("#result").empty();
		// 수신메시지 로드하는 부분
		// 수신 메시지 로드 -> jquery로 해당 리스트에 뿌려준다.
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
	
				/*result Div 안에 listRow Div 를 복사하여 붙이면서 불러온 정보를 차례대로 담는다. */
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
	}
	
	function importData(no){
		$.ajax({
			type:'get',
			url:'${root}/message/messageRead.do?message_no=' + no,
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
			//	alert(responseData);
				var data=JSON.parse(responseData);
			//	alert(data.message_no);
				$("input[name='message_no']").val(data.message_no);
		 		$("input[name='message_receiver']").val(data.message_receiver);
		 		$("input[name='member_id']").val(data.member_id); 
		 		$("input[name='message_sDate']").val(data.message_sDate); 
		 		$("textarea[name='message_content']").val(data.message_content); 
			},
			error:function(data){
				alert("에러가 발생하였습니다.");
			} 
		}); 
	}
</script>
</head>
<body>
	<article class="container-fluid">
	<div class="row">
		<section class="page-header">
			<h2 class="page-title">메시지</h2>
		</section>
	</div>
	<div class="row">
		<div>
			<!-- 큰 사이즈 화면에서 탭 목록-->
			<ul id="myTab" class="nav nav-pills nav-stacked col-md-2 hidden-xs hidden-sm" role="tablist">
				<!-- 탭 사이즈를 조절 -->
				<li role="presentation">
				<a href="#tab_sendMessageList" aria-controls="tab_sendMessageList" role="tab" data-toggle="tab" onclick="msgSendList()">발신함</a>
				</li>
				
				<li role="presentation" class="active">
				<a href="#tab_receiveMessageList" aria-controls="tab_receiveMessageList" role="tab" data-toggle="tab" onclick="msgReceiveList()">수신함</a>
				</li>
				
				<li role="presentation">
				<a href="#tab_messageWrite" aria-controls="tab_messageWrite" role="tab" data-toggle="tab">메시지 작성</a>
				</li>
			</ul>

			<!-- 작은 사이즈 화면에서 탭 목록-->
			<ul class="nav nav-tabs hidden-md hidden-lg" role="tablist">
				<li role="presentation">
				<a href="#tab_sendMessageList" aria-controls="tab_sendMessageList" role="tab" data-toggle="tab" onclick="msgSendList()">발신함</a>
				</li>
				
				<li role="presentation" class="active">
				<a href="#tab_receiveMessageList" aria-controls="tab_receiveMessageList" role="tab" data-toggle="tab" onclick="msgReceiveList()">수신함</a>
				</li>
				
				<li role="presentation">
				<a href="#tab_messageWrite" aria-controls="tab_messageWrite" role="tab" data-toggle="tab">메시지 작성</a>
				</li>
			</ul>

			<!-- 수신함 탭 내용 -->
			<div class="tab-content col-md-10">
				<section role="tabpanel" class="tab-pane active" id="tab_receiveMessageList">
					<div class="row" id="receiveMessage_item_list">
						<div class="thumbnail">
							<div class="caption">

							<!--수신함-->
							<div class="row" id="receive_message">
								
									<div class="col-md-1 col-sm-1 col-xs-1">번호</div>
									<div class="col-md-4 col-sm-4 col-xs-4">내용</div>
									<div class="col-md-2 col-sm-2 col-xs-2">발신자</div>
									<div class="col-md-3 col-sm-3 col-xs-3">발송일</div>
									<div class="col-md-2 col-sm-2 col-xs-2">수신여부</div>
									<br/>								
							</div>

							<!-- 정보를 담아내기 위한 그릇 -->
							<div class="row" id="listRow">
								<a data-toggle="modal" href="#messageRead" class="btn-example"> 
								<div id="no" class="col-md-1 col-sm-1 col-xs-1"></div>
								<div id="content" class="col-md-4 col-sm-4 col-xs-4"></div>
								<div id="id" class="col-md-2 col-sm-2 col-xs-2"></div>
								<div id="sDate" class="col-md-3 col-sm-3 col-xs-3"></div>
								<div id="yn" class="col-md-2 col-sm-2 col-xs-2"></div>		
								</a> 
							</div>

							<!-- 그릇을 담기위한 상위 개념 임의생성 -->
							<div id="result"></div>
						</div>
					</div>
				</div>
				</section>
				
				<!-- 발신함 탭 -->
				<div role="tabpanel" class="tab-pane" id="tab_sendMessageList">
					<div class="row" id="sendMessage_item_list">
						<div class="thumbnail">
							<div class="caption">

								<!-- 발신함 -->
								<div class="row" id="send_message">
										<div class="col-md-1 col-sm-1 col-xs-1">번호</div>
										<div class="col-md-4 col-sm-4 col-xs-4">내용</div>
										<div class="col-md-2 col-sm-2 col-xs-2">수신자</div>
										<div class="col-md-3 col-sm-3 col-xs-3">발송일</div>
										<div class="col-md-2 col-sm-2 col-xs-2">수신여부</div>
								</div>

								<!-- 정보를 담아내기 위한 그릇 -->
								<div id="listRow1">
									<a data-toggle="modal" href="#messageRead" class="btn-example"> 
									<div id="no1" class="col-md-1 col-sm-1 col-xs-1"></div>
									<div id="content1" class="col-md-4 col-sm-4 col-xs-4"></div>
									<div id="id1" class="col-md-2 col-sm-2 col-xs-2"></div>
									<div id="sDate1" class="col-md-3 col-sm-3 col-xs-3"></div>
									<div id="yn1" class="col-md-2 col-sm-2 col-xs-2"></div>
									</a>
								</div>

								<!-- 그릇을 담기위한 상위 개념 임의생성 -->
								<div id="result1" class="row"></div>
							</div>
						</div>
					</div>
				</div>
				
				<div role="tabpanel" class="tab-pane" id="tab_messageWrite">
					<jsp:include page="messageWrite.jsp"/>
				</div>


			</div>
		</div>
	</div>
	</article>	
</body>
</html>