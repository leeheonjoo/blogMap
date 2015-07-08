<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set var="root" value="${pageContext.request.contextPath}"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>Home</title>
<!-- css : 부트스트랩_합쳐지고 최소화된 최신 css -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"/>

<!-- css : 부트스트랩_부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css"/>

<!-- layer.css -->
<link rel="stylesheet" type="text/css" href="${root}/css/layer.css"/>

<!-- js : jquery -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<!-- js : 부트스트랩_합쳐지고 최소화된 최신 자바스크립트 -->

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript">
	// 20150625 이헌주 - layer popup function - 각 서비스는 레이어 위에 include 형식으로 popup
	function layer_open(el){
		var temp = $('#' + el);
		var temp_bg = $('#' + el + '_bg');   //dimmed 레이어를 감지하기 위한 boolean 변수
		var temp_div = $('#' + el + '_div');
		var temp_btn = $('#' + el + '_btn');
		
		// layer fadeIn
		if(temp_bg){
			temp_div.fadeIn();	//'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다. 
		}else{
			temp.fadeIn();
		}
		// layer를 화면의 중앙에 위치시킨다.
		if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
		else temp.css('top', '0px');
		if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
		else temp.css('left', '0px');
		// layer fadeOut : 종료버튼 클릭시
		temp_btn.click(function(e){
			if(temp_bg){
				temp_div.fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다. 
			}else{
				temp.fadeOut();
			}
			e.preventDefault();
		});
		
		// layer fadeOut : 바탕화면 클릭시
		temp_bg.click(function(e){
			temp_div.fadeOut();
			e.preventDefault();
		});
	}
</script>
</head>
<body>
	<article class="container-fluid">

		<!-- 블로그 검색 레이어 오픈 -->
		<a href="#" class="btn-example" onclick="layer_open('blogListMain');return false;">BlogList</a>
		
		<!-- 블로그 검색 레이어 -->
		<div id="blogListMain_div" class="layer">
			<div id="blogListMain_bg" class="bg"></div>
			<div id="blogListMain" class="pop-layer">
				<div class="pop-container">
					<div class="pop-conts">
						<!--content // -->
						<div class="btn-r">
							<input id="blogListMain_btn" type="button" class="cbtn" value="X"/>
						</div>
						
						<!-- 블로그 게시글 메인 -->
						<jsp:include page="board/blogListMain.jsp"/>
						<!--// content -->
					</div>
				</div>
			</div>
		</div>
	</article>
</body>
</html>