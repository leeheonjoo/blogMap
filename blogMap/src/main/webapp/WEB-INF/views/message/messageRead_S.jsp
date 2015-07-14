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
			<h2 class="page-title">Read Message</h2>
		</section>
	</div>
<form class="form-horizontal">
	<div class="col-md-12 col-sm-12 col-xs-12">
		<div class="form-group form-group-lg">
			<div class="col-md-1 col-sm-1 col-xs-1">
				<label class="control-label" for="formGroupInputLarge">No</label>
			</div>
			
			<div class="col-md-3 col-sm-3 col-xs-3">
				<input type="text" class="form-control" name="message_no"/>
			</div>
			
			<div class="col-md-2 col-sm-2 col-xs-2">
				<label class="control-label" for="formGroupInputLarge">Receiver</label>
			</div>
			
			<div class="col-md-6 col-sm-6 col-xs-6">
				<input type="text" class="form-control" name="message_receiver"/>
			</div>
		</div>
		
		<div class="form-group form-group-lg">
			<div class="col-md-1 col-sm-1 col-xs-1">
				<label class="control-label" for="formGroupInputLarge">Date</label>
			</div>
			
			<div class="col-md-3 col-sm-3 col-xs-3">
				<input type="text" class="form-control" name="message_sDate"/>
			</div>
		
			<div class="col-md-2 col-sm-2 col-xs-2">
				<label class="control-label" for="formGroupInputLarge">Writer</label>
			</div>
			
			<div class="col-md-6 col-sm-6 col-xs-6">
				<input type="text" class="form-control" name="member_id"/>
			</div>
		</div>
		
		<div class="form-group form-group-lg">
			<div class="col-md-2 col-sm-2 col-xs-2">
				<label class="control-label" for="formGroupInputLarge">Content</label>
			</div>
			
			<div class="col-md-10 col-sm-10 col-xs-10">
				<textarea rows="5" class="form-control" name="message_content"></textarea>
			</div>
		</div>
	</div>	
</form>
</article>
</body>
</html>