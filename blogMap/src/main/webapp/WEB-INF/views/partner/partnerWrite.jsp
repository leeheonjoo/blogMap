<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set var="root" value="${pageContext.request.contextPath}"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>partnerWrite</title>
<script type="text/javascript">
$(document).ready(function(){
	var email=sessionStorage.getItem('email');
	alert("현재 로그인 중인 아이디입니다.:"+email);
	
	$("#partnerWrite_btn").click(function(){
		$.ajax({
			type:'post',
			url:'${root}/partner/partnerWrite.do',
			data:{
				member_id:email,
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				alert(responseData==1){
					$("input[name='partnerWrite']").val("");
				}
			}
		});
	});
});
</script>
</head>
<body>

</body>
</html>