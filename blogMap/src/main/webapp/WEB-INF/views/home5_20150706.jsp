<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set var="root" value="${pageContext.request.contextPath}" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Home</title>
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
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>	
<script type="text/javascript" src="${root }/css/manager/script.js"></script>

<!-- JavaScript jQuery code from Bootply.com editor --> 
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

<script type="text/javascript">
	function layer_open(el) {
		var el='memberInfo';
		var temp = $('#' + el);
		var temp_bg = $('#' + el + '_bg');   //dimmed 레이어를 감지하기 위한 boolean 변수
		var temp_div = $('#' + el + '_div');
		var temp_btn = $('#' + el + '_btn');
		
		if (temp_bg) {
			temp_div.fadeIn(); //'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다. 
		} else {
			temp.fadeIn();
		}

		// 화면의 중앙에 레이어를 띄운다.
		if (temp.outerHeight() < $(document).height())
			temp.css('margin-top', '-' + temp.outerHeight() / 2 + 'px');
		else temp.css('top', '0px');
		if (temp.outerWidth() < $(document).width()) 
			temp.css('margin-left', '-' + temp.outerWidth() / 2 + 'px');
		else temp.css('left', '0px');

		temp_btn.click(function(e) {
			if (temp_bg) {
				temp_div.fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다. 
			} else {
				temp.fadeOut();
			}
			e.preventDefault();
		});

		temp_bg.click(function(e) { //배경을 클릭하면 레이어를 사라지게 하는 이벤트 핸들러
			temp_div.fadeOut();
			e.preventDefault();
		});
	}
</script>
<%-- <link rel="stylesheet" type="text/css" href="${root}/css/manager/layer.css" /> --%>
</head>
<body>
	<div class="condtainer-fluid">
		
		<!-- 관리자페이지 레이어 오픈 -->
		<a href="#" class="btn-example"	onclick="layer_open();return false;">관리자페이지</a>
		
		<div id="memberInfo_div" class="layer">
			<div id="memberInfo_bg" class="bg"></div>
			<div id="memberInfo"  class="pop-layer">
				<div class="pop-container">
					<div class="pop-conts">
						<!--content //-->
						<jsp:include page="manager/main.jsp" />
	
						<div class="btn-r">
							<a href="#" id="memberInfo_btn">Close</a>
						</div>
						<!--// content-->
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="container-fluid">
		<br/><br/>		
		<a data-toggle="modal" href="#ManagerMain" class="btn btn-primary">Manager</a>
		
		<!-- blogList -->
		<div class="modal fade" id="ManagerMain" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h5 class="modal-title">Modal Main</h5>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="manager/main.jsp"/>
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


		<div class="modal fade" id="blogListSub" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h5 class="modal-title">Modal Sub</h5>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
								<jsp:include page="manager/memberlist.jsp"/>
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
</body>
</html>