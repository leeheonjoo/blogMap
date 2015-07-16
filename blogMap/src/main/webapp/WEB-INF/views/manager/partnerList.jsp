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
<script type="text/javascript">

/******************************************/ 
/*			          					  */
/*			제휴업체 탭 클릭시 실행			  */
/*										  */
/******************************************/ 
	function getPartnerList(){
		//alert("getPartnerList : "+ searchTag);
		$("#partnerListResult").empty();	// 제휴업체 정보를 불러오기전 리셋(중복 삽입을 방지하기 위해)
		//alert("파트너리스트")
		$.ajax({
			type:'get',
			url:'${root}/manager/partnerInfo.do',
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				var data=JSON.parse(responseData);
			   // alert(data);
				
			    if(data.length <1){
					alert("데이타가 없습니다.");
					return false;
				}
				
				$.each(data, function(i){					
					var getRgdate = new Date(data[i].partner_rgdate);	// 등록일 날짜 변환
					var rgyear = getRgdate.getFullYear();
					var rgmonth = getRgdate.getMonth() + 1;
					var rgday = getRgdate.getDate();
					var rgDate = rgyear + "년 " + rgmonth + "월 "	+ rgday + "일";
					//alert(rgDate);
					
					var getYdate = new Date(data[i].partner_rgdate);	// 승인일 날짜 변환
					var yyear = getYdate.getFullYear();
					var ymonth = getYdate.getMonth() + 1;
					var yday = getYdate.getDate();
					var yDate = yyear + "년 " + ymonth + "월 "	+ yday + "일";
					//alert(yDate);
					 if(data[i].partner_yn == "Y"){ 
							$("#partnerListResult").append("<tr style='text-align:center;'>"
									+ "<td>" + data[i].partner_no + "</td>"			// 아이디
									+ "<td>" + data[i].member_id + "</td>"			// 이름	
									+ "<td><a data-toggle='modal' href='#partnerDetail' class='btn-example' id='partner"+data[i].partner_no+"'>" + data[i].partner_name + "</a></td>"		//
									+ "<td>" + data[i].partner_phone + "</td>"		//							
									+ "<td>" + rgDate + "</td>"						// 등록일
									+ "<td>" + yDate + "</td>"		//
									+ "<td>"
									+"<input type='button' id='partner' value = '삭제' name='"+data[i].member_id+"'/></td>"
									+ "</tr>");
					 }else if(data[i].partner_yn =="N"){ 
							$("#partnerListResult").append("<tr style='text-align:center;'>"
									+ "<td>" + data[i].partner_no + "</td>"			// 아이디
									+ "<td>" + data[i].member_id + "</td>"			// 이름								
									+ "<td><a data-toggle='modal' href='#partnerDetail' class='btn-example' id='partner"+data[i].partner_no+"'>" + data[i].partner_name + "</a></td>"		//
									+ "<td>" + data[i].partner_phone + "</td>"		//							
									+ "<td>" + rgDate + "</td>"						// 등록일
									+ "<td>" + yDate + "</td>"		//
									+ "<td>"
									+"<input type='button' id='partner' value = '승인' name='"+data[i].member_id+"'/></td>"
									+ "</tr>");
					}
					
					$("#partner"+data[i].partner_no).click(function(){
						/* $("#partner_data-body").empty(); */
						partnerDetail(data[i].partner_no);
					});
				});
								
				$("#partner[value='승인']").click(function(){			// 승인버튼을 클릭시 실행
					var tagId = $(this).attr('name');		
					var check = confirm(tagId + "를(을) 승인 하시겠습니까?");
					if(check == "1"){
						partnerSubmit(tagId);
					}else{
						alert("취소하셨습니다.");
					}
				});
				
				$("#partner[value='삭제']").click(function(){			// 삭제버튼을 클릭시 실행
					var tagId = $(this).attr('name');
					var check=confirm(tagId + "를(을) 삭제 하시겠습니까?");
					if(check == "1"){
						partnerDelete(tagId);
					}else{
						alert("취소하셨습니다.");
					}
				});			
			
			},error:function(){
				alert("에러가 발생하였습니다.");
			}
			
		});
		
		function partnerSubmit(tagId){
			$.ajax({
				type:'get',
				url:'${root}/manager/partnerSubmit.do?id='+tagId,
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					
					var submitChcek=JSON.parse(responseData);
					alert("partnerSubmit :" + submitChcek);
					
					if(!submitChcek){
						alert("데이타가 없습니다.");
						return false;
					};
					
					if(submitChcek.length >= 1){
						alert("승인되었습니다.");
						getPartnerList();
					};
					
				},error:function(submitChcek){
					alert("에러가 발생하였습니다.");
				}
			});
		}
		
		function partnerDelete(tagId){	
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
			
		}
		
		function partnerDetail(partnerNo){
			$("#partnerDetailResult").empty();
			$.ajax({
				type:'get',
				url:'${root}/manager/partnerDetail.do?partner_no='+partnerNo,
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					var data=JSON.parse(responseData);
					//var filename=data.partner_pic_name
					
					$("#partnerDetailResult").append($("#partnerDetailMain").clone().css("display","block"));
					$("#partnerDetailMain:last-child #member_id").html(data.member_id);
					$("#partnerDetailMain:last-child #partner_img").attr("src", "${root}/pds/partner/"+data.partner_pic_name);
					$("#partnerDetailMain:last-child #partner_name").html(data.partner_name);
					$("#partnerDetailMain:last-child #partner_phone").html(data.partner_phone);
					$("#partnerDetailMain:last-child #partner_address").html(data.partner_addr);
					$("#partnerDetailMain:last-child #partner_rgdate").html(data.partner_rgdate);					
					$("#partnerDetailMain:last-child #partner_ydate").html(data.partner_ydate);
					
					if(data.partner_yn == "Y"){
						//$("#partner_submit").css("display", "none");
						$("#partnerDetailMain:last-child #partner_detail_button").attr({"name":data.member_id, "value":"삭제"});
					}else if(data.partner_yn == "N"){
						//$("#partner_delete").css("display", "none");
						$("#partnerDetailMain:last-child #partner_detail_button").attr({"name":data.member_id, "value":"승인"});
					}
					
					$("#partner_detail_button[value='삭제']").click(function(){
						var tagId = $(this).attr('name');
						var check=confirm(tagId + "를(을) 삭제 하시겠습니까?");
						if(check == "1"){
							partnerDelete(tagId);
						}else{
							alert("취소하셨습니다.");
						}
					});
					
					$("#partner_detail_button[value='승인']").click(function(){			// 승인버튼을 클릭시 실행
						var tagId = $(this).attr('name');
						var check = confirm(tagId + "를(을) 승인 하시겠습니까?");
						if(check == "1"){
							partnerSubmit(tagId);
						}else{
							alert("취소하셨습니다.");
						}
					});
				},
				error:function(data){
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
		$("#searchPartner").click(function(){
			//alert("검색버튼");
			var searchTag=$("input[id='searchTag']").val();
			alert(searchTag);
			/* searchPartnerList(searchTag); */
			$("#partnerListResult").empty();	// 제휴업체 정보를 불러오기전 리셋(중복 삽입을 방지하기 위해)
			$.ajax({
				type:'get',
				url:'${root}/manager/searchPartnerInfo.do?name=' + searchTag,
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					$("input[id='searchTag']").val("");
					var data=JSON.parse(responseData);
					//alert(data);
					
					if(data.length <1){
						alert("데이타가 없습니다.");
						return false;
					}
					
					$.each(data, function(i){
						var getRgdate = new Date(data[i].partner_rgdate);	// 등록일 날짜 변환
						var rgyear = getRgdate.getFullYear();
						var rgmonth = getRgdate.getMonth() + 1;
						var rgday = getRgdate.getDate();
						var rgDate = rgyear + "년 " + rgmonth + "월 "	+ rgday + "일";
						//alert(rgDate);
						
						var getYdate = new Date(data[i].partner_rgdate);	// 승인일 날짜 변환
						var yyear = getYdate.getFullYear();
						var ymonth = getYdate.getMonth() + 1;
						var yday = getYdate.getDate();
						var yDate = yyear + "년 " + ymonth + "월 "	+ yday + "일";
						//alert(yDate);
						 if(data[i].partner_yn == "Y"){ 
								$("#partnerListResult").append("<tr style='text-align:center;'>"
										+ "<td>" + data[i].partner_no + "</td>"			// 아이디
										+ "<td>" + data[i].member_id + "</td>"			// 이름	
										+ "<td><a data-toggle='modal' href='#partnerDetail' class='btn-example' id='partner"+data[i].partner_no+"'>" + data[i].partner_name + "</a></td>"		//
										+ "<td>" + data[i].partner_phone + "</td>"		//							
										+ "<td>" + rgDate + "</td>"						// 등록일
										+ "<td>" + yDate + "</td>"		//
										+ "<td>"
										+"<input type='button' id='partner' value = '삭제' name='"+data[i].member_id+"'/></td>"
										+ "</tr>");
						 }else if(data[i].partner_yn =="N"){ 
								$("#partnerListResult").append("<tr style='text-align:center;'>"
										+ "<td>" + data[i].partner_no + "</td>"			// 아이디
										+ "<td>" + data[i].member_id + "</td>"			// 이름								
										+ "<td><a data-toggle='modal' href='#partnerDetail' class='btn-example' id='partner"+data[i].partner_no+"'>" + data[i].partner_name + "</a></td>"		//
										+ "<td>" + data[i].partner_phone + "</td>"		//							
										+ "<td>" + rgDate + "</td>"						// 등록일
										+ "<td>" + yDate + "</td>"		//
										+ "<td>"
										+"<input type='button' id='partner' value = '승인' name='"+data[i].member_id+"'/></td>"
										+ "</tr>");
						}
						
						$("#partner"+data[i].partner_no).click(function(){
							/* $("#partner_data-body").empty(); */
							partnerDetail(data[i].partner_no);
						});
					});
									
					$("#partner[value='승인']").click(function(){			// 승인버튼을 클릭시 실행
						var tagId = $(this).attr('name');		
						var check = confirm(tagId + "를(을) 승인 하시겠습니까?");
						if(check == "1"){
							partnerSubmit(tagId);
						}else{
							alert("취소하셨습니다.");
						}
					});
					
					$("#partner[value='삭제']").click(function(){			// 삭제버튼을 클릭시 실행
						var tagId = $(this).attr('name');
						var check=confirm(tagId + "를(을) 삭제 하시겠습니까?");
						if(check == "1"){
							partnerDelete(tagId);
						}else{
							alert("취소하셨습니다.");
						}
					});		
				
				},error:function(){
					alert("에러가 발생하였습니다.");
				}
				
			});
			
			function partnerSubmit(tagId){
				$.ajax({
					type:'get',
					url:'${root}/manager/partnerSubmit.do?id='+tagId,
					contentType:'application/x-www-form-urlencoded;charset=UTF-8',
					success:function(responseData){
						
						var submitChcek=JSON.parse(responseData);
						alert("partnerSubmit :" + submitChcek);
						
						if(!submitChcek){
							alert("데이타가 없습니다.");
							return false;
						};
						
						if(submitChcek == "1"){
							alert("승인되었습니다.");
							getPartnerList();
						};
						
					},error:function(submitChcek){
						alert("에러가 발생하였습니다.");
					}
				});
			}
			
			function partnerDelete(tagId){	
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
				
			}
			
			
			function partnerDetail(partnerNo){
				$("#partnerDetailResult").empty();
				$.ajax({
					type:'get',
					url:'${root}/manager/partnerDetail.do?partner_no='+partnerNo,
					contentType:'application/x-www-form-urlencoded;charset=UTF-8',
					success:function(responseData){
						var data=JSON.parse(responseData);
						var fileName = "${root }/css/manager/images/star0.jpg"
						//var fileName = data.partner_pic_path + data.partner_pic_name;
						//alert(fileName);
						
						$("#partnerDetailResult").append($("#partnerDetailMain").clone().css("display","block"));
						$("#partnerDetailMain:last-child #partner_img").attr("src", fileName);
						$("#partnerDetailMain:last-child #partner_name").html(data.partner_name);
						$("#partnerDetailMain:last-child #partner_phone").html(data.partner_phone);
						$("#partnerDetailMain:last-child #partner_address").html(data.partner_addr);
						if(data.partner_yn == "Y"){
							//$("#partner_submit").css("display", "none");
							$("#partnerDetailMain:last-child #partner_detail_button").attr({"name":data.member_id, "value":"삭제"});
						}else if(data.partner_yn == "N"){
							//$("#partner_delete").css("display", "none");
							$("#partnerDetailMain:last-child #partner_detail_button").attr({"name":data.member_id, "value":"승인"});
						}
						
						$("#partner_detail_button[value='삭제']").click(function(){
							var tagId = $(this).attr('name');
							var check=confirm(tagId + "를(을) 삭제 하시겠습니까?");
							if(check == "1"){
								partnerDelete(tagId);
							}else{
								alert("취소하셨습니다.");
							}
						});
						
						$("#partner_detail_button[value='승인']").click(function(){			// 승인버튼을 클릭시 실행
							var tagId = $(this).attr('name');
							var check = confirm(tagId + "를(을) 승인 하시겠습니까?");
							if(check == "1"){
								partnerSubmit(tagId);
							}else{
								alert("취소하셨습니다.");
							}
						});
					},
					error:function(data){
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
		$("input[name='partner_yn']").click(function(){
			var status=$(this).attr("id");
			alert(status);
			
			$("#partnerListResult").empty();	// 제휴업체 정보를 불러오기전 리셋(중복 삽입을 방지하기 위해)
			
			$.ajax({
				type:'get',
				url:'${root}/manager/searchPartnerYN.do?partner_yn=' + status,
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					var data=JSON.parse(responseData);
					//alert(data);
					
					if(data.length <1){
						alert("데이타가 없습니다.");
						return false;
					}
					
					$.each(data, function(i){
						var getRgdate = new Date(data[i].partner_rgdate);	// 등록일 날짜 변환
						var rgyear = getRgdate.getFullYear();
						var rgmonth = getRgdate.getMonth() + 1;
						var rgday = getRgdate.getDate();
						var rgDate = rgyear + "년 " + rgmonth + "월 "	+ rgday + "일";
						//alert(rgDate);
						
						var getYdate = new Date(data[i].partner_rgdate);	// 승인일 날짜 변환
						var yyear = getYdate.getFullYear();
						var ymonth = getYdate.getMonth() + 1;
						var yday = getYdate.getDate();
						var yDate = yyear + "년 " + ymonth + "월 "	+ yday + "일";
						//alert(yDate);
						 if(data[i].partner_yn == "Y"){ 
								$("#partnerListResult").append("<tr style='text-align:center;'>"
										+ "<td>" + data[i].partner_no + "</td>"			// 아이디
										+ "<td>" + data[i].member_id + "</td>"			// 이름	
										+ "<td><a data-toggle='modal' href='#partnerDetail' class='btn-example' id='partner"+data[i].partner_no+"'>" + data[i].partner_name + "</a></td>"		//
										+ "<td>" + data[i].partner_phone + "</td>"		//							
										+ "<td>" + rgDate + "</td>"						// 등록일
										+ "<td>" + yDate + "</td>"		//
										+ "<td>"
										+"<input type='button' id='partner' value = '삭제' name='"+data[i].member_id+"'/></td>"
										+ "</tr>");
						 }else if(data[i].partner_yn =="N"){ 
								$("#partnerListResult").append("<tr style='text-align:center;'>"
										+ "<td>" + data[i].partner_no + "</td>"			// 아이디
										+ "<td>" + data[i].member_id + "</td>"			// 이름								
										+ "<td><a data-toggle='modal' href='#partnerDetail' class='btn-example' id='partner"+data[i].partner_no+"'>" + data[i].partner_name + "</a></td>"		//
										+ "<td>" + data[i].partner_phone + "</td>"		//							
										+ "<td>" + rgDate + "</td>"						// 등록일
										+ "<td>" + yDate + "</td>"		//
										+ "<td>"
										+"<input type='button' id='partner' value = '승인' name='"+data[i].member_id+"'/></td>"
										+ "</tr>");
						}
						
						$("#partner"+data[i].partner_no).click(function(){
							/* $("#partner_data-body").empty(); */
							partnerDetail(data[i].partner_no);
						});
					});
									
					$("#partner[value='승인']").click(function(){			// 승인버튼을 클릭시 실행
						var tagId = $(this).attr('name');		
						var check = confirm(tagId + "를(을) 승인 하시겠습니까?");
						if(check == "1"){
							partnerSubmit(tagId);
						}else{
							alert("취소하셨습니다.");
						}
					});
					
					$("#partner[value='삭제']").click(function(){			// 삭제버튼을 클릭시 실행
						var tagId = $(this).attr('name');
						var check=confirm(tagId + "를(을) 삭제 하시겠습니까?");
						if(check == "1"){
							partnerDelete(tagId);
						}else{
							alert("취소하셨습니다.");
						}
					});		
				
				},error:function(){
					alert("에러가 발생하였습니다.");
				}
				
			});
			
			function partnerSubmit(tagId){
				$.ajax({
					type:'get',
					url:'${root}/manager/partnerSubmit.do?id='+tagId,
					contentType:'application/x-www-form-urlencoded;charset=UTF-8',
					success:function(responseData){
						
						var submitChcek=JSON.parse(responseData);
						alert("partnerSubmit :" + submitChcek);
						
						if(!submitChcek){
							alert("데이타가 없습니다.");
							return false;
						};
						
						if(submitChcek == "1"){
							alert("승인되었습니다.");
							getPartnerList();
						};
						
					},error:function(submitChcek){
						alert("에러가 발생하였습니다.");
					}
				});
			}
			
			function partnerDelete(tagId){	
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
				
			}
			
			function partnerDetail(partnerNo){
				$("#partnerDetailResult").empty();
				$.ajax({
					type:'get',
					url:'${root}/manager/partnerDetail.do?partner_no='+partnerNo,
					contentType:'application/x-www-form-urlencoded;charset=UTF-8',
					success:function(responseData){
						var data=JSON.parse(responseData);
						
						var fileName = data.partner_pic_path + data.partner_pic_name;
						//alert(fileName);
						
						$("#partnerDetailResult").append($("#partnerDetailMain").clone().css("display","block"));
						$("#partnerDetailMain:last-child #partner_img").attr("src", fileName);
						$("#partnerDetailMain:last-child #partner_name").html(data.partner_name);
						$("#partnerDetailMain:last-child #partner_phone").html(data.partner_phone);
						$("#partnerDetailMain:last-child #partner_address").html(data.partner_addr);
						if(data.partner_yn == "Y"){
							//$("#partner_submit").css("display", "none");
							$("#partnerDetailMain:last-child #partner_detail_button").attr({"name":data.member_id, "value":"삭제"});
						}else if(data.partner_yn == "N"){
							//$("#partner_delete").css("display", "none");
							$("#partnerDetailMain:last-child #partner_detail_button").attr({"name":data.member_id, "value":"승인"});
						}
						
						$("#partner_detail_button[value='삭제']").click(function(){
							var tagId = $(this).attr('name');
							var check=confirm(tagId + "를(을) 삭제 하시겠습니까?");
							if(check == "1"){
								partnerDelete(tagId);
							}else{
								alert("취소하셨습니다.");
							}
						});
						
						$("#partner_detail_button[value='승인']").click(function(){			// 승인버튼을 클릭시 실행
							var tagId = $(this).attr('name');
							var check = confirm(tagId + "를(을) 승인 하시겠습니까?");
							if(check == "1"){
								partnerSubmit(tagId);
							}else{
								alert("취소하셨습니다.");
							}
						});
					},
					error:function(data){
						alert("에러가 발생했습니다.");
					}
	
				});
			};	
		});
	
	});

</script>
</head>
<body>
<div class="caption">

	<div>
			<input type="button" id="getPartnerList" value="Reset"/>&nbsp;&nbsp;
			<input type="radio" name="partner_yn" id="Y"/><span>승인업체</span> &nbsp;&nbsp;
			<input type="radio" name="partner_yn" id="N"/><span>미승인업체</span>&nbsp;&nbsp;
			<input type="text" placeholder="Name Search" id="searchTag"/> 
			<input type="submit" id="searchPartner" value="Search"/>	
	</div><br/>
	
	<div>
		<div class="span7">   
			<div class="widget stacked widget-table action-table">
	    				
					
					<div class="widget-content">
						
						<table class="table table-striped table-bordered" >
							<thead>
								<tr class="widget-header" >
									<th class="col-md-1 col-sm-1 col-xs-1" style="text-align: center;">순번</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">아이디</th>
									<!-- <th class="col-md-1 col-sm-1 col-xs-1" style="text-align: center;">유형 </th> -->
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">업체명</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">전화번호</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">등록</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">승인</th>
									<th class="col-md-1 col-sm-1 col-xs-1" style="text-align: center;">구분</th>
								</tr>
							</thead>
							<tbody id="partnerListResult"></tbody>  <!-- 자료를 붙일 바디 -->
							</table>
						
					</div> <!-- /widget-content -->
				
			</div> <!-- /widget -->
	    </div>
	</div>
	</div>
	
</body>
</html>