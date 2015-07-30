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
					//alert(responseData);
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
	<div class="container" style="width:100%;">
        <div class="row centered-form">
	        <div>
	        	<div class="panel panel-default">
	        		<div class="panel-heading">
				    	<h1 class="panel-title">비밀번호 찾기</h1>
				 	</div>
				 	
		 			<div class="panel-body"> 
		    		<!-- <form role="form"> -->
		  	
						<div class="row">
		    				<div class="col-xs-6 col-sm-6 col-md-6">
		    					<div class="form-group">
		               				<input type="text" name="member_id_renew" class="form-control input-sm" placeholder="Email Address"/>
		    					</div>
		    				</div>
		    				
		    				<div class="col-xs-2 col-sm-2 col-md-2">
			    					<div class="form-group">
			    						<input type="button" name="submit" value="발송" class="btn btn-info btn-block"/>
			    					</div>
			    			</div>
		    			</div>
		    		</div>
				</div>
			</div>
		</div>
	</div> 
</body>
</html>