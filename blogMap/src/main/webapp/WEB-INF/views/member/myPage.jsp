<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="root" value="${pageContext.request.contextPath }"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	function leadingZeros(n, digits) {
	    var zero = '';
	    n = n.toString();
	
	    if (n.length < digits) {
	        for (i = 0; i < digits - n.length; i++)
	            zero += '0';
	    }
	    return zero + n;
	}

if(sessionStorage.getItem('email')!=null){
	
	$(function(){
		
		if(sessionStorage.getItem('jointype')!=null){
			$("#myPage_update_btn").css("display","none");
			$("#myPage_delete_btn").css("display","none");
			$("#myPage_fb_delete_btn").show();
		}
		
		//페북으로 등록한 인원이 회원탈퇴버튼누를때
		$("#myPage_fb_delete_btn").click(function(){
			$.ajax({
				type:'post',
				url:'${root}/member/email_confirm.do',
				data:{
					member_id:sessionStorage.getItem("email")
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					//alert(responseData);
					email_confirm_check(responseData);
				}
			});
		});
		
		$("#blogmap_main_myPage").click(function(){
			$.ajax({
				type:'POST',
				url:"${root}/member/myPage.do",
				data:{
					member_id:sessionStorage.getItem("email")
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					//alert(responseData);
				 	var data=responseData.split("|");
					
				 	memberData=JSON.parse(data[0])
					
					$("#myPage_member_id").text(memberData.member_id);
					
					$("#myPage_member_name").text(memberData.member_name);
	
				    var d = new Date(memberData.member_joindate);
				    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);

					$("#myPage_member_joindate").text(dt);				
					$("#myPage_member_point_total").text(data[1]+"points");
				
					$("#myPage_member_point_total").click(function(){
						$(".abc").attr("class","abc");
						$("#bbb").attr("class","active");
						
					});
					
					if(data[1]>=0&&data[1]<20){
						$("#myPage_member_rate").text("신입");
					}
					if(data[1]>=20&&data[1]<100){
						$("#myPage_member_rate").text("주임");
					}
					if(data[1]>=100&&data[1]<500){
						$("#myPage_member_rate").text("대리");
					}
					if(data[1]>=500){
						$("#myPage_member_rate").text("과장");
					}
					
					$("#myPage_member_board_total").text(data[2]+" EA");
					$("#myPage_member_board_total").click(function(){
						$(".abc").attr("class","abc");
						$("#ccc").attr("class","active");
						
					});
					
					$("#myPage_member_favorite_total").text(data[3]+ " EA");
					$("#myPage_member_favorite_total").click(function(){
						$(".abc").attr("class","abc");
						$("#ddd").attr("class","active");
						
					});
					
					$("#myPage_member_coupon_total").text(data[4]+ " EA");
					$("#myPage_member_coupon_total").click(function(){
						$(".abc").attr("class","abc");
						$("#eee").attr("class","active");
						
					});
				}
			});
			
			myPagePointInfo();
			myPageBoardInfo();
			myPageFavoriteInfo();
			$("input[name='mycoupon_use']:eq(0)").attr("checked",true);
			myPageCouponInfo('usable');
		});
		
		var p_startPage=0; 
		var p_endPage=0;
		var pageBlock=10;
		
		var b_startPage=0;
		var b_endPage=0;
		
		var c_startPage=0;
		var c_endPage=0;
		
		var f_startPage=0;
		var f_endPage=0;
		
		//포인트정보
		function myPagePointInfo(){
			$("#myPage_member_point_list_title").empty();
			$("#myPage_member_point_list_content").empty();
			$("#myPage_member_point_list_pageNum").empty();
			
			$.ajax({
				type:'POST',
				url:'${root}/member/point_info.do',
				data:{
					member_id:sessionStorage.getItem("email")					
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					//alert(responseData);
					
					var data=responseData.split("|");
					var boardSize=data[1];
					var count=data[2];
					var currentPage=data[3];
					
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					p_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					p_endPage=p_startPage+pageBlock-1;
					
					$("#myPage_member_point_list_title").append("<div class='col-xs-1 col-sm-1 col-md-1'><div class='header'>번호</div></div><div class='col-xs-2 col-sm-2 col-md-2'><div class='header'>발생일</div></div><div class='col-xs-7 col-sm-7 col-md-7'><div class='header'>내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</div></div><div class='col-xs-2 col-sm-2 col-md-2'><div class='header'>포인트</div></div>");
					var point_data=JSON.parse(data[0]);
					
					$.each(point_data,function(i){						 
					    var d = new Date(point_data[i].POINT_DATE);
					    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
					    
						$("#myPage_member_point_list_content").append('<div class="row margin-0"><div class="col-xs-1 col-sm-1 col-md-1"><div class="cell"><div class="propertyname">'+point_data[i].POINT_NO+'</div></div></div>'
						+'<div class="col-xs-2 col-sm-2 col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
						+'<div class="col-xs-7 col-sm-7 col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a id="point_data_read'+i+'" href="#">'+point_data[i].BOARD_TITLE+'</a></div></div></div>'
						+'<div class="col-xs-2 col-sm-2 col-md-2"><div class="cell"><div class="description">'+point_data[i].POINT_VALUE+'</div></div></div></div>');
						
						$("#point_data_read"+i).click(function(){
							//alert(point_data[i].BOARD_NO);
							blogListDetails(point_data[i].BOARD_NO);
							$("div[id='blogListDetail'].modal").modal();
						});	
					});
					
					if(p_endPage>pageCount){
						p_endPage=pageCount;
					}
										
					//페이징
				
					//이전
					if(p_startPage>pageBlock){
						$("#myPage_member_point_list_before").css("display","inline-block");
						
					}
					
					if(p_startPage<=pageBlock){
						$("#myPage_member_point_list_before").css("display","none");
					}
					
					
					for(var i=p_startPage;i<=p_endPage;i++){
						$("#myPage_member_point_list_pageNum").append("<a href='#' id='point_paging_num"+i+"'>"+i+"</a>");
						$("#point_paging_num"+i).click(function(){
							//alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/point_info.do',
								data:{
									member_id:sessionStorage.getItem("email"),
									pageNumber:$(this).text()
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									//alert(responseData);
									
									var data=responseData.split("|");
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
									
									$("#myPage_member_point_list_title").empty();
									$("#myPage_member_point_list_content").empty();
									$("#myPage_member_point_list_title").append("<div class='col-xs-1 col-sm-1 col-md-1'><div class='header'>번호</div></div><div class='col-xs-2 col-sm-2 col-md-2'><div class='header'>발생일</div></div><div class='col-xs-7 col-sm-7 col-md-7'><div class='header'>내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</div></div><div class='col-xs-2 col-sm-2 col-md-2'><div class='header'>포인트</div></div>");
									var point_data=JSON.parse(data[0]);
									
									$.each(point_data,function(i){						 
									    var d = new Date(point_data[i].POINT_DATE);
									    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
									    
										$("#myPage_member_point_list_content").append('<div class="row margin-0"><div class="col-xs-1 col-sm-1 col-md-1"><div class="cell"><div class="propertyname">'+point_data[i].POINT_NO+'</div></div></div>'
										+'<div class="col-xs-2 col-sm-2 col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
										+'<div class="col-xs-7 col-sm-7 col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a id="point_data_read'+i+'" href="#">'+point_data[i].BOARD_TITLE+'</a></div></div></div>'
										+'<div class="col-xs-2 col-sm-2 col-md-2"><div class="cell"><div class="description">'+point_data[i].POINT_VALUE+'</div></div></div></div>');
										
										$("#point_data_read"+i).click(function(){
											//alert(point_data[i].BOARD_NO);
											blogListDetails(point_data[i].BOARD_NO);
											$("div[id='blogListDetail'].modal").modal();
										});	
									});
								}
							});
						});
					}
										
					//다음
					if(p_endPage<pageCount){
						$("#myPage_member_point_list_after").css("display","inline-block");												
					}
					
					if(p_endPage>=pageCount){
						$("#myPage_member_point_list_after").css("display","none");
					}
				}			
			});
		};
		
		//다음클릭시
		$("#point_paging_after").click(function(){
			$.ajax({
				type:'POST',
				url:'${root}/member/point_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					pageNumber:p_startPage+pageBlock
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					//alert(responseData);
					
					var data=responseData.split("|");				
					var boardSize=data[1];
					var count=data[2];
					var currentPage=data[3];
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					p_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					p_endPage=p_startPage+pageBlock-1;
					
					$("#myPage_member_point_list_title").empty();
					$("#myPage_member_point_list_content").empty();
					$("#myPage_member_point_list_title").append("<div class='col-xs-1 col-sm-1 col-md-1'><div class='header'>번호</div></div><div class='col-xs-2 col-sm-2 col-md-2'><div class='header'>발생일</div></div><div class='col-xs-7 col-sm-7 col-md-7'><div class='header'>내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</div></div><div class='col-xs-2 col-sm-2 col-md-2'><div class='header'>포인트</div></div>");
					var point_data=JSON.parse(data[0]);
					
					$.each(point_data,function(i){						 
					    var d = new Date(point_data[i].POINT_DATE);
					    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
					    //+ " "+ leadingZeros(d.getHours(),2) +":"+ leadingZeros(d.getMinutes(),2);
					    
						$("#myPage_member_point_list_content").append('<div class="row margin-0"><div class="col-xs-1 col-sm-1 col-md-1"><div class="cell"><div class="propertyname">'+point_data[i].POINT_NO+'</div></div></div>'
						+'<div class="col-xs-2 col-sm-2 col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
						+'<div class="col-xs-7 col-sm-7 col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a id="point_data_read'+i+'" href="#">'+point_data[i].BOARD_TITLE+'</a></div></div></div>'
						+'<div class="col-xs-2 col-sm-2 col-md-2"><div class="cell"><div class="description">'+point_data[i].POINT_VALUE+'</div></div></div></div>');
						
						$("#point_data_read"+i).click(function(){
							//alert(point_data[i].BOARD_NO);
							blogListDetails(point_data[i].BOARD_NO);
							$("div[id='blogListDetail'].modal").modal();
						});	
					});
					
					if(p_endPage>pageCount){
						p_endPage=pageCount;
					}
					
					//이전
					if(p_startPage>pageBlock){
						//alert("block");
						$("#myPage_member_point_list_before").css("display","inline-block");
						$("#myPage_member_point_list_pageNum").css("display","none");
						$("#myPage_member_point_list_pageNum").css("display","inline-block");
					}
					
					if(p_startPage<=pageBlock){
						$("#myPage_member_point_list_before").css("display","none");
					}
					
					//페이지번호
					$("#myPage_member_point_list_pageNum").empty();
					for(var i=p_startPage;i<=p_endPage;i++){
						$("#myPage_member_point_list_pageNum").append("<a href='#' id='point_paging_num"+i+"'>"+i+"</a>");
						$("#point_paging_num"+i).click(function(){
							//alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/point_info.do',
								data:{
									member_id:sessionStorage.getItem("email"),
									pageNumber:$(this).text()
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									//alert(responseData);
									
									var data=responseData.split("|");
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
									
									$("#myPage_member_point_list_title").empty();
									$("#myPage_member_point_list_content").empty();
									$("#myPage_member_point_list_title").append("<div class='col-xs-1 col-sm-1 col-md-1'><div class='header'>번호</div></div><div class='col-xs-2 col-sm-2 col-md-2'><div class='header'>발생일</div></div><div class='col-xs-7 col-sm-7 col-md-7'><div class='header'>내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</div></div><div class='col-xs-2 col-sm-2 col-md-2'><div class='header'>포인트</div></div>");
									var point_data=JSON.parse(data[0]);
									
									$.each(point_data,function(i){						 
									    var d = new Date(point_data[i].POINT_DATE);
									    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
									    
										$("#myPage_member_point_list_content").append('<div class="row margin-0"><div class="col-xs-1 col-sm-1 col-md-1"><div class="cell"><div class="propertyname">'+point_data[i].POINT_NO+'</div></div></div>'
										+'<div class="col-xs-2 col-sm-2 col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
										+'<div class="col-xs-7 col-sm-7 col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a id="point_data_read'+i+'" href="#">'+point_data[i].BOARD_TITLE+'</a></div></div></div>'
										+'<div class="col-xs-2 col-sm-2 col-md-2"><div class="cell"><div class="description">'+point_data[i].POINT_VALUE+'</div></div></div></div>');
										
										$("#point_data_read"+i).click(function(){
											//alert(point_data[i].BOARD_NO);
											blogListDetails(point_data[i].BOARD_NO);
											$("div[id='blogListDetail'].modal").modal();
										});	
									});
								}
							});
						});
					}
					
					//다음
					if(p_endPage<pageCount){
						$("#myPage_member_point_list_after").css("display","inline-block");
					}
					
					if(p_endPage>=pageCount){
						$("#myPage_member_point_list_after").css("display","none");
					}
					
				}
			});
		});
		
		//이전클릭시
		$("#point_paging_before").click(function(){
			$.ajax({
				type:'POST',
				url:'${root}/member/point_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					pageNumber:p_startPage-pageBlock
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
				
					var data=responseData.split("|");
					var boardSize=data[1];
					var count=data[2];
					var currentPage=data[3];
					//var pageBlock=1;
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					//alert(pageCount);
					p_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					p_endPage=p_startPage+pageBlock-1;
					
					$("#myPage_member_point_list_title").empty();
					$("#myPage_member_point_list_content").empty();
					$("#myPage_member_point_list_title").append("<div class='col-xs-1 col-sm-1 col-md-1'><div class='header'>번호</div></div><div class='col-xs-2 col-sm-2 col-md-2'><div class='header'>발생일</div></div><div class='col-xs-7 col-sm-7 col-md-7'><div class='header'>내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</div></div><div class='col-xs-2 col-sm-2 col-md-2'><div class='header'>포인트</div></div>");
					var point_data=JSON.parse(data[0]);
					
					$.each(point_data,function(i){						 
					    var d = new Date(point_data[i].POINT_DATE);
					    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
					    
						$("#myPage_member_point_list_content").append('<div class="row margin-0"><div class="col-xs-1 col-sm-1 col-md-1"><div class="cell"><div class="propertyname">'+point_data[i].POINT_NO+'</div></div></div>'
						+'<div class="col-xs-2 col-sm-2 col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
						+'<div class="col-xs-7 col-sm-7 col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a id="point_data_read'+i+'" href="#">'+point_data[i].BOARD_TITLE+'</a></div></div></div>'
						+'<div class="col-xs-2 col-sm-2 col-md-2"><div class="cell"><div class="description">'+point_data[i].POINT_VALUE+'</div></div></div></div>');
						
						$("#point_data_read"+i).click(function(){
							//alert(point_data[i].BOARD_NO);
							blogListDetails(point_data[i].BOARD_NO);
							$("div[id='blogListDetail'].modal").modal();
						});	
					});
					
					//이전
					if(p_startPage>pageBlock){
						$("#myPage_member_point_list_before").css("display","inline-block");
						
					}
					
					if(p_startPage<=pageBlock){
						$("#myPage_member_point_list_before").css("display","none");
					}
					
					//페이지번호
					$("#myPage_member_point_list_pageNum").empty();
					for(var i=p_startPage;i<=p_endPage;i++){
						$("#myPage_member_point_list_pageNum").append("<a href='#' id='point_paging_num"+i+"'>"+i+"</a>");
						$("#point_paging_num"+i).click(function(){
							//alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/point_info.do',
								data:{
									member_id:sessionStorage.getItem("email"),
									pageNumber:$(this).text()
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									//alert(responseData);
									
									var data=responseData.split("|");
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
									
									
									$("#myPage_member_point_list_title").empty();
									$("#myPage_member_point_list_content").empty();
									$("#myPage_member_point_list_title").append("<div class='col-xs-1 col-sm-1 col-md-1'><div class='header'>번호</div></div><div class='col-xs-2 col-sm-2 col-md-2'><div class='header'>발생일</div></div><div class='col-xs-7 col-sm-7 col-md-7'><div class='header'>내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</div></div><div class='col-xs-2 col-sm-2 col-md-2'><div class='header'>포인트</div></div>");
									var point_data=JSON.parse(data[0]);
									
									$.each(point_data,function(i){						 
									    var d = new Date(point_data[i].POINT_DATE);
									    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
									    
										$("#myPage_member_point_list_content").append('<div class="row margin-0"><div class="col-xs-1 col-sm-1 col-md-1"><div class="cell"><div class="propertyname">'+point_data[i].POINT_NO+'</div></div></div>'
										+'<div class="col-xs-2 col-sm-2 col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
										+'<div class="col-xs-7 col-sm-7 col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a id="point_data_read'+i+'" href="#">'+point_data[i].BOARD_TITLE+'</a></div></div></div>'
										+'<div class="col-xs-2 col-sm-2 col-md-2"><div class="cell"><div class="description">'+point_data[i].POINT_VALUE+'</div></div></div></div>');
										
										$("#point_data_read"+i).click(function(){
											//alert(point_data[i].BOARD_NO);
											blogListDetails(point_data[i].BOARD_NO);
											$("div[id='blogListDetail'].modal").modal();
										});	
									});
								}
							});
						});
					}
					
					//다음
					if(p_endPage<pageCount){
						$("#myPage_member_point_list_after").css("display","inline-block");
					}
					
					if(p_endPage>=pageCount){
						$("#myPage_member_point_list_after").css("display","none");
					}
				}
			});
		});
			
		//쿠폰정보 사용가능/불가능 라디오버튼 클릭시
		$("input[name='mycoupon_use']").click(function(){
			var coupon_use=$(this).attr('id');
			//alert(coupon_use);
			myPageCouponInfo(coupon_use);
		});
		
		//쿠폰정보
		function myPageCouponInfo(coupon_use){	
			$("#myPage_member_coupon_list_content").empty();
			$("#myPage_member_coupon_list_pageNum").empty();
			$.ajax({
				type:'post',
				url:'${root}/member/coupon_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					coupon_use:coupon_use
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					var couponData=responseData.split("|");
					
					var couponInfo=JSON.parse(couponData[0]);
					var boardSize=couponData[1];
					var count=couponData[2];
					var currentPage=couponData[3];
					
					
					$.each(couponInfo,function(i){
						var getbymd = new Date(couponInfo[i].COUPON_BYMD);	// 등록일 날짜 변환
						var byear = leadingZeros(getbymd.getFullYear(),4);
						var bmonth = leadingZeros(getbymd.getMonth() + 1,2);
						var bday = leadingZeros(getbymd.getDate(),2);
						var bymd = byear + "/" + bmonth + "/" + bday;
						 
						var geteymd = new Date(couponInfo[i].COUPON_EYMD);	// 승인일 날짜 변환
						var eyear = leadingZeros(geteymd.getFullYear(),4);
						var emonth = leadingZeros(geteymd.getMonth() + 1,2);
						var eday = leadingZeros(geteymd.getDate(),2);
						var eymd = eyear + "/" + emonth + "/" + eday;
						$("#myPage_member_coupon_list_content").append('<div class="col-xs-6 col-sm-6 col-md-4"><h4 class="text-center"><div class="thumbnail" style="margin-bottom:0px;"><span class="label label-info">'+couponInfo[i].PARTNER_NAME+'</span></h4><img src="${root}/pds/coupon/'+couponInfo[i].COUPON_PIC_NAME+'" class="img-responsive" style="margin:0 auto;width:200px;height:150px;"><div class="caption" style="margin:10px;"><div class="row"><div class="col-md-8 col-xs-8"><h4>'+couponInfo[i].COUPON_ITEM+'</h4></div><div class="col-md-4 col-xs-4 price"><h4><label>'+couponInfo[i].COUPON_DISCOUNT+'%</label></h4></div></div><p style="font-size:13px;">'+ bymd +' ~ '+ eymd +'</p><p style="font-size:13px;">'+couponInfo[i].PARTNER_PHONE+'</p></div></div></div>');
					});
					
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					c_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					c_endPage=c_startPage+pageBlock-1;
	
					if(c_endPage>pageCount){
						c_endPage=pageCount;
					}
					
					//이전
					if(c_startPage>pageBlock){
						$("#myPage_member_coupon_list_before").css("display","inline-block");
					}
					
					if(c_startPage<=pageBlock){
						$("#myPage_member_coupon_list_before").css("display","none");
					}
					
					//페이지번호
					for(var i=c_startPage;i<=c_endPage;i++){
						$("#myPage_member_coupon_list_pageNum").append("<a href='#' id='coupon_paging_num"+i+"'>"+i+"</a>");
						$("#coupon_paging_num"+i).click(function(){
							//alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/coupon_info.do',
								data:{
									member_id:sessionStorage.getItem("email"),
									pageNumber:$(this).text()
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									//alert(responseData);
									
									var data=responseData.split("|");									
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
									
									$("#myPage_member_coupon_list_content").empty();
									var couponInfo=JSON.parse(data[0]);
									
									$.each(couponInfo,function(i){
										var getbymd = new Date(couponInfo[i].COUPON_BYMD);	// 등록일 날짜 변환
										var byear = leadingZeros(getbymd.getFullYear(),4);
										var bmonth = leadingZeros(getbymd.getMonth() + 1,2);
										var bday = leadingZeros(getbymd.getDate(),2);
										var bymd = byear + "/" + bmonth + "/" + bday;
										 
										var geteymd = new Date(couponInfo[i].COUPON_EYMD);	// 승인일 날짜 변환
										var eyear = leadingZeros(geteymd.getFullYear(),4);
										var emonth = leadingZeros(geteymd.getMonth() + 1,2);
										var eday = leadingZeros(geteymd.getDate(),2);
										var eymd = eyear + "/" + emonth + "/" + eday;
										
										$("#myPage_member_coupon_list_content").append('<div class="col-xs-6 col-sm-6 col-md-4"><h4 class="text-center"><div class="thumbnail" style="margin-bottom:0px;"><span class="label label-info">'+couponInfo[i].PARTNER_NAME+'</span></h4><img src="${root}/pds/coupon/'+couponInfo[i].COUPON_PIC_NAME+'" class="img-responsive" style="margin:0 auto;width:200px;height:150px;"><div class="caption" style="margin:10px;"><div class="row"><div class="col-md-8 col-xs-8"><h4>'+couponInfo[i].COUPON_ITEM+'</h4></div><div class="col-md-4 col-xs-4 price"><h4><label>'+couponInfo[i].COUPON_DISCOUNT+'%</label></h4></div></div><p style="font-size:13px;">'+ bymd +' ~ '+ eymd +'</p><p style="font-size:13px;">'+couponInfo[i].PARTNER_PHONE+'</p></div></div></div>');
									});
								}
							});
						});
					}
					
					//다음
					if(c_endPage<pageCount){
						$("#myPage_member_coupon_list_after").css("display","inline-block");					
					}
					
					if(c_endPage>=pageCount){
						$("#myPage_member_coupon_list_after").css("display","none");
					}
				}
			});
		};
		
		//다음클릭시
		$("#coupon_paging_after").click(function(){
			$.ajax({
				type:'POST',
				url:'${root}/member/coupon_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					pageNumber:c_startPage+pageBlock
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					//alert(responseData);
					
					var data=responseData.split("|");					
					var boardSize=data[1];
					var count=data[2];
					var currentPage=data[3];
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					c_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					c_endPage=c_startPage+pageBlock-1;
					
					$("#myPage_member_coupon_list_content").empty();
					var couponInfo=JSON.parse(data[0]);
					
					$.each(couponInfo,function(i){
						var getbymd = new Date(couponInfo[i].COUPON_BYMD);	// 등록일 날짜 변환
						var byear = leadingZeros(getbymd.getFullYear(),4);
						var bmonth = leadingZeros(getbymd.getMonth() + 1,2);
						var bday = leadingZeros(getbymd.getDate(),2);
						var bymd = byear + "/" + bmonth + "/" + bday;
						 
						var geteymd = new Date(couponInfo[i].COUPON_EYMD);	// 승인일 날짜 변환
						var eyear = leadingZeros(geteymd.getFullYear(),4);
						var emonth = leadingZeros(geteymd.getMonth() + 1,2);
						var eday = leadingZeros(geteymd.getDate(),2);
						var eymd = eyear + "/" + emonth + "/" + eday;
						
						$("#myPage_member_coupon_list_content").append('<div class="col-xs-6 col-sm-6 col-md-4"><h4 class="text-center"><div class="thumbnail" style="margin-bottom:0px;"><span class="label label-info">'+couponInfo[i].PARTNER_NAME+'</span></h4><img src="${root}/pds/coupon/'+couponInfo[i].COUPON_PIC_NAME+'" class="img-responsive" style="margin:0 auto;width:200px;height:150px;"><div class="caption" style="margin:10px;"><div class="row"><div class="col-md-8 col-xs-8"><h4>'+couponInfo[i].COUPON_ITEM+'</h4></div><div class="col-md-4 col-xs-4 price"><h4><label>'+couponInfo[i].COUPON_DISCOUNT+'%</label></h4></div></div><p style="font-size:13px;">'+ bymd +' ~ '+ eymd +'</p><p style="font-size:13px;">'+couponInfo[i].PARTNER_PHONE+'</p></div></div></div>');
					});
										
					if(c_endPage>pageCount){
						c_endPage=pageCount;
					}
					
					//이전
					if(c_startPage>pageBlock){
						$("#myPage_member_coupon_list_before").css("display","inline-block");
						$("#myPage_member_coupon_list_pageNum").css("display","none");
						$("#myPage_member_coupon_list_pageNum").css("display","inline-block");
					}
					
					if(c_startPage<=pageBlock){
						$("#myPage_member_coupon_list_before").css("display","none");
					}
					
					//페이지번호
					$("#myPage_member_coupon_list_pageNum").empty();
					for(var i=c_startPage;i<=c_endPage;i++){
						$("#myPage_member_coupon_list_pageNum").append("<a href='#' id='coupon_paging_num"+i+"'>"+i+"</a>");
						$("#coupon_paging_num"+i).click(function(){
							//alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/coupon_info.do',
								data:{
									member_id:sessionStorage.getItem("email"),
									pageNumber:$(this).text()
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									
									var data=responseData.split("|");									
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
									
									$("#myPage_member_coupon_list_content").empty();
									var couponInfo=JSON.parse(data[0]);
									
									$.each(couponInfo,function(i){
										var getbymd = new Date(couponInfo[i].COUPON_BYMD);	// 등록일 날짜 변환
										var byear = leadingZeros(getbymd.getFullYear(),4);
										var bmonth = leadingZeros(getbymd.getMonth() + 1,2);
										var bday = leadingZeros(getbymd.getDate(),2);
										var bymd = byear + "/" + bmonth + "/" + bday;
										 
										var geteymd = new Date(couponInfo[i].COUPON_EYMD);	// 승인일 날짜 변환
										var eyear = leadingZeros(geteymd.getFullYear(),4);
										var emonth = leadingZeros(geteymd.getMonth() + 1,2);
										var eday = leadingZeros(geteymd.getDate(),2);
										var eymd = eyear + "/" + emonth + "/" + eday;
										
										$("#myPage_member_coupon_list_content").append('<div class="col-xs-6 col-sm-6 col-md-4"><h4 class="text-center"><div class="thumbnail" style="margin-bottom:0px;"><span class="label label-info">'+couponInfo[i].PARTNER_NAME+'</span></h4><img src="${root}/pds/coupon/'+couponInfo[i].COUPON_PIC_NAME+'" class="img-responsive" style="margin:0 auto;width:200px;height:150px;"><div class="caption" style="margin:10px;"><div class="row"><div class="col-md-8 col-xs-8"><h4>'+couponInfo[i].COUPON_ITEM+'</h4></div><div class="col-md-4 col-xs-4 price"><h4><label>'+couponInfo[i].COUPON_DISCOUNT+'%</label></h4></div></div><p style="font-size:13px;">'+ bymd +' ~ '+ eymd +'</p><p style="font-size:13px;">'+couponInfo[i].PARTNER_PHONE+'</p></div></div></div>');
									});
								}
							});
						});
					}
					
					//다음
					if(c_endPage<pageCount){
						$("#myPage_member_coupon_list_after").css("display","inline-block");
					}
					
					if(c_endPage>=pageCount){
						$("#myPage_member_coupon_list_after").css("display","none");
					}
					
				}
			});
		});
		
		
		//이전클릭시
		$("#coupon_paging_before").click(function(){
			$.ajax({
				type:'POST',
				url:'${root}/member/coupon_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					pageNumber:c_startPage-pageBlock
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					//alert(responseData);
					
					var data=responseData.split("|");
					var boardSize=data[1];
					var count=data[2];
					var currentPage=data[3];
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					c_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					c_endPage=c_startPage+pageBlock-1;
					
					$("#myPage_member_coupon_list_content").empty();
					var couponInfo=JSON.parse(data[0]);
					
					$.each(couponInfo,function(i){
						var getbymd = new Date(couponInfo[i].COUPON_BYMD);	// 등록일 날짜 변환
						var byear = leadingZeros(getbymd.getFullYear(),4);
						var bmonth = leadingZeros(getbymd.getMonth() + 1,2);
						var bday = leadingZeros(getbymd.getDate(),2);
						var bymd = byear + "/" + bmonth + "/" + bday;
						 
						var geteymd = new Date(couponInfo[i].COUPON_EYMD);	// 승인일 날짜 변환
						var eyear = leadingZeros(geteymd.getFullYear(),4);
						var emonth = leadingZeros(geteymd.getMonth() + 1,2);
						var eday = leadingZeros(geteymd.getDate(),2);
						var eymd = eyear + "/" + emonth + "/" + eday;
						
						$("#myPage_member_coupon_list_content").append('<div class="col-xs-6 col-sm-6 col-md-4"><h4 class="text-center"><div class="thumbnail" style="margin-bottom:0px;"><span class="label label-info">'+couponInfo[i].PARTNER_NAME+'</span></h4><img src="${root}/pds/coupon/'+couponInfo[i].COUPON_PIC_NAME+'" class="img-responsive" style="margin:0 auto;width:200px;height:150px;"><div class="caption" style="margin:10px;"><div class="row"><div class="col-md-8 col-xs-8"><h4>'+couponInfo[i].COUPON_ITEM+'</h4></div><div class="col-md-4 col-xs-4 price"><h4><label>'+couponInfo[i].COUPON_DISCOUNT+'%</label></h4></div></div><p style="font-size:13px;">'+ bymd +' ~ '+ eymd +'</p><p style="font-size:13px;">'+couponInfo[i].PARTNER_PHONE+'</p></div></div></div>');
					});
					
					//이전
					if(c_startPage>pageBlock){
						$("#myPage_member_coupon_list_before").css("display","inline-block");
					}
					
					if(c_startPage<=pageBlock){
						$("#myPage_member_coupon_list_before").css("display","none");
					}
					
					//페이지번호
					$("#myPage_member_coupon_list_pageNum").empty();
					for(var i=c_startPage;i<=c_endPage;i++){
						$("#myPage_member_coupon_list_pageNum").append("<a href='#' id='coupon_paging_num"+i+"'>"+i+"</a>");
						$("#coupon_paging_num"+i).click(function(){
							//alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/coupon_info.do',
								data:{
									member_id:sessionStorage.getItem("email"),
									pageNumber:$(this).text()
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									
									var data=responseData.split("|");									
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
									
									$("#myPage_member_coupon_list_content").empty();
									var couponInfo=JSON.parse(data[0]);
									
									$.each(couponInfo,function(i){
										var getbymd = new Date(couponInfo[i].COUPON_BYMD);	// 등록일 날짜 변환
										var byear = leadingZeros(getbymd.getFullYear(),4);
										var bmonth = leadingZeros(getbymd.getMonth() + 1,2);
										var bday = leadingZeros(getbymd.getDate(),2);
										var bymd = byear + "/" + bmonth + "/" + bday;
										 
										var geteymd = new Date(couponInfo[i].COUPON_EYMD);	// 승인일 날짜 변환
										var eyear = leadingZeros(geteymd.getFullYear(),4);
										var emonth = leadingZeros(geteymd.getMonth() + 1,2);
										var eday = leadingZeros(geteymd.getDate(),2);
										var eymd = eyear + "/" + emonth + "/" + eday;
										
										$("#myPage_member_coupon_list_content").append('<div class="col-xs-6 col-sm-6 col-md-4"><h4 class="text-center"><div class="thumbnail" style="margin-bottom:0px;"><span class="label label-info">'+couponInfo[i].PARTNER_NAME+'</span></h4><img src="${root}/pds/coupon/'+couponInfo[i].COUPON_PIC_NAME+'" class="img-responsive" style="margin:0 auto;width:200px;height:150px;"><div class="caption" style="margin:10px;"><div class="row"><div class="col-md-8 col-xs-8"><h4>'+couponInfo[i].COUPON_ITEM+'</h4></div><div class="col-md-4 col-xs-4 price"><h4><label>'+couponInfo[i].COUPON_DISCOUNT+'%</label></h4></div></div><p style="font-size:13px;">'+ bymd +' ~ '+ eymd +'</p><p style="font-size:13px;">'+couponInfo[i].PARTNER_PHONE+'</p></div></div></div>');
									});
								}
							});
						});
					}
					
					//다음
					if(c_endPage<pageCount){
						$("#myPage_member_coupon_list_after").css("display","inline-block");
					}
					
					if(c_endPage>=pageCount){
						$("#myPage_member_coupon_list_after").css("display","none");
					}
				}
			});
		});
		
		
		
		//게시글 정보
		function myPageBoardInfo(){	
			$("#myPage_member_board_list_title").empty();
			$("#myPage_member_board_list_content").empty();
			$("#myPage_member_board_list_pageNum").empty();
			$.ajax({
				type:'POST',
				url:'${root}/member/board_info.do',
				data:{
					member_id:sessionStorage.getItem("email")				
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					//alert(responseData);
					
					var data=responseData.split("|");					
					var boardSize=data[1];
					var count=data[2];
					var currentPage=data[3];
					
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					b_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					b_endPage=b_startPage+pageBlock-1;
					
					$("#myPage_member_board_list_title").append("<div class='col-md-1'><div class='header'>번호</div></div><div class='col-md-2'><div class='header'>작성일</div></div><div class='col-md-2'><div class='header'>카테고리</div></div><div class='col-md-7'><div class='header'>제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</div></div>");
					var board_data=JSON.parse(data[0]);
					
					$.each(board_data,function(i){
					    var d = new Date(board_data[i].BOARD_RGDATE);
					    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
					    //+ " "+ leadingZeros(d.getHours(),2) +":"+ leadingZeros(d.getMinutes(),2);

						$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="description">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
						+'<div class="col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a href="#" id="board_data_read'+i+'">'+board_data[i].BOARD_TITLE+'</a></div></div></div></div>');
						
						$("#board_data_read"+i).click(function(){
							blogListDetails(board_data[i].BOARD_NO);
	                        $("div[id='blogListDetail'].modal").modal();
						});
					});
					
					if(b_endPage>pageCount){
						b_endPage=pageCount;
					}
					
					
					//페이징					
					//이전
					if(b_startPage>pageBlock){
						$("#myPage_member_board_list_before").css("display","inline-block");
					}
					
					if(b_startPage<=pageBlock){
						$("#myPage_member_board_list_before").css("display","none");
					}
					
					//페이지번호
					for(var i=b_startPage;i<=b_endPage;i++){
						$("#myPage_member_board_list_pageNum").append("<a href='#' id='board_paging_num"+i+"'>"+i+"</a>");
						$("#board_paging_num"+i).click(function(){
							//alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/board_info.do',
								data:{
									member_id:sessionStorage.getItem("email"),
									pageNumber:$(this).text()
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									//alert(responseData);
									
									var data=responseData.split("|");
									
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
									
									$("#myPage_member_board_list_title").empty();
									$("#myPage_member_board_list_content").empty();
									$("#myPage_member_board_list_title").append("<div class='col-md-1'><div class='header'>번호</div></div><div class='col-md-2'><div class='header'>작성일</div></div><div class='col-md-2'><div class='header'>카테고리</div></div><div class='col-md-7'><div class='header'>제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</div></div>");
									var board_data=JSON.parse(data[0]);
									
									$.each(board_data,function(i){
									    var d = new Date(board_data[i].BOARD_RGDATE);
									    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
									    //+ " "+ leadingZeros(d.getHours(),2) +":"+ leadingZeros(d.getMinutes(),2);

										$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="description">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
										+'<div class="col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a href="#" id="board_data_read'+i+'">'+board_data[i].BOARD_TITLE+'</a></div></div></div></div>');
										
										$("#board_data_read"+i).click(function(){
											blogListDetails(board_data[i].BOARD_NO);
					                        $("div[id='blogListDetail'].modal").modal();
										});
									});
								}
							});
						});
					}
					
					//다음
					if(b_endPage<pageCount){
						$("#myPage_member_board_list_after").css("display","inline-block");					
					}
					
					if(b_endPage>=pageCount){
						$("#myPage_member_board_list_after").css("display","none");
					}
				}			
			});
		};
		
		//다음클릭시
		$("#board_paging_after").click(function(){
			$.ajax({
				type:'POST',
				url:'${root}/member/board_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					pageNumber:b_startPage+pageBlock
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					//alert(responseData);
					
					var data=responseData.split("|");
					var boardSize=data[1];
					var count=data[2];
					var currentPage=data[3];
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					b_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					b_endPage=b_startPage+pageBlock-1;
					
					$("#myPage_member_board_list_title").empty();
					$("#myPage_member_board_list_content").empty();
					$("#myPage_member_board_list_title").append("<div class='col-md-1'><div class='header'>번호</div></div><div class='col-md-2'><div class='header'>작성일</div></div><div class='col-md-2'><div class='header'>카테고리</div></div><div class='col-md-7'><div class='header'>제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</div></div>");
					var board_data=JSON.parse(data[0]);
					
					$.each(board_data,function(i){
					    var d = new Date(board_data[i].BOARD_RGDATE);
					    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
					    //+ " "+ leadingZeros(d.getHours(),2) +":"+ leadingZeros(d.getMinutes(),2);

						$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="description">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
						+'<div class="col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a href="#" id="board_data_read'+i+'">'+board_data[i].BOARD_TITLE+'</a></div></div></div></div>');
						
						$("#board_data_read"+i).click(function(){
							blogListDetails(board_data[i].BOARD_NO);
	                        $("div[id='blogListDetail'].modal").modal();
						});
					});
									
					if(b_endPage>pageCount){
						b_endPage=pageCount;
					}
					
					//이전
					if(b_startPage>pageBlock){
						//alert("block");
						$("#myPage_member_board_list_before").css("display","inline-block");
						$("#myPage_member_board_list_pageNum").css("display","none");
						$("#myPage_member_board_list_pageNum").css("display","inline-block");
					}
					
					if(b_startPage<=pageBlock){
						$("#myPage_member_board_list_before").css("display","none");
					}
					
					//페이지번호
					$("#myPage_member_board_list_pageNum").empty();
					for(var i=b_startPage;i<=b_endPage;i++){
						$("#myPage_member_board_list_pageNum").append("<a href='#' id='board_paging_num"+i+"'>"+i+"</a>");
						$("#board_paging_num"+i).click(function(){
							//alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/board_info.do',
								data:{
									member_id:sessionStorage.getItem("email"),
									pageNumber:$(this).text()
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									//alert(responseData);
									
									var data=responseData.split("|");									
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
									
									$("#myPage_member_board_list_title").empty();
									$("#myPage_member_board_list_content").empty();
									$("#myPage_member_board_list_title").append("<div class='col-md-1'><div class='header'>번호</div></div><div class='col-md-2'><div class='header'>작성일</div></div><div class='col-md-2'><div class='header'>카테고리</div></div><div class='col-md-7'><div class='header'>제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</div></div>");
									var board_data=JSON.parse(data[0]);
									
									$.each(board_data,function(i){
									    var d = new Date(board_data[i].BOARD_RGDATE);
									    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
									    //+ " "+ leadingZeros(d.getHours(),2) +":"+ leadingZeros(d.getMinutes(),2);

										$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="description">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
										+'<div class="col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a href="#" id="board_data_read'+i+'">'+board_data[i].BOARD_TITLE+'</a></div></div></div></div>');
										
										$("#board_data_read"+i).click(function(){
											blogListDetails(board_data[i].BOARD_NO);
					                        $("div[id='blogListDetail'].modal").modal();
										});
									});
								}
							});
						});
					}
					
					//다음
					if(b_endPage<pageCount){
						$("#myPage_member_board_list_after").css("display","inline-block");
					}
					
					if(b_endPage>=pageCount){
						$("#myPage_member_board_list_after").css("display","none");
					}					
				}
			});
		});
		
		
		//이전클릭시
		$("#board_paging_before").click(function(){
			$.ajax({
				type:'POST',
				url:'${root}/member/board_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					pageNumber:b_startPage-pageBlock
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					
					var data=responseData.split("|");					
					var boardSize=data[1];
					var count=data[2];
					var currentPage=data[3];
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					//alert(pageCount);
					b_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					b_endPage=b_startPage+pageBlock-1;
					
					$("#myPage_member_board_list_title").empty();
					$("#myPage_member_board_list_content").empty();
					$("#myPage_member_board_list_title").append("<div class='col-md-1'><div class='header'>번호</div></div><div class='col-md-2'><div class='header'>작성일</div></div><div class='col-md-2'><div class='header'>카테고리</div></div><div class='col-md-7'><div class='header'>제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</div></div>");
					var board_data=JSON.parse(data[0]);
					
					$.each(board_data,function(i){
					    var d = new Date(board_data[i].BOARD_RGDATE);
					    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
					    //+ " "+ leadingZeros(d.getHours(),2) +":"+ leadingZeros(d.getMinutes(),2);

						$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="description">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
						+'<div class="col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a href="#" id="board_data_read'+i+'">'+board_data[i].BOARD_TITLE+'</a></div></div></div></div>');
						
						$("#board_data_read"+i).click(function(){
							blogListDetails(board_data[i].BOARD_NO);
	                        $("div[id='blogListDetail'].modal").modal();
						});
					});
										
					//이전
					if(b_startPage>pageBlock){
						$("#myPage_member_board_list_before").css("display","inline-block");					
					}
					
					if(b_startPage<=pageBlock){
						$("#myPage_member_board_list_before").css("display","none");
					}
					
					$("#myPage_member_board_list_pageNum").empty();
					for(var i=b_startPage;i<=b_endPage;i++){
						$("#myPage_member_board_list_pageNum").append("<a href='#' id='board_paging_num"+i+"'>"+i+"</a>");
						$("#board_paging_num"+i).click(function(){
							//alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/board_info.do',
								data:{
									member_id:sessionStorage.getItem("email"),
									pageNumber:$(this).text()
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									
									var data=responseData.split("|");									
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
																
									$("#myPage_member_board_list_title").empty();
									$("#myPage_member_board_list_content").empty();
									$("#myPage_member_board_list_title").append("<div class='col-md-1'><div class='header'>번호</div></div><div class='col-md-2'><div class='header'>작성일</div></div><div class='col-md-2'><div class='header'>카테고리</div></div><div class='col-md-7'><div class='header'>제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</div></div>");
									var board_data=JSON.parse(data[0]);
									
									$.each(board_data,function(i){
									    var d = new Date(board_data[i].BOARD_RGDATE);
									    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
									    //+ " "+ leadingZeros(d.getHours(),2) +":"+ leadingZeros(d.getMinutes(),2);

										$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="description">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
										+'<div class="col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a href="#" id="board_data_read'+i+'">'+board_data[i].BOARD_TITLE+'</a></div></div></div></div>');
										
										$("#board_data_read"+i).click(function(){
											blogListDetails(board_data[i].BOARD_NO);
					                        $("div[id='blogListDetail'].modal").modal();
										});
									});
								}
							});
						});
					}
									
					//다음
					if(b_endPage<pageCount){
						$("#myPage_member_board_list_after").css("display","inline-block");
					}
					
					if(b_endPage>=pageCount){
						$("#myPage_member_board_list_after").css("display","none");
					}
				}
			});
		});
		
		//즐겨찾기정보
		function myPageFavoriteInfo(){	
			$("#myPage_member_favorite_list_title").empty();
			$("#myPage_member_favorite_list_content").empty();
			$("#myPage_member_favorite_list_pageNum").empty();
			$.ajax({
				type:'POST',
				url:'${root}/member/favorite_info.do',
				data:{
					member_id:sessionStorage.getItem("email")					
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					
					var data=responseData.split("|");					
					var boardSize=data[1];
					var count=data[2];
					var currentPage=data[3];
					
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					f_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					f_endPage=f_startPage+pageBlock-1;
					
					$("#myPage_member_favorite_list_title").append("<div class='col-md-1'><div class='header'>순번</div></div><div class='col-md-2'><div class='header'>등록일</div></div><div class='col-md-2'><div class='header'>글번호</div></div><div class='col-md-7'><div class='header'>제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</div></div>");
					var favorite_data=JSON.parse(data[0]);
					
					$.each(favorite_data,function(i){
						var d = new Date(favorite_data[i].FAVORITE_RGDATE);
					    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
					    //+ " "+ leadingZeros(d.getHours(),2) +":"+ leadingZeros(d.getMinutes(),2);
				
						$("#myPage_member_favorite_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+favorite_data[i].FAVORITE_NO+'</div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="description">'+favorite_data[i].BOARD_NO+'</div></div></div>'
						+'<div class="col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a href="#" id="favorite_data_read'+i+'">'+favorite_data[i].BOARD_TITLE+'</a></div></div></div></div>');
						
						$("#favorite_data_read"+i).click(function(){
							blogListDetails(favorite_data[i].BOARD_NO);
	                        $("div[id='blogListDetail'].modal").modal();
						});
					});
					
					if(f_endPage>pageCount){
						f_endPage=pageCount;
					}
					
					//페이징
					
					//이전
					if(f_startPage>pageBlock){
						$("#myPage_member_favorite_list_before").css("display","inline-block");
					}
					
					if(f_startPage<=pageBlock){
						$("#myPage_member_favorite_list_before").css("display","none");
					}
					
					
					for(var i=f_startPage;i<=f_endPage;i++){
						$("#myPage_member_favorite_list_pageNum").append("<a href='#' id='favorite_paging_num"+i+"'>"+i+"</a>");
						$("#favorite_paging_num"+i).click(function(){
							$.ajax({
								type:'POST',
								url:'${root}/member/favorite_info.do',
								data:{
									member_id:sessionStorage.getItem("email"),
									pageNumber:$(this).text()
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									//alert(responseData);
									
									var data=responseData.split("|");									
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
									
									$("#myPage_member_favorite_list_title").empty();
									$("#myPage_member_favorite_list_content").empty();
									$("#myPage_member_favorite_list_title").append("<div class='col-md-1'><div class='header'>순번</div></div><div class='col-md-2'><div class='header'>등록일</div></div><div class='col-md-2'><div class='header'>글번호</div></div><div class='col-md-7'><div class='header'>제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</div></div>");
									var favorite_data=JSON.parse(data[0]);
									
									$.each(favorite_data,function(i){
										var d = new Date(favorite_data[i].FAVORITE_RGDATE);
									    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
									    //+ " "+ leadingZeros(d.getHours(),2) +":"+ leadingZeros(d.getMinutes(),2);
								
										$("#myPage_member_favorite_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+favorite_data[i].FAVORITE_NO+'</div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="description">'+favorite_data[i].BOARD_NO+'</div></div></div>'
										+'<div class="col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a href="#" id="favorite_data_read'+i+'">'+favorite_data[i].BOARD_TITLE+'</a></div></div></div></div>');
										
										$("#favorite_data_read"+i).click(function(){
											blogListDetails(favorite_data[i].BOARD_NO);
					                        $("div[id='blogListDetail'].modal").modal();
										});
									});
								}
							});
						});
					}
					
					//다음
					if(f_endPage<pageCount){
						$("#myPage_member_favorite_list_after").css("display","inline-block");
						
						
					}
					
					if(f_endPage>=pageCount){
						$("#myPage_member_favorite_list_after").css("display","none");
					}
				}			
			});
		};
		
		//다음클릭시
		$("#favorite_paging_after").click(function(){
			$.ajax({
				type:'POST',
				url:'${root}/member/favorite_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					pageNumber:f_startPage+pageBlock
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					//alert(responseData);
					
					var data=responseData.split("|");				
					var boardSize=data[1];
					var count=data[2];
					var currentPage=data[3];
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					//alert(pageCount);
					f_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					f_endPage=f_startPage+pageBlock-1;
					
					$("#myPage_member_favorite_list_title").empty();
					$("#myPage_member_favorite_list_content").empty();
					$("#myPage_member_favorite_list_title").append("<div class='col-md-1'><div class='header'>순번</div></div><div class='col-md-2'><div class='header'>등록일</div></div><div class='col-md-2'><div class='header'>글번호</div></div><div class='col-md-7'><div class='header'>제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</div></div>");
					var favorite_data=JSON.parse(data[0]);
					
					$.each(favorite_data,function(i){
						var d = new Date(favorite_data[i].FAVORITE_RGDATE);
					    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
					    //+ " "+ leadingZeros(d.getHours(),2) +":"+ leadingZeros(d.getMinutes(),2);
				
						$("#myPage_member_favorite_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+favorite_data[i].FAVORITE_NO+'</div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="description">'+favorite_data[i].BOARD_NO+'</div></div></div>'
						+'<div class="col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a href="#" id="favorite_data_read'+i+'">'+favorite_data[i].BOARD_TITLE+'</a></div></div></div></div>');
						
						$("#favorite_data_read"+i).click(function(){
							blogListDetails(favorite_data[i].BOARD_NO);
	                        $("div[id='blogListDetail'].modal").modal();
						});
					});
					
					if(f_endPage>pageCount){
						f_endPage=pageCount;
					}
					
					//이전
					if(f_startPage>pageBlock){
						$("#myPage_member_favorite_list_before").css("display","inline-block");
						$("#myPage_member_favorite_list_pageNum").css("display","none");
						$("#myPage_member_favorite_list_pageNum").css("display","inline-block");
					}
					
					if(f_startPage<=pageBlock){
						$("#myPage_member_favorite_list_before").css("display","none");
					}
					
					$("#myPage_member_favorite_list_pageNum").empty();
					for(var i=f_startPage;i<=f_endPage;i++){
						$("#myPage_member_favorite_list_pageNum").append("<a href='#' id='favorite_paging_num"+i+"'>"+i+"</a>");
						$("#favorite_paging_num"+i).click(function(){
							//alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/favorite_info.do',
								data:{
									member_id:sessionStorage.getItem("email"),
									pageNumber:$(this).text()
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									
									var data=responseData.split("|");									
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
									
									$("#myPage_member_favorite_list_title").empty();
									$("#myPage_member_favorite_list_content").empty();
									$("#myPage_member_favorite_list_title").append("<div class='col-md-1'><div class='header'>순번</div></div><div class='col-md-2'><div class='header'>등록일</div></div><div class='col-md-2'><div class='header'>글번호</div></div><div class='col-md-7'><div class='header'>제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</div></div>");
									var favorite_data=JSON.parse(data[0]);
									
									$.each(favorite_data,function(i){
										var d = new Date(favorite_data[i].FAVORITE_RGDATE);
									    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
									    //+ " "+ leadingZeros(d.getHours(),2) +":"+ leadingZeros(d.getMinutes(),2);
								
										$("#myPage_member_favorite_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+favorite_data[i].FAVORITE_NO+'</div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="description">'+favorite_data[i].BOARD_NO+'</div></div></div>'
										+'<div class="col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a href="#" id="favorite_data_read'+i+'">'+favorite_data[i].BOARD_TITLE+'</a></div></div></div></div>');
										
										$("#favorite_data_read"+i).click(function(){
											blogListDetails(favorite_data[i].BOARD_NO);
					                        $("div[id='blogListDetail'].modal").modal();
										});
									});
								}
							});
						});
					}

					//다음
					if(f_endPage<pageCount){
						$("#myPage_member_favorite_list_after").css("display","inline-block");
					}
					
					if(f_endPage>=pageCount){
						$("#myPage_member_favorite_list_after").css("display","none");
					}
					
				}
			});
		});
		
		
		//이전클릭시
		$("#favorite_paging_before").click(function(){
			$.ajax({
				type:'POST',
				url:'${root}/member/favorite_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					pageNumber:f_startPage-pageBlock
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					
					var data=responseData.split("|");					
					var boardSize=data[1];
					var count=data[2];
					var currentPage=data[3];
					var pageCount=parseInt(count/boardSize)+(count%boardSize==0 ? 0:1);
					
					f_startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					f_endPage=f_startPage+pageBlock-1;
					
					$("#myPage_member_favorite_list_title").empty();
					$("#myPage_member_favorite_list_content").empty();
					$("#myPage_member_favorite_list_title").append("<div class='col-md-1'><div class='header'>순번</div></div><div class='col-md-2'><div class='header'>등록일</div></div><div class='col-md-2'><div class='header'>글번호</div></div><div class='col-md-7'><div class='header'>제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</div></div>");
					var favorite_data=JSON.parse(data[0]);
					
					$.each(favorite_data,function(i){
						var d = new Date(favorite_data[i].FAVORITE_RGDATE);
					    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
					    //+ " "+ leadingZeros(d.getHours(),2) +":"+ leadingZeros(d.getMinutes(),2);
				
						$("#myPage_member_favorite_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+favorite_data[i].FAVORITE_NO+'</div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="description">'+favorite_data[i].BOARD_NO+'</div></div></div>'
						+'<div class="col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a href="#" id="favorite_data_read'+i+'">'+favorite_data[i].BOARD_TITLE+'</a></div></div></div></div>');
						
						$("#favorite_data_read"+i).click(function(){
							blogListDetails(favorite_data[i].BOARD_NO);
	                        $("div[id='blogListDetail'].modal").modal();
						});
					});
					
					//이전
					if(f_startPage>pageBlock){
						$("#myPage_member_favorite_list_before").css("display","inline-block");
					}
					
					if(f_startPage<=pageBlock){
						$("#myPage_member_favorite_list_before").css("display","none");
					}
					
					$("#myPage_member_favorite_list_pageNum").empty();
					for(var i=f_startPage;i<=f_endPage;i++){
						$("#myPage_member_favorite_list_pageNum").append("<a href='#' id='favorite_paging_num"+i+"'>"+i+"</a>");
						$("#favorite_paging_num"+i).click(function(){
							//alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/favorite_info.do',
								data:{
									member_id:sessionStorage.getItem("email"),
									pageNumber:$(this).text()
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									//alert(responseData);
									
									var data=responseData.split("|");									
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
									
									
									$("#myPage_member_favorite_list_title").empty();
									$("#myPage_member_favorite_list_content").empty();
									$("#myPage_member_favorite_list_title").append("<div class='col-md-1'><div class='header'>순번</div></div><div class='col-md-2'><div class='header'>등록일</div></div><div class='col-md-2'><div class='header'>글번호</div></div><div class='col-md-7'><div class='header'>제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</div></div>");
									var favorite_data=JSON.parse(data[0]);
									
									$.each(favorite_data,function(i){
										var d = new Date(favorite_data[i].FAVORITE_RGDATE);
									    var dt =leadingZeros(d.getFullYear(), 4) + '/' +leadingZeros(d.getMonth() + 1, 2) + '/' +leadingZeros(d.getDate(), 2);
									    //+ " "+ leadingZeros(d.getHours(),2) +":"+ leadingZeros(d.getMinutes(),2);
								
										$("#myPage_member_favorite_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+favorite_data[i].FAVORITE_NO+'</div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="type">'+dt+'</div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="description">'+favorite_data[i].BOARD_NO+'</div></div></div>'
										+'<div class="col-md-7" style="text-align:left;"><div class="cell"><div class="description"><a href="#" id="favorite_data_read'+i+'">'+favorite_data[i].BOARD_TITLE+'</a></div></div></div></div>');
										
										$("#favorite_data_read"+i).click(function(){
											blogListDetails(favorite_data[i].BOARD_NO);
					                        $("div[id='blogListDetail'].modal").modal();
										});
									});
									
								}
							});
						});
					}
					
					//다음
					if(f_endPage<pageCount){
						$("#myPage_member_favorite_list_after").css("display","inline-block");
					}
					
					if(f_endPage>=pageCount){
						$("#myPage_member_favorite_list_after").css("display","none");
					}
				}
			});
		});
	});
}

</script>
<!-- myPage_boardInfo -->

<link rel="stylesheet" href="${root }/css/layer.css" type="text/css"/>
</head>
<body>
<div class="container">
	<div class="col-md-2 col-xs-2 col-sm-2">
	    <nav class="nav-sidebar">
			<ul class="nav tabs">
			  <li id="aaa" class="abc active"><a id="member_info_tabBtn" href="#tab1" data-toggle="tab">회원정보</a></li>
	          <li id="bbb" class="abc"><a id="myPage_point_info_tabBtn" href="#tab2" data-toggle="tab">포인트</a></li>
	          <li id="ccc" class="abc"><a id="myPage_board_info_tabBtn" href="#tab3" data-toggle="tab">게시글</a></li>
	          <li id="ddd" class="abc"><a id="myPage_favorite_info_tabBtn" href="#tab4" data-toggle="tab">즐겨찾기</a></li>  
	          <li id="eee" class="abc"><a id="myPage_coupon_info_tabBtn" href="#tab5" data-toggle="tab">쿠폰</a></li>                              
			</ul>
		</nav>
	</div>
<!-- tab content -->
	<div class="tab-content">
		<div class="tab-pane active text-style" id="tab1">
 			 <div class=" col-md-7 col-lg-7 col-xs-7 col-sm-7 " style="font-size:14px;"> 
                  <table class="table table-user-information" style="">
                    <tbody>
                      <tr>
                        <td class="tableFontSize">계정정보:</td>
                        <td class="tableFontSize" id="myPage_member_id"></td>
                      </tr>
                      <tr>
                        <td class="tableFontSize">이름:</td>
                        <td class="tableFontSize" id="myPage_member_name"></td>
                      </tr>
                      <tr>
                        <td class="tableFontSize">회원등급:</td>
                        <td class="tableFontSize" id="myPage_member_rate"></td>
                      </tr>
                     
                      <tr>
                        <td class="tableFontSize">포인트:</td>
                        <td class="tableFontSize"><a href="#tab2" data-toggle="tab" id="myPage_member_point_total"></a></td>
                      </tr>
                      
                      <tr>
                        <td class="tableFontSize">게시글:</td>
                        <td class="tableFontSize"><a href="#tab3" data-toggle="tab" id="myPage_member_board_total"></a></td>
                      </tr>
                      
                      <tr>
                        <td class="tableFontSize">즐겨찾기:</td>
                        <td class="tableFontSize"><a href="#tab4" data-toggle="tab" id="myPage_member_favorite_total"></a></td>
                      </tr>
                      
                      <tr>
                        <td class="tableFontSize">쿠폰:</td>
                        <td class="tableFontSize"><a href="#tab5" data-toggle="tab" id="myPage_member_coupon_total"></a></td>
                      </tr>
                      
                      <tr>
                        <td class="tableFontSize">가입일:</td>
                        <td class="tableFontSize" id="myPage_member_joindate"></td>
                      </tr>
                    </tbody>
                  </table>
                  
                  <a data-toggle="modal" href="#blogmap_myPageUpdate" id="myPage_update_btn" class="btn btn-primary">정보수정</a>
                  <a data-toggle="modal" href="#blogmap_myPageDelete" id="myPage_delete_btn" class="btn btn-primary">회원탈퇴</a>
                  <a data-toggle="modal" href="#blogmap_fb_myPageDelete" id="myPage_fb_delete_btn" class="btn btn-primary" style="display:'none';">회원탈퇴</a>
                </div>
 
		</div>
		<div class="tab-pane text-style" id="tab2">
			<div class="col-xs-9 col-md-9 col-sm-9 col-lg-9" id="myPage_member_point_list">
				<h4 style="font-size:16px;">포인트 정보</h4>
			
				<div class="method" style="text-align:center;font-size:15px;" >
			        <div class="row margin-0 list-header hidden-sm hidden-xs" id="myPage_member_point_list_title" style="text-align:center;">
			        </div>
			
					<div id="myPage_member_point_list_content">
			        </div>
			    </div>
					
				<div id="myPage_member_point_paging" class="container" style="width:100%;text-align:center;">
					<ul class="pagination">
		              <li id="myPage_member_point_list_before" style="display:'none';"><a href="#" id="point_paging_before">«</a></li>
		              <li id="myPage_member_point_list_pageNum"></li>
		              <li id="myPage_member_point_list_after" style="display:'none';"><a href="#" id="point_paging_after">»</a></li>
           			</ul>
				</div> 
				
            </div>
		</div>
		
		<div class="tab-pane text-style" id="tab3">
  			<div class="col-xs-9 col-md-9 col-sm-9 col-lg-9" id="myPage_member_board_list">
				<h4 style="font-size:16px;">게시글 정보</h4>
			
				<div class="method" style="text-align:center;font-size:15px;">
			        <div class="row margin-0 list-header hidden-sm hidden-xs" id="myPage_member_board_list_title" style="text-align:center;">
			        </div>
			
					<div id="myPage_member_board_list_content">
			        </div>
			    </div>
					
				<div id="myPage_member_board_paging" class="container" style="width:100%;text-align:center;">
					<ul class="pagination">
		              <li id="myPage_member_board_list_before" style="display:'none';"><a href="#" id="board_paging_before">«</a></li>
		              <li id="myPage_member_board_list_pageNum"></li>
		              <li id="myPage_member_board_list_after" style="display:'none';"><a href="#" id="board_paging_after">»</a></li>
           			</ul>
				</div> 
				
            </div>
		</div>
		
		<div class="tab-pane text-style" id="tab4">
  			<div class="col-xs-9 col-md-9 col-sm-9 col-lg-9" id="myPage_member_favorite_list">
				<h4 style="font-size:16px;">즐겨찾기 정보</h4>
			
				<div class="method" style="text-align:center;font-size:15px;">
			        <div class="row margin-0 list-header hidden-sm hidden-xs" id="myPage_member_favorite_list_title" style="text-align:center;">
			        </div>
			
					<div id="myPage_member_favorite_list_content">
			        </div>
			    </div>
    
				<div id="myPage_member_favorite_paging" class="container" style="width:100%;text-align:center;">
					<ul class="pagination">
		              <li id="myPage_member_favorite_list_before" style="display:'none';"><a href="#" id="favorite_paging_before">«</a></li>
		              <li id="myPage_member_favorite_list_pageNum"></li>
		              <li id="myPage_member_favorite_list_after" style="display:'none';"><a href="#" id="favorite_paging_after">»</a></li>
           			</ul>
				</div> 
            </div>
		</div>
		
		<!-- 쿠폰정보 -->
		<div class="tab-pane text-style" id="tab5">
		<div style="font-size: 14px;">
			<input type="radio" name="mycoupon_use" id="usable"/><span>사용가능쿠폰</span> &nbsp;&nbsp;
			<input type="radio" name="mycoupon_use" id="unusable"/><span>사용불가능쿠폰</span>&nbsp;&nbsp;
		</div><br/>
      
	        <div class="row">
		    	<div class="col-sm-8 col-xs-8 col-md-8" id="myPage_member_coupon_list_content">					
		        </div> 		
			</div>
	  
	        <div class="row">
	        	<center>
	        	<div id="myPage_member_coupon_paging" class="container" style="width:100%;text-align:center;">
						<ul class="pagination">
			              <li id="myPage_member_coupon_list_before" style="display:'none';"><a href="#" id="coupon_paging_before">«</a></li>
			              <li id="myPage_member_coupon_list_pageNum"></li>
			              <li id="myPage_member_coupon_list_after" style="display:'none';"><a href="#" id="coupon_paging_after">»</a></li>
	           			</ul>
				</div> 
				</center>
	        </div>     
        </div>	
	</div>
</div>
	
</body>
</html>
