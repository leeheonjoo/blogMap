<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set var="root" value="${pageContext.request.contextPath}"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Home</title>
<!-- CDN 서비스에서 부트스트랩 스타일시트를 불러옵니다 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"/>					<!-- bootstrap stylesheet 로드 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css"/>				<!-- bootstrap 확장 테마 stylesheet 로드 -->	
<style>
	.modal-lg{
		width: auto;
		margin: 1% 1% 0px 1%;
	}
</style>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>												<!-- jquery javascript를 로드 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>						<!-- bootstrap javascript를 로드 -->
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
	<div class="container-fluid">
		<br/><br/>		
		<a id="mainMessageLink" data-toggle="modal" href="#mainMessage" class="btn btn-primary">정기창 메시지</a>

			<!-- blogList -->
		<div class="modal fade" id="mainMessage" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">BlogMap</h4>
					</div>
					<div class="modal-body">
						<jsp:include page="message/mainMessage.jsp"/>
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
	
	<!-- 메시지 조회 창 -->
	<div class="modal fade" id="messageRead" data-backdrop="static">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h5 class="modal-title">BlogMap</h5>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="message/messageRead.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a data-toggle="modal" href="#messageDelete" class="btn btn-primary btn-delete">메시지 삭제</a>
					</div>
			   </div>
			</div>
		</div>
		
		<!-- 메시지 삭제 창 -->
		<div class="modal fade" id="messageDelete" data-backdrop="static">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h5 class="modal-title">BlogMap</h5>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="message/messageDelete.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">취소</a>
						<a class="btn btn-primary delete_btn" onclick="msgDelete()">메시지 삭제</a>
					</div>
			   </div>
			</div>
		</div>
	</div>
</body>
</html>