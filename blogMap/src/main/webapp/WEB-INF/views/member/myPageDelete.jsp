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
$(function(){
	//var email=sessionStorage.getItem('email');
	//$("#myPageUpdate_member_id").val(email);
	
	var email="kimjh112339@naver.com";
	
	$("#myPageDelete_OkayBtn").click(function(){
		//유효성검사
		
		$.ajax({
			type:"post",
			url:"${root}/member/myPageDelete.do",
			data:{
				member_id:email,
				member_pwd:$("#myPageDelete_pwd").val()
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				alert(responseData);
				
				if(responseData=="1"){
					alert("삭제 되었습니다.");
					location.href="${root}/1";
				}else{
					alert("삭제 실패");
				}
			}
		});
	});
	
	$("#myPageDelete_CancelBtn").click(function(){
		//$("#myPageDelete_layer_div").fadeOut();
		$("div[id='blogmap_myPageDelete'].modal").modal('hide');
	});
	
});
</script>
</head>
<body>
	<h3>비밀번호를 입력해주세요.</h3>
	<div>
		<input id="myPageDelete_pwd" type="password"/>
	</div>
	
	<div>
		<input id="myPageDelete_OkayBtn" type="button" value="탈퇴"/>
		<input id="myPageDelete_CancelBtn" type="button" value="취소"/>
	</div>
</body>
</html>