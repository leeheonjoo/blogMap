<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set var="root" value="${pageContext.request.contextPath}"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>PartnerDetail</title>

</head>
<body>
<div id="partnerDetailMain" style="display: none;">
	<!-- <img src="D:/NaverCapture/partner.png" width="300px" height="300px"/> -->
	
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">업체 정보</h4>
			</div>
			
			<div class="modal-body" id="partner_data-body">
				<div class="row form-horizontal">
					<div class="col-md-3">
						<img class="img-responsive img" id="partner_img" width="30%" height="30%" src="" alt=""/>
						
					</div>
					<div class="col-md-9">
						<div class="form-group">
							<label class="col-xs-3 control-label">업체명</label>
							<div class="col-xs-9">
								<p class="form-control-static name" id="partner_name"></p>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-xs-3 control-label">전화번호</label>
							<div class="col-xs-9">
								<p class="form-control-static phone" id="partner_phone"></p>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-xs-3 control-label">주소</label>
							<div class="col-xs-9">
								<p class="form-control-static address" id="partner_address"></p>
							</div>
						</div>
					</div>
				</div>						
			</div>
			
			<div class="modal-footer">
				<input type="button" class="btn btn-default" id="partner_detail_button"/>
				<input type="button" class="btn btn-default" data-dismiss="modal" value="닫기"/>				
			</div>
		</div>
	</div>
</div>

<div id="partnerDetailResult"></div>
</body>
</html>