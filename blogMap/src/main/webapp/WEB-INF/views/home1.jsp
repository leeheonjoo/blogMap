<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set var="root" value="${pageContext.request.contextPath}"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/> 
<title>BlogMAP</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>

<!-- CDN 서비스에서 stylesheet를 불러옵니다 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"/>					<!-- bootstrap stylesheet 로드 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css"/>				<!-- bootstrap 확장 테마 stylesheet 로드 -->

<style>
	.modal-lg{
		width: auto;
		margin: 1% 1% 0px 1%;
	}
</style>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<!-- 부트스트랩 자바스크립트 파일 로드 -->    
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>         
<script type="text/javascript">
/* function layer_open(el){
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

	temp_btn.click(function(e){
		if(temp_bg){
			temp_div.fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다. 
		}else{
			temp.fadeOut();
		}
		e.preventDefault();
	});
	
	temp_bg.click(function(e){	//배경을 클릭하면 레이어를 사라지게 하는 이벤트 핸들러
		temp_div.fadeOut();
		e.preventDefault();
	});
} */
	$(function(){    //세션 등록시
		if(sessionStorage.getItem('email')!=null){
			$("b").text("로그인됨");
		}
	});
	
	function logout(){	//세션비우기
		sessionStorage.clear();
	}
</script>
<%-- <link rel="stylesheet" type="text/css" href="${root}/css/layer.css"/>  --%>
<script type='text/javascript'>
	$(document).ready(function() {
		$('.modal').on('hidden.bs.modal', function( event ) {
			$(this).removeClass( 'fv-modal-stack' );
			$('body').data( 'fv_open_modals', $('body').data( 'fv_open_modals' ) - 1 );
		});

		$( '.modal' ).on( 'shown.bs.modal', function ( event ) {
			 // keep track of the number of open modals
			 if ( typeof( $('body').data( 'fv_open_modals' ) ) == 'undefined' ){
			   $('body').data( 'fv_open_modals', 0 );
			 }
	                   
			 // if the z-index of this modal has been set, ignore.
	                        
			if ( $(this).hasClass( 'fv-modal-stack' ) ){
				return;
			}
	                   
			$(this).addClass( 'fv-modal-stack' );
			
			$('body').data( 'fv_open_modals', $('body').data( 'fv_open_modals' ) + 1 );
			
			$(this).css('z-index', 1040 + (10 * $('body').data( 'fv_open_modals' )));
			
			$( '.modal-backdrop' ).not( '.fv-modal-stack' ).css( 'z-index', 1039 + (10 * $('body').data( 'fv_open_modals' )));
			
			$( '.modal-backdrop' ).not( 'fv-modal-stack' ).addClass( 'fv-modal-stack' );
		});
	});
</script>
</head>
<body>
	<!-- 로그인 -->
	<div class="container-fluid">
		<br/><br/>		
		<a data-toggle="modal" href="#blogmapLogin" class="btn btn-primary">blogMapLogin</a>
		
		<!-- login -->
		<div class="modal fade" id="blogmapLogin" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/login.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 회원가입 -->
		<div class="modal fade" id="blogmapRegister" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/register.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 비밀번호중복확인(사용가능) -->
		<div class="modal fade" id="blogmap_registerCheckOk" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/registerCheckOk.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 비밀번호중복확인(사용불가능) -->
		<div class="modal fade" id="blogmap_registerCheckNo" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/registerCheckNo.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 비밀번호 찾기 -->
		<div class="modal fade" id="blogmap_renew_pwd" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/renew_pwd.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 메일전송 확인 -->
		<div class="modal fade" id="blogmap_email_confirm" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/email_confirm.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
	</div>
	
	
	<!-- 로그인확인 -->
	<b id="loginOk"></b>
	<!-- 로그아웃 -->
	<input type="button" name="logout" value="로그아웃" onclick="javascript:logout()"/>
	<br/><br/><br/>
	
	<!-- 마이페이지 -->
	<div class="container-fluid">
	    <br/><br/>		
		<a data-toggle="modal" href="#blogmap_myPage" class="btn btn-primary">blogMapList</a>
		
		<!-- 마이페이지 -->
		<div class="modal fade" id="blogmap_myPage" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/myPage.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 수정 -->
		<div class="modal fade" id="blogmap_myPageUpdate" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/myPageUpdate.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 탈퇴 -->
		<div class="modal fade" id="blogmap_myPageDelete" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/myPageDelete.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
	</div>
	
	<!-- 로그인 -->
	<%-- <div class="container-fluid" style="border:1px solid black">                                                                                                                                                                                                                                                          
		<a href="#" class="btn-example" onclick="layer_open('login_layer');return false;">BlogList</a>
		
		<div id="login_layer_div" class="layer">
			<div id="login_layer_bg" class="bg"></div>
			<div id="login_layer" class="pop-layer">
				<div class="pop-container">
					<div class="pop-conts">
						<!--content // -->
						<div class="btn-r">
							<input id="login_layer_btn" type="button" class="cbtn" value="X"/>
						</div>

						<jsp:include page="member/login.jsp"/>
						<!--// content -->
					</div>
				</div>
			</div>
		</div>
	</div> --%>
	
	
	
	<!-- myPage -->
	<%-- <div class="container-fluid" style="border:1px solid black">                                                                                                                                                                                                                                                          
		<a href="#" class="btn-example" onclick="layer_open('myPage_layer');return false;">BlogList</a>
		
		<div id="myPage_layer_div" class="layer">
			<div id="myPage_layer_bg" class="bg"></div>
			<div id="myPage_layer" class="pop-layer">
				<div class="pop-container">
					<div class="pop-conts">
						<!--content // -->
						<div class="btn-r">
							<input id="myPage_layer_btn" type="button" class="cbtn" value="X"/>
						</div>

						<jsp:include page="member/myPage.jsp"/>
						<!--// content -->
					</div>
				</div>
			</div>
		</div>
	</div> --%>
	
</body>
</html>