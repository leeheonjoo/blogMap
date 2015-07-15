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
<title>Manager</title>
<script type="text/javascript" src="${root }/css/manager/script.js"></script>
<script type="text/javascript">

	function getManagerList(){
		var email=sessionStorage.getItem('email');
		alert(email);
		$("#managerListResult").empty();	// 관리자 정보를 가져오기전 리셋 시킴 (중복을 삽입을 방지하기 위해)
		$("#managerLogList").hide();
		$.ajax({
			type:'get',
			url:'${root}/manager/managerInfo.do',
			cache: false,
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				var data=JSON.parse(responseData);	// 가지고 온 데이타를 data변수에 저장 
				//alert("managerList:" + data[0].manager_id);
				
				if(!data){
					alert("데이타가 없습니다.");
					return false;
				}
				
				$.each(data, function(i){		// 화면에 뿌려주기 위해 each문으로 루프돌림
					var getRgdate = new Date(data[i].manager_rgdate);	// 등록일 날짜 변환
					var rgyear = getRgdate.getFullYear();
					var rgmonth = getRgdate.getMonth() + 1;
					var rgday = getRgdate.getDate();
					var rgDate = rgyear + "년 " + rgmonth + "월 "	+ rgday + "일";
					//alert(rgDate);
					
					var getYdate = new Date(data[i].manager_exdate);	// 승인일 날짜 변환
					var exyear = getYdate.getFullYear();
					var exmonth = getYdate.getMonth() + 1;
					var exday = getYdate.getDate();
					var exDate = exyear + "년 " + exmonth + "월 "	+ exday + "일";
					//alert(yDate);
					
					$("#managerListResult").append("<tr style='text-align:center;'>"
							+ "<td>" + data[i].manager_id + "</td>"			// 아이디
							+ "<td>" + data[i].manager_name + "</td>"			// 이름	
							+ "<td>" + data[i].manager_email + "</td>"		//
							+ "<td>" + rgDate + "</td>"		//							
							+ "<td>" + exDate + "</td>"						// 등록일
							+ "<td>" + data[i].manager_yn + "</td>"		//
							+ "<td>"
							+"<input id='log' type='button' value='로그' name='"+data[i].manager_id+"'/></td>"
							+ "</tr>");
					
					$("#log[name='"+data[i].manager_id+"']").click(function(){		// log버튼 클릭하면 로그기록을 불러옴
						//alert("로그버튼");
						$("#managerLogList").show();
						$("#managerLogResult").empty();
						var tagId = $(this).attr('name');
						//alert("managerLog"+tagId);
						
						$.ajax({
							type:'get',
							url:'${root}/manager/managerLog.do?name='+tagId,
							contentType:'application/x-www-form-urlencoded;charset=UTF-8',
							success:function(responseData){
								var Logdata=JSON.parse(responseData);
								//alert("button:" + Logdata[0].manager_id);
								
								if(!Logdata){
									alert("데이타가 없습니다.");
									return false;
								}
								
								$.each(Logdata, function(i){		// 화면에 뿌려주기 위해 each문으로 루프돌림
									
									$("#managerLogResult").append("<tr style='text-align:center;'>"
											+ "<td>" + Logdata[i].log_no + "</td>"			// 아이디
											+ "<td>" + Logdata[i].manager_id + "</td>"			// 이름	
											+ "<td>" + Logdata[i].log_date + "</td>"		//
											+ "<td>" + Logdata[i].log_code + "</td>"		//							
											+ "<td>" + Logdata[i].log_content + "</td>"						// 등록일	
											+ "</tr>");
								});
								
							},error:function(data){
								alert("에러가 발생하였습니다.");
							}
						});

					});
					
				});
				
			},
			error:function(data){
				alert("에러가 발생하였습니다.");
			}
			
		});

	}
	
	$(function(){
		$("#logHide").click(function(){
			$("#managerLogList").hide();
			
		})
	})
</script>
</head>
<body>


<div class="caption">
	
	<div>
		<div class="span7">   
			<div class="widget stacked widget-table action-table">
	    				
					
					<div class="widget-content">
						
						<table class="table table-striped table-bordered" >
							<thead>
								<tr class="widget-header" >
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">아이디</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">이름</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">이메일</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">등록일</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">종료일</th>
									<th class="col-md-1 col-sm-1 col-xs-1" style="text-align: center;">사용</th>
									<th class="col-md-1 col-sm-1 col-xs-1" style="text-align: center;">기록</th>
								</tr>
							</thead>
							<tbody id="managerListResult"></tbody>  <!-- 자료를 붙일 바디 -->
							</table>
						
					</div> <!-- /widget-content -->
				
			</div> <!-- /widget -->
	    </div>
	</div>
</div>

<!-- 	
	<div>
관리자정보 타이틀
	<div class="row" id="managerTitle" align="center">
        <div class="col-md-2 col-sm-2 col-xs-2">아이디</div>
        <div class="col-md-2 col-sm-2 col-xs-2">이름</div>
        <div class="col-md-2 col-sm-2 col-xs-2">이메일</div>
        <div class="col-md-2 col-sm-2 col-xs-2">등록일</div>
        <div class="col-md-2 col-sm-2 col-xs-2">종료일</div>
        <div class="col-md-1 col-sm-1 col-xs-1">사용여부</div>
        <div class="col-md-1 col-sm-1 col-xs-1">기록</div>
    </div>
	
관리자 정보를 불러올 기본틀
	<div class="row" id="managerList" style="display:none;" align="center">
		<div class="col-md-2 col-sm-2 col-xs-2" id="managerId"></div>
        <div class="col-md-2 col-sm-2 col-xs-2" id="managerName"></div>
        <div class="col-md-2 col-sm-2 col-xs-2" id="managerEmail"></div>
        <div class="col-md-2 col-sm-2 col-xs-2" id="managerRgDate"></div>
        <div class="col-md-2 col-sm-2 col-xs-2" id="managerExDate"></div>
        <div class="col-md-1 col-sm-1 col-xs-1" id="managerYN"></div>
        <div class="col-md-1 col-sm-1 col-xs-1">
        	<input id="log" type="button" value="로그"/>
        </div>
	</div>
	
관리자 정보를 삽입시킬 div테그	
	<div class="row" id="managerListResult" align="center"></div>
</div>
 -->
 
 <div class="caption" id="managerLogList" >
	
	<div>
		<div class="span7">   
			<div class="widget stacked widget-table action-table">
	    				
					
					<div class="widget-content">
					<div style="text-align:right;"><input type="button" id="logHide" value="Close"/>	</div>
											
						<table class="table table-striped table-bordered" >
							<thead>
								<tr class="widget-header">
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">순번</th>
									<th class="col-md-3 col-sm-3 col-xs-3" style="text-align: center;">관리자</th>
									<th class="col-md-3 col-sm-3 col-xs-3" style="text-align: center;">로그데이트</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">로그코드</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">내용</th>
								</tr>
							</thead>
							<tbody id="managerLogResult"></tbody>  <!-- 자료를 붙일 바디 -->
							</table>
						
					</div> <!-- /widget-content -->
				
			</div> <!-- /widget -->
	    </div>
	</div>
</div>

</body>
</html>

