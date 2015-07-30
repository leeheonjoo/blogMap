<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>	
	<div class="container" style="width:100%;">
        <div class="row centered-form">
	        <div>
	        	<div class="panel panel-default">
	        		<div class="panel-heading">
				    	<h1 class="panel-title">입력된 이메일로 인증번호가 발송되었습니다.</h1>
				 	</div>
				 	
		 			<div class="panel-body"> 		  	
						<div class="row">
		    				<div class="col-xs-6 col-sm-6 col-md-6">
		    					<div class="form-group">
		               				<input type="text" id="email_confirm_num" class="form-control input-sm" placeholder="인증번호를 입력해주세요."/>
		    					</div>
		    				</div>
		    				
		    				<div style="min-width:100px">
			    					<div class="form-group">
			    						<input type="button" id="email_confirm_check_btn" style="width:100px;" value="확인" class="btn btn-info btn-block"/>
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