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
<div id="couponDetailMain" style="display: none;">
	<%--  <img src="${root }/css/manager/images/star0.jpg" width="300px" height="300px"/> --%>
	
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">쿠폰 정보</h4>
			</div>
			
			<div class="modal-body" id="partner_data-body">
				<div class="row form-horizontal">
					<div class="col-md-3">
						<img class="img-responsive img" id="coupon_img"/>
						
					</div>
					<div class="col-md-9">
					
						<div class="form-group">
							<label class="col-xs-3 control-label">업체명</label>
							<div class="col-xs-9">
								<p class="form-control-static address" id="partner_no"></p>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-xs-3 control-label">상품</label>
							<div class="col-xs-9">
								<p class="form-control-static name" id="coupon_item"></p>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-xs-3 control-label">할인율</label>
							<div class="col-xs-9">
								<p class="form-control-static phone" id="coupon_discount"></p>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-xs-3 control-label">시작일</label>
							<div class="col-xs-9">
								<p class="form-control-static address" id="coupon_bymd"></p>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-xs-3 control-label">종료일</label>
							<div class="col-xs-9">
								<p class="form-control-static address" id="coupon_eymd"></p>
							</div>
						</div>
												
					</div>
				</div>						
			</div>
			
			<div class="modal-footer">
				<input type="button" class="btn btn-default" id="coupon_detail_button"/>
				<input type="button" class="btn btn-default" data-dismiss="modal" value="닫기" />	
				
				<button type="button" class="btn btn-lg btn-danger" data-toggle="popover" title="Popover title" data-content="And here's some amazing content. It's very engaging. Right?">click</button>	
			</div>
		</div>
	</div>
</div>

<div id="couponDetailResult"></div>
</body>
</html>