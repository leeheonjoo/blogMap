<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set var="root" value="${pageContext.request.contextPath}"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<!-- META TAG 설정 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">					<!-- IE 브라우져일경우 기본 호홤모드를 Edge로 설정합니다 -->
<meta name="viewport" content="width=device-width, initial-scale=1">	<!-- 문서 로드시 기본 화면 비율을 1.0으로 설정합니다 -->
<meta name="description" content="블로그맵">								<!-- 이 문서에 대한 자세한 설명을 기록합니다. 검색엔진 검색시 노출 됩니다. -->
<meta name="keywords" content="BLOGMAP, 블로그맵">							<!-- 이 문서와 연관 -->
<title>BLOG MAP</title>

<!-- CDN 서비스에서 stylesheet를 불러옵니다 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"/>					<!-- bootstrap stylesheet 로드 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css"/>				<!-- bootstrap 확장 테마 stylesheet 로드 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.7.3/css/bootstrap-select.css"/>	<!-- bootstrap-select stylesheet 로드 -->
<style>
	.modal-lg{
		width: auto;
		margin: 0px 10px 0px 10px;
	}
</style>

<!-- IE9 미만에서 HTML5 엘리먼트(html5shiv) 및 미디어쿼리(respond)를 사용할수 있게 합니다 -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>		
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>			 
<![endif]-->

<!-- CDN 서비스에서 javascript를 불러옵니다 -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>												<!-- jquery javascript를 로드 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>						<!-- bootstrap javascript를 로드 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.7.3/js/bootstrap-select.js"></script>	<!-- bootstrap-select javascript를 로드 -->
<script src="https://netdna.bootstrapcdn.com/twitter-bootstrap/2.0.4/js/bootstrap-dropdown.js"></script>		<!-- bootstrap-dropdown javascript를 로드 -->

</head>
<body>
	<div class="container-fluid">
		<br/>
<!-- 		<button type="button" class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target="#write_pop">업체등록</button> -->
		<a data-toggle="modal" href="#myModal" class="btn btn-primary">modal</a>	

		<!-- blogListMain 레이어 시작-->
		<div class="modal fade" id="myModal">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
						<h4 class="modal-title">블로그 검색</h4>
					</div>
					
					<div class="modal-body">
						<jsp:include page="board/blogListMain.jsp"/>
					</div>
	
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
					</div>
	
				</div>
			</div>
		</div>
		<!-- blogListMain 레이어 종료-->
	</div>
<script type="text/javascript">
	$(document).ready(function() {
	
	$('#openBtn').click(function(){
		$('#myModal').modal({show:true})
	});
	
	
	$('.modal').on('hidden.bs.modal', function( event ) {
	        $(this).removeClass( 'fv-modal-stack' );
	        $('body').data( 'fv_open_modals', $('body').data( 'fv_open_modals' ) - 1 );
	        });
	
	
	$( '.modal' ).on( 'shown.bs.modal', function ( event ) {
	           
	           // keep track of the number of open modals
	           
	           if ( typeof( $('body').data( 'fv_open_modals' ) ) == 'undefined' )
	           {
	             $('body').data( 'fv_open_modals', 0 );
	           }
	           
	             
	           // if the z-index of this modal has been set, ignore.
	                
	        if ( $(this).hasClass( 'fv-modal-stack' ) )
	                {
	                return;
	                }
	           
	        $(this).addClass( 'fv-modal-stack' );
	
	        $('body').data( 'fv_open_modals', $('body').data( 'fv_open_modals' ) + 1 );
	
	        $(this).css('z-index', 1040 + (10 * $('body').data( 'fv_open_modals' )));
	
	        $( '.modal-backdrop' ).not( '.fv-modal-stack' )
	                .css( 'z-index', 1039 + (10 * $('body').data( 'fv_open_modals' )));
	
	
	        $( '.modal-backdrop' ).not( 'fv-modal-stack' )
	                .addClass( 'fv-modal-stack' ); 
	
	         });
	
	});
</script>
</body>
</html>