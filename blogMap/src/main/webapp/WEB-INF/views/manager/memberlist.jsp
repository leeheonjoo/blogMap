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
				
				$.each(data, function(i){		// 화면에 뿌려주기 위해 each문으로 루프돌림v
					$("#memberListResult").append($("#memberList").clone().css("display","block"));		// #memberList를 복사하여 memberListSResult에 붙임 
					$("#memberList:last-child #memberId").append(data[i].member_id);
					$("#memberList:last-child #memberName").append(data[i].member_name);
					$("#memberList:last-child #memberJoindate").append(data[i].member_joindate);
					$("#memberList:last-child #memberJoinType").append(data[i].member_jointype);
					$("#memberList:last-child #memberPoint").append(data[i].member_point);
					$("#memberList:last-child #delete").attr("name", data[i].member_id);				// 삭제버튼의 name속성을 회원ID로 삽입
					
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
<!-- 회원정보 타이틀 -->	
	<div class="row" id="memberTitle" align="center">
        <div class="col-md-3 col-sm-3 col-xs-3">아이디</div>
        <div class="col-md-2 col-sm-2 col-xs-2">이름</div>
        <div class="col-md-3 col-sm-3 col-xs-3">가입일</div>
        <div class="col-md-1 col-sm-1 col-xs-1">가입유형</div>
        <div class="col-md-2 col-sm-2 col-xs-2">포인트</div>
    	<div class="col-md-1 col-sm-1 col-xs-1">삭제</div>
    </div>

<!-- 회원정보를 불러올 기본틀  -->		
	<div class="row" id="memberList" style="display:none;" align="center" >
		<div class="col-md-3 col-sm-3 col-xs-3" id="memberId"></div>
        <div class="col-md-2 col-sm-2 col-xs-2" id="memberName"></div>
        <div class="col-md-3 col-sm-3 col-xs-3" id="memberJoindate"></div>
        <div class="col-md-1 col-sm-1 col-xs-1" id="memberJoinType"></div>
        <div class="col-md-2 col-sm-2 col-xs-2" id="memberPoint"></div>
    	<div class="col-md-1 col-sm-1 col-xs-1">
    		<input id="delete" type="button" value="삭제"/>
    	</div>
	</div>

<!-- 회원정보를 삽입시킬 div테그 -->	
	<div class="row" id="memberListResult"></div>
	</div>
</body>
</html>

