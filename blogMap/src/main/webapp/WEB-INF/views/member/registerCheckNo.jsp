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
	
	<div class="container">
        <div class="row centered-form">
	        <div class="col-xs-12 col-sm-8 col-md-8 col-sm-offset-1 col-md-offset-1">
	        	<div class="panel panel-default">
	        		<div class="panel-heading">
				    	<h3 class="panel-title">중복된 아이디 입니다.</h3>
				 	</div>
				 	
		 			<div class="panel-body"> 
		    		<!-- <form role="form"> -->
		  	
						<div class="row">
		    				<div class="col-xs-6 col-sm-6 col-md-6">
		    					<div class="form-group">
		               				<input type="email" id="registerCheck" class="form-control input-sm" placeholder="Email Address"/>
		    					</div>
		    				</div>
		    				
		    				<div class="col-xs-2 col-sm-2 col-md-2">
			    					<div class="form-group">
			    						<input type="button" id="registerCheckBtn" value="중복확인" class="btn btn-info btn-block"/>
			    						<!-- <button id="member_id_confirm" class="btn btn-default">이메일인증</button> -->
			    					</div>
			    			</div>
		    			</div>
		    			
		    		</div>
		    		
				</div>
			</div>
		</div>
	</div> 
	
<!-- 	아이디: <input type="text" id="registerCheck"/>
	<input type="button" id="registerCheckBtn" value="중복체크"/><br/> -->
	
</body>
</html>