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
if(sessionStorage.getItem('email')!=null){
$(function(){
	var startPage=0; 
	var endPage=0;
	var pageBlock=1;
	$.ajax({
		type:'POST',
		url:"${root}/member/myPage.do",
		data:{
			member_id:sessionStorage.getItem("email")
			//member_id:"kimjh112339@naver.com"
		},
		contentType:'application/x-www-form-urlencoded;charset=UTF-8',
		success:function(responseData){
			//alert(responseData);
		 	var data=responseData.split("|");
			
		 	memberData=JSON.parse(data[0])
			
			$("#myPage_member_id").val(memberData.member_id);
			$("#myPage_member_id").attr("disabled","disabled");
			
			$("#myPage_member_name").val(memberData.member_name);
			$("#myPage_member_name").attr("disabled","disabled");
			
			$("#myPage_member_joindate").val(memberData.member_joindate);
			$("#myPage_member_joindate").attr("disabled","disabled");
			
			$("#myPage_member_point").val(data[1]);
			$("#myPage_member_point").attr("disabled","disabled");
			
			$("#myPage_member_boardCount").val(data[2]);
			$("#myPage_member_boardCount").attr("disabled","disabled");
			
			$("#myPage_member_favoriteCount").val(data[3]);
			$("#myPage_member_favoriteCount").attr("disabled","disabled");
		}
	});
	
	$("#myPage_update_btn").click(function(){
		//layer_open('myPageUpdate_layer')
		$("div[id='blogmap_myPageUpdate'].modal").modal();
		
	});
	
	$("#myPage_delete_btn").click(function(){
		//layer_open('myPageDelete_layer')
		$("div[id='blogmap_myPageDelete'].modal").modal();
	});
	
	$("#point_info_btn").click(function(){
		$.ajax({
			type:'POST',
			url:'${root}/member/point_info.do',
			data:{
				member_id:sessionStorage.getItem("email")
				//member_id:"kimjh112339@naver.com"
				
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				//alert(responseData);
				
				var data=responseData.split("|");
				/* alert(data[0]);
				alert(data[1]);
				alert(data[2]);
				alert(data[3]); */
				
				var boardSize=data[1];
				var count=data[2];
				var currentPage=data[3];
				
				var pageCount=count/boardSize+(count%boardSize==0 ? 0:1);
				alert(pageCount);
				startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
				endPage=startPage+pageBlock-1;
				
				
				//$("#myPage_member_point_list").empty();
				$("#myPage_member_point_list_title").append("<div><span>번호</span><span>발생일</span><span>내용</span><span>포인트</span></div>");
				var point_data=JSON.parse(data[0]);
				
				
				$.each(point_data,function(i){
					//alert(data[i].BOARD_TITLE);
					$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
					
				});
				
				if(endPage>pageCount){
					endPage=pageCount;
				}
				
				//페이징
				//$("#myPage_member_point_list_pageNum").empty();
				/* $("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
				
				//이전
				alert("startPage"+startPage);
				alert("pageCount"+pageCount);
				if(startPage>pageBlock){
					$("#myPage_member_point_list_before").css("display","inline-block");
				}
				
				if(startPage<=pageBlock){
					$("#myPage_member_point_list_before").css("display","none");
				}
				
				
				for(var i=startPage;i<=endPage;i++){
					$("#myPage_member_point_list_pageNum").append("<a href='#' id='point_paging_num"+i+"'>"+i+"</a>");
					$("#point_paging_num"+i).click(function(){
						alert($(this).text());
						$.ajax({
							type:'POST',
							url:'${root}/member/point_info.do',
							data:{
								member_id:sessionStorage.getItem("email"),
								//member_id:"kimjh112339@naver.com",
								pageNumber:$(this).text()
							},
							contentType:'application/x-www-form-urlencoded;charset=UTF-8',
							success:function(responseData){
								//alert(responseData);
								
								var data=responseData.split("|");
								/* alert(data[0]);
								alert(data[1]);
								alert(data[2]);
								alert(data[3]); */
								
								var boardSize=data[1];
								var count=data[2];
								var currentPage=data[3];
								
								$("#myPage_member_point_list_title").empty();
								$("#myPage_member_point_list_content").empty();
								$("#myPage_member_point_list_title").append("<div><span>번호</span><span>발생일</span><span>내용</span><span>포인트</span></div>");
								var point_data=JSON.parse(data[0]);
								
								$.each(point_data,function(i){
									//alert(data[i].BOARD_TITLE);
									$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
									
								});
							}
						});
					});
				}
				
				
				alert("endPage:"+endPage);
				alert("pageCount:"+pageCount);
				//다음
				if(endPage<pageCount){
					$("#myPage_member_point_list_after").css("display","inline-block");
					
					
				}
				
				if(endPage>=pageCount){
					$("#myPage_member_point_list_after").css("display","none");
				}
				
				
				alert($("#myPage_member_point_list").css("display"));
				if($("#myPage_member_point_list").css("display")=="none"){
					alert("aa");
					$("#myPage_member_point_list").css("display","block");
				}else if($("#myPage_member_point_list").css("display")=="block"){
					alert("bb");
					$("#myPage_member_point_list").css("display","none");
				} 			
			}			
		});
	});
	
	//다음클릭시
	$("#point_paging_after").click(function(){
		alert("Aa");
		$.ajax({
			type:'POST',
			url:'${root}/member/point_info.do',
			data:{
				member_id:sessionStorage.getItem("email"),
				//member_id:"kimjh112339@naver.com",
				pageNumber:startPage+pageBlock
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				//alert(responseData);
				
				var data=responseData.split("|");
				/* alert(data[0]);
				alert(data[1]);
				alert(data[2]);
				alert(data[3]); */
				
				var boardSize=data[1];
				var count=data[2];
				var currentPage=data[3];
				var pageBlock=1;
				var pageCount=count/boardSize+(count%boardSize==0 ? 0:1);
				alert(pageCount);
				startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
				endPage=startPage+pageBlock-1;
				
				//$("#myPage_member_point_list").empty();
				$("#myPage_member_point_list_title").empty();
				$("#myPage_member_point_list_content").empty();
				$("#myPage_member_point_list_title").append("<div><span>번호</span><span>발생일</span><span>내용</span><span>포인트</span></div>");
				var point_data=JSON.parse(data[0]);
				
				$.each(point_data,function(i){
					//alert(data[i].BOARD_TITLE);
					$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
					
				});
				
			/* 	$("#myPage_member_point_list_pageNum").remove();
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
				
				
				alert("다음startPage:"+startPage);
				alert("다음endPage:"+endPage);
				alert("다음pageBlock"+pageBlock)
				//이전
				if(startPage>pageBlock){
					alert("block");
					$("#myPage_member_point_list_before").css("display","inline-block");
				}
				
				if(startPage<=pageBlock){
					//alert("hidden");
					$("#myPage_member_point_list_before").css("display","none");
				}
				
				$("#myPage_member_point_list_pageNum").empty();
				for(var i=startPage;i<=endPage;i++){
					$("#myPage_member_point_list_pageNum").append("<a href='#' id='point_paging_num"+i+"'>"+i+"</a>");
					$("#point_paging_num"+i).click(function(){
						alert($(this).text());
						$.ajax({
							type:'POST',
							url:'${root}/member/point_info.do',
							data:{
								member_id:sessionStorage.getItem("email"),
								//member_id:"kimjh112339@naver.com",
								pageNumber:$(this).text()
							},
							contentType:'application/x-www-form-urlencoded;charset=UTF-8',
							success:function(responseData){
								//alert(responseData);
								
								var data=responseData.split("|");
								/* alert(data[0]);
								alert(data[1]);
								alert(data[2]);
								alert(data[3]); */
								
								var boardSize=data[1];
								var count=data[2];
								var currentPage=data[3];
								
								$("#myPage_member_point_list_title").empty();
								$("#myPage_member_point_list_content").empty();
								$("#myPage_member_point_list_title").append("<div><span>번호</span><span>발생일</span><span>내용</span><span>포인트</span></div>");
								var point_data=JSON.parse(data[0]);
								$.each(point_data,function(i){
									//alert(data[i].BOARD_TITLE);
									$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
									
								});
							}
						});
					});
				}
				alert("다음endPage:"+endPage);
				alert("다음pageCount"+pageCount);
				alert("다음마지막startPage:"+startPage);
				//다음
				if(endPage<pageCount){
					alert("다음block");
					$("#myPage_member_point_list_after").css("display","inline-block");
				}
				
				if(endPage>=pageCount){
					alert("다음hidden");
					$("#myPage_member_point_list_after").css("display","none");
					alert("bbbbbb");
				}
				
			}
		});
	});
	
	
	//이전클릭시
	$("#point_paging_before").click(function(){
		alert("이전startPage:"+startPage);
		alert("이전pageBlock:"+pageBlock);
		$.ajax({
			type:'POST',
			url:'${root}/member/point_info.do',
			data:{
				member_id:sessionStorage.getItem("email"),
				//member_id:"kimjh112339@naver.com",
				pageNumber:startPage-pageBlock
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				//alert(responseData);
				
				var data=responseData.split("|");
				/* alert(data[0]);
				alert(data[1]);
				alert(data[2]);
				alert(data[3]); */
				
				var boardSize=data[1];
				var count=data[2];
				var currentPage=data[3];
				var pageBlock=1;
				var pageCount=count/boardSize+(count%boardSize==0 ? 0:1);
				alert(pageCount);
				startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
				endPage=startPage+pageBlock-1;
				
				//$("#myPage_member_point_list").empty();
				$("#myPage_member_point_list_title").empty();
				$("#myPage_member_point_list_content").empty();
				$("#myPage_member_point_list_title").append("<div><span>번호</span><span>발생일</span><span>내용</span><span>포인트</span></div>");
				var point_data=JSON.parse(data[0]);
				
				$.each(point_data,function(i){
					//alert(data[i].BOARD_TITLE);
					$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
					
				});
				
			/* 	$("#myPage_member_point_list_pageNum").remove();
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
				
				alert("startPage:"+startPage);
				alert("pageBlock:"+pageBlock);
				//이전
				if(startPage>pageBlock){
					$("#myPage_member_point_list_before").css("display","inline-block");
				}
				
				if(startPage<=pageBlock){
					$("#myPage_member_point_list_before").css("display","none");
				}
				
				$("#myPage_member_point_list_pageNum").empty();
				for(var i=startPage;i<=endPage;i++){
					$("#myPage_member_point_list_pageNum").append("<a href='#' id='point_paging_num"+i+"'>"+i+"</a>");
					$("#point_paging_num"+i).click(function(){
						alert($(this).text());
						$.ajax({
							type:'POST',
							url:'${root}/member/point_info.do',
							data:{
								member_id:sessionStorage.getItem("email"),
								//member_id:"kimjh112339@naver.com",
								pageNumber:$(this).text()
							},
							contentType:'application/x-www-form-urlencoded;charset=UTF-8',
							success:function(responseData){
								//alert(responseData);
								
								var data=responseData.split("|");
								/* alert(data[0]);
								alert(data[1]);
								alert(data[2]);
								alert(data[3]); */
								
								var boardSize=data[1];
								var count=data[2];
								var currentPage=data[3];
								
								
								$("#myPage_member_point_list_title").empty();
								$("#myPage_member_point_list_content").empty();
								$("#myPage_member_point_list_title").append("<div><span>번호</span><span>발생일</span><span>내용</span><span>포인트</span></div>");
								var point_data=JSON.parse(data[0]);
								
								$.each(point_data,function(i){
									//alert(data[i].BOARD_TITLE);
									$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
									
								});
							}
						});
					});
				}
				
				//다음
				if(endPage<pageCount){
					$("#myPage_member_point_list_after").css("display","inline-block");
				}
				
				if(endPage>=pageCount){
					$("#myPage_member_point_list_after").css("display","none");
				}
			}
		});
	});
	
	
	
	$("#board_info_btn").click(function(){
		$.ajax({
			type:'POST',
			url:'${root}/member/board_info.do',
			data:{
				member_id:sessionStorage.getItem("email")
				//member_id:"kimjh112339@naver.com"
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				$("#myPage_member_board_list").empty();
				$("#myPage_member_board_list").append("<div><span>게시글번호</span><span>작성일</span><span>카테고리</span><span>제목</span></div>")
				var data=JSON.parse(responseData);
				$.each(data,function(i){
					//alert(data[i].BOARD_TITLE);
					$("#myPage_member_board_list").append("<div><span>"+data[i].BOARD_NO+"</span><span>"+data[i].BOARD_RGDATE+"</span><span>"+data[i].CATEGORY_MNAME+"</span><span>"+data[i].BOARD_TITLE+"</span></div>");
					
				});
				
				
				alert($("#myPage_member_board_list").css("display"));
				if($("#myPage_member_board_list").css("display")=="none"){
					alert("aa");
					$("#myPage_member_board_list").css("display","block");
				}else if($("#myPage_member_board_list").css("display")=="block"){
					alert("bb");
					$("#myPage_member_board_list").css("display","none");
				} 			
			}			
		});
	});
	
	$("#favorite_info_btn").click(function(){
		$.ajax({
			type:'POST',
			url:'${root}/member/favorite_info.do',
			data:{
				member_id:sessionStorage.getItem("email")
				//member_id:"kimjh112339@naver.com"
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				$("#myPage_member_favorite_list").empty();
				$("#myPage_member_favorite_list").append("<div><span>순번</span><span>등록일</span><span>게시글번호</span><span>제목</span></div>")
				var data=JSON.parse(responseData);
				$.each(data,function(i){
					//alert(data[i].BOARD_TITLE);
					$("#myPage_member_favorite_list").append("<div><span>"+data[i].FAVORITE_NO+"</span><span>"+data[i].FAVORITE_RGDATE+"</span><span>"+data[i].BOARD_NO+"</span><span>"+data[i].BOARD_TITLE+"</span></div>");
					
				});
				
				
				alert($("#myPage_member_favorite_list").css("display"));
				if($("#myPage_member_favorite_list").css("display")=="none"){
					//alert("aa");
					$("#myPage_member_favorite_list").css("display","block");
				}else if($("#myPage_member_favorite_list").css("display")=="block"){
					//alert("bb");
					$("#myPage_member_favorite_list").css("display","none");
				} 			
			}			
		});
	});
});
}

/* function layer_open(el){
	var temp = $('#' + el);
	var temp_bg = $('#' + el + '_bg');   //dimmed 레이어를 감지하기 위한 boolean 변수
	var temp_div = $('#' + el + '_div');
	var temp_btn = $('#' + el + '_btn');
	
	// layer fadeIn
	if(temp_bg){
		temp_div.fadeIn();	//'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다. 
	}else{
		temp.fadeIn();
	}
	// layer를 화면의 중앙에 위치시킨다.
	if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
	else temp.css('top', '0px');
	if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
	else temp.css('left', '0px');
	// layer fadeOut : 종료버튼 클릭시
	temp_btn.click(function(e){
		if(temp_bg){
			temp_div.fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다. 
		}else{
			temp.fadeOut();
		}
		e.preventDefault();
	});
	
	// layer fadeOut : 바탕화면 클릭시
	temp_bg.click(function(e){
		temp_div.fadeOut();
		e.preventDefault();
	});
} */


</script>
</head>
<body>
	<div>
		<span>계정정보<input id="myPage_member_id" type="text"/></span>&nbsp;&nbsp;&nbsp;
		<span><input id="myPage_update_btn" type="button" value="수정"/></span>&nbsp;&nbsp;
		<span><input id="myPage_delete_btn" type="button" value="탈퇴"/></span>
	</div>
	
	<div>
		이름<input id="myPage_member_name" type="text"/>
	</div>
	
	<div>
		회원등급<input id="myPage_member_rate" type="text"/>
	</div>
	
	<div>
		가입일<input id="myPage_member_joindate" type="text"/>
	</div>
	
	<div>
		<span>포인트<input id="myPage_member_point" type="text"/></span>
		<span><input id="point_info_btn" type="button" value="point_info"/></span>
		<div id="myPage_member_point_list" style="display:none;">
			<div id="myPage_member_point_list_title">
			</div>
			
			<div id="myPage_member_point_list_content">
			</div>
			
			<div id="myPage_member_point_paging">
				<span id='myPage_member_point_list_before' style="display:'none';"><a href="#" id="point_paging_before">이전</a></span>
				<span id='myPage_member_point_list_pageNum'></span>
				<span id='myPage_member_point_list_after' style="display:'none';"><a href="#" id="point_paging_after">다음</a></span>
			</div>
		</div>
	</div>
	
	<div>
		<span>게시글<input id="myPage_member_boardCount" type="text"/></span>
		<span><input id="board_info_btn" type="button" value="write_info"/></span>
		<div id="myPage_member_board_list" style="display:none;"></div>
	</div>
	
	<div>
		<span>즐겨찾기<input id="myPage_member_favoriteCount" type="text"/></span>
		<span><input id="favorite_info_btn" type="button" value="favorite_info"/></span>
		<div id="myPage_member_favorite_list" style="display:none;"></div>
	</div>
	
	<div>
		<span>쿠폰<input id="myPage_member_couponCount" type="text"/></span>
		<span><input type="button" value="coupon_info"/></span>
	</div>
	
	
	
	
	<div class="row-fluid user-infos cyruxx">
            <div class="span10 offset1">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">User information</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row-fluid">
                            <div class="span3">
                                <img class="img-circle"
                                     src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=100"
                                     alt="User Pic">
                            </div>
                            <div class="span6">
                                <strong>Cyruxx</strong><br>
                                <!-- <div class="table table-condensed table-responsive table-user-information">
                                    <div>
                                    <div>
                                        <span>User level:</span>>
                                        <span>Administrator</span>
                                    </div>
                                    <div>
                                        <span>Registered since:</span>
                                        <span>11/12/2013</span>
                                    </div>
                                    <div>
                                        <span>Topics</span>
                                        <span>15</span>
                                    </div>
                                    <div>
                                        <span>Warnings</span>
                                        <span>0</span>
                                    </div>
                                    </div>
                                </div> -->
                                <table class="table table-condensed table-responsive table-user-information">
                                    <tbody>
                                    <tr>
                                        <td>User level:</td>
                                        <td>Administrator</td>
                                    </tr>
                                    <tr>
                                        <td>Registered since:</td>
                                        <td>11/12/2013</td>
                                    </tr>
                                    <tr>
                                        <td>Topics</td>
                                        <td>15</td>
                                    </tr>
                                    <tr>
                                        <td>Warnings</td>
                                        <td>0</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <button class="btn  btn-primary" type="button"
                                data-toggle="tooltip"
                                data-original-title="Send message to user"><i class="icon-envelope icon-white"></i></button>
                        <span class="pull-right">
                            <button class="btn btn-warning" type="button"
                                    data-toggle="tooltip"
                                    data-original-title="Edit this user"><i class="icon-edit icon-white"></i></button>
                            <button class="btn btn-danger" type="button"
                                    data-toggle="tooltip"
                                    data-original-title="Remove this user"><i class="icon-remove icon-white"></i></button>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        
	
	<%-- <!-- 수정 -->
	<div class="container-fluid">

		<!-- 블로그 검색 레이어 -->
		<div id="myPageUpdate_layer_div" class="layer">
			<div id="myPageUpdate_layer_bg" class="bg"></div>
			<div id="myPageUpdate_layer" class="pop-layer">
				<div class="pop-container">
					<div class="pop-conts">
						<!--content // -->
						<div class="btn-r">
							<input id="myPageUpdate_layer_btn" type="button" class="cbtn" value="X"/>
						</div>
						
						<!-- 블로그 게시글 메인 -->
						<jsp:include page="myPageUpdate.jsp"/>
						<!--// content -->
					</div>
				</div>
			</div>
		</div>
	</div>	 --%>

	<%-- <!-- 탈퇴 -->
	<div class="container-fluid">

		<!-- 블로그 검색 레이어 -->
		<div id="myPageDelete_layer_div" class="layer">
			<div id="myPageDelete_layer_bg" class="bg"></div>
			<div id="myPageDelete_layer" class="pop-layer">
				<div class="pop-container">
					<div class="pop-conts">
						<!--content // -->
						<div class="btn-r">
							<input id="myPageDelete_layer_btn" type="button" class="cbtn" value="X"/>
						</div>
						
						<!-- 블로그 게시글 메인 -->
						<jsp:include page="myPageDelete.jsp"/>
						<!--// content -->
					</div>
				</div>
			</div>
		</div>
	</div>		 --%>
</body>
</html>