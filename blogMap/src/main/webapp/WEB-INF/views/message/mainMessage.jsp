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
	var email = sessionStorage.getItem('email');

	function msgSendList(){	
		 $("#receiveMsgResult").empty();
		 $("#sendMsgResult").empty();
		/* alert("1"); */
		// 발신메시지 로드하는 부분
		// 발신 메시지 로드 -> jquery로 해당 리스트에 뿌려준다.
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
					var date=new Date(data[i].message_sDate);
					var sy=date.getFullYear();
					var sm=date.getMonth()+1;
					var sd=date.getDate();
					
					var sdate=sy + "/" + sm + "/" + sd;
					/* alert(sdate); */
					/* alert(date.getFullYear() + "/" + date.getMonth()+1 + "/" + date.getDate() + "/" + date.getHours()); */
					
					$("#sendMsgResult").append($("#sendListRow").clone());
						$("#sendMsgResult #sendListRow:last-child #msg_S_no").append(data[i].message_no);
						$("#sendMsgResult #sendListRow:last-child #msg_S_content").append(data[i].message_content);
						$("#sendMsgResult #sendListRow:last-child #msg_S_id").append(data[i].message_receiver);
						$("#sendMsgResult #sendListRow:last-child #msg_S_sDate").append(sdate);
						$("#sendMsgResult #sendListRow:last-child #msg_S_yn").append(data[i].message_yn);
						$("#sendMsgResult #sendListRow:last-child a").attr("id", data[i].message_no);
						
						$("#" + data[i].message_no).click(function(){
							msgSendimportData(data[i].message_no);	
						});
					});
				},
		error : function(data) {
			alert("에러가 발생하였습니다.");
		}
	});
	
	function msgSendimportData(no){
			$.ajax({
				type:'get',
				url:'${root}/message/messageRead.do?message_no=' + no,
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
				//	alert(responseData);
					var data=JSON.parse(responseData);
					
					var date=new Date(data.message_sDate);
					var sy=date.getFullYear();
					var sm=date.getMonth()+1;
					var sd=date.getDate();
					
					var sdate=sy + "/" + sm + "/" + sd;
				//	alert(data.message_no);
					$("input[name='message_no']").val(data.message_no);
			 		$("input[name='message_receiver']").val(data.message_receiver);
			 		$("input[name='member_id']").val(data.member_id); 
			 		$("input[name='message_sDate']").val(sdate); 
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
		$("#receiveMsgResult").empty();
		$("#sendMsgResult").empty();
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
						
						$("#" + data[i].message_no).click(function(){
							msgRecieveimportData(data[i].message_no);	
						});
					});
				},
		error : function(data) {
			alert("에러가 발생하였습니다.");
		}
	});
	}

	function msgRecieveimportData(no){
			$.ajax({
				type:'get',
				url:'${root}/message/messageRead.do?message_no=' + no,
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
				//	alert(responseData);
					var data=JSON.parse(responseData);
					
					var date=new Date(data.message_sDate);
					var sy=date.getFullYear();
					var sm=date.getMonth()+1;
					var sd=date.getDate();
					
					var sdate=sy + "/" + sm + "/" + sd;
				//	alert(data.message_no);
					$("input[name='message_no']").val(data.message_no);
			 		$("input[name='message_receiver']").val(data.message_receiver);
			 		$("input[name='member_id']").val(data.member_id); 
			 		$("input[name='message_sDate']").val(sdate); 
			 		$("textarea[name='message_content']").val(data.message_content); 
				},
				error:function(data){
					alert("에러가 발생하였습니다.");
			} 
		}); 
	}
	
	$(function(){
		var email = sessionStorage.getItem('email');
		/* alert("현재 사용중인 아이디: " + email); */
		
		$("#mainMessageLink").click(function(){
			messageView();
		});
	});
	
	function messageView(){
		// 메시지 창을 비워준다.
		$("#receiveMsgResult").empty();
		$("#sendMsgResult").empty();
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
						
						$("#" + data[i].message_no).click(function(){
							msgimportData(data[i].message_no);	
						});
					});
				},
			error : function(data) {
				alert("에러가 발생하였습니다.");
			}
		});
	}
	
	function msgimportData(no){
		$.ajax({
			type:'get',
			url:'${root}/message/messageRead.do?message_no=' + no,
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
			//	alert(responseData);
				var data=JSON.parse(responseData);
				
				var date=new Date(data.message_sDate);
				var sy=date.getFullYear();
				var sm=date.getMonth()+1;
				var sd=date.getDate();
				
				var sdate=sy + "/" + sm + "/" + sd;
			//	alert(data.message_no);
				$("input[name='message_no']").val(data.message_no);
		 		$("input[name='message_receiver']").val(data.message_receiver);
		 		$("input[name='member_id']").val(data.member_id); 
		 		$("input[name='message_sDate']").val(sdate); 
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
								<div class="col-md-3 col-sm-3 col-xs-3">발신자</div>
								<div class="col-md-3 col-sm-3 col-xs-3">발송일</div>
								<div class="col-md-1 col-sm-1 col-xs-1">수신</div>
							</div>

							<!-- 정보를 담아내기 위한 그릇 -->
							<div class="row" id="receiveListRow">
								<a data-toggle="modal" href="#messageRead" class="btn-example"> 
								<div id="msg_R_no" class="col-md-1 col-sm-1 col-xs-1"></div>
								<div id="msg_R_content" class="col-md-4 col-sm-4 col-xs-4"></div>
								<div id="msg_R_id" class="col-md-3 col-sm-3 col-xs-3"></div>
								<div id="msg_R_sDate" class="col-md-3 col-sm-3 col-xs-3"></div>
								<div id="msg_R_yn" class="col-md-1 col-sm-1 col-xs-1"></div>		
								</a> 
							</div>

							<!-- 그릇을 담기위한 상위 개념 임의생성 -->
							<div id="receiveMsgResult"></div>
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
								<div class="row" id="sendListRow">
									<a data-toggle="modal" href="#messageRead" class="btn-example"> 
									<div id="msg_S_no" class="col-md-1 col-sm-1 col-xs-1"></div>
									<div id="msg_S_content" class="col-md-4 col-sm-4 col-xs-4"></div>
									<div id="msg_S_id" class="col-md-2 col-sm-2 col-xs-2"></div>
									<div id="msg_S_sDate" class="col-md-3 col-sm-3 col-xs-3"></div>
									<div id="msg_S_yn" class="col-md-2 col-sm-2 col-xs-2"></div>
									</a>
								</div>

								<!-- 그릇을 담기위한 상위 개념 임의생성 -->
								<div id="sendMsgResult"></div>
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