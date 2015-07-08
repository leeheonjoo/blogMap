<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set var="root" value="${pageContext.request.contextPath}"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Home</title>
<link rel="stylesheet" type="text/css" href="${root }/css/manager/layer.css"></link>

<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->
<%-- <script type="text/javascript" src="${root }/css/manager/script.js"></script> --%>

<script type="text/javascript">
	$(document).ready(function(){
		// memberList
 		$("input#getMemberList").click(function(){	// 회원정보버튼 클릭시 실행
			getMemberList();	// 회원리스트 불러오는 함수 호출
		}); 
		
		// partnerList
		$("input#getPartnerList").click(function(){		// 제휴업체 정보버튼 클릭시 실행
			getPartnerList()		// 제휴업체 정보를 불러오는 함수 호출
		});
		
		 // couponList
		$("input#couponInfo2").click(function(){		// 쿠폰 정보버튼 클릭시 실행
			getCouponlist()		// 제휴업체 정보를 불러오는 함수 호출
			var el='couponInfo2';
			var temp = $('div#' + el);
			var temp_bg = $('#' + el + '_bg');   //dimmed 레이어를 감지하기 위한 boolean 변수
			var temp_div = $('#' + el + '_div');
			var temp_btn = $('#' + el + '_btn');
			
			if (temp_bg) {
				temp_div.fadeIn(); //'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다. 
			} else {
				temp.fadeIn();
			}

			// 화면의 중앙에 레이어를 띄운다.
			if (temp.outerHeight() < $(document).height())
				temp.css('margin-top', '-' + temp.outerHeight() / 2 + 'px');
			else temp.css('top', '0px');
			if (temp.outerWidth() < $(document).width()) 
				temp.css('margin-left', '-' + temp.outerWidth() / 2 + 'px');
			else temp.css('left', '0px');

			temp_btn.click(function(e) {
				if (temp_bg) {
					temp_div.fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다. 
				} else {
					temp.fadeOut();
				}
				e.preventDefault();
			});

			temp_bg.click(function(e) { //배경을 클릭하면 레이어를 사라지게 하는 이벤트 핸들러
				temp_div.fadeOut();
				e.preventDefault();
			});
						
		}); 
		
		// managerList
		$("input#managerInfo2").click(function(){		//관리자정보 버튼을 클릭시 실행
			getManagerList();		// 관리자 정보를 불러오는 함수 호출
			var el='managerInfo2';
			var temp = $('div#' + el);
			var temp_bg = $('#' + el + '_bg');   //dimmed 레이어를 감지하기 위한 boolean 변수
			var temp_div = $('#' + el + '_div');
			var temp_btn = $('#' + el + '_btn');
			
			if (temp_bg) {
				temp_div.fadeIn(); //'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다. 
			} else {
				temp.fadeIn();
			}

			// 화면의 중앙에 레이어를 띄운다.
			if (temp.outerHeight() < $(document).height())
				temp.css('margin-top', '-' + temp.outerHeight() / 2 + 'px');
			else temp.css('top', '0px');
			if (temp.outerWidth() < $(document).width()) 
				temp.css('margin-left', '-' + temp.outerWidth() / 2 + 'px');
			else temp.css('left', '0px');

			temp_btn.click(function(e) {
				if (temp_bg) {
					temp_div.fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다. 
				} else {
					temp.fadeOut();
				}
				e.preventDefault();
			});

			temp_bg.click(function(e) { //배경을 클릭하면 레이어를 사라지게 하는 이벤트 핸들러
				temp_div.fadeOut();
				e.preventDefault();
			});
						
		});
		
	});
	
</script>
</head>
<body>
	<!-- modal로 변경 시키기 
	&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&7 -->
<!--회원 정보 레이어 -->
	<div class="container-fluid">
	<br/><br/>		
	<a data-toggle="modal" href="#memberInfo" class="btn btn-primary">회원정보</a>
	</div>
	
<!--제휴업체 정보 레이어 -->	
	<div class="container-fluid">
	<br/><br/>		
	<a data-toggle="modal" href="#partnerInfo" class="btn btn-primary">제휴업체정보</a>
	</div>

	
	<!-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&7 -->
		

<!--제휴업체 정보 레이어 -->				
<%-- 	<input id="patnerInfo2" type="button" value="제휴업체관리"/><br/><br/>
	
	<div id="patnerInfo2_div" class="layer">
		<div id="patnerInfo2_bg" class="bg"></div>
			<div id="patnerInfo2"  class="pop-layer">
				<div class="pop-container">
					<div class="pop-conts">
						<!--content //-->
						<jsp:include page="partnerList.jsp" />

						<div class="btn-r">
						<a href="#" id="patnerInfo2_btn">Close</a>
						</div>
					<!--// content-->
				</div>
			</div>
		</div>
	</div> --%>

<!-- 쿠폰 정보 레이어 -->	
	<input id="couponInfo2" type="button" value="쿠폰관리"/><br/><br/>
	
	<div id="couponInfo2_div" class="layer">
		<div id="couponInfo2_bg" class="bg"></div>
			<div id="couponInfo2"  class="pop-layer">
				<div class="pop-container">
					<div class="pop-conts">
						<!--content //-->
						<jsp:include page="couponList.jsp" />

						<div class="btn-r">
						<a href="#" id="couponInfo2_btn">Close</a>
						</div>
					<!--// content-->
				</div>
			</div>
		</div>
	</div>


<!-- 관리자 정보 레이어 -->		
	<input id="managerInfo2" type="button" value="관리자정보"/><br/><br/>
	
	<div id="managerInfo2_div" class="layer">
		<div id="managerInfo2_bg" class="bg"></div>
			<div id="managerInfo2"  class="pop-layer">
				<div class="pop-container">
					<div class="pop-conts">
						<!--content //-->
						<jsp:include page="managerList.jsp" />

						<div class="btn-r">
						<a href="#" id="managerInfo2_btn">Close</a>
						</div>
					<!--// content-->
				</div>
			</div>
		</div>
	</div>
</body>
</html>

