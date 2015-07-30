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
		//var email=sessionStorage.getItem('email');
		//alert(email);
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
					var getRgdate = new Date(data[i].manager_rgdate);
              		var rgDate = leadingZeros(getRgdate.getFullYear(), 4) + '/' + leadingZeros(getRgdate.getMonth() + 1, 2) + '/' + leadingZeros(getRgdate.getDate(), 2);
              		
              		var getExdate = new Date(data[i].manager_exdate);
              		var exDate = leadingZeros(getExdate.getFullYear(), 4) + '/' + leadingZeros(getExdate.getMonth() + 1, 2) + '/' + leadingZeros(getExdate.getDate(), 2);
									
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
								
								if(Logdata.length < 0){
									alert("데이타가 없습니다.");
									return false;
								}
								
								$.each(Logdata, function(i){		// 화면에 뿌려주기 위해 each문으로 루프돌림
									var getLogDate = new Date(Logdata[i].log_date);
				              		var logDate = leadingZeros(getLogDate.getFullYear(), 4) + '/' + leadingZeros(getLogDate.getMonth() + 1, 2) + '/' + leadingZeros(getLogDate.getDate(), 2) + " " + getLogDate.getHours() + ":" + getLogDate.getMinutes() + ":" + getLogDate.getSeconds() ;                               
									
									$("#managerLogResult").append("<tr style='text-align:center;'>"
											+ "<td>" + Logdata[i].log_no + "</td>"			// 아이디
											+ "<td>" + Logdata[i].manager_id + "</td>"			// 이름	
											+ "<td>" + logDate + "</td>"		//
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
										<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center; min-width:150px; max-width:150px;">아이디</th>
										<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center; min-width:100px; max-width:100px;">이름</th>
										<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center; min-width:150px; max-width:150px;">이메일</th>
										<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center; min-width:110px; max-width:110px;">등록일</th>
										<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center; min-width:110px; max-width:110px;">종료일</th>
										<th class="col-md-1 col-sm-1 col-xs-1" style="text-align: center; min-width:50px; max-width:50px;">사용</th>
										<th class="col-md-1 col-sm-1 col-xs-1" style="text-align: center; min-width:70px; max-width:70px;">기록</th>
									</tr>
								</thead>
								<tbody id="managerListResult"></tbody>  <!-- 자료를 붙일 바디 -->
								</table>
							
						</div> <!-- /widget-content -->
					
				</div> <!-- /widget -->
		    </div>
		</div>
	</div>
 
	<div class="caption" id="managerLogList" >
		<div>
			<div class="span7">   
				<div class="widget stacked widget-table action-table">
		    				
						
						<div class="widget-content">
						<div style="text-align:right;"><input type="button" id="logHide" value="Close"/>	</div>
												
							<table class="table table-striped table-bordered" >
								<thead>
									<tr class="widget-header">
										<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center; min-width:50px; max-width:50px;">순번</th>
										<th class="col-md-3 col-sm-3 col-xs-3" style="text-align: center; min-width:150px; max-width:150px;">관리자</th>
										<th class="col-md-3 col-sm-3 col-xs-3" style="text-align: center; min-width:110px; max-width:110px;">로그데이트</th>
										<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center; min-width:100px; max-width:100px;">로그코드</th>
										<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center; min-width:100px; max-width:100px;">내용</th>
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