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
		$("#myPageUpdate_member_id").val(email);
		$("#myPageUpdate_member_id").attr("disabled","disabled");
		
		$("#myPageUpdate_btn").click(function(){
			if($("#myPageUpdate_member_name").val()!=""){
				
				if($("#myPageUpdate_member_pwd").val()==$("#myPageUpdate_member_pwd_check").val()){
					$.ajax({
						type:"post",
						url:"${root}/member/myPageUpdate_pwdCheck.do",
						data:{
							member_id:email,
							member_pwd:$("#myPage_member_pwd").val()
						},
						contentType:'application/x-www-form-urlencoded;charset=UTF-8',
						success:function(responseData){
							//alert(responseData);
							
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
											location.href="${root}/";
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
				}else{
					alert("수정할 비밀번호가 일치하지 않습니다.");
				}
			}else{
				alert("이름을 입력해주세요.");
			}
			
			
		});
	});	
}
</script>
</head>
<body>
	<label>계정정보</label><br/>
	<div class="row">
		<div class="col-xs-8 col-sm-8 col-md-8">
			<div class="form-group">
          			<input type="text" id="myPageUpdate_member_id" class="form-control input-sm"/>
			</div>
		</div>
	</div>
	
	<label>이름</label><br/>
	<div class="row">
		<div class="col-xs-8 col-sm-8 col-md-8">
			<div class="form-group">
          			<input type="text" id="myPageUpdate_member_name" class="form-control input-sm" placeholder="Name"/>
			</div>
		</div>
	</div>
	
	<label>현재비밀번호</label><br/>
	<div class="row">
		<div class="col-xs-8 col-sm-8 col-md-8">
			<div class="form-group">
          			<input type="password" id="myPage_member_pwd" class="form-control input-sm" placeholder="Password"/>
			</div>
		</div>
	</div>
	
	<label>수정할 비밀번호</label><br/>
	<div class="row">
		<div class="col-xs-8 col-sm-8 col-md-8">
			<div class="form-group">
          			<input type="password" id="myPageUpdate_member_pwd" class="form-control input-sm" placeholder="Password"/>
			</div>
		</div>
	</div>
	
	<label>비밀번호 확인</label><br/>
	<div class="row">
		<div class="col-xs-8 col-sm-8 col-md-8">
			<div class="form-group">
          			<input type="password" id="myPageUpdate_member_pwd_check" class="form-control input-sm" placeholder="Confirm password"/>
			</div>
		</div>
	</div><br/>
	
	<div>
       	<button id="myPageUpdate_btn" class="btn btn-primary" style="min-width:110px">Update</button>
  	</div>
</body>
</html>