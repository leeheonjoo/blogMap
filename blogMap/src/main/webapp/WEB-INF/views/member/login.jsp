<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="root" value="${pageContext.request.contextPath }"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	$(document).ready(function(){
		$("#login_btn").click(function(){
			$.ajax({
				type:'POST',
				url:'${root}/member/login.do',
				data:{
					id:$("#member_login_id").val(),
					password:$("#member_login_password").val()					
				},
				
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){  
	 				var loginData=JSON.parse(responseData);
	 				
	 				if(loginData!=null){
	 					if(loginData.member_id==null){
	 						if (window.sessionStorage) {
		 		                sessionStorage.setItem('email', loginData.manager_id);
		 		                var email = sessionStorage.getItem('email');
		 		                sessionStorage.setItem('manager_yn',loginData.manager_yn);
		 		                //alert(sessionStorage.getItem('manager_yn'));
		 		            }
	 					}else if(loginData.manager_id==null){
	 						if (window.sessionStorage) {
		 		                sessionStorage.setItem('email', loginData.member_id);
		 		                var email = sessionStorage.getItem('email');
		 		            }
	 						
	 					}	 
	 					 //$("#blogmap_login_bar").fadeOut();
	 				   	 //$("#blogmap_after_login").css("display","block");
	 					 alert("로그인 성공");
	 					 location.href="${root}/";
	 				}
	 				
	 				if(loginData==null){
	 					alert("아이디와 암호를 확인해주세요");
	 				
	 				}
				}
			});
		});

	});
</script>
</head>
<body>
	
	<!-- <span>
	<input type="text" name="id"/><br/>
	<input type="password" name="password"/>
	</span>
	
	<span>
	<input type="button" id="login" value="로그인"/>
	</span>
	
	<div id="loginCheck"></div> -->
	
	
    <script>

      window.fbAsyncInit = function() {
    	var email = null;  
   		var jointype = null;
   		
        FB.init({
          appId      : '371551513047868', // 앱 ID
          status     : true,          // 로그인 상태를 확인
          cookie     : true,          // 쿠키허용
          xfbml      : true,        // parse XFBML
          oauth  : true // enable OAuth 2.0
        });
        
        FB.getLoginStatus(function(response) {
        	 
            if (response.status === 'connected') {
                
                FB.api('/me', function(user) {
                    if (user) {
                     /*   var image = document.getElementById('image');
                        image.src = 'http://graph.facebook.com/' + user.id + '/picture';*/
                        
                        var name = document.getElementById('name');
                        name.innerHTML = user.name
                        var id = document.getElementById('id');
                        id.innerHTML = user.email
                        
                        $.ajax({
                        	type:'POST',
                        	url:'${root}/member/fbLogin.do',
                        	data:{
                        		member_id:user.email,
                        		member_name:user.name
                        	},
                        	contentType:'application/x-www-form-urlencoded;charset=UTF-8',
                        	success:function(responseData){

                        		if(sessionStorage.getItem('email') == null){
                        			var data=JSON.parse(responseData);
                        			
                        			if(data.member_jointype=="0001"&&data.member_pwd!="undefined"){
                            			alert("기존에 등록한 아이디가 있습니다.");
                            			FB.logout();
                            			return false;
                            			
                            		}else{
                            			if(data!=null){
    	               	 					if (window.sessionStorage) {
    	               	 		                sessionStorage.setItem('email', data.member_id);
    	               	 		                email = sessionStorage.getItem('email');
    	               	 		                
    	               	 		                sessionStorage.setItem('jointype', data.member_jointype);
    	              	 		                	jointype = sessionStorage.getItem('jointype');
    	               	 		                //alert(email);
    	               	 		                //alert(jointype);
    	               	 		                $("#loginCheck").text(email);
    	               	 		            }
    	               	 					
    	                           		}
                            		}
                        			alert("로그인 성공");
                                    document.location.reload();
                                 }
                        		
                        	}
                        	
                        });
                        
                    }
                });    
                 
            } else if (response.status === 'not_authorized') {
				//alert("aa");
            } else {
                //alert("bb");
            }
            
            
        },{scope: 'public_profile,email'});
         FB.Event.subscribe('auth.login', function(response) {
			 //alert("이전:"+email);
			 //alert("이전:"+jointype);
        	 document.location.reload();
        	 //alert("이후:"+email);
			// alert("이후:"+jointype);
        }); 
         
      };
    
      // Load the SDK Asynchronously
       (function(d){
         var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
         if (d.getElementById(id)) {return;}
         js = d.createElement('script'); js.id = id; js.async = true;
         js.src = "//connect.facebook.net/ko_KR/all.js";
         ref.parentNode.insertBefore(js, ref);
       }(document));  
</script> 
        

	<!-- 페북 로그인시 사용자 정보 출력 -->  
    <p>사용자정보 출력</p>
    <div align="left">
     <!--   <img id="image"/>-->
        <div id="name"></div>
        <div id="id"></div>
    </div>

	<!-- 로그아웃 -->
	<a href="#" onclick="FB.logout();">[logout]</a><br>
        
	<!-- 회원가입 -->
	<br/><br/>
	
	<a data-toggle="modal" href="#blogmapRegister" class="btn btn-primary">회원가입</a>

	<!-- 비밀번호찾기 -->
	<a data-toggle="modal" href="#blogmap_renew_pwd" class="btn btn-primary">비밀번호찾기</a>
</body>
</html>