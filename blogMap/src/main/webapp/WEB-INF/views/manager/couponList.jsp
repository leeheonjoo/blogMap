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
					$("#couponListResult").append($("#couponList").clone().css("display","block"));		// #memberList를 복사하여 memberListSResult에 붙임 
					$("#couponList:last-child #couponNo").append(data[i].coupon_no);
					$("#couponList:last-child #partner").append(data[i].partner_no);
					$("#couponList:last-child #item").append(data[i].coupon_item);
					$("#couponList:last-child #discount").append(data[i].coupon_discount);
					$("#couponList:last-child #couponBymd").append(data[i].coupon_bymd);
					$("#couponList:last-child #couponEymd").append(data[i].coupon_eymd);
					//$("#couponList:last-child #coupon").attr({"name":data[i].coupon_no, "value":"승인"});	
					if(data[i].coupon_yn == "n"){
						$("#couponList:last-child #coupon").attr({"name":data[i].coupon_no, "value":"승인"});				// 미승인된 쿠폰에 승인 버튼 추가
					}else if(data[i].coupon_yn == "y"){
						$("#couponList:last-child #coupon").attr({"name":data[i].coupon_no, "value":"취소"});				// 승인된 쿠폰에 쿠폰 취소버튼 추가
					}					
					
				});
				
				$("#partner[value='취소']").click(function(){
					var tagId = $(this).attr('name');
					alert(tagId);
					
					$.ajax({
						type:'get',
						url:'${root}/manager/partnerDelete.do?id='+tagId,
						contentType:'application/x-www-form-urlencoded;charset=UTF-8',
						success:function(responseData){
							
							var deleteCheck=JSON.parse(responseData);
							alert("partnerDelete :" + deleteCheck);
							
							if(!deleteCheck){
								alert("데이타가 없습니다.");
								return false;
							};
							
							if(deleteCheck == "1"){		//삭제가 정상적으로 이루어지면 시행
								alert("삭제되었습니다.");
								getPartnerList();		// 함수를 다시 호출하여 변경사항 표시
							};
							
						},error:function(deleteCheck){
							alert("에러가 발생하였습니다.");
						}
					});
					
				});	
				
				
				$("#coupon[value='승인']").click(function(){			// 승인버튼을 클릭시 실행
					var couponNo = $(this).attr('name');		
					//alert(tagId);
					
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
				});
				
			},
			error:function(data){
				alert("에러가 발생하였습니다.");
			}
			
		});

	}
</script>
</head>
<body>
	<div>
<!-- 회원정보 타이틀 -->	
		<div class="row" id="couponTitle" align="center">
	       	<div class="col-md-1 col-sm-1 col-xs-1">순번</div>
	        <div class="col-md-2 col-sm-2 col-xs-2">업체명</div>
	        <div class="col-md-2 col-sm-2 col-xs-2">상품</div>
	        <div class="col-md-2 col-sm-2 col-xs-2">할인율</div>
	        <div class="col-md-2 col-sm-2 col-xs-2">시작일</div>
	    	<div class="col-md-2 col-sm-2 col-xs-2">종료일</div>
	    	<div class="col-md-1 col-sm-1 col-xs-1">구분</div>
	    	
  	  </div>

<!-- 쿠폰정보를 불러올 기본틀  -->		
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

<!-- 회원정보를 삽입시킬 div테그 -->	
		<div class="row" id="couponListResult"></div>
	</div>
</body>
</html>

