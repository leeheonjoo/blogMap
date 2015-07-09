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
<title>Home</title>
</head>
<body>
<article class="container-fluid">
	<div class="row">
		<section class="page-header">
			<h2 class="page-title">메시지</h2>
		</section>
	</div>
<form class="form-horizontal">
	<div class="col-md-12 col-sm-12 col-xs-12">
		<div class="form-group form-group-lg">
			<div class="col-md-3 col-sm-3 col-xs-3">
				<label class="control-label" for="formGroupInputLarge">메시지 번호</label>
			</div>
			
			<div class="col-md-3 col-sm-3 col-xs-3">
				<input type="text" class="form-control" name="message_no"/>
			</div>
			
			<div class="col-md-2 col-sm-2 col-xs-2">
				<label class="control-label" for="formGroupInputLarge">수신자</label>
			</div>
			
			<div class="col-md-4 col-sm-4 col-xs-4">
				<input type="text" class="form-control" name="message_receiver"/>
			</div>
		</div>
		<br/>
		
		<div class="form-group form-group-lg">
			<div class="col-md-3 col-sm-3 col-xs-3">
				<label class="control-label" for="formGroupInputLarge">발신자</label>
			</div>
			
			<div class="col-md-3 col-sm-3 col-xs-3">
				<input type="text" class="form-control" name="member_id"/>
			</div>
			
			<div class="col-md-2 col-sm-2 col-xs-2">
				<label class="control-label" for="formGroupInputLarge">발신일</label>
			</div>
			
			<div class="col-md-4 col-sm-4 col-xs-4">
				<input type="text" class="form-control" name="message_sDate"/>
			</div>
		</div>
		<br/>
		
		<div class="form-group form-group-lg">
			<div class="col-md-3 col-sm-3 col-xs-3">
				<label class="control-label" for="formGroupInputLarge">메시지 내용</label>
			</div>
			
			<div class="col-md-9 col-sm-9 col-xs-9">
				<textarea rows="5" class="form-control" name="message_content"></textarea>
			</div>
		</div>
		<br/>	
	</div>	
</form>
</article>
</body>
</html>