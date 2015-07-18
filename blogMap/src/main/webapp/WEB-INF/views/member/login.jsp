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
	 				var loginData=JSON.parse(responseData);
	 				
	 				if(loginData!=null){
	 					alert("aa");
	 					if(loginData.member_id!="undefined"){
	 						if (window.sessionStorage) {
		 		                sessionStorage.setItem('email', loginData.member_id);
		 		                var email = sessionStorage.getItem('email');
		 		            }
	 					}else if(loginData.manager_id!="undefined"){
	 						if (window.sessionStorage) {
		 		                sessionStorage.setItem('email', loginData.manager_id);
		 		                var email = sessionStorage.getItem('email');
		 		                sessionStorage.setItem('	',loginData.manager_yn);
		 		               
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
    /* function checkLoginState() {
        FB.getLoginStatus(function(response) {
          statusChangeCallback(response);
        });
      } */

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
       
        //---
       /*   (function(d){

            var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}

            js = d.createElement('script'); js.id = id; js.async = true;

            js.src = "//connect.facebook.net/en_US/all.js";

            d.getElementsByTagName('head')[0].appendChild(js);

          }(document));   //기본적으로 페이스북과 연동하는 세팅 입니다. 같이 써주면 됩니다.
		
        

        	 

        	 

        	FB.login(function(response) {

        	if (response.authResponse) {
        		alert("a");
        		checkLoginState();
        	     // callback 영역입니다. 자신의 브라우저가 페북에 연동되면 여기로직을 처리 하게 되죠

        	} else {
        		alert("b");
        	     //오류가 났거나 연동이 실패 했을때 처리 하는부분..... 

        	       }

        	     }
				
        	 , {scope: "public_profile,email"} 

        	);
 */
        	
    
          
       //---
		
		
          
        
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
                        			alert("로그인 성공");
                                    document.location.reload();
                                 }
                        		
                        		
                        		//alert(responseData);
                        		var data=JSON.parse(responseData);
                        		//alert("jointype:"+data.member_jointype);
                        		//alert("member_pwd:"+data.member_pwd);
                        		if(data.member_jointype=="0001"&&data.member_pwd!="undefined"){
                        			alert("기존에 등록한 아이디가 있습니다.");
                        			FB.logout();
                        		}else{
                        			if(data!=null){
	               	 					if (window.sessionStorage) {
	               	 		                sessionStorage.setItem('email', data.member_id);
	               	 		                email = sessionStorage.getItem('email');
	               	 		                
	               	 		                sessionStorage.setItem('jointype', data.member_jointype);
	              	 		                	jointype = sessionStorage.getItem('jointype');
	               	 		                //alert(email);
	               	 		                //alert(jointype);
	               	 		                //$("input[name='member_id']").attr("value",sessionStorage.getItem('email'));
	               	 		                $("#loginCheck").text(email);
	               	 		               
	               	 		            }
	               	 					 
	               	 					
	               	 					
	               	 					$("#blogmap_before_login span").remove();
	               	 					$("#blogmap_main_myPage").css("display","inline-block");
	               	 					$("#blogmap_before_login").attr("data-toggle","");
	               	 					$("#login_text").text("Logout");
	               	 					
	               	 					if(sessionStorage.getItem('jointype')!=null){
	               	 						$("#myPage_update_btn").css("display","none");
	               	 						$("#myPage_delete_btn").css("display","none");
	               	 						$("#myPage_fb_delete_btn").show();
	               	 					}
	               	 					
	               	 					$("#blogmap_main_myPage").click(function(){
	               	 						$.ajax({
	               	 							type:'POST',
	               	 							url:"${root}/member/myPage.do",
	               	 							data:{
	               	 								member_id:sessionStorage.getItem("email")
	               	 								//member_id:"kimjh112339@naver.com"
	               	 							},
	               	 							contentType:'application/x-www-form-urlencoded;charset=UTF-8',
	               	 							success:function(responseData){
	               	 								//alert(responseData);
	               	 							 	var data=responseData.split("|");
	               	 								
	               	 							 	memberData=JSON.parse(data[0])
	               	 								
	               	 								$("#myPage_member_id").text(memberData.member_id);
	               	 								//$("#myPage_member_id").attr("disabled","disabled");
	               	 								
	               	 								$("#myPage_member_name").text(memberData.member_name);
	               	 								//$("#myPage_member_name").attr("disabled","disabled");
	               	 								
	               	 								$("#myPage_member_joindate").text(memberData.member_joindate);
	               	 								//$("#myPage_member_joindate").attr("disabled","disabled");
	               	 								
	               	 								$("#myPage_member_point_total").text(data[1]+"points");
	               	 								/* $("#myPage_member_point").val(data[1]);
	               	 								$("#myPage_member_point").attr("disabled","disabled"); */
	               	 								
	               	 								$("#myPage_member_point_total").click(function(){
	               	 									$(".abc").attr("class","abc");
	               	 									$("#bbb").attr("class","active");
	               	 									
	               	 								});
	               	 								
	               	 								if(data[1]>20){
	               	 									$("#myPage_member_rate").text("새싹");
	               	 								}
	               	 								
	               	 								$("#myPage_member_board_total").text(data[2]+" EA");
	               	 								//$("#myPage_member_boardCount").attr("disabled","disabled");
	               	 								$("#myPage_member_board_total").click(function(){
	               	 									$(".abc").attr("class","abc");
	               	 									$("#ccc").attr("class","active");
	               	 									
	               	 								});
	               	 								
	               	 								$("#myPage_member_favorite_total").text(data[3]+ " EA");
	               	 								//$("#myPage_member_favoriteCount").attr("disabled","disabled");
	               	 								$("#myPage_member_favorite_total").click(function(){
	               	 									$(".abc").attr("class","abc");
	               	 									$("#ddd").attr("class","active");
	               	 									
	               	 								});
	               	 								
	               	 								$("#myPage_member_coupon_total").text(data[4]+ " EA");
	               	 								//$("#myPage_member_couponCount").attr("disabled","disabled");
	               	 								$("#myPage_member_coupon_total").click(function(){
	               	 									$(".abc").attr("class","abc");
	               	 									$("#eee").attr("class","active");
	               	 									
	               	 								});
	               	 							}
	               	 						});
	               	 					});
	               	 					
	               	 					if($("#login_text").text()=="Logout"){
	               	 						$("#blogmap_before_login").click(function(){
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
        	 //$("#blogmap_login_bar").fadeOut();
			 //$("#blogmap_after_login").css("display","block");
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



