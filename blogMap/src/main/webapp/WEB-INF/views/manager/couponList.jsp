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
				//alert(data.length)
				if(data.length < 1){
					alert("데이타가 없습니다.");
					return false;
				}
				
				$.each(data, function(i){		// 화면에 뿌려주기 위해 each문으로 루프돌림
					var getbymd = new Date(data[i].COUPON_BYMD);	// 등록일 날짜 변환
					var byear = getbymd.getFullYear();
					var bmonth = getbymd.getMonth() + 1;
					var bday = getbymd.getDate();
					var bymd = byear + "년 " + bmonth + "월 "	+ bday + "일";
					//alert(bymd);
					
					var geteymd = new Date(data[i].COUPON_EYMD);	// 승인일 날짜 변환
					var eyear = geteymd.getFullYear();
					var emonth = geteymd.getMonth() + 1;
					var eday = geteymd.getDate();
					var eymd = eyear + "년 " + emonth + "월 "	+ eday + "일";
					//alert(eymd);
					
					
					if(data[i].COUPON_YN == "N"){
						$("#couponListResult").append("<tr style='text-align:center;'>"
								+ "<td>" + data[i].COUPON_NO + "</td>"			// 아이디
								+ "<td>" + data[i].PARTNER_NAME + "</td>"			// 이름	
								+ "<td><a data-toggle='modal' href='#couponDetail' class='btn-example' id='coupon"+data[i].COUPON_NO+"'>" + data[i].COUPON_ITEM + "</a></td>"		//
								+ "<td>" + data[i].COUPON_DISCOUNT + "</td>"		//							
								+ "<td>" + bymd + "</td>"						// 등록일
								+ "<td>" + eymd + "</td>"		//
								+ "<td>"
								+"<input type='button' id='coupon' value = '승인' name='"+data[i].COUPON_NO+"'/></td>"
								+ "</tr>");
					}else if(data[i].COUPON_YN =="Y"){
						$("#couponListResult").append("<tr style='text-align:center;'>"
								+ "<td>" + data[i].COUPON_NO + "</td>"			// 아이디
								+ "<td>" + data[i].PARTNER_NAME + "</td>"			// 이름	
								+ "<td><a data-toggle='modal' href='#couponDetail' class='btn-example' id='coupon"+data[i].COUPON_NO+"'>" + data[i].COUPON_ITEM + "</a></td>"		//
								+ "<td>" + data[i].COUPON_DISCOUNT + "</td>"		//							
								+ "<td>" + bymd + "</td>"						// 등록일
								+ "<td>" + eymd + "</td>"		//
								+ "<td>"
								+"<input type='button' id='coupon' value = '취소' name='"+data[i].COUPON_NO+"'/></td>"
								+ "</tr>");
					}
					
					$("#coupon"+data[i].COUPON_NO).click(function(){
						/* $("#partner_data-body").empty(); */
						couponDetail(data[i].COUPON_NO);
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
			var manager = sessionStorage.getItem('email');
			$.ajax({
				type:'get',
				url:'${root}/manager/couponCancle.do?couponNo='+couponNo  + '&manager_id='+ manager,
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					$("#couponListResult").empty();
					var cancleCheck=JSON.parse(responseData);
					//alert("couponCancle :" + cancleCheck);
					
					if(!cancleCheck){
						alert("데이타가 없습니다.");
						return false;
					};
					
					if(cancleCheck == "1"){		//삭제가 정상적으로 이루어지면 시행
						alert("취소되었습니다.");						
						getCouponlist();		// 함수를 다시 호출하여 변경사항 표시
						couponDetail(couponNo);						
					};
					
				},error:function(deleteCheck){
					alert("에러가 발생하였습니다.");
				}
			});
			
		};		
		
		function couponSubmit(couponNo){
			var manager = sessionStorage.getItem('email');
			$.ajax({
				type:'get',
				url:'${root}/manager/couponSubmit.do?couponNo='+couponNo  + '&manager_id='+ manager,
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					$("#couponListResult").empty();
					var submitChcek=JSON.parse(responseData);
					//alert("couponSubmit :" + submitChcek);
					
					if(!submitChcek){
						alert("데이타가 없습니다.");
						return false;
					};
					
					if(submitChcek == "1"){
						alert("승인되었습니다.");
						getCouponlist();		// 함수를 다시 호출하여 변경사항 표시
						couponDetail(couponNo);						
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
					//alert(data[0].PARTNER_NAME);
					var getbymd = new Date(data[0].COUPON_BYMD);	// 등록일 날짜 변환
					var byear = getbymd.getFullYear();
					var bmonth = getbymd.getMonth() + 1;
					var bday = getbymd.getDate();
					var bymd = byear + "년 " + bmonth + "월 "	+ bday + "일";
					//alert(bymd);
					
					var geteymd = new Date(data[0].COUPON_EYMD);	// 승인일 날짜 변환
					var eyear = geteymd.getFullYear();
					var emonth = geteymd.getMonth() + 1;
					var eday = geteymd.getDate();
					var eymd = eyear + "년 " + emonth + "월 "	+ eday + "일";
					//alert(eymd);
					
					$("#couponDetailResult").append($("#couponDetailMain").clone().css("display","block"));
					$("#couponDetailMain:last-child #coupon_img").attr("src", "${root}/pds/coupon/"+data[0].COUPON_PIC_NAME);
					$("#couponDetailMain:last-child #partner_no").html(data[0].PARTNER_NAME);
					$("#couponDetailMain:last-child #coupon_item").html(data[0].COUPON_ITEM);
					$("#couponDetailMain:last-child #coupon_discount").html(data[0].COUPON_DISCOUNT);
					$("#couponDetailMain:last-child #coupon_bymd").html(bymd);
					$("#couponDetailMain:last-child #coupon_eymd").html(eymd);					
					if(data[0].COUPON_YN == "Y"){
						//$("#partner_submit").css("display", "none");
						$("#couponDetailMain:last-child #coupon_detail_button").attr({"name":data[0].COUPON_NO, "value":"취소"});
					}else if(data[0].COUPON_YN == "N"){
						//$("#partner_delete").css("display", "none");
						$("#couponDetailMain:last-child #coupon_detail_button").attr({"name":data[0].COUPON_NO, "value":"승인"});
					} 
					
					$("#coupon_detail_button[value='취소']").click(function(){
						var couponNo = $(this).attr('name');
						//alert(couponNo);
						var check = confirm("쿠폰 발행을 취소하시겠습니까?");
						if(check == "1"){
							couponCancle(couponNo);
						}else{
							alert("취소하셨습니다.")
						}
					});
					
					$("#coupon_detail_button[value='승인']").click(function(){			// 승인버튼을 클릭시 실행
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
					alert("에러가 발생했습니다.");
				}

			});
		};	

	};
	
	 $(function(){
		 /******************************************/ 
		/*			          					  */
		/*			검색버튼 클릭시 실행				  */
		/*										  */
		/******************************************/ 
		$("#searchCoupon").click(function(){
			
			var searchTag=$("input[id='CouponSearchTag']").val();
			//alert(searchTag);
			$.ajax({
				type:'get',
				url:'${root}/manager/searchCouponInfo.do?name=' + searchTag,
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					$("#couponListResult").empty();
					$("input[id='CouponSearchTag']").val("");
					var data=JSON.parse(responseData);
					//alert(data.length);
					
					if(data.length < 1){
						alert("데이타가 없습니다.");
						return false;
					}
					
					$.each(data, function(i){		// 화면에 뿌려주기 위해 each문으로 루프돌림
						var getbymd = new Date(data[i].COUPON_BYMD);	// 등록일 날짜 변환
						var byear = getbymd.getFullYear();
						var bmonth = getbymd.getMonth() + 1;
						var bday = getbymd.getDate();
						var bymd = byear + "년 " + bmonth + "월 "	+ bday + "일";
						//alert(bymd);
						
						var geteymd = new Date(data[i].COUPON_EYMD);	// 승인일 날짜 변환
						var eyear = geteymd.getFullYear();
						var emonth = geteymd.getMonth() + 1;
						var eday = geteymd.getDate();
						var eymd = eyear + "년 " + emonth + "월 "	+ eday + "일";
						//alert(eymd);
						
						if(data[i].COUPON_YN == "N"){
							$("#couponListResult").append("<tr style='text-align:center;'>"
									+ "<td>" + data[i].COUPON_NO + "</td>"			// 아이디
									+ "<td>" + data[i].PARTNER_NAME + "</td>"			// 이름	
									+ "<td><a data-toggle='modal' href='#couponDetail' class='btn-example' id='coupon"+data[i].COUPON_NO+"'>" + data[i].COUPON_ITEM + "</a></td>"		//
									+ "<td>" + data[i].COUPON_DISCOUNT + "</td>"		//							
									+ "<td>" + bymd + "</td>"						// 등록일
									+ "<td>" + eymd + "</td>"		//
									+ "<td>"
									+"<input type='button' id='coupon' value = '승인' name='"+data[i].COUPON_NO+"'/></td>"
									+ "</tr>");
						}else if(data[i].COUPON_YN =="Y"){
							$("#couponListResult").append("<tr style='text-align:center;'>"
									+ "<td>" + data[i].COUPON_NO + "</td>"			// 아이디
									+ "<td>" + data[i].PARTNER_NAME + "</td>"			// 이름	
									+ "<td><a data-toggle='modal' href='#couponDetail' class='btn-example' id='coupon"+data[i].COUPON_NO+"'>" + data[i].COUPON_ITEM + "</a></td>"		//
									+ "<td>" + data[i].COUPON_DISCOUNT + "</td>"		//							
									+ "<td>" + bymd + "</td>"						// 등록일
									+ "<td>" + eymd + "</td>"		//
									+ "<td>"
									+"<input type='button' id='coupon' value = '취소' name='"+data[i].COUPON_NO+"'/></td>"
									+ "</tr>");
						}
						
						$("#coupon"+data[i].COUPON_NO).click(function(){
							/* $("#partner_data-body").empty(); */
							couponDetail(data[i].COUPON_NO);
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
					alert("에러가 발생했습니다.");
				}
			});
			
			function couponCancle(couponNo){
				var manager = sessionStorage.getItem('email');
				$.ajax({
					type:'get',
					url:'${root}/manager/couponCancle.do?couponNo='+couponNo  + '&manager_id='+ manager,
					contentType:'application/x-www-form-urlencoded;charset=UTF-8',
					success:function(responseData){
						$("#couponListResult").empty();
						var cancleCheck=JSON.parse(responseData);
						//alert("couponCancle :" + cancleCheck);
						
						if(!cancleCheck){
							alert("데이타가 없습니다.");
							return false;
						};
						
						if(cancleCheck == "1"){		//삭제가 정상적으로 이루어지면 시행
							alert("취소되었습니다.");
							getCouponlist();		// 함수를 다시 호출하여 변경사항 표시
							couponDetail(couponNo);						
						};
						
					},error:function(deleteCheck){
						alert("에러가 발생하였습니다.");
					}
				});
				
			};		
			
			function couponSubmit(couponNo){
				var manager = sessionStorage.getItem('email');
				$.ajax({
					type:'get',
					url:'${root}/manager/couponSubmit.do?couponNo='+couponNo  + '&manager_id='+ manager,
					contentType:'application/x-www-form-urlencoded;charset=UTF-8',
					success:function(responseData){
						$("#couponListResult").empty();
						var submitChcek=JSON.parse(responseData);
						//alert("couponSubmit :" + submitChcek);
						
						if(!submitChcek){
							alert("데이타가 없습니다.");
							return false;
						};
						
						if(submitChcek == "1"){
							alert("승인되었습니다.");
							getCouponlist();		// 함수를 다시 호출하여 변경사항 표시
							couponDetail(couponNo);						
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
						//alert(data[0].PARTNER_NAME);
						var getbymd = new Date(data[0].COUPON_BYMD);	// 등록일 날짜 변환
						var byear = getbymd.getFullYear();
						var bmonth = getbymd.getMonth() + 1;
						var bday = getbymd.getDate();
						var bymd = byear + "년 " + bmonth + "월 "	+ bday + "일";
						//alert(bymd);
						
						var geteymd = new Date(data[0].COUPON_EYMD);	// 승인일 날짜 변환
						var eyear = geteymd.getFullYear();
						var emonth = geteymd.getMonth() + 1;
						var eday = geteymd.getDate();
						var eymd = eyear + "년 " + emonth + "월 "	+ eday + "일";
						//alert(eymd);
						
						$("#couponDetailResult").append($("#couponDetailMain").clone().css("display","block"));
						$("#couponDetailMain:last-child #coupon_img").attr("src", "${root}/pds/coupon/"+data[0].COUPON_PIC_NAME);
						$("#couponDetailMain:last-child #partner_no").html(data[0].PARTNER_NAME);
						$("#couponDetailMain:last-child #coupon_item").html(data[0].COUPON_ITEM);
						$("#couponDetailMain:last-child #coupon_discount").html(data[0].COUPON_DISCOUNT);
						$("#couponDetailMain:last-child #coupon_bymd").html(bymd);
						$("#couponDetailMain:last-child #coupon_eymd").html(eymd);					
						if(data[0].COUPON_YN == "Y"){
							//$("#partner_submit").css("display", "none");
							$("#couponDetailMain:last-child #coupon_detail_button").attr({"name":data[0].COUPON_NO, "value":"취소"});
						}else if(data[0].COUPON_YN == "N"){
							//$("#partner_delete").css("display", "none");
							$("#couponDetailMain:last-child #coupon_detail_button").attr({"name":data[0].COUPON_NO, "value":"승인"});
						} 
						
						$("#coupon_detail_button[value='취소']").click(function(){
							var couponNo = $(this).attr('name');
							//alert(couponNo);
							var check = confirm("쿠폰 발행을 취소하시겠습니까?");
							if(check == "1"){
								couponCancle(couponNo);
							}else{
								alert("취소하셨습니다.")
							}
						});
						
						$("#coupon_detail_button[value='승인']").click(function(){			// 승인버튼을 클릭시 실행
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
						alert("에러가 발생했습니다.");
					}

				});
			};	
			
			
			
		});
		 
		/******************************************/ 
		/*			          					  */
		/*			라디오버튼 클릭시 실행				  */
		/*										  */
		/******************************************/ 
		
		$("input[name='coupon_yn']").click(function(){
			var status=$(this).attr("id");
			//alert(status);
			
			$("#couponListResult").empty();	// 제휴업체 정보를 불러오기전 리셋(중복 삽입을 방지하기 위해)
			
			$.ajax({
				type:'get',
				url:'${root}/manager/searchCouponYN.do?coupon_yn=' + status,
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					var data=JSON.parse(responseData);
					
					if(data.length <1){
						alert("데이타가 없습니다.");
						return false;
					}
					
					$.each(data, function(i){		// 화면에 뿌려주기 위해 each문으로 루프돌림
						var getbymd = new Date(data[i].COUPON_BYMD);	// 등록일 날짜 변환
						var byear = getbymd.getFullYear();
						var bmonth = getbymd.getMonth() + 1;
						var bday = getbymd.getDate();
						var bymd = byear + "년 " + bmonth + "월 "	+ bday + "일";
						//alert(bymd);
						
						var geteymd = new Date(data[i].COUPON_EYMD);	// 승인일 날짜 변환
						var eyear = geteymd.getFullYear();
						var emonth = geteymd.getMonth() + 1;
						var eday = geteymd.getDate();
						var eymd = eyear + "년 " + emonth + "월 "	+ eday + "일";
						//alert(eymd);
						
						if(data[i].COUPON_YN == "N"){
							$("#couponListResult").append("<tr style='text-align:center;'>"
									+ "<td>" + data[i].COUPON_NO + "</td>"			// 아이디
									+ "<td>" + data[i].PARTNER_NAME + "</td>"			// 이름	
									+ "<td><a data-toggle='modal' href='#couponDetail' class='btn-example' id='coupon"+data[i].COUPON_NO+"'>" + data[i].COUPON_ITEM + "</a></td>"		//
									+ "<td>" + data[i].COUPON_DISCOUNT + "</td>"		//							
									+ "<td>" + bymd + "</td>"						// 등록일
									+ "<td>" + eymd + "</td>"		//
									+ "<td>"
									+"<input type='button' id='coupon' value = '승인' name='"+data[i].COUPON_NO+"'/></td>"
									+ "</tr>");
						}else if(data[i].COUPON_YN =="Y"){
							$("#couponListResult").append("<tr style='text-align:center;'>"
									+ "<td>" + data[i].COUPON_NO + "</td>"			// 아이디
									+ "<td>" + data[i].PARTNER_NAME + "</td>"			// 이름	
									+ "<td><a data-toggle='modal' href='#couponDetail' class='btn-example' id='coupon"+data[i].COUPON_NO+"'>" + data[i].COUPON_ITEM + "</a></td>"		//
									+ "<td>" + data[i].COUPON_DISCOUNT + "</td>"		//							
									+ "<td>" + bymd + "</td>"						// 등록일
									+ "<td>" + eymd + "</td>"		//
									+ "<td>"
									+"<input type='button' id='coupon' value = '취소' name='"+data[i].COUPON_NO+"'/></td>"
									+ "</tr>");
						}
						
						$("#coupon"+data[i].COUPON_NO).click(function(){
							/* $("#partner_data-body").empty(); */
							couponDetail(data[i].COUPON_NO);
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
					alert("에러가 발생했습니다.");
					
				}
				
			});
		});
		
		function couponCancle(couponNo){
			var manager = sessionStorage.getItem('email');
			$.ajax({
				type:'get',
				url:'${root}/manager/couponCancle.do?couponNo='+couponNo  + '&manager_id='+ manager,
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
						couponDetail(couponNo);						
					};
					
				},error:function(deleteCheck){
					alert("에러가 발생하였습니다.");
				}
			});
			
		};		
		
		function couponSubmit(couponNo){
			var manager = sessionStorage.getItem('email');
			$.ajax({
				type:'get',
				url:'${root}/manager/couponSubmit.do?couponNo='+couponNo  + '&manager_id='+ manager,
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
						getCouponlist();		// 함수를 다시 호출하여 변경사항 표시
						couponDetail(couponNo);						
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
					//alert(data[0].PARTNER_NAME);
					var getbymd = new Date(data[0].COUPON_BYMD);	// 등록일 날짜 변환
					var byear = getbymd.getFullYear();
					var bmonth = getbymd.getMonth() + 1;
					var bday = getbymd.getDate();
					var bymd = byear + "년 " + bmonth + "월 "	+ bday + "일";
					//alert(bymd);
					
					var geteymd = new Date(data[0].COUPON_EYMD);	// 승인일 날짜 변환
					var eyear = geteymd.getFullYear();
					var emonth = geteymd.getMonth() + 1;
					var eday = geteymd.getDate();
					var eymd = eyear + "년 " + emonth + "월 "	+ eday + "일";
					//alert(eymd);
					
					$("#couponDetailResult").append($("#couponDetailMain").clone().css("display","block"));
					$("#couponDetailMain:last-child #coupon_img").attr("src", "${root}/pds/coupon/"+data[0].COUPON_PIC_NAME);
					$("#couponDetailMain:last-child #partner_no").html(data[0].PARTNER_NAME);
					$("#couponDetailMain:last-child #coupon_item").html(data[0].COUPON_ITEM);
					$("#couponDetailMain:last-child #coupon_discount").html(data[0].COUPON_DISCOUNT);
					$("#couponDetailMain:last-child #coupon_bymd").html(bymd);
					$("#couponDetailMain:last-child #coupon_eymd").html(eymd);					
					if(data[0].COUPON_YN == "Y"){
						//$("#partner_submit").css("display", "none");
						$("#couponDetailMain:last-child #coupon_detail_button").attr({"name":data[0].COUPON_NO, "value":"취소"});
					}else if(data[0].COUPON_YN == "N"){
						//$("#partner_delete").css("display", "none");
						$("#couponDetailMain:last-child #coupon_detail_button").attr({"name":data[0].COUPON_NO, "value":"승인"});
					} 
					
					$("#coupon_detail_button[value='취소']").click(function(){
						var couponNo = $(this).attr('name');
						alert(couponNo);
						var check = confirm("쿠폰 발행을 취소하시겠습니까?");
						if(check == "1"){
							couponCancle(couponNo);
						}else{
							alert("취소하셨습니다.")
						}
					});
					
					$("#coupon_detail_button[value='승인']").click(function(){			// 승인버튼을 클릭시 실행
						var couponNo = $(this).attr('name');		
						alert(couponNo);
						var check = confirm("쿠폰을 승인 하시겠습니까?");
						if(check == "1"){
							couponSubmit(couponNo);
						}else{
							alert("취소하셨습니다.")
						}
					});	
				},error:function(data){
					alert("에러가 발생했습니다.");
				}

			});
		};	
		
	 });
			
</script>
</head>
<body>

<div class="caption">

	<div>
			<input type="button" id="getCouponList" value="Reset"/>&nbsp;&nbsp;
			<input type="radio" name="coupon_yn" id="Y"/><span>승인쿠폰</span> &nbsp;&nbsp;
			<input type="radio" name="coupon_yn" id="N"/><span>미승인쿠폰</span>&nbsp;&nbsp;
			<input type="text" placeholder="Name Search" id="CouponSearchTag"/> 
			<input type="submit" id="searchCoupon" value="Search"/>	
	</div><br/>
	
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
</body>
</html>

