<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<c:set var="root" value="${pageContext.request.contextPath }"/>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>BLOG MAP</title>
<script type="text/javascript">
$(function() {
	$("#partner_tour_button").click(function() {
		$("#category_code").val("100000");
	})
	$("#partner_restaurant_button").click(function() {
		$("category_code").val("200000");
	})
})
</script>
</head>
<body>
	<article class="container">
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
					<a href="#tab_restaurant" aria-controls="tab_restaurant" role="tab" data-toggle="tab">Restaurant</a>
				</li>
			</ul>
			
			<!-- 작은 사이즈 화면에서 탭 목록-->
			<ul class="nav nav-tabs hidden-md hidden-lg" role="tablist">
				<li role="presentation" class="active">
					<a href="#tab_tour" aria-controls="tab_tour" role="tab" data-toggle="tab">Tour</a>
				</li>
				<li role="presentation">
					<a href="#tab_restaurant" aria-controls="tab_restaurant" role="tab" data-toggle="tab">Restaurant</a>
				</li>
			</ul>

			<!-- tour 탭 내용 --> 
			<div class="tab-content col-md-9">
				<section role="tabpanel" class="tab-pane active" id="tab_tour">
					<div class="row" id="tour_item_list">	
						<div class="col-md-2 col-sm-3 col-xs-4 item" data-name="무한 상사" data-phone="010-4164-3340" data-address="서울시 송파구 가락본동 19-17호 210호" role="button">
							<div class="thumbnail">
								<img class="img-responsive" src="http://placehold.it/300x300" alt="업체이미지"/>
								<div class="caption">
									<p>업체이름</p>
								</div>
							</div>
						</div>
					</div>
					<div class="row">	
						<hr/>
						<div class="col-xs-12 text-right">
							<button type="button" id="partner_tour_button" name="partner_tour_button"  class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target="#write_pop">tour 업체등록</button>								
						</div>
					</div>
				</section>
				<div role="tabpanel" class="tab-pane" id="tab_restaurant">	
				
				<!-- restaurant 탭 내용 -->
				<section role="tabpanel" class="tab-pane active" id="tab_restaurant">
					<div class="row" id="restaurant_item_list">	
						<div class="col-md-2 col-sm-3 col-xs-4 item" data-name="영심이 떡볶이 &김밥" data-phone="031-708-3090" data-address="판교 2호점 " role="button">
							<div class="thumbnail">
								<img class="img-responsive" src="http://placehold.it/300x300" alt="업체이미지"/>
								<div class="caption">
									<p>업체이름</p>
								</div>
							</div>
						</div>
					</div>
					<div class="row">	
						<hr/>
						<div class="col-xs-12 text-right">
							<button type="button" id="partner_restaurant_button" class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target="#write_pop">restaurant 업체등록</button>									
						</div>
					</div>
				</section>	
				</div>
			</div>
		</div>
	</div>
	</article>
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
//  				if(! confirm("신청하시겠습니까?")) return false;		
				
				var data = new FormData();
				$.each($('#attachFile')[0].files,function(i,file){
					data.append('file',file);
				})
				$.ajax({
					type: 'POST',
					url : '${root}/partner/write.do',
					data : data,
					processData:false,
					contentType:false,
					success:function(data)
					{
						alert(data);
					},
					error:function()
					{
						alert("서버와의 데이터 연결에 실패하였습니다.");
						return false;
					}
				});
				
				/* 폼 Submit 처리 
				 * AJAX 로는 파일전송이 처리되지 않습니다.
				 * 실제로 구현하기위해서는
				 * iframe element를 생성하고 그곳에서 데이터 처리를 하셔야합니다.
				 * 또는 http://malsup.com/jquery/form/ 에 방문하여 jquery플러그인을 사용하시길 바랍니다.
				 *  
				$.ajax({
					url : '${root}/partner/partnerinfo.do',
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

			$(document).ready(function(){	
				/* 데이타를 채우기 위해 복사 */
				
				$(function(){
					$("#partner_Registration").click(function(){
				$.ajax({
					type:'post',
					url:'${root}/partner/partnerList.do',
					contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
				success : function(responseData) {
				var data = JSON.parse(responseData);
				for(i=0; i<4; i++)
				{
					var clone = $("#tour_item_list > .item").eq(0).clone();
					$("#tour_item_list").append(clone);
				}
				
					if (!data) {
						alert("등록된 정보가 없습니다.");
						return false;
					}
				}
			})
		})
	})
			
				
				// 각 업체를 클릭했을때 이벤트
				$("#tour_item_list > .item").click(function(){
					
					// 정보를 가져와서 세팅한다.
					var data_name = $(this).attr('data-name');
					var data_phone = $(this).attr('data-phone');
					var data_address = $(this).attr('data-address');
					var data_img = $(this).find('img').attr('src');
					
					$("#modal_info .name").text(data_name);
					$("#modal_info .phone").text(data_phone);
					$("#modal_info .address").text(data_address);
					$("#modal_info .img").attr('src', data_img);
					
					// 모달레이어를 연다.
					$("#modal_info").modal('show');
				});
				
				$("#modal_info").modal({
					'show' : false,
					'backdrop' : 'static'
				}).on('hidden.bs.modal', function(){
					// 가져왓던 정보를 초기화
					$("#modal_info .name").text('');
					$("#modal_info .phone").text('');
					$("#modal_info .address").text('');
					$("#modal_info .img").attr('src','');
				});
			});
			
			
			$(document).ready(function(){	
				/* 데이타를 채우기 위해 복사 */
				for(i=0; i<3; i++)
				{
					var clone = $("#restaurant_item_list > .item").eq(0).clone();
					$("#restaurant_item_list").append(clone);
				}
				
				// 각 업체를 클릭했을때 이벤트
				$("#restaurant_item_list > .item").click(function(){
					
					// 정보를 가져와서 세팅한다.
					var data_name = $(this).attr('data-name');
					var data_phone = $(this).attr('data-phone');
					var data_address = $(this).attr('data-address');
					var data_img = $(this).find('img').attr('src');
					
					$("#modal_info .name").text(data_name);
					$("#modal_info .phone").text(data_phone);
					$("#modal_info .address").text(data_address);
					$("#modal_info .img").attr('src', data_img);
					
					// 모달레이어를 연다.
					$("#modal_info").modal('show');
				});
				$("#modal_info").modal({
					'show' : false,
					'backdrop' : 'static'
				}).on('hidden.bs.modal', function(){
					// 가져왓던 정보를 초기화
					$("#modal_info .name").text('');
					$("#modal_info .phone").text('');
					$("#modal_info .address").text('');
					$("#modal_info .img").attr('src','');
				});
			});
		</script>
	</body>
</html>