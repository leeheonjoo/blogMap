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
				//alert("managerList:" + data)
				if(!data){
					alert("데이타가 없습니다.");
					return false;
				}
				
				$.each(data, function(i){		// 화면에 뿌려주기 위해 each문으로 루프돌림
					$("#managerListResult").append($("#managerList").clone().css("display","block"));		// #managerList를 복사하여 #managerListResult에 복사함
					$("#managerList:last-child #managerId").append(data[i].manager_id);
					$("#managerList:last-child #managerName").append(data[i].manager_name);
					$("#managerList:last-child #managerEmail").append(data[i].manager_email);
					$("#managerList:last-child #managerRgDate").append(data[i].manager_rgdate);
					$("#managerList:last-child #managerExDate").append(data[i].manager_exdate);
					$("#managerList:last-child #managerYN").append(data[i].manager_yn);
					/* $("#managerList:last-child #managerLogResult").attr("name",data[i].manager_id); */
					$("#managerList:last-child #log").attr("name", data[i].manager_id);
					
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
									
									$("#managerLogResult").append($("#managerLog").clone().css("display","block"));		// #memberList를 복사하여 memberListSResult에 복사함 
									$("#managerLog:last-child #LogNo").append(Logdata[i].log_no);
									$("#managerLog:last-child #managerId").append(Logdata[i].manager_id);
									$("#managerLog:last-child #LogDate").append(Logdata[i].log_date);
									$("#managerLog:last-child #LogCode").append(Logdata[i].log_code);
									$("#managerLog:last-child #LogContent").append(Logdata[i].log_content);
								
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
</script>
</head>
<body>	
	<div>
<!-- 관리자정보 타이틀 -->
	<div class="row" id="managerTitle" align="center">
        <div class="col-md-2 col-sm-2 col-xs-2">아이디</div>
        <div class="col-md-2 col-sm-2 col-xs-2">이름</div>
        <div class="col-md-2 col-sm-2 col-xs-2">이메일</div>
        <div class="col-md-2 col-sm-2 col-xs-2">등록일</div>
        <div class="col-md-2 col-sm-2 col-xs-2">종료일</div>
        <div class="col-md-1 col-sm-1 col-xs-1">사용여부</div>
        <div class="col-md-1 col-sm-1 col-xs-1">기록</div>
    </div>
	
<!-- 관리자 정보를 불러올 기본틀 -->
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
	
<!-- 관리자 정보를 삽입시킬 div테그 -->	
	<div class="row" id="managerListResult" align="center"></div>
</div>

<!-- 관리자 로그 삽입 -->
	<div id="managerLogList" >
<!-- 관리자 로그 타이틀 -->	
		<div class="row" id="managerLogTitle" align="center">
	        <div class="col-md-2 col-sm-2 col-xs-2">순번</div>
	        <div class="col-md-3 col-sm-3 col-xs-3">관리자</div>
	        <div class="col-md-3 col-sm-3 col-xs-3">로그데이트</div>
	        <div class="col-md-2 col-sm-2 col-xs-2">로그코드</div>
	        <div class="col-md-2 col-sm-2 col-xs-2">내용</div>
	        
	    </div>
<!-- 관리자 행위 로그를 불러올 기본틀 -->
		<div id="managerLog" style="display:none;" align="center">
			<div class="col-md-2 col-sm-2 col-xs-2" id="LogNo"></div>
	        <div class="col-md-3 col-sm-3 col-xs-3" id="managerId"></div>
	        <div class="col-md-3 col-sm-3 col-xs-3" id="LogDate"></div>
	        <div class="col-md-2 col-sm-2 col-xs-2" id="LogCode"></div>
	        <div class="col-md-2 col-sm-2 col-xs-2" id="LogContent"></div>
		</div>
	
<!--  로그기록을 삽입시킬 divtag -->	
		<div id="managerLogResult"></div>
	</div>
	
</body>
</html>

