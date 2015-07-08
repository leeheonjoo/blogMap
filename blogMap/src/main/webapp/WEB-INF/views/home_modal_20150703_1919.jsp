<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set var="root" value="${pageContext.request.contextPath}"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<meta charset="utf-8">
	<title>Bootply.com - Multiple Modal Overlay</title>
	<meta name="generator" content="Bootply" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

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

        <!-- CSS code from Bootply.com editor -->
        
        <style type="text/css">
            
    
        </style>
        
<!-- CDN 서비스에서 javascript를 불러옵니다 -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>												<!-- jquery javascript를 로드 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>						<!-- bootstrap javascript를 로드 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.7.3/js/bootstrap-select.js"></script>	<!-- bootstrap-select javascript를 로드 -->
<script src="https://netdna.bootstrapcdn.com/twitter-bootstrap/2.0.4/js/bootstrap-dropdown.js"></script>		<!-- bootstrap-dropdown javascript를 로드 -->
<!-- JavaScript jQuery code from Bootply.com editor -->
<script type='text/javascript'>   
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
	
		<a data-toggle="modal" href="#my" class="btn btn-primary">Launch modal</a>
		
		<div class="modal" id="my">
			<div class="modal-dialog modal-lg">
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		          <h4 class="modal-title">Modal 1</h4>
		        </div><div class="container"></div>
		        <div class="modal-body">
		          Content for the dialog / modal goes here.
		          <br>
		          <br>
		          <br>
		          <p>more content</p>
		          <br>
		          <br>
		          <br>
		          <a data-toggle="modal" href="#myModal2" class="btn btn-primary">Launch modal</a>
		        </div>
		        <div class="modal-footer">
		          <a href="#" data-dismiss="modal" class="btn">Close</a>
		          <a href="#" class="btn btn-primary">Save changes</a>
		        </div>
		      </div>
		    </div>
		</div>
		
		<div class="modal" id="myModal2">
			<div class="modal-dialog modal-lg">
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		          <h4 class="modal-title">Modal 2</h4>
		        </div><div class="container"></div>
		        <div class="modal-body">
		          Content for the dialog / modal goes here.
		          <br>
		          <br>
		          <p>come content</p>
		          <br>
		          <br>
		          <br>
		          <a data-toggle="modal" href="#myModal3" class="btn btn-primary">Launch modal</a>
		        </div>
		        <div class="modal-footer">
		          <a href="#" data-dismiss="modal" class="btn">Close</a>
		          <a href="#" class="btn btn-primary">Save changes</a>
		        </div>
		      </div>
		    </div>
		</div>
		
		<div class="modal" id="myModal3">
			<div class="modal-dialog">
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		          <h4 class="modal-title">Modal 3</h4>
		        </div><div class="container"></div>
		        <div class="modal-body">
		          Content for the dialog / modal goes here.
		          <br>
		          <br>
		          <br>
		          <br>
		          <br>
		          <a data-toggle="modal" href="#myModal4" class="btn btn-primary">Launch modal</a>
		        </div>
		        <div class="modal-footer">
		          <a href="#" data-dismiss="modal" class="btn">Close</a>
		          <a href="#" class="btn btn-primary">Save changes</a>
		        </div>
		      </div>
		    </div>
		</div>
		
		<div class="modal" id="myModal4" data-backdrop="static">
			<div class="modal-dialog">
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		          <h4 class="modal-title">Modal 4</h4>
		        </div><div class="container"></div>
		        <div class="modal-body">
		          Content for the dialog / modal goes here.
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