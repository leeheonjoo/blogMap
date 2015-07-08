<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="root" value="${pageContext.request.contextPath }"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	$(function(){
		$("input[name='submit']").click(function(){
			$.ajax({
				url:"${root}/member/renew_pwd.do",
				type:"POST",
				data:{
					member_id:$("input[name='member_id_renew']").val()
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					alert(responseData);
					if(responseData=="1"){
						alert("임시 비밀번호가 전송되었습니다.");
						$("input[name='member_id_renew']").val("");
						$("div[id='blogmap_renew_pwd'].modal").modal('hide');
					}
					
					if(responseData=="0"){
						alert("아이디를 확인해주세요.");
					}
				}
			});
		});
	});
</script>
</head>
<body>
	<div>
		아이디(이메일)<input type="text" name="member_id_renew"/>   
	</div>
	
	<div>
		<input type="button" name="submit" value="발송"/>
	</div>
</body>
</html>