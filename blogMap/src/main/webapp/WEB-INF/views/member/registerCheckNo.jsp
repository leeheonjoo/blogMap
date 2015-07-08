<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="root" value="${pageContext.request.contextPath }"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->
<script type="text/javascript">
	$(function(){
		/* if($("#registerCheckzz").val()!=""){
			alert("aa"); */
		
			$("#registerCheckBtn").click(function(){
				$.ajax({
					type:'POST',
					url:'${root}/member/registerCheck.do',
					data:{
						member_id:$("#registerCheck").val(),
					},
					contentType:'application/x-www-form-urlencoded;charset=UTF-8',
					success:function(responseCheckData){
						alert(responseCheckData);
						
						if(responseCheckData=="0"){    //아이디 중복 안됨
							 //$('#registerCheckNo_div').fadeOut();
							 $("div[id='blogmap_registerCheckNo'].modal").modal('hide');
							 //$('#registerCheckOk_div').fadeIn();
							 $("div[id='blogmap_registerCheckOk'].modal").modal();
						}
						
						
					}
				});
			});
			/* 	}else{
			alert("아이디를 입력해주세요");
		} */
	});
</script>
</head>
<body>
	<h3>중복된 아이디입니다.</h3>
	아이디: <input type="text" id="registerCheck"/>
	<input type="button" id="registerCheckBtn" value="중복체크"/><br/>
	
</body>
</html>