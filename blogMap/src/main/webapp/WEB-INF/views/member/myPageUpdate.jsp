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
	$("#myPageUpdate_member_id").val(email);
	$("#myPageUpdate_member_id").attr("disabled","disabled");
	
	$("#myPageUpdate_btn").click(function(){
		//유효성검사
		/* var check=confirm("정말로 수정하시겠습니까?");
		if(check==true){
			
		} */
		$.ajax({
			type:"post",
			url:"${root}/member/myPageUpdate_pwdCheck.do",
			data:{
				member_id:email,
				member_pwd:$("#myPage_member_pwd").val()
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				alert(responseData);
				
				if(responseData=="1"){
					$.ajax({
						type:"post",
						url:"${root}/member/myPageUpdate.do",
						data:{
							member_id:email,
							member_name:$("#myPageUpdate_member_name").val(),
							member_pwd:$("#myPageUpdate_member_pwd").val()	
						},
						contentType:'application/x-www-form-urlencoded;charset=UTF-8',
						success:function(responseUpData){
							
							if(responseUpData=="1"){
								alert("수정완료!");
								//$("#myPageUpdate_layer_div").fadeOut();
								location.href="${root}/1";
							}else{
								alert("수정실패");
							}
	
						}
					});
				}
				
				if(responseData=="0"){
					alert("비밀번호가 일치하지 않습니다.");
				}
			}
		});
	});
});	
</script>
</head>
<body>
	<div>
		계정정보<input id="myPageUpdate_member_id" type="text"/> 
	</div>
	
	<div>
		이름<input id="myPageUpdate_member_name" type="text"/> 
	</div>
	
	<div>
		현재비밀번호<input id="myPage_member_pwd" type="password"/> 
	</div>
	
	<div>
		수정할 비밀번호<input id="myPageUpdate_member_pwd" type="password"/> 
	</div>
	
	<div>
		비밀번호 확인<input id="myPageUpdate_member_pwd_check" type="password"/> 
	</div>
	
	<div>
		<input id="myPageUpdate_btn" type="button" value="수정"/> 
	</div>
</body>
</html>