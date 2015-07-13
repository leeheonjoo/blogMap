<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<c:set var="root" value="${pageContext.request.contextPath }" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>BLOG MAP</title>
<style>
.table-bordered {
	border: 1px solid #dddddd;
	border-collapse: separate;
	border-left: 0;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
}

.table {
	width: 100%;
	margin-bottom: 20px;
	background-color: transparent;
	border-collapse: collapse;
	border-spacing: 0;
	display: table;
}

.widget.widget-table .table {
	margin-bottom: 0;
	border: none;
}

.widget.widget-table .widget-content {
	padding: 0;
}

.widget .widget-header+.widget-content {
	border-top: none;
	-webkit-border-top-left-radius: 0;
	-webkit-border-top-right-radius: 0;
	-moz-border-radius-topleft: 0;
	-moz-border-radius-topright: 0;
	border-top-left-radius: 0;
	border-top-right-radius: 0;
}

.widget .widget-content {
	padding: 20px 15px 15px;
	background: #FFF;
	border: 1px solid #D5D5D5;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	border-radius: 5px;
}

.widget .widget-header {
	position: relative;
	height: 40px;
	line-height: 40px;
	background: #E9E9E9;
	background: -moz-linear-gradient(top, #fafafa 0%, #e9e9e9 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #fafafa),
		color-stop(100%, #e9e9e9));
	background: -webkit-linear-gradient(top, #fafafa 0%, #e9e9e9 100%);
	background: -o-linear-gradient(top, #fafafa 0%, #e9e9e9 100%);
	background: -ms-linear-gradient(top, #fafafa 0%, #e9e9e9 100%);
	background: linear-gradient(top, #fafafa 0%, #e9e9e9 100%);
	text-shadow: 0 1px 0 #fff;
	border-radius: 5px 5px 0 0;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1), inset 0 1px 0 white, inset 0
		-1px 0 rgba(255, 255, 255, 0.7);
	border-bottom: 1px solid #bababa;
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FAFAFA',
		endColorstr='#E9E9E9');
	-ms-filter:
		"progid:DXImageTransform.Microsoft.gradient(startColorstr='#FAFAFA', endColorstr='#E9E9E9')";
	border: 1px solid #D5D5D5;
	-webkit-border-top-left-radius: 4px;
	-webkit-border-top-right-radius: 4px;
	-moz-border-radius-topleft: 4px;
	-moz-border-radius-topright: 4px;
	border-top-left-radius: 4px;
	border-top-right-radius: 4px;
	-webkit-background-clip: padding-box;
}

thead {
	display: table-header-group;
	vertical-align: middle;
	border-color: inherit;
}

.widget .widget-header h3 {
	top: 2px;
	position: relative;
	left: 10px;
	display: inline-block;
	margin-right: 3em;
	font-size: 14px;
	font-weight: 600;
	color: #555;
	line-height: 18px;
	text-shadow: 1px 1px 2px rgba(255, 255, 255, 0.5);
}

.widget .widget-header [class^="icon-"], .widget .widget-header [class*=" icon-"]
	{
	display: inline-block;
	margin-left: 13px;
	margin-right: -2px;
	font-size: 16px;
	color: #555;
	vertical-align: middle;
}
</style>
<script type="text/javascript">
	var email = sessionStorage.getItem('email');

	function msgSendList() {
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
	}
	
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
	

	function msgReceiveList() {
		// 메시지 창을 비워준다.
		$("#receiveMsgResult").empty();
		$("#sendMsgResult").empty();
		/* alert("1"); */
		// 수신메시지 로드하는 부분
		// 수신 메시지 로드 -> jquery로 해당 리스트에 뿌려준다.
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
	}

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

	$(function() {
		var email = sessionStorage.getItem('email');
		/* alert("현재 사용중인 아이디: " + email); */

		$("#mainMessageLink").click(function() {
			messageView();
		});
	});

	function messageView() {
		// 메시지 창을 비워준다.
		$("#receiveMsgResult").empty();
		$("#sendMsgResult").empty();
		// 수신메시지 로드하는 부분
		// 수신 메시지 로드 -> jquery로 해당 리스트에 뿌려준다.
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
						msgimportData(data[i].message_no);
					});
				});
			},
			error : function(data) {
				alert("에러가 발생하였습니다.");
			}
		});
	}

	function msgimportData(no) {
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

			<!-- 수신함 클릭시 -->
			<div class="tab-content col-md-10">
				<section role="tabpanel" class="tab-pane active"
					id="tab_receiveMessageList">
				<div class="row" id="receiveMessage_item_list">
					<div class="thumbnail">
						<div class="caption">
							<div class="span7">
								<div class="widget stacked widget-table action-table">
									<div class="widget-content">
										<table class="table table-striped table-bordered">
											<thead>
												<tr class="hidden-xs" id="receive_message">
													<th class="col-md-1 col-sm-1 col-xs-1"
														style="text-align: center;">No</th>
													<th class="col-md-5 col-sm-5 col-xs-5"
														style="text-align: center;">Message_Content</th>
													<th class="col-md-3 col-sm-3 col-xs-3"
														style="text-align: center;">Writer</th>
													<th class="col-md-2 col-sm-2 col-xs-2"
														style="text-align: center;">WriteDate</th>
													<th class="col-md-1 col-sm-1 col-xs-1"
														style="text-align: center;">Reception</th>
												</tr>
												
												<tr class="visible-xs" id="receive_message">
													<th class="col-xs-5"
														style="text-align: center;">Writer</th>
													<th class="col-xs-7"
														style="text-align: center;">Message_Content</th>
												</tr>
											</thead>
											<tbody id="receiveMsgResult">		<!-- 자료를 담기 위한 그릇 -->
											</tbody>
										</table>
									</div>		<!-- /widget-content -->
								</div>			<!-- /widget -->
							</div>
						</div>
					</div>
				</div>
				</section>

				<!-- 발신함 클릭시 -->
				<div role="tabpanel" class="tab-pane" id="tab_sendMessageList">
					<div class="row" id="sendMessage_item_list">
						<div class="thumbnail">
							<div class="caption">
								<div class="span7">
									<div class="widget stacked widget-table action-table">
										<div class="widget-content">
											<table class="table table-striped table-bordered">
												<thead>
													<tr class="hidden-xs" id="send_message">
														<th class="col-md-1 col-sm-1 col-xs-1"
															style="text-align: center;">No</th>
														<th class="col-md-5 col-sm-5 col-xs-5"
															style="text-align: center;">Message_Content</th>
														<th class="col-md-3 col-sm-3 col-xs-3"
															style="text-align: center;">Writer</th>
														<th class="col-md-2 col-sm-2 col-xs-2"
															style="text-align: center;">WriteDate</th>
														<th class="col-md-1 col-sm-1 col-xs-1"
															style="text-align: center;">Reception</th>
													</tr>
													
													<tr class="visible-xs" id="send_message">
															<th class="col-xs-5"
																style="text-align: center;">Writer</th>
															<th class="col-xs-7"
																style="text-align: center;">Message_Content</th>
													</tr>
												</thead>
												<tbody id="sendMsgResult">		<!-- 자료를 담기 위한 그릇 -->
												</tbody>
											</table>
										</div>		<!-- /widget-content -->
									</div>			<!-- /widget -->
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- 메시지 작성 클릭시 -->
				<div role="tabpanel" class="tab-pane" id="tab_messageWrite">
					<jsp:include page="messageWrite.jsp" />
				</div>
			</div>
		</div>
	</div>
	</article>

</body>
</html>