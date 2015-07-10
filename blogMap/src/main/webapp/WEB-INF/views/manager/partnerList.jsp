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
	function getPartnerList(){
		$("#partnerListResult").empty();	// 제휴업체 정보를 불러오기전 리셋(중복 삽입을 방지하기 위해)
		//alert("파트너리스트")
		$.ajax({
			type:'get',
			url:'${root}/manager/partnerInfo.do',
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				var data=JSON.parse(responseData);
				
				if(!data){
					alert("데이타가 없습니다.");
					return false;
				}
				
				$.each(data, function(i){
					$("#partnerListResult").append($("#partnerList").clone().css("display","block"));
					$("#partnerList:last-child #no").append(data[i].partner_no);
					$("#partnerList:last-child #memberId").append(data[i].member_id);
					$("#partnerList:last-child #partnerType").append(data[i].category_code);
					$("#partnerList:last-child #partnerName").append(data[i].partner_name);
					$("#partnerList:last-child #partnerPhone").append(data[i].partner_phone);
					$("#partnerList:last-child #rgDate").append(data[i].partner_rgdate);
					$("#partnerList:last-child #yDate").append(data[i].partner_ydate);
					$("#partnerList:last-child a").attr("id", "partner"+data[i].partner_no);
					
					
					if(data[i].partner_yn == "n"){
						$("#partnerList:last-child #partner").attr({"name":data[i].member_id, "value":"승인"});
					}else if(data[i].partner_yn == "y"){
						$("#partnerList:last-child #partner").attr({"name":data[i].member_id, "value":"삭제"});
					};
					
					$("#partner"+data[i].partner_no).click(function(){
						/* $("#partner_data-body").empty(); */
						partnerDetail(data[i].partner_no);
					});
				});
								
				$("#partner[value='승인']").click(function(){			// 승인버튼을 클릭시 실행
					var tagId = $(this).attr('name');		
					//alert(tagId);
					partnerSubmit(tagId);
				});
				
				$("#partner[value='삭제']").click(function(){
					var tagId = $(this).attr('name');
					//alert(tagId);
					partnerDelete(tagId);
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
					var button= document.createElement("input");
					var data=JSON.parse(responseData);
					var fileName = data.partner_pic_path + data.partner_pic_name;
					alert(fileName);
					
					$("#partnerDetailResult").append($("#partnerDetailMain").clone().css("display","block"));
					$("#partnerDetailMain:last-child #partner_img").attr("src", fileName);
					$("#partnerDetailMain:last-child #partner_name").html(data.partner_name);
					$("#partnerDetailMain:last-child #partner_phone").html(data.partner_phone);
					$("#partnerDetailMain:last-child #partner_address").html(data.partner_addr);
					if(data.partner_yn == "y"){
						//$("#partner_submit").css("display", "none");
						$("#partnerDetailMain:last-child #partner_detail_button").attr({"name":data.member_id, "value":"삭제"});
					}else if(data.partner_yn == "n"){
						//$("#partner_delete").css("display", "none");
						$("#partnerDetailMain:last-child #partner_detail_button").attr({"name":data.member_id, "value":"승인"});
					}
					
					$("#partner_detail_button[value='삭제']").click(function(){
						var tagId = $(this).attr('name');
						alert(tagId);
						//partnerDelete(tagId);
					});
					
					$("#partner_detail_button[value='승인']").click(function(){			// 승인버튼을 클릭시 실행
						var tagId = $(this).attr('name');		
						alert(tagId);
						//partnerSubmit(tagId);
					});
				},
				error:function(data){
					alert("에러가 발생했습니다.");
				}

			});
		};	
		$("#searchPartner").click(function(){
			alert("검색버튼");
			//partnerDelete(tagId);
		});
	};
	

</script>
</head>
<body>

<div class="row" id="listBody">
	<div class="row" id="searchTag">
			<input type="button" id="getPartnerList" value="리셋"/>
			<input type="radio" name="partner_yn" id="Ok"/><span>승인업체</span> &nbsp;&nbsp;
			<input type="radio" name="partner_yn" id="None"/><span>미승인업체</span>&nbsp;&nbsp;
			<form action="#">
				<input type="text" placeholder="Search" /> 
				<input type="submit" id="searchPartner" value="Search"/>
			</form>
		
	</div>
		
		<div class="row" id="partnerTitle" align="center">				
	        <div class="col-md-1 col-sm-1 col-xs-1">순번</div>
	        <div class="col-md-2 col-sm-2 col-xs-2">아이디</div>
	        <div class="col-md-1 col-sm-1 col-xs-1">유형</div>
	        <div class="col-md-1 col-sm-1 col-xs-1">업체명</div>
	        <div class="col-md-2 col-sm-2 col-xs-2">전화번호</div>
	    	<div class="col-md-2 col-sm-2 col-xs-2">등록일</div>
	    	<div class="col-md-2 col-sm-2 col-xs-2">승인일</div>
	    	<div class="col-md-1 col-sm-1 col-xs-1">구분</div>    	
    	</div>
			
		<div class="row" id="partnerList" style="display:none;" align="center">
			
			<div class="col-md-1 col-sm-1 col-xs-1" id="no"></div>
			<a data-toggle="modal" href="#partnerDetail" class="btn-example">
	        <div class="col-md-2 col-sm-2 col-xs-2" id="memberId"></div>
	        <div class="col-md-1 col-sm-1 col-xs-1" id="partnerType"></div>
	        <div class="col-md-1 col-sm-1 col-xs-1" id="partnerName"></div>
	        <div class="col-md-2 col-sm-2 col-xs-2" id="partnerPhone"></div>
	        </a>
	    	<div class="col-md-2 col-sm-2 col-xs-2" id="rgDate"></div>
	    	<div class="col-md-2 col-sm-2 col-xs-2" id="yDate"></div>
	    	
	    	
	    	
	    	<div class="col-md-1 col-sm-1 col-xs-1">
	    		<input id="partner" type="button"/>
	    	</div>
		</div>
			
		<div class="row" id="partnerListResult" align="center"></div>
		
	</div>
</body>
</html>