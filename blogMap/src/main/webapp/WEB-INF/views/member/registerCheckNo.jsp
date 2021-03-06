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
		
			$("#registerCheckBtn").click(function(){
				$.ajax({
					type:'POST',
					url:'${root}/member/registerCheck.do',
					data:{
						member_id:$("#registerCheck").val(),
					},
					contentType:'application/x-www-form-urlencoded;charset=UTF-8',
					success:function(responseCheckData){
						//alert(responseCheckData);
						
						if(responseCheckData=="0"){    //아이디 중복 안됨
							 $("div[id='blogmap_registerCheckNo'].modal").modal('hide');
							 $("div[id='blogmap_registerCheckOk'].modal").modal();
						}
						
						
					}
				});
			});
	});
</script>
</head>
<body>
	
	<div class="container" style="width:100%">
        <div class="row centered-form">
	        <div>
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
		    				
		    				<div style="display:inline-block; min-width:100px;">
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
</body>
</html>