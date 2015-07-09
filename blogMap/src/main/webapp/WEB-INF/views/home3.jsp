<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set var="root" value="${pageContext.request.contextPath}"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>partner Home</title>
	<!-- CDN 서비스에서 부트스트랩 스타일시트를 불러옵니다 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"/>
<style>
.modal-lg{
		width: auto;
		margin: 1% 1% 0px 1%;
	}
</style>
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>			<!-- 부트스트랩 자바스크립트 파일 로드 -->
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
<!-- 블로그 검색 레이어 오픈 --> 
<a data-toggle="modal" href="#blogListMain" class="btn btn-primary" id ="partner_Registration">제휴업체등록</a>
<!-- blogList -->
	<div class="modal fade" id="blogListMain" data-backdrop="static">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title">제휴업체등록</h4>
					<div class="row">
					  <div class="col-lg-4">
					    <div class="input-group">
					      <input type="text" class="form-control" placeholder="Search for..."/>
					      <span class="input-group-btn">
					        <button class="btn btn-default" type="button">검색</button>
					      </span>
					    </div>	<!-- /input-group -->
					  </div>	<!-- /.col-lg-6 -->
					</div>		<!-- /.row -->	
				</div>
				<div class="modal-body">
					<div id="mainResult">
						<jsp:include page="partner/mainHome.jsp" />
					</div>
				</div>
			</div>
	    </div>
	</div>
	
	<!-- 제휴업체 정보 팝업 레이어 --> 
	<section class="modal fade" id="modal_info">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">업체 정보</h4>
				</div>
				
				<div class="modal-body" id="data-body">
					<div class="row form-horizontal">
						<div class="col-md-3">
							<img class="img-responsive img" src="" alt="">
						</div>
						<div class="col-md-9">
							<div class="form-group">
								<label class="col-xs-3 control-label">업체명</label>
								<div class="col-xs-9">
									<p class="form-control-static name" name="p_name"></p> 
									<!-- <input type="text" class="form-control-static" name="p_name"/> -->
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-xs-3 control-label">전화번호</label>
								<div class="col-xs-9">
									<p class="form-control-static phone" name="p_phone"></p> 
<!-- 									<input type="text" class="form-control-static phone" id="p_phone"></input> -->
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-xs-3 control-label">주소</label>
								<div class="col-xs-9">
								<p class="form-control-static address" name="p_addr"></p> 
<!-- 									<input type="text" class="form-control-static address" id="p_addr"></input> -->
								</div>
							</div>
						</div>
					</div>						
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</section>
	
	<!-- 제휴업체 정보 팝업 레이어 끝 -->
	<section class="modal fade" id="write_pop">
		<div class="modal-dialog modal-lg">
			<form id="write_form" class="col-xs-12 form-horizontal" method="post" action="${root}/partner/write.do" autocomplete="off" enctype="multipart/form-data">
				<div class="modal-content">
					
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">신규 업체 등록</h4>
					</div>

					<div class="modal-body" id="data-body">							
						<input type="hidden"  id="category_code" name="category_code"/>
						<input type="hidden"  id="member_id" name="member_id" value="${member_id }"/>
						<div class="form-group">
							<label class="col-xs-4 control-label">업체명</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" name="partner_name" id="name" value="${partner_name}" required="required" placeholder="업체명"/>
							</div>
						</div>

						<div class="form-group">
							<label class="col-xs-4 control-label">전화번호</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" name="partner_phone" id="phone" value="${partner_phone}" required="required" placeholder="전화번호"/>
							</div>
						</div>

						<div class="form-group">
							<label class="col-xs-4 control-label">주소</label>
							<div class="col-xs-8">
								<input type="text" class="form-control" name="Partner_addr" id="address" value="${partner_address}" required="required" placeholder="주소"/>
							</div>											
						</div>

						<div class="form-group">
							<label class="col-xs-4 control-label">업체사진</label>
							<div class="col-xs-8">
								<input type="file" class="form-control" name="img_src" id="img_src"/>
							</div>
						</div>
					</div>

					<div class="modal-footer">
						<button type="submit" class="btn btn-primary" id="form_validation">신청하기</button>
					</div>
				</div>
			</form>
		</div>
	</section>
</body>
</html>
