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
		if($("#member_register_id").val()!=""){
			$.ajax({
				type:'POST',
				url:'${root}/member/registerCheck.do',
				data:{
					member_id:$("#member_register_id").val(),
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseCheckData){
					alert(responseCheckData);
					
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
		if($("#member_register_id_hidden").val()!=""){//아이디 인증햇을때
			
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
					alert(responseData);
					
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
			alert("아이디 중복체크와 인증을 해주세요");
		} 
	});
	
	/* $("#register").click(function(){
		$.ajax({
			type:'POST',
			url:'${root}/member/registerCheck.do',
			data:{
				member_id:$("input[name='member_id']").val(),
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseCheckData){
				alert(responseCheckData);
				
				if(responseCheckData=="0"){
					$.ajax({
						type:'POST',
						
						url:'${root}/member/register.do',
						data:{
							member_id:$("input[name='member_id']").val(),
							member_pwd:$("input[name='member_pwd']").val(),
							member_name:$("input[name='member_name']").val()
						},
						contentType:'application/x-www-form-urlencoded;charset=UTF-8',
						success:function(responseData){
							alert(responseData);
							
							if(responseData=="1"){
								alert("회원가입완료");
								location.href="${root}/1";
							}
							
							if(responseData!="1"){
								alert("회원가입실패");
							}
						}
					});
				}
				
				if(responseCheckData=="1"){
					alert("아이디중복!");
				}
			}
		});
	}); */
});

/* function layer_open(el){
	var temp = $('#' + el);
	var temp_bg = $('#' + el + '_bg');   //dimmed 레이어를 감지하기 위한 boolean 변수
	var temp_div = $('#' + el + '_div');
	var temp_btn = $('#' + el + '_btn');
	
	// layer fadeIn
	if(temp_bg){
		temp_div.fadeIn();	//'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다. 
	}else{
		temp.fadeIn();
	}

	// layer를 화면의 중앙에 위치시킨다.
	if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
	else temp.css('top', '0px');
	if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
	else temp.css('left', '0px');

	// layer fadeOut : 종료버튼 클릭시
	temp_btn.click(function(e){
		if(temp_bg){
			temp_div.fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다. 
		}else{
			temp.fadeOut();
		}
		e.preventDefault();
	});
	
	// layer fadeOut : 바탕화면 클릭시
	temp_bg.click(function(e){
		temp_div.fadeOut();
		e.preventDefault();
	});
} */


function email_confirm_check(confirm_num){  //이메일 인증 확인버튼
	alert(confirm_num);
	$("#email_confirm_check_btn").click(function(){
		alert("aa");
		if($('#email_confirm_num').val()==confirm_num){
			$("div[id='blogmap_email_confirm'].modal").modal('hide');
			alert("인증완료!");
			$("#member_register_id_hidden").val($('#member_register_id').val());
			$('#member_register_id').attr("disabled","disabled");
			
		}else{
			alert("인증번호가 맞지 않습니다.");
		} 
	});
}
</script>
</head>
<body>
	
	<div>
		아이디 <input type="text" id="member_register_id"/>
		<input type="button" id="member_id_check" value="아이디 중복체크"/>
		<input type="button" id="member_id_confirm" value="아이디(email) 인증"/>
		<input type="hidden" id="member_register_id_hidden"/>
	</div>
	
	<div>
		비밀번호	<input type="password" name="member_pwd"/>
	</div>
	
	<div>
		비밀번호 확인 <input type="password" name="member_pwd_check"/>
	</div>
	<div>
		성명 <input type="text" name="member_name"/>
	</div>
	
	<input id="register" type="button" value="가입"/>
	
	
	
	<%-- <!-- 중복확인 레이어(사용가능) -->
	<div class="container-fluid">

		<!-- 블로그 검색 레이어 -->
		<div id="registerCheckOk_div" class="layer">
			<div id="registerCheckOk_bg" class="bg"></div>
			<div id="registerCheckOk" class="pop-layer">
				<div class="pop-container">
					<div class="pop-conts">
						<!--content // -->
						<div class="btn-r">
							<input id="registerCheckOk_btn" type="button" class="cbtn" value="X"/>
						</div>
						
						<!-- 블로그 게시글 메인 -->
						<jsp:include page="registerCheckOk.jsp"/>
						<!--// content -->
					</div>
				</div>
			</div>
		</div>
	</div> --%>
	
	<%-- <!-- 중복확인 레이어(중복) -->
	<div class="container-fluid">
	
		<!-- 블로그 검색 레이어 -->
		<div id="registerCheckNo_div" class="layer">
			<div id="registerCheckNo_bg" class="bg"></div>
			<div id="registerCheckNo" class="pop-layer">
				<div class="pop-container">
					<div class="pop-conts">
						<!--content // -->
						<div class="btn-r">
							<input id="registerCheckNo_btn" type="button" class="cbtn" value="X"/>
						</div>
						
						<!-- 블로그 게시글 메인 -->
						<jsp:include page="registerCheckNo.jsp"/>
						<!--// content -->
					</div>
				</div>
			</div>
		</div>
	</div> --%>
	
	<!-- 이메일 인증번호 발송 레이어 -->	
	<%-- <div class="container-fluid">
		
		<!-- 블로그 검색 레이어 -->
		<div id="email_confirm_div" class="layer">
			<div id="email_confirm_bg" class="bg"></div>
			<div id="email_confirm" class="pop-layer">
				<div class="pop-container">
					<div class="pop-conts">
						<!--content // -->
						<div class="btn-r">
							<input id="email_confirm_btn" type="button" class="cbtn" value="X"/>
						</div>
						
						<!-- 블로그 게시글 메인 -->
						<jsp:include page="email_confirm.jsp"/>
						<!--// content -->
					</div>
				</div>
			</div>
		</div>
	</div> --%>
</body>
</html>