<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="root" value="${pageContext.request.contextPath }"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(document).ready(function(){
	$("#member_id_confirm").hide();
	
	$("#member_id_check").click(function(){
		var emailCheck = $("#member_register_id").val();  
		var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;//이메일 유효성검사
		
		if(regex.test(emailCheck) === false) {  
		    alert("잘못된 이메일 형식입니다.");  
		    return false;  
		} 
		
		if($("#member_register_id").val()!=""){
			$.ajax({
				type:'POST',
				url:'${root}/member/registerCheck.do',
				data:{
					member_id:$("#member_register_id").val(),
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseCheckData){
					//alert(responseCheckData);
					
					if(responseCheckData=="0"){    //아이디 중복 안됨
 						$("div[id='blogmap_registerCheckOk'].modal").modal();
					}
					
					if(responseCheckData=="1"){		//아이디 중복
						$("div[id='blogmap_registerCheckNo'].modal").modal();
					}
				}
			});
		}else{
			alert("아이디를 입력해주세요");
		}	
	});
	
	
	$("#member_id_confirm").click(function(){
		$("div[id='blogmap_email_confirm'].modal").modal();
		
		$.ajax({
			type:'post',
			url:'${root}/member/email_confirm.do',
			data:{
				member_id:$('#member_register_id').val()
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				//alert(responseData);
				email_confirm_check(responseData);
			}
		});
	});
	
	
	$("#register").click(function(){
		var RegexName = /^[가-힣]{2,5}$/; //이름 유효성 검사 2~5자 사이
		
		if ( !RegexName.test($.trim($("input[name='member_name']").val())) )
		{
			alert("이름을 2~5자로 입력해주세요.");
			return false;
		}
		
		if ($("input[name='member_pwd']").val().length<6 || $("input[name='member_pwd']").val().length>12){
			 alert ("비밀번호를 6~12자까지 입력해주세요.");
			 return false;
		}
		
		if($("#member_register_id_hidden").val()!=""){//아이디 인증햇을때
			if($("input[ame='member_pwd']").val()!=""&&$("input[name='member_name']").val()!=""){
				if($("input[name='member_pwd']").val()==$("input[name='member_pwd_check']").val()){
					$.ajax({
						type:'POST',
						url:'${root}/member/register.do',
						data:{
							member_id:$("#member_register_id_hidden").val(),
							member_pwd:$("input[name='member_pwd']").val(),
							member_name:$("input[name='member_name']").val()
						},
						contentType:'application/x-www-form-urlencoded;charset=UTF-8',
						success:function(responseData){
							//alert(responseData);
							if(responseData=="1"){
								alert("회원가입완료");
								location.href="${root}/";
							}
							
							if(responseData!="1"){
								alert("회원가입실패");
							}
						}
					});
				}else{
					alert("비밀번호가 일치하지않습니다.");
				}
			}else{
				alert("비밀번호와 이름을 입력해주세요.");
			}
		}else{
			alert("아이디 중복체크와 인증을 해주세요");
		} 
	});
});

function email_confirm_check(confirm_num){  //이메일 인증 확인버튼
	//alert(confirm_num);
	$("#email_confirm_check_btn").click(function(){
		if($('#email_confirm_num').val()==confirm_num){
			$("div[id='blogmap_email_confirm'].modal").modal('hide');
			alert("인증완료!");
			$("#member_register_id_hidden").val($('#member_register_id').val());
			$('#member_register_id').attr("disabled","disabled");
			
		}else{
			alert("인증번호가 맞지 않습니다.");
		} 
	});
	
	$("#fb_delete_email_confirm_check_btn").click(function(){
		 if($("#fb_delete_email_confirm_num").val()==confirm_num){
				$.ajax({
					type:"post",
					url:"${root}/member/myPage_fb_delete.do",
					data:{
						member_id:sessionStorage.getItem('email')
					},
					contentType:'application/x-www-form-urlencoded;charset=UTF-8',
					success:function(responseData){
						//alert(responseData);
						if(responseData=="1"){
							alert("삭제되었습니다.");
							sessionStorage.clear();
							FB.logout();
							
						}else{
							alert("삭제실패");
						}
					}	
				});
			}else{
				alert("인증번호가 맞지 않습니다.");
			}
	});
}
</script>
</head>
<body>
	<div class="container" style="width:100%;">
        <div class="row centered-form">
        <div>
        	<div class="panel panel-default">
        		<div class="panel-heading">
			    		<h3 class="panel-title">Please sign up for BlogMap</h3>
			 			</div>
			 			<div class="panel-body">
			    		<!-- <form role="form"> -->
			  	
							<div class="row">
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
			               				<input type="email" id="member_register_id" class="form-control input-sm" placeholder="Email Address" required autofocus/>
			    					</div>
			    				</div>
			    				
			    				&nbsp;&nbsp;
			    				<div style="display:inline-block; min-width:80px; margin-left:3px;">
			    					<div class="form-group">
			    						<input type="button" id="member_id_check" value="중복확인" class="btn btn-info btn-block"/>
			    						<!-- <button id="member_id_check" class="btn btn-default">중복확인</button> -->
			    					</div>
			    				</div>&nbsp;&nbsp;&nbsp;&nbsp;
			    				
			    				<div style="display:inline-block; min-width:80px;">
			    					<div class="form-group">
			    						<input type="button" id="member_id_confirm" value="이메일인증" class="btn btn-info btn-block"/>
			    						<!-- <button id="member_id_confirm" class="btn btn-default">이메일인증</button> -->
			    					</div>
			    				</div>
			    				
			    				<input type="hidden" id="member_register_id_hidden"/>
			    			</div>
			    			
			    			<div class="row">
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
			    						<input type="password" name="member_pwd" class="form-control input-sm" placeholder="Password"/>
			    					</div>
			    				</div>
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
			    						<input type="password" name="member_pwd_check" class="form-control input-sm" placeholder="Confirm Password"/>
			    					</div>
			    				</div>
			    			</div>
			    			
			    			<div class="row">
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
			                			<input type="text" name="member_name" class="form-control input-sm" placeholder="Name"/>
			    					</div>
			    				</div>
			    			</div>
			    			
			    			<input type="button" id="register" value="Register" class="btn btn-info btn-block"/>
			    		
			    		<!-- </form> -->
			    	</div>
	    		</div>
    		</div>
    	</div>
    </div>
</body>
</html>