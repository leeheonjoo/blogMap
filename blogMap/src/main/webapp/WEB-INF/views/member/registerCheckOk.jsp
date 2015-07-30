<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->
<script type="text/javascript">
	$(function(){
		$("input[name='okay']").click(function(){
			if($("#registerCheck").val()!=""){
				$("#member_register_id").val($("#registerCheck").val());
				$("#registerCheck").val("");
			}
			
			$("div[id='blogmap_registerCheckOk'].modal").modal('hide');
			$("#member_id_confirm").show();
			$("#member_id_confirm").attr("data-placement","left");
			$("#member_id_confirm").attr("title","이메일 인증을 받으셔야 합니다");
			
		});
		
		$("input[name='cancel']").click(function(){
			$("div[id='blogmap_registerCheckOk'].modal").modal('hide');
		});
	});
</script>
</head>
<body>
	<!-- <h3>사용가능한 아이디 입니다.</h3>
	<input type="button" name="okay" value="사용하기"/>
	<input type="button" name="cancel" value="취소"/> -->
	
	<div class="container" style="width:100%">
        <div class="row centered-form">
	        <div>
	        	<div class="panel panel-default" style="text-align:center;">
	        		<div class="panel-heading">
				    	<h1 class="panel-title">사용가능한 아이디입니다.</h1>
				 	</div>
				 	
		 			<div class="panel-body"> 
		    		<!-- <form role="form"> -->
		  				&nbsp;&nbsp;
						<div class="row">
		    				<div style="display:inline-block; min-width:100px;">
			    					<div class="form-group">
			    						<input type="button" name="okay" value="사용하기" class="btn btn-info btn-block"/>
			    						
			    					</div>
			    			</div>&nbsp;&nbsp;&nbsp;&nbsp;
			    			
			    			<div style="display:inline-block; min-width:100px;">
			    					<div class="form-group">
			    						<input type="button" name="cancel" value="취소" class="btn btn-info btn-block"/>
			    						
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