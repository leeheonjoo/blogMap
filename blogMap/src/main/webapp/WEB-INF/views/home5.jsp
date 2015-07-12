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
<script type="text/javascript" src="${root}/css/manager/script.js"></script>

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

<%-- <link rel="stylesheet" type="text/css" href="${root}/css/manager/layer.css" /> --%>
</head>
<body>
	<div class="container-fluid">
		<br/><br/>		
		<a data-toggle="modal" href="#ManagerMain" class="btn btn-primary">Manager</a>
	<!-- ManagerMain (관리자페이지 메인)-->
		<div class="modal fade" id="ManagerMain" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h5 class="modal-title">Manager Main</h5>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<%--<jsp:include page="manager/main.jsp"/>--%>
							<jsp:include page="manager/managerMain_test.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<!-- <a href="#" class="btn btn-primary">Save changes</a> -->
					</div>
				</div>
		    </div>
		</div>

	<!-- 제휴업체 상세조회 (관리자페이지 - 제휴업체 페이지 제휴업체 상세 페이지)-->
		<div class="modal fade" id="partnerDetail" data-backdrop="static">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h5 class="modal-title">제휴업체</h5>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="manager/partnerDetail.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<!-- <a href="#" class="btn btn-primary">Save changes</a> -->
					</div>
			   </div>
			</div>
		</div>
		
	 <!-- partnerList (관리자페이지 - 제휴업체 페이지)  -->
		<%-- <div class="modal fade" id="partnerInfo" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h5 class="modal-title">PartnerInfo</h5>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="manager/partnerList.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<!-- <a href="#" class="btn btn-primary">Save changes</a> -->
					</div>
			   </div>
			</div>
		</div> --%>
		
		
		
		
	</div>
</body>
</html>