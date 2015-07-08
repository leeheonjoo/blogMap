<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set var="root" value="${pageContext.request.contextPath}"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Home</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#btnOk").click(function(){
			$.ajax({
				type:'get',
				url:'${root}/board/test.do',
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
// 					var data=JSON.parse(responseData);
// 					if(!data){
// 						alert("존재하지 않는 ID입니다");
// 						return false;
// 					}
// // 					alert(data.category_code);
					
// 					$("#test11").html(data.category_code);
					$("#test11").html(responseData);
				},
				error:function(data){
					alert("에러가 발생하였습니다.");
				}
			});
		});
	});
</script>
</head>
<body>
	<div id="test11">아하하.</div>
	<input id="btnOk" type="button" value="클릭"/>
	<input type="text" value=""></input>
</body>
</html>