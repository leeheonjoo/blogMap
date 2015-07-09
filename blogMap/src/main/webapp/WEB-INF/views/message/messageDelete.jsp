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
<title>Delete</title>
<script type="text/javascript">
	function msgDelete() {
		var email=sessionStorage.getItem('email');
		
		//alert($("input[name='message_no']").val());
			$.ajax({
				type : 'post',
				url : '${root}/message/messageDelete.do',
			 	data : {
			 		member_id : $("input[name='member_Delid']").val(),
					message_no : $("input[name='message_no']").val()
			 	}, 
				contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
				success : function(responseData) {
				//	alert(responseData);
					if(responseData == 1){
						$('#myTab a:first').tab('show');
						$("#receiveMsgResult").empty();
						$("#sendMsgResult").empty();
						$("input[name='member_Delid']").val("");
						
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
								//	alert(i + " " + data[i].message_no + " " + data[i].message_content);
									$("#sendMsgResult").append($("#sendListRow").clone());
									$("#sendMsgResult #sendListRow:last-child #msg_S_no").append(data[i].message_no);
									$("#sendMsgResult #sendListRow:last-child #msg_S_content").append(data[i].message_content);
									$("#sendMsgResult #sendListRow:last-child #msg_S_id").append(data[i].member_id);
									$("#sendMsgResult #sendListRow:last-child #msg_S_sDate").append(data[i].message_sDate);
									$("#sendMsgResult #sendListRow:last-child #msg_S_yn").append(data[i].message_yn);
									$("#sendMsgResult #sendListRow:last-child a").attr("id", data[i].message_no);
									
									$("#" + data[i].message_no).click(function(){
										msgDelimportData(data[i].message_no);	
									});
								});
							},
							error : function(data) {
								alert("에러가 발생하였습니다.");
							}
						});

		 function msgDelimportData(no){
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
		}
	});
}
</script>
</head>
<body>
	<form class="form-horizontal" id="msgDel">
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="form-group form-group-lg">
				<div>
					<div class="col-md-4 col-sm-4 col-xs-4">
						<label class="control-label" for="formGroupInputLarge">아이디</label>
					</div>
					
					<div class="col-md-8 col-sm-8 col-xs-8">
						<input type="text" class="form-control" name="member_Delid"/>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>