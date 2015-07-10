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
	 				//alert(responseData);
	 				
	 				if(responseData!="null"){
	 					 if (window.sessionStorage) {
	 		                sessionStorage.setItem('email', responseData);
	 		                var email = sessionStorage.getItem('email');
	 		                alert(email);
	 		                $("#loginCheck").text(email);
	 		            }
	 	
	 					 
	 					 
	 					 //$("#blogmap_login_bar").fadeOut();
	 				   	 //$("#blogmap_after_login").css("display","block");
	 					 alert("로그인 성공");
	 					 location.href="${root}/";
	 					
	
	 				}
	 				
	 				if(responseData=="null"){
	 					alert("아이디와 암호를 확인해주세요");
	 				
	 				}
				}
			});
		});
		
		
	});
	
	/* function layer_open1(el){
		var temp = $('#' + el);
		var temp_bg = $('#' + el + '_bg');   //dimmed 레이어를 감지하기 위한 boolean 변수
		var temp_div = $('#' + el + '_div');
		var temp_btn = $('#' + el + '_btn');

		if(temp_bg){
			temp_div.fadeIn();	//'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다. 
		}else{
			temp.fadeIn();
		}

		// 화면의 중앙에 레이어를 띄운다.
		if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
		else temp.css('top', '0px');
		if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
		else temp.css('left', '0px');

		temp.find('input.cbtn').click(function(e){
			temp_div.fadeOut();
			e.preventDefault();
		});
		
		temp_bg.click(function(e){	//배경을 클릭하면 레이어를 사라지게 하는 이벤트 핸들러
			temp_div.fadeOut();
			e.preventDefault();
		});
	} */
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
        FB.init({
          appId      : '371551513047868', // 앱 ID
          status     : true,          // 로그인 상태를 확인
          cookie     : true,          // 쿠키허용
          xfbml      : true           // parse XFBML
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
                        		alert(responseData);
                        		var data=JSON.parse(responseData);
                        		
                        		if(data!=null){
            	 					 if (window.sessionStorage) {
            	 		                sessionStorage.setItem('email', data.member_id);
            	 		                var email = sessionStorage.getItem('email');
            	 		                
            	 		                sessionStorage.setItem('jointype', data.member_jointype);
           	 		                	var jointype = sessionStorage.getItem('jointype');
            	 		                alert(email);
            	 		                alert(jointype);
            	 		                //$("input[name='member_id']").attr("value",sessionStorage.getItem('email'));
            	 		                $("#loginCheck").text(email);
            	 		                
            	 		            }
            	 					 
            	 					alert("로그인 성공");
            	 					
            	 					$("#blogmap_login_bar").fadeOut();
            	 					$("#blogmap_after_login").css("display","block");
            	 					
            	 					$("#blogmap_after_login").click(function(){
            	 						if(sessionStorage.getItem('jointype')=="0002"){
            	 							FB.logout();
            	 						}
            	 						sessionStorage.clear();
            	 						//$("#blogmap_after_login").css("display","none");
            	 						//$("#blogmap_login_bar").fadeIn();
            	 						location.href="${root}/";
            	 					
            	 					});
                        		}
                        	}
                        	
                        });
                        
                    }
                });    
                 
            } else if (response.status === 'not_authorized') {

            } else {
                
            }
            
            
        });
         FB.Event.subscribe('auth.login', function(response) {
        	 //$("#blogmap_login_bar").fadeOut();
			 //$("#blogmap_after_login").css("display","block");
			 
        	 document.location.reload();
        	 
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
        
 
   <!--  <fb:login-button show-faces="false" width="200" max-rows="1"></fb:login-button> -->
	<!-- <a href="#" onclick="FB.login();">[login]</a> -->
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
	
	<%-- <div class="container-fluid" style="border:1px solid black">                                                                                                                                                                                                                                                          
		<a href="#" class="btn-example" onclick="layer_open1('layerMain11');return false;">회원가입</a>
		
		<div id="layerMain11_div" class="layer">
			<div id="layerMain11_bg" class="bg"></div>
			<div id="layerMain11" class="pop-layer">
				<div class="pop-container">
					<div class="pop-conts">
						<!--content // -->
						<div class="btn-r">
							<input id="layerMain11_btn" type="button" class="cbtn" value="X"/>
						</div>

						<jsp:include page="register.jsp"/>
						<!--// content -->
					</div>
				</div>
			</div>
		</div>
	</div> --%>

<!-- 비밀번호찾기 -->
	
	<a data-toggle="modal" href="#blogmap_renew_pwd" class="btn btn-primary">비밀번호찾기</a>

	<%-- <div class="container-fluid" style="border:1px solid black">                                                                                                                                                                                                                                                          
		<a href="#" class="btn-example" onclick="layer_open1('layerMain22');return false;">비밀번호찾기</a>
		
		<div id="layerMain22_div" class="layer">
			<div id="layerMain22_bg" class="bg"></div>
			<div id="layerMain22" class="pop-layer">
				<div class="pop-container">
					<div class="pop-conts">
						<!--content // -->
						<div class="btn-r">
							<input id="layerMain11_btn" type="button" class="cbtn" value="X"/>
						</div>

						<jsp:include page="renew_pwd.jsp"/>
						<!--// content -->
					</div>
				</div>
			</div>
		</div>
	</div> --%>


</body>
</html>



