<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!-- test를 위해 ID 입력 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.input-group-addon.primary {
    color: rgb(255, 255, 255);
    background-color: rgb(50, 118, 177);
    border-color: rgb(40, 94, 142);
}
.input-group-addon.success {
    color: rgb(255, 255, 255);
    background-color: rgb(92, 184, 92);
    border-color: rgb(76, 174, 76);
}
.input-group-addon.info {
    color: rgb(255, 255, 255);
    background-color: rgb(57, 179, 215);
    border-color: rgb(38, 154, 188);
}
.input-group-addon.warning {
    color: rgb(255, 255, 255);
    background-color: rgb(240, 173, 78);
    border-color: rgb(238, 162, 54);
}
.input-group-addon.danger {
    color: rgb(255, 255, 255);
    background-color: rgb(217, 83, 79);
    border-color: rgb(212, 63, 58);
}
</style>
<script type="text/javascript">
$(function() {
	$("#ggd").click(function() {
		alert("하하");
		$('[data-toggle="confirmation"]').confirmation(title);
	})
	
});

</script>
</head>
<body>
	<div id="blogRead_rgdate">
		<label>작성일:</label>
		<label></label>
	</div>
	<div id="blogRead_category">
		<label>카테고리:</label> 
		<label></label> |
		<label></label>
	</div>
	<div id="blogRead_writer">
		<label>작성자:</label> 
		<label></label>
	</div>
	<div id="blogRead_addr">
		<label>주소:</label>
		<label></label>
	</div>
	<div id="blogRead_title">
		<label>제목:</label>
		<label></label>
	</div>
	<div id="blogRead_content">
		<label>내용:</label>
		<div></div>
	</div>
	<div style="display: none;">
	 <div id="imgHidden" class="item active">
        <div class="col-md-4">
            <a href="#"><img id="imgsrc" src="" class="img-responsive center-block"></a>
            <div class="text-center">1</div>
        </div>
    </div>
	</div>
	    <div class="container">
        <div class="row">
            <div class="span12">
                <div class="well">
                    <div id="myCarousel" class="carousel fdi-Carousel slide">
                     <!-- Carousel items -->
                        <div class="carousel fdi-Carousel slide" id="eventCarousel" data-interval="0">
                            <div id="imgDisplay" class="carousel-inner onebyone-carosel">
                               
                            </div>
                            <a class="left carousel-control" href="#eventCarousel" data-slide="prev"></a>
                            <a class="right carousel-control" href="#eventCarousel" data-slide="next"></a>
                        </div>
                        <!--/carousel-inner-->
                    </div><!--/myCarousel-->
                </div><!--/well-->
            </div>
        </div>
	</div>	
	<div id="blogRead_grade">
		<label>평점:</label>
		<img src="" width="150" height="30"/><br /> 
	</div>
	<div>
	<input type="button" class="btn btn-primary" value="추천" />
	<input type="button" class="btn btn-primary" value="비추천" />
	<input type="button" class="btn btn-primary" value="즐겨찾기" />
	<input type="button" class="btn btn-primary" value="쿠폰발급" />
	<br/>
	<div id="blogRead_reply">
		<label>답글:</label>
	   <div class="row form-group">
        <div class="input-group">
            <input type="text" class="form-control">
            <span class="input-group-addon success"><span class="glyphicon glyphicon-ok"></span></span>
        </div>
        </div>
        <div id="blogRead_reply_content">
        </div>
    </div>
	</div>
	
	 <!-- 하단 버튼 -->
	<div align="right">
		<input type="button" class="btn btn-primary" id="savebutton" value="수정" /> 
		<a id="ggd" class="btn" data-toggle="confirmation" data-placement="bottom" data-original-title>삭제</a> 
		<input type="button" class="btn btn-primary" value="목록" />
	</div>
	

</body>
</html>