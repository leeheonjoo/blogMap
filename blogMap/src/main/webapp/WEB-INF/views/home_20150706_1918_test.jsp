<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.7.3/css/bootstrap-select.css"/>	<!-- bootstrap-select stylesheet 로드 -->
<style>
	.modal-lg{
		width: auto;
		margin: 1% 1% 0px 1%;
	}
</style>

<!--[if lt IE 9]>
	<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
        
<!-- CDN 서비스에서 javascript를 불러옵니다 -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>												<!-- jquery javascript를 로드 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>						<!-- bootstrap javascript를 로드 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.7.3/js/bootstrap-select.js"></script>	<!-- bootstrap-select javascript를 로드 -->
<script src="https://netdna.bootstrapcdn.com/twitter-bootstrap/2.0.4/js/bootstrap-dropdown.js"></script>		<!-- bootstrap-dropdown javascript를 로드 -->
</head>
<!-- modal -->
<script type="text/javascript">
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
$(function(){
	$("#popbutton").click(function(){
		$('#testtest div.modal').modal({remote : '${root}/board/blogListMain1.do'});
	})
})
</script>
<body>
	<div class="container-fluid">
		<br/><br/>		
		<a data-toggle="modal" href="#blogListMain" class="btn btn-primary">blogMapList</a>
		<button class="btn btn-default" id="popbutton">모달출력버튼</button><br/>
		
		<div id="testtest">
		<div class="modal fade">
		  <div class="modal-dialog">
		    <div class="modal-content">
		    	<!-- remote ajax call이 되는영역 -->
		    </div>
		  </div>
		</div>
		</div>
		
		<!-- blogList -->
		<div class="modal fade" id="blogListMain" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h5 class="modal-title">Modal Main</h5>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="board/blogListMain.jsp"/>
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
<%--  							<jsp:include page="board/blogListMain.jsp"/> --%>
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