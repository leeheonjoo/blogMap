<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set var="root" value="${pageContext.request.contextPath}"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<!-- META TAG 설정 -->		
<meta charset="utf-8">														<!-- 이 HTML의 문자셋을 설정합니다 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">						<!-- IE 브라우져일경우 기본 호홤모드를 Edge로 설정합니다 -->
<meta name="viewport" content="width=device-width, initial-scale=1">		<!-- 문서 로드시 기본 화면 비율을 1.0으로 설정합니다 -->
<meta name="description" content="블로그맵">								<!-- 이 문서에 대한 자세한 설명을 기록합니다. 검색엔진 검색시 노출 됩니다. -->
<meta name="keywords" content="BLOGMAP, 블로그맵">							<!-- 이 문서와 연관 -->
<title>BLOG MAP</title>

<!-- CDN 서비스에서 부트스트랩 스타일시트를 불러옵니다 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

<!-- IE9 미만에서 HTML5 엘리먼트(html5shiv) 및 미디어쿼리(respond)를 사용할수 있게 합니다 -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>		
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>			 
<![endif]-->

</head>
<body>
	<article class="container-fluid">

			<div class="row">
				<section class="page-header">
					<h2 class="page-title">제휴업체 정보</h2>
				</section>
			</div>

			<div class="row">
				<div>
					<!-- 큰 사이즈 화면에서 탭 목록-->					
					<ul class="nav nav-pills nav-stacked col-md-3 hidden-xs hidden-sm" role="tablist">
						<li role="presentation" class="active">
							<a href="#tab_tour" aria-controls="tab_tour" role="tab" data-toggle="tab">Tour</a>
						</li>
						<li role="presentation">
							<a href="#tab_restrant" aria-controls="tab_restrant" role="tab" data-toggle="tab">Restrant</a>
						</li>
					</ul>
					
					<!-- 작은 사이즈 화면에서 탭 목록-->
					<ul class="nav nav-tabs hidden-md hidden-lg" role="tablist">
						<li role="presentation" class="active">
							<a href="#tab_tour" aria-controls="tab_tour" role="tab" data-toggle="tab">Tour</a>
						</li>
						<li role="presentation">
							<a href="#tab_restrant" aria-controls="tab_restrant" role="tab" data-toggle="tab">Restrant</a>
						</li>
					</ul>

					<!-- 탭 내용 -->
					<div class="tab-content col-md-9">
						
						<section role="tabpanel" class="tab-pane active" id="tab_tour">
							
							<div class="row" id="tour_item_list">
								
								<div class="col-md-2 col-sm-3 col-xs-4 item" data-name="업체이름" data-phone="010-1111-2222" data-address="서울 강남구 역삼동 133-333번지" role="button">
									<div class="thumbnail">
										<img class="img-responsive" src="http://placehold.it/300x300" alt="업체이미지">
										<div class="caption">
											<p>업체이름</p>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<hr>
								<div class="col-xs-12 text-right">
									<button type="button" class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target="#write_pop">업체등록</button>									
								</div>
							</div>
							
						</section>
						
						<div role="tabpanel" class="tab-pane" id="tab_restrant">			
						</div>	
					</div>
				</div>
			</div>
	</article>
		
		<!-- blogListMain 레이어 시작-->
		<section class="modal fade" id="write_pop">
			<div class="modal-dialog modal-lg">
				<form id="write_form" class="col-xs-12 form-horizontal" method="post" action="" autocomplete="off" enctype="multipart/form-data">
					<div class="modal-content">
						
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title">블로그 검색</h4>
						</div>

						<div class="modal-body" id="data-body">
							<jsp:include page="board/blogListMain.jsp"/>
						</div>

						<div class="modal-footer">
							<button type="submit" class="btn btn-primary" onclick="return form_validation();">
								신청하기
							</button>
						</div>
					
					</div>
				</form>
			</div>
		</section>
		<!-- blogListMain 레이어 종료-->
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>			<!-- JQUERY 로드 -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>			<!-- 부트스트랩 자바스크립트 파일 로드 -->
		<!-- 부트스트랩 자바스크립트는 jquery 기반으로 만들어져 있기때문에 반드시 jquery를 불러오는 코드가 먼저 나와야 합니다.-->
		
		<style>
/* 		.modal-dialog {  */
/* 		      width: auto;  */
/* 		      height: 100%;  */
/* 		      padding: 0;  */
/* 		      margin:0;  */
/* 		}  */
		
/* 		.modal-content { */
/* 				width: auto;  */
/*  		      height: auto; */
/* 		      border-radius: 0; */
/*  		      color:white; */
/*  		      overflow:auto; */
/*  		} */
		</style>
		<script type="text/javascript">
			/*
			 * 제휴 업체 신청전 폼유효성 검증
			 */
			function form_validation()
			{
				var returnVal = false;
				// 빈값이 있는지 확인
				if(! check_empty("#name", '업체이름') ) return false;
				if(! check_empty("#phone", '연락처') ) return false;
				if(! check_empty("#address", '주소') ) return false;
				
				// 글자수 체크
				if( $("#name").val().length < 4 || $("#name").val().length > 50 )
				{
					alert("업체 이름은 최소 5글자 이상 50글자 미만이어야 합니다.");
					$("#name").focus();
					return false;
				} 
				
				// 핸드폰 번호 유효성 체크
				var phoneRegex = /^\d{2,3}-\d{3,4}-\d{4}$/;
				
				if(! phoneRegex.test( $("#phone").val() ) )
				{
					alert("잘못된 번호 형식입니다.");
					$("#phone").focus();
					return false;
				}
				
				// 사용자 확인창
				if(! confirm("신청하시겠습니까?")) return false;
				
				/* 폼 Submit 처리 
				 * AJAX 로는 파일전송이 처리되지 않습니다.
				 * 실제로 구현하기위해서는
				 * iframe element를 생성하고 그곳에서 데이터 처리를 하셔야합니다.
				 * 또는 http://malsup.com/jquery/form/ 에 방문하여 jquery플러그인을 사용하시길 바랍니다.
				 *  
				
				$.ajax({
					url : '처리페이지',
					type: 'post',
					data : $("#write_form").serialize(),
					success:function(data)
					{
						// ajax 처리 성공시 
					},
					error:function()
					{
						alert("서버와의 데이터 연결에 실패하였습니다.");
						return false;
					}
				});
				*/
				
				// 실제 폼이 전송되어 페이지가 변경되는것을 막기위해 false 리턴
				return false;
			}
			
			/*
			 * 해당 엘리먼트의 값이 비어있는지 확인하고,
			 * 비어있을시 경고창을 띄운후 False 반환
			 */
			function check_empty(el, title)
			{
				if($(el) == 'undefined' || $(el).val() == '')
				{
					alert( title + "는 필수 입력 항목입니다.");
					$(el).focus();
					return false;
				}
				
				return true;
			}
		</script>
</body>
</html>