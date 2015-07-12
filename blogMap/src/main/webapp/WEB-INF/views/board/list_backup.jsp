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
<div style="display: none;" id="hidden_items" class="list-group" >
          <a id="listItem" href="#" class="list-group-item">
                <div class="media col-md-3">
                    <figure class="pull-left">
                        <img class="media-object img-rounded img-responsive"  src="http://placehold.it/350x250" alt="placehold.it/350x250" >
                    </figure>
                    <span style="text-align: left;" id="result_no"></span>
                </div>
                <div class="col-md-6">
                    <h4 id="result_title" class="list-group-item-heading"> </h4>
                    <p id="result_content" class="list-group-item-text"> 
                    </p>
                </div>
                <div class="col-md-3 text-center">
                	<h2 id="result_rgdate"><small></small></h2>
                    <h2 id="result_count"><small></small></h2>
                    <button id="result_button" type="button" class="btn btn-default btn-lg btn-block" onmouseout="gray_button(this)" onmouseover="blue_button(this)"> 자세히 보기 </button>
                    <div id="result_star" class="stars">
                        <span class="glyphicon glyphicon-star-empty"></span>
                        <span class="glyphicon glyphicon-star-empty"></span>
                        <span class="glyphicon glyphicon-star-empty"></span>
                        <span class="glyphicon glyphicon-star-empty"></span>
                        <span class="glyphicon glyphicon-star-empty"></span>
                    </div>
                    <p id="result_grade"><small></small></p>
                </div> 
          </a>
        
        </div>
<div class="container">
    <div class="row">
		<div class="well">
        <h1  class="text-center">blogMap Result</h1>
        <div id="list_items" class="list-group">
        </div>
        </div>
	</div>
</div>
</body>
</html>	