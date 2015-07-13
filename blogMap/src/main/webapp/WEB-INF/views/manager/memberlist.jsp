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
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->
<%-- <script type="text/javascript" src="${root }/css/manager/script.js"></script> --%>
<style>
.table-bordered {
border: 1px solid #dddddd;
border-collapse: separate;
border-left: 0;
-webkit-border-radius: 4px;
-moz-border-radius: 4px;
border-radius: 4px;
}

.table {
width: 100%;
margin-bottom: 20px;
background-color: transparent;
border-collapse: collapse;
border-spacing: 0;
display: table;
}

.widget.widget-table .table {
margin-bottom: 0;
border: none;
}

.widget.widget-table .widget-content {
padding: 0;
}

.widget .widget-header + .widget-content {
border-top: none;
-webkit-border-top-left-radius: 0;
-webkit-border-top-right-radius: 0;
-moz-border-radius-topleft: 0;
-moz-border-radius-topright: 0;
border-top-left-radius: 0;
border-top-right-radius: 0;
}

.widget .widget-content {
padding: 20px 15px 15px;
background: #FFF;
border: 1px solid #D5D5D5;
-moz-border-radius: 5px;
-webkit-border-radius: 5px;
border-radius: 5px;
}

.widget .widget-header {
position: relative;
height: 40px;
line-height: 40px;
background: #E9E9E9;
background: -moz-linear-gradient(top, #fafafa 0%, #e9e9e9 100%);
background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #fafafa), color-stop(100%, #e9e9e9));
background: -webkit-linear-gradient(top, #fafafa 0%, #e9e9e9 100%);
background: -o-linear-gradient(top, #fafafa 0%, #e9e9e9 100%);
background: -ms-linear-gradient(top, #fafafa 0%, #e9e9e9 100%);
background: linear-gradient(top, #fafafa 0%, #e9e9e9 100%);
text-shadow: 0 1px 0 #fff;
border-radius: 5px 5px 0 0;
box-shadow: 0 2px 5px rgba(0,0,0,0.1),inset 0 1px 0 white,inset 0 -1px 0 rgba(255,255,255,0.7);
border-bottom: 1px solid #bababa;
filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FAFAFA', endColorstr='#E9E9E9');
-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr='#FAFAFA', endColorstr='#E9E9E9')";
border: 1px solid #D5D5D5;
-webkit-border-top-left-radius: 4px;
-webkit-border-top-right-radius: 4px;
-moz-border-radius-topleft: 4px;
-moz-border-radius-topright: 4px;
border-top-left-radius: 4px;
border-top-right-radius: 4px;
-webkit-background-clip: padding-box;
}

thead {
display: table-header-group;
vertical-align: middle;
border-color: inherit;
}

.widget .widget-header h3 {
top: 2px;
position: relative;
left: 10px;
display: inline-block;
margin-right: 3em;
font-size: 14px;
font-weight: 600;
color: #555;
line-height: 18px;
text-shadow: 1px 1px 2px rgba(255, 255, 255, 0.5);
}

.widget .widget-header [class^="icon-"], .widget .widget-header [class*=" icon-"] {
display: inline-block;
margin-left: 13px;
margin-right: -2px;
font-size: 16px;
color: #555;
vertical-align: middle;
}
</style>
<script type="text/javascript">

	function getMemberList(){
		
		$.ajax({
			type:'get',
			url:'${root}/manager/memberinfo.do',
			cache: false,
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				$("#memberListResult").empty();		// 데이타를 가지고 오기전에 리셋 (중복삽입을 방지하기 위해)
				var data=JSON.parse(responseData);	// 가지고 온 데이타를 data변수에 저장 
				
				if(!data){
					alert("데이타가 없습니다.");
					return false;
				}
				
				$.each(data, function(i){		// 화면에 뿌려주기 위해 each문으로 루프돌림
					var date = new Date(data[i].member_joindate);
					var year = date.getFullYear();
					var month = date.getMonth() + 1;
					var day = date.getDate();
					
					var rgDate = year + "년 " + month + "월 "	+ day + "일";
					
					$("#memberListResult").append("<tr style='text-align: center;'>"
										+ "<td>" + data[i].member_id + "</td>"			// 아이디
										+ "<td>" + data[i].member_name + "</td>"		// 이름
										+ "<td>" + rgDate + "</td>"						// 가입일
										+ "<td>" + data[i].member_jointype + "</td>"	//
										+ "<td>" + data[i].member_point + "</td>"		//
										+ "<td class='td-actions'><input type='button' id='delete' value = '삭제' name='"+data[i].member_id+"'/></td>"
										+ "</tr>")
					
					
					$("#delete[name='"+data[i].member_id+"']").click(function(){	// 각 회원ID의  name속성을 가진 delete 버튼을 클릭시 각 행을 삭제
						var tagId = $(this).attr('name');		// button의 name 속성값을 tagId에 저장
						alert(tagId);

						$.ajax({
							type:'get',
							url:'${root}/manager/delete.do?name='+tagId,
							contentType:'application/x-www-form-urlencoded;charset=UTF-8',
							success:function(responseData){
								var data=JSON.parse(responseData);
								
								if(!data){
									alert("데이타가 없습니다.");
									return false;
								}
								
								if(data== "1"){
									alert("삭제되었습니다.");
								}
							},error:function(data){
								alert("에러가 발생하였습니다.");
							}
						});
						 $(this).parent().parent().remove();;

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
		<input type="button" id="getMemberList" value="조회"/>
	</div>
	
	<div>
		<div class="span7">   
			<div class="widget stacked widget-table action-table">
	    				
					
					<div class="widget-content">
						
						<table class="table table-striped table-bordered" >
							<thead>
								<tr class="widget-header" >
									<th class="col-md-3 col-sm-3 col-xs-3" style="text-align: center;">아이디</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">이름</th>
									<th class="col-md-3 col-sm-3 col-xs-3" style="text-align: center;">가입일 </th>
									<th class="col-md-1 col-sm-1 col-xs-1" style="text-align: center;">유형</th>
									<th class="col-md-2 col-sm-2 col-xs-2" style="text-align: center;">포인트</th>
									<th class="col-md-1 col-sm-1 col-xs-1" style="text-align: center;"></th>
								</tr>
							</thead>
							<tbody id="memberListResult"></tbody>  <!-- 자료를 붙일 바디 -->
							</table>
						
					</div> <!-- /widget-content -->
				
			</div> <!-- /widget -->
	    </div>

<!--  테이블로 변경 -->	
<!-- <!-- 회원정보 타이틀 -->	 
<!-- 	<div class="row" id="memberTitle" align="center"> -->
<!--         <div class="col-md-3 col-sm-3 col-xs-3">아이디</div> -->
<!--         <div class="col-md-2 col-sm-2 col-xs-2">이름</div> -->
<!--         <div class="col-md-3 col-sm-3 col-xs-3">가입일</div> -->
<!--         <div class="col-md-1 col-sm-1 col-xs-1">가입유형</div> -->
<!--         <div class="col-md-2 col-sm-2 col-xs-2">포인트</div> -->
<!--     	<div class="col-md-1 col-sm-1 col-xs-1">삭제</div> -->
<!--     </div> -->

<!-- <!-- 회원정보를 불러올 기본틀  -->		 
<!-- 	<div class="row" id="memberList" style="display:none;" align="center" > -->
<!-- 		<div class="col-md-3 col-sm-3 col-xs-3" id="memberId"></div> -->
<!--         <div class="col-md-2 col-sm-2 col-xs-2" id="memberName"></div> -->
<!--         <div class="col-md-3 col-sm-3 col-xs-3" id="memberJoindate"></div> -->
<!--         <div class="col-md-1 col-sm-1 col-xs-1" id="memberJoinType"></div> -->
<!--         <div class="col-md-2 col-sm-2 col-xs-2" id="memberPoint"></div> -->
<!--     	<div class="col-md-1 col-sm-1 col-xs-1"> -->
<!--     		<input id="delete" type="button" value="삭제"/> -->
<!--     	</div> -->
<!-- 	</div> -->

<!-- <!-- 회원정보를 삽입시킬 div테그 -->	 
<!-- 	<div class="row" id="memberListResult"></div> -->
	</div>
</body>
</html>

