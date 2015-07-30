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
if(sessionStorage.getItem('email')!=null){
	$(function(){
		var email=sessionStorage.getItem('email');
		
		$("#myPageDelete_OkayBtn").click(function(){
			//유효성검사
			if($("#myPageDelete_pwd").val()!=""){
				$.ajax({
					type:"post",
					url:"${root}/member/myPageDelete.do",
					data:{
						member_id:email,
						member_pwd:$("#myPageDelete_pwd").val()
					},
					contentType:'application/x-www-form-urlencoded;charset=UTF-8',
					success:function(responseData){
						//alert(responseData);
						
						if(responseData=="1"){
							alert("삭제 되었습니다.");
							sessionStorage.clear();
							location.href="${root}/";
						}else{
							alert("비밀번호가 맞지 않습니다.");
						}
					}
				});
			}else{
				alert("비밀번호를 입력해주세요");
			}
			
		});
		
		$("#myPageDelete_CancelBtn").click(function(){
			$("div[id='blogmap_myPageDelete'].modal").modal('hide');
		});
		
	});
}
</script>
</head>
<body>
	<label>비밀번호를 입력해주세요.</label>
   	<div class="row">
		<div class="col-xs-8 col-sm-8 col-md-8">
			<div class="form-group">
          			<input type="password" id="myPageDelete_pwd" class="form-control input-sm" placeholder="Password"/>
			</div>
		</div>
	</div>
   	<div>
   	    <button id="myPageDelete_OkayBtn" class="btn btn-primary">삭제</button>&nbsp;&nbsp;
   	    <button id="myPageDelete_CancelBtn" class="btn btn-primary">취소</button>
   	</div>
</body>
</html>