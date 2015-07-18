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
	$("input[name='member_id']").val(sessionStorage.getItem('email'));
	$("#partner_tour_button").click(function() {
		$("#category_code").val("100000");
	})
	$("#partner_restaurant_button").click(function() {
		$("#category_code").val("200000");
	})
})
</script>
</head>
<style>
.img-responsive {height:}
#list_partner_name {width:100%;text-overflow:ellipsis;white-space:nowrap;overflow:hidden}
</style>
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
					<a href="#tab_tour" aria-controls="tab_tour" role="tab" data-toggle="tab">Tour & Restaurant</a>
				</li>
			</ul>
		
				<!-- 작은 사이즈 화면에서 탭 목록-->
				<ul class="nav nav-tabs hidden-md hidden-lg" role="tablist">
				<li role="presentation" class="active">
					<a href="#tab_tour" aria-controls="tab_tour" role="tab" data-toggle="tab">Tour & Restaurant</a>
				</li>
			</ul>

			<!-- tour 탭 내용 -->
			<div class="tab-content col-md-9">
				<section role="tabpanel" class="tab-pane active" id="tab_tour">
					<div class="row" id="tour_item_list">	
						
					</div>
					<div id="partnerListResult"></div>  <!-- 자료를 붙일 바디 -->
				<div class="row">
						<div class="col-xs-12 text-right">
							<button type="button" id="partner_tour_button" name="partner_tour_button"  class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target="#write_pop">업체등록</button>								
						</div>
					</div>
				</section>
				<div class="col-md-2 col-sm-3 col-xs-4 tour_items" id="tour_item" role="button" style="display:none;">
					<div id="tour_info" class="thumbnail">	
						<a data-toggle="modal" href="#modal_info" class="list_partner_no">
							
							<img class="img-responsive" id="partner_imagers"/> 
<!-- 							<div class='clearfix'></div> -->
							
							<div class="caption">
								<p id="list_partner_name"></p>
							</div>								
						</a>
					</div>
				</div>
			</div>
			
	</article>
		<script type="text/javascript">
			/*
			 * 제휴 업체 신청전 폼유효성 검증
			 */
			function form_partnerWrite()
			{
				var returnVal = false;
				// 빈값이 있는지 확인
				if(! check_empty("#name", '업체이름') ) return false;
				if(! check_empty("#phone", '연락처') ) return false;
				if(! check_empty("#address", '주소') ) return false;
				
				// 글자수 체크
				if( $("#name").val().length < 1 || $("#name").val().length > 50 )
				{
					alert("업체 이름은 최소 1글자 이상 50글자 미만이어야 합니다.");
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
// 				if(! confirm("신청하시겠습니까?")) return null;		
				
// 					id가 smarteditor인 textarea에 에디터에서 대입
// 					obj.getById["board_content"].exec("UPDATE_CONTENTS_FIELD",[]);
// 					폼 submit();

					var partnerName=$("input type[name='partner_name']").val();
					var partnerPhone=$("input type[name='partner_phone']").val();
					var partnerAddr=$("input type[name='partner_addr']").val();
					var partnerImage=$("#partner_imagers").val();
					
			/* 		alert(partnerName);
					alert(partnerPhone);
					alert(partnerAddr);
					alert(partnerImage);
					$("#write_form").submit(); */
				
				var data = new FormData($('#write_form')[0]);
				
 			 	/* $.each($('#write_form')[0].files,function(i,file){
 					data[i].append('file',file);
				});  */
				
 				alert("넘어오나마지막");
				 $.ajax({
					type: 'POST',
					url : '${root}/partner/write.do',
					data :data,
 					processData:false,
 					contentType:false,
					/* contentType : 'application/x-www-form-urlencoded;charset=UTF-8', */
					success:function(data)
					{
						alert("성공");
						$("section[id=write_pop].modal").modal("hide");
						$("#tour_item_list").empty();	//데이터를 가지고 오기전에 리셋(중복삽입을 방지하기 위해)
						
						$.ajax({
							type:'post',
							url:'${root}/partner/writeList.do',
							contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
							success : function(responseData) {
								var data = JSON.parse(responseData);
								/* 데이타를 채우기 위해 복사 */
								$.each(data, function(i){
										
									$("#tour_item_list").append($("#tour_item").clone().css("display", "block"));
									$("#tour_item:last-child .list_partner_name").html(data[i].partner_name);
									$("#tour_item:last-child a[class='list_partner_no']").attr("id", "partner_no"+data[i].partner_no);
									$("input[name='partner_no']").html(data[i].partner_no);
									$("#tour_item:last-child #partner_imagers").attr("src","${root}/pds/partner/"+data[i].partner_pic_name);
									
									// 각 업체를 클릭했을때 이벤트
									$("#partner_no" + data[i].partner_no).click(function(){
										//alert("업체클릭" + data[i].partner_no)
										partnerData(data[i].partner_no);	
									});
									
									$(".asdasd").click(function(){
										var id = $(this).find('.list_partner_no').attr('id');
										$("#modal_info").modal('show');
									});
								});
							}	
						});	
					},
					error:function()
					{
						alert("서버와의 데이터 연결에 실패하였습니다.");
						return false;
					}
				}); 
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
				
				/* $("#partner_Registration").click(function(){
					alert("ok"); */	
				$.ajax({
					type:'post',
					url:'${root}/partner/writeList.do',
					contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
					success : function(responseData) {
						var data = JSON.parse(responseData);
						//alert(data);
					
						/* 데이타를 채우기 위해 복사 */
						$.each(data, function(i){
							
							$("#tour_item_list").append($("#tour_item").clone().css("display", "block"));
							$("#tour_item:last-child #list_partner_name").html(data[i].partner_name);
							$("#tour_item:last-child a.list_partner_no").attr("id", "partner_no"+data[i].partner_no);
							$("input[name='partner_no']").html(data[i].partner_no);
							$("#tour_item:last-child #partner_imagers").attr("src","${root}/pds/partner/"+data[i].partner_pic_name);
							
							// 각 업체를 클릭했을때 이벤트
							$("#partner_no" + data[i].partner_no).click(function(){
								//alert("업체클릭" + data[i].partner_no)
								partnerData(data[i].partner_no);	
							});
						});
						/*
						var max_height = 0;
						
						$(".tour_items").each(function(){
							
							if(max_height < $(this).height())
							{
								max_height = $(this).height();
							}
						});
						
						$(".tour_items").css({
							'height': max_height
						});
						
						$(".tour_items .img-responsive").css({
							'max-height' : "100%"
						});
						*/
					}	
				});	
		});
// function get_list(page){
						
// }
// $(document).ready(function(){
// 	});
// }
// $("#search_Partner").click(get_list);

		$("#search_Partner").click(function(){
			alert("제휴업체");
			var searchTag=$("input[id='partnerSearchTag']").val();
			alert(searchTag);
		
			$.ajax({
				type:'get',
				url:'${root}/partner/search_Partnerinfo.do?name='+searchTag,
				cache:false,
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
			
					$("#tour_item_list").empty();	//데이터를 가지고 오기전에 리셋(중복삽입을 방지하기 위해)
					var data=JSON.parse(responseData);	//가지고 온 데이터를 data 변수에 저장

					if(!data){
						alert("데이터가 없습니다.");
						return false;
					}
					$.each(data,function(i){	//화면에 뿌려주기 위해 each문으로 루프돌림
						$("#tour_item_list").append($("#tour_item").clone().css("display", "block"));
						$("#tour_item:last-child #list_partner_name").html(data[i].partner_name);
						$("#tour_item:last-child a[class='list_partner_no']").attr("id", "partner_no"+data[i].partner_no);
						$("input[name='partner_no']").html(data[i].partner_no);
						$("#tour_item:last-child #partner_imagers").attr("src","${root}/pds/partner/"+data[i].partner_pic_name);
						
						// 각 업체를 클릭했을때 이벤트
						$("#partner_no" + data[i].partner_no).click(function(){
						
							//alert("업체클릭" + data[i].partner_no)
							partnerData(data[i].partner_no);	
						});
						
					});
				}
			});
		});
		 function partnerData(no){
				$.ajax({
					type:'get',
					url:'${root}/partner/getTourPartnerListDate.do?partnerNo=' + no,
					contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
					success : function(responseData) {
						var data = JSON.parse(responseData);
//		 				alert("업체이름" + data.partner_name);
						
  						//$("p[name='p_category_code']").html(data.category_code);
						$("p[name='p_name']").html(data.partner_name);
						$("p[name='p_phone']").html(data.partner_phone);
						$("p[name='p_addr']").html(data.partner_addr);
// 						$("img[id='partnerDetail_imagers']").attr("src","${root}/css/images/partner/"+data.partner_pic_name);
						$("img[id='partnerDetail_imagers']").attr("src","${root}/pds/partner/"+data.partner_pic_name);
					}
				});
			};
		/*888888888888888888888888888888888888888888888  */
		/* 여기에 복사하기 */ 
		/*888888888888888888888888888888888888888888888  */
		</script>
	</body>
</html>