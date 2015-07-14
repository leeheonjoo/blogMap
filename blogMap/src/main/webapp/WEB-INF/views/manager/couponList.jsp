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
<title>Member Page</title>
<script type="text/javascript" src="${root }/css/manager/script.js"></script>
<script type="text/javascript">
	function getCouponlist(){
		$("#couponListResult").empty();
		$.ajax({
			type:'get',
			url:'${root}/manager/couponInfo.do',
			cache: false,
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				$("#couponListResult").empty();		// 데이타를 가지고 오기전에 리셋 (중복삽입을 방지하기 위해)
				var data=JSON.parse(responseData);	// 가지고 온 데이타를 data변수에 저장 
				
				if(!data){
					alert("데이타가 없습니다.");
					return false;
				}
				
				$.each(data, function(i){		// 화면에 뿌려주기 위해 each문으로 루프돌림
					var getbymd = new Date(data[i].coupon_bymd);	// 등록일 날짜 변환
					var byear = getbymd.getFullYear();
					var bmonth = getbymd.getMonth() + 1;
					var bday = getbymd.getDate();
					var bymd = byear + "년 " + bmonth + "월 "	+ bday + "일";
					//alert(bymd);
					
					var geteymd = new Date(data[i].coupon_eymd);	// 승인일 날짜 변환
					var eyear = geteymd.getFullYear();
					var emonth = geteymd.getMonth() + 1;
					var eday = geteymd.getDate();
					var eymd = eyear + "년 " + emonth + "월 "	+ eday + "일";
					//alert(eymd);
					
					if(data[i].coupon_yn == "N"){
						$("#couponListResult").append("<tr style='text-align:center;'>"
								+ "<td>" + data[i].coupon_no + "</td>"			// 아이디
								+ "<td>" + data[i].partner_no + "</td>"			// 이름	
								+ "<td><a data-toggle='modal' href='#couponDetail' class='btn-example' id='coupon"+data[i].coupon_no+"'>" + data[i].coupon_item + "</a></td>"		//
								+ "<td>" + data[i].coupon_discount + "</td>"		//							
								+ "<td>" + bymd + "</td>"						// 등록일
								+ "<td>" + eymd + "</td>"		//
								+ "<td>"
								+"<input type='button' id='coupon' value = '승인' name='"+data[i].coupon_no+"'/></td>"
								+ "</tr>");
					}else if(data[i].coupon_yn =="Y"){
						$("#couponListResult").append("<tr style='text-align:center;'>"
								+ "<td>" + data[i].coupon_no + "</td>"			// 아이디
								+ "<td>" + data[i].partner_no + "</td>"			// 이름	
								+ "<td><a data-toggle='modal' href='#couponDetail' class='btn-example' id='coupon"+data[i].coupon_no+"'>" + data[i].coupon_item + "</a></td>"		//
								+ "<td>" + data[i].coupon_discount + "</td>"		//							
								+ "<td>" + bymd + "</td>"						// 등록일
								+ "<td>" + eymd + "</td>"		//
								+ "<td>"
								+"<input type='button' id='coupon' value = '취소' name='"+data[i].coupon_no+"'/></td>"
								+ "</tr>");
					}
					
					$("#coupon"+data[i].coupon_no).click(function(){
						/* $("#partner_data-body").empty(); */
						couponDetail(data[i].coupon_no);
					});
					
				});
								
				$("#coupon[value='취소']").click(function(){
					var couponNo = $(this).attr('name');
					//alert(couponNo);
					var check = confirm("쿠폰 발행을 취소하시겠습니까?");
					if(check == "1"){
						couponCancle(couponNo);
					}else{
						alert("취소하셨습니다.")
					}
				});
				
				$("#coupon[value='승인']").click(function(){			// 승인버튼을 클릭시 실행
					var couponNo = $(this).attr('name');		
					//alert(couponNo);
					var check = confirm("쿠폰을 승인 하시겠습니까?");
					if(check == "1"){
						couponSubmit(couponNo);
					}else{
						alert("취소하셨습니다.")
					}
				});				
				
			},error:function(data){
				alert("에러가 발생하였습니다.");
			}
			
		});
		
		function couponCancle(couponNo){
			$.ajax({
				type:'get',
				url:'${root}/manager/couponCancle.do?couponNo='+couponNo,
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					
					var cancleCheck=JSON.parse(responseData);
					//alert("couponCancle :" + cancleCheck);
					
					if(!cancleCheck){
						alert("데이타가 없습니다.");
						return false;
					};
					
					if(cancleCheck == "1"){		//삭제가 정상적으로 이루어지면 시행
						alert("취소되었습니다.");
						getCouponlist();		// 함수를 다시 호출하여 변경사항 표시
					};
					
				},error:function(deleteCheck){
					alert("에러가 발생하였습니다.");
				}
			});
			
		};		
		
		function couponSubmit(couponNo){
			$.ajax({
				type:'get',
				url:'${root}/manager/couponSubmit.do?couponNo='+couponNo,
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					
					var submitChcek=JSON.parse(responseData);
					//alert("couponSubmit :" + submitChcek);
					
					if(!submitChcek){
						alert("데이타가 없습니다.");
						return false;
					};
					
					if(submitChcek == "1"){
						alert("승인되었습니다.");
						getCouponlist();
					};
					
				},error:function(submitChcek){
					alert("에러가 발생하였습니다.");
				}
			});
		};
		
		function couponDetail(couponNo){
			$("#couponDetailResult").empty();
			$.ajax({
				type:'get',
				url:'${root}/manager/couponDetail.do?coupon_no='+couponNo,
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				 success:function(responseData){
					var data=JSON.parse(responseData);
					//var filename=data.partner_pic_name
					alert(data.coupon_pic_name);
					$("#couponDetailResult").append($("#couponDetailMain").clone().css("display","block"));
					$("#couponDetailMain:last-child #coupon_img").attr("src", "${root}/css/coupon/images/"+data.coupon_pic_name);
					$("#couponDetailMain:last-child #partner_no").html(data.partner_no);
					$("#couponDetailMain:last-child #coupon_item").html(data.coupon_item);
					$("#couponDetailMain:last-child #coupon_discount").html(data.coupon_discount);
					$("#couponDetailMain:last-child #coupon_bymd").html(data.coupon_bymd);
					$("#couponDetailMain:last-child #coupon_eymd").html(data.coupon_eymd);					
					if(data.coupon_yn == "Y"){
						//$("#partner_submit").css("display", "none");
						$("#couponDetailMain:last-child #coupon_detail_button").attr({"name":data.coupon_no, "value":"삭제"});
					}else if(data.coupon_yn == "N"){
						//$("#partner_delete").css("display", "none");
						$("#couponDetailMain:last-child #coupon_detail_button").attr({"name":data.coupon_no, "value":"승인"});
					} 
					
					$("#coupon[value='취소']").click(function(){
						var couponNo = $(this).attr('name');
						//alert(couponNo);
						var check = confirm("쿠폰 발행을 취소하시겠습니까?");
						if(check == "1"){
							couponCancle(couponNo);
						}else{
							alert("취소하셨습니다.")
						}
					});
					
					$("#coupon[value='승인']").click(function(){			// 승인버튼을 클릭시 실행
						var couponNo = $(this).attr('name');		
						//alert(couponNo);
						var check = confirm("쿠폰을 승인 하시겠습니까?");
						if(check == "1"){
							couponSubmit(couponNo);
						}else{
							alert("취소하셨습니다.")
						}
					});	
				},
				error:function(data){
					alert("에러가 발생했습니다.");
				}

			});
		};	

	};
</script>
</head>
<body>

<div class="caption">

	<div class="row" id="searchTag">
			<input type="button" id="getPartnerList" value="리셋"/>
			<input type="radio" name="partner_yn" id="y"/><span>승인업체</span> &nbsp;&nbsp;
			<input type="radio" name="partner_yn" id="n"/><span>미승인업체</span>&nbsp;&nbsp;
			<input type="text" placeholder="Search" id="searchTag"/> 
			<input type="submit" id="searchPartner" value="Search"/>	
	</div>
	
	<div>
		<div class="span7">   
			<div class="widget stacked widget-table action-table">
	    				
					
					<div class="widget-content">
						
						<table class="table table-striped table-bordered" >
							<thead>
								<tr class="widget-header" >
									<th class="col-md-1 col-sm-1 col-xs-1" style="text-align: center;">순번</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">업체명</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">품목</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">할인율</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">시작일</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">종료일</th>
									<th class="col-md-1 col-sm-1 col-xs-1" style="text-align: center;">구분</th>
								</tr>
							</thead>
							<tbody id="couponListResult"></tbody>  <!-- 자료를 붙일 바디 -->
							</table>
						
					</div> <!-- /widget-content -->
				
			</div> <!-- /widget -->
	    </div>
	</div>
	</div>
	
	<!-- 
	<div>
회원정보 타이틀	
		<div class="row" id="couponTitle" align="center">
	       	<div class="col-md-1 col-sm-1 col-xs-1">순번</div>
	        <div class="col-md-2 col-sm-2 col-xs-2">업체명</div>
	        <div class="col-md-2 col-sm-2 col-xs-2">상품</div>
	        <div class="col-md-2 col-sm-2 col-xs-2">할인율</div>
	        <div class="col-md-2 col-sm-2 col-xs-2">시작일</div>
	    	<div class="col-md-2 col-sm-2 col-xs-2">종료일</div>
	    	<div class="col-md-1 col-sm-1 col-xs-1">구분</div>
	    	
  	  </div>

쿠폰정보를 불러올 기본틀 		
		<div class="row" id="couponList" style="display:none;" align="center">
			<div class="col-md-1 col-sm-1 col-xs-1" id="couponNo"></div>
	        <div class="col-md-2 col-sm-2 col-xs-2" id="partner"></div>
	        <div class="col-md-2 col-sm-2 col-xs-2" id="item"></div>
	        <div class="col-md-2 col-sm-2 col-xs-2" id="discount"></div>
	        <div class="col-md-2 col-sm-2 col-xs-2" id="couponBymd"></div>
	    	<div class="col-md-2 col-sm-2 col-xs-2" id="couponEymd"></div>
	    	<div class="col-md-1 col-sm-1 col-xs-1">
	    		<input id="coupon" type="button"/>
	    	</div>
		</div>

회원정보를 삽입시킬 div테그	
		<div class="row" id="couponListResult"></div>
	</div> -->
</body>
</html>

