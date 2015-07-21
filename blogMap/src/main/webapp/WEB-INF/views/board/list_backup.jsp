<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
<style>
	a.list-group-item {
	    height:auto;
	    min-height:220px;
	}
	a.list-group-item.active small {
	    color:#fff;
	}
	.stars {
	    margin:20px auto 1px;    
	}
</style>
<script type="text/javascript">
function blue_button(btn) {
	$(btn).attr("class","btn btn-primary btn-lg btn-block");
}
function gray_button(btn) {
	$(btn).attr("class","btn btn-default btn-lg btn-block");
}
function blue_a(a) {
	$(a).attr("class","list-group-item active");
}
function gray_a(a) {
	$(a).attr("class","list-group-item");
}

</script>
</head>
<body>

</body>
</html>	