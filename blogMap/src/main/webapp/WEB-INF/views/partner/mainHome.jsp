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
})
</script>
</head>

<style>
.img-responsive {height:}
#list_partner_name {width:100%;text-overflow:ellipsis;white-space:inherit;overflow:initial;}
</style>

<body>

	<article class="container">
		<div class="row">
			<!-- 큰 사이즈 화면에서 탭 목록-->					
			<ul class="nav nav-pills nav-stacked col-md-2 hidden-xs hidden-sm" role="tablist">
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
			<div class="tab-content col-md-10 thumbnail">
				<div class="col-md-5 input-group">
					<input type="text" class="form-control" placeholder="제휴업체 검색" id="partnerSearchTag"/> 
		     		<span class="input-group-btn">
		     			<input type="button" class="btn btn-default" id="search_Partner" value="검색"/>
		     		</span>
       			</div><br/>
				<section role="tabpanel" class="tab-pane active" id="tab_tour">
					<div class="row" id="tour_item_list"></div>
					<div id="partnerListResult"></div>  <!-- 자료를 붙일 바디 -->
				
					<div class="col-md-3 col-sm-4 col-xs-4 tour_items" id="tour_item" role="button" style="display:none;">
						<div id="tour_info" class="thumbnail">	
							<a data-toggle="modal" href="#modal_info" class="list_partner_no">
								
								<img class="img-responsive" id="partner_imagers"/> 
								
								<div class="caption">
									<p id="list_partner_name"></p>
								</div>								
							</a>
						</div>
					</div>
				</section>
			</div>
		</div>
		<div class="modal-footer">
        	<button type="button"  id="partner_tour_button" name="partner_tour_button" class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target="#write_pop"">업체등록</button>
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
 				if(! confirm("신청하시겠습니까?")) return null;		
				
// 					id가 smarteditor인 textarea에 에디터에서 대입
// 					obj.getById["board_content"].exec("UPDATE_CONTENTS_FIELD",[]);
// 					폼 submit();
				
				var data = new FormData($('#write_form')[0]);
				
 			 	/* $.each($('#write_form')[0].files,function(i,file){
 					data[i].append('file',file);
				});  */
				
				 $.ajax({
					type: 'POST',
					url : '${root}/partner/write.do',
					data :data,
 					processData:false,
 					contentType:false,
					/* contentType : 'application/x-www-form-urlencoded;charset=UTF-8', */
					success:function(data)
					{
						alert("등록 성공");
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
// function get_list(page){
						
// }
// $(document).ready(function(){
// 	});
// }
// $("#search_Partner").click(get_list);

		$("#search_Partner").click(function(){
			//alert("제휴업체");
			var searchTag=$("input[id='partnerSearchTag']").val();
			//alert("찾으려는 검색어"+searchTag);
		
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
			 //alert(no);
				$.ajax({
					type:'get',
					url:'${root}/partner/getTourPartnerListDate.do?partnerNo=' + no,
					contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
					success : function(responseData) {
						var data = JSON.parse(responseData);
		 				//alert("업체이름" + data[0].PARTNER_YN);
						
  						$("div[name='p_category_MNAME']").html(data[0].MNAME);
  						$("div[name='p_category_SNAME']").html(data[0].SNAME);
						$("p[name='p_name']").html(data[0].PARTNER_NAME);
						$("p[name='p_phone']").html(data[0].PARTNER_PHONE);
						$("p[name='p_addr']").html(data[0].PARTNER_ADDR);

						$("img[id='partnerDetail_imagers']").attr("src","${root}/pds/partner/"+data[0].PARTNER_PIC_NAME);
					}
				});
			};
		
		function form_couponWrite(){
			
			var data = new FormData($('#couponWrite_form')[0]);
			
			$.ajax({
				type: 'POST',
				url : '${root}/partner/couponWrite.do',
				data :data,
					processData:false,
					contentType:false,
				/* contentType : 'application/x-www-form-urlencoded;charset=UTF-8', */
				success:function(data)
				{
					alert("성공");
// 					$("section[id=write_pop].modal").modal("hide");
// 					$("#tour_item_list").empty();	//데이터를 가지고 오기전에 리셋(중복삽입을 방지하기 위해)
					if(data=="1"){
						alert("쿠폰이 등록되었습니다.");
						$("section[id='mainCoupon_Registration'].modal").modal("hide");
						$("#coupon_item").val("");
						$("#coupon_discount").val("");
						$("#coupon_bymd").val("");
						$("#coupon_eymd").val("");
						$("#coupon_imagers").val("");
						
					}
				},
				error:function()
				{
					alert("서버와의 데이터 연결에 실패하였습니다.");
					return false;
				}
			}); 
			// 실제 폼이 전송되어 페이지가 변경되는것을 막기위해 false 리턴
			return false;
		};
		
		
		 function getPartnerInfo(){	
				/* 데이타를 채우기 위해 복사 */
				
				$.ajax({
					type:'post',
					url:'${root}/partner/writeList.do',
					contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
					success : function(responseData) {
						var data = JSON.parse(responseData);
						//alert(data);
					
						/* 데이타를 채우기 위해 복사 */
						$("#tour_item_list").empty();
						$.each(data, function(i){
							
							$("#tour_item_list").append($("#tour_item").clone().css("display", "block"));
							$("#tour_item:last-child #list_partner_name").html(data[i].partner_name);
							$("#tour_item:last-child a.list_partner_no").attr("id", "partner_no"+data[i].partner_no);
							$("input[name='partner_no']").html(data[i].partner_no);
							$("#tour_item:last-child #partner_imagers").attr("src","${root}/pds/partner/"+data[i].partner_pic_name);
							
							// 각 업체를 클릭했을때 이벤트
							$("#partner_no" + data[i].partner_no).click(function(){
								//alert("업체클릭번호" + data[i].partner_no)
								$("#partner_no").val(data[i].partner_no);
										
								//alert($("#partner_no").val());
								partnerData(data[i].partner_no);	
							});
						});
						
//						var max_height = 0;
						
//						$(".tour_items").each(function(){
							
//							if(max_height < $(this).height())
//							{
//								max_height = $(this).height();
//							}
//						});
						
//						$(".tour_items").css({
//							'height': max_height
//						});
						
						$(".tour_items .img-responsive").css({
							'max-width':"100%",
							'height': "150px"
						});
						
					}	
				});
		 };
		</script>
	</body>
</html>
