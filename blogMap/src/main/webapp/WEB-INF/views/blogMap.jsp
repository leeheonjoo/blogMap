<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set var="root" value="${pageContext.request.contextPath}"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- META TAG 설정 -->
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
<title>BlogMap</title>

<!-- CDN 서비스에서 stylesheet를 불러옵니다 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"/>					<!-- bootstrap stylesheet 로드 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css"/>				<!-- bootstrap 확장 테마 stylesheet 로드 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.7.3/css/bootstrap-select.css"/>	<!-- bootstrap-select stylesheet 로드 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css"/>
<link rel="stylesheet" type="text/css" href="${root}/css/layer.css"/>
<link rel="stylesheet" type="text/css" href="${root}/css/blogMap/blogMap.css"/>											<!-- Metro style dynamic Tiles stylesheet 로드 -->
<style>
	.modal-dialog{
		width: auto;
		margin: 1% 1% 0px 1%;
		height:auto;
  		max-height: 90%;
 	    overflow-y: auto;
     	overflow-x: hidden;
	}

 	.modal-myPage{
 		width: 900px; 
 		margin: auto;
 	}
	
 	.modal-email-confrim{
 		width: auto;
 		margin: 2% 20% 0px 20%;
  		height: 600px;
   		max-height: 600px;
     	overflow-y:auto;
 	}

	#mainResult{
	  height: 90%;
	  overflow-y: auto;
	  overflow-x: hidden;
	}
</style>
<!--[if lt IE 9]>
	<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
        
<!-- CDN 서비스에서 javascript를 불러옵니다 -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>												<!-- jquery javascript를 로드 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>						<!-- bootstrap javascript를 로드 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.7.3/js/bootstrap-select.js"></script>	<!-- bootstrap-select javascript를 로드 -->
<script src="https://netdna.bootstrapcdn.com/twitter-bootstrap/2.0.4/js/bootstrap-dropdown.js"></script>		<!-- bootstrap-dropdown javascript를 로드 -->
<script type="text/javascript" src="http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=60e9ac7ab8734daca3d2053c1e713dbd"></script>
<!-- 네이버 스마트에디터 -->
<script type="text/javascript" src="${root }/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<!-- 컨폼 확인창 -->	
<script type="text/javascript" src="${root }/css/board/jquery.popconfirm.js"></script>
<!-- modal, session check -->
<!-- Modal, Metro style javascript를 로드 -->
<script type="text/javascript" src="${root}/css/blogMap/blogMap.js"></script>
<script>
	//<session check -> button change>
	$(function(){
		if(sessionStorage.getItem("email")!=null){
			$("#blogmap_before_login span").remove();
			$("#myPage_fb_delete_btn").css("display","none");

			
			$("#blogmap_main_myPage").css("display","inline-block");
			$("#blogmap_before_login").attr("data-toggle","");
			
			if(sessionStorage.getItem("manager_yn")=="Y"){
				$("#manager_page_icon").css("display","inline-block");
				$("#blogmap_main_myPage").css("display","none");
			}
			
			$("#login_text").text("Logout");
			
			if($("#login_text").text()=="Logout"){
				$("#blogmap_before_login").click(function(){
					if(sessionStorage.getItem('jointype')=="0002"){
						FB.logout();
					}
					sessionStorage.clear();
					location.href="${root}/";
				});
			}
		}
	});
</script>
<script>
    // blogMap 메인화면의 추천게시물 로드 스크립트
	$(function(){
		$.ajax({
			type:'get',
			url:'${root}/board/getRecommandBlog.do',
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
					var data=JSON.parse(responseData);
					if(!data){
						alert("blogMap 추천게시물 get Error");
						return false;
					}

					var travel_count=0;
                    var food_count=0;
                    var coupon_count=0;
                    $.each(data,function(i){
                    	var category=data[i].CATEGORY;
                    	var boardNo=data[i].BOARD_NO;
                    	var boardTitle=data[i].BOARD_TITLE;
                    	var fileName=data[i].FILE_NAME;

                     	var carousel_image = "<div class='item'>";
                     	if(category=='100' || category=='200'){
                     		carousel_image += "<img src=" + "${root}/pds/board/"+ fileName + " name="+ "P" + boardNo + " />";	
                     	}else{
                     		carousel_image += "<img src=" + "${root}/pds/coupon/"+ fileName + " name="+ "C" + boardNo + " />";
                     	}
                       	carousel_image += "<div class='carousel-caption'>";
                       	carousel_image += "<h6>"+ boardTitle +"</h6>";
                       	carousel_image += "</div>";
                       	carousel_image += "</div>";
                    	
                       	if(category=='100'){
                           if(travel_count==0){
                                $("#tile7 .carousel-inner").empty();                                                  	  
                           }else if(travel_count==2){
                        	    $("#tile8 .carousel-inner").empty();
                           }

                           if(travel_count<2){
                           	  $("#tile7 .carousel-inner").append(carousel_image);
                           }else{
                        	  $("#tile8 .carousel-inner").append(carousel_image);
                           }
                            
                            
                       	    
                            if(travel_count==0){
                             	$("#tile7 .item").addClass("active");
                            }else if(travel_count==2){
                            	$("#tile8 .item").addClass("active");
                            }
                            
                            travel_count++;                       		
                       	}else if(category=='200'){
                            if(food_count==0){
                                $("#tile10 .carousel-inner").empty();                                          	  
                            }else if(food_count==2){
                            	$("#tile9 .carousel-inner").empty();
                            }
                            
                            if(food_count<2){
                            	 $("#tile10 .carousel-inner").append(carousel_image);
                            }else{
                            	 $("#tile9 .carousel-inner").append(carousel_image);
                            }
                           
                       	    
                            if(food_count==0){
                             	$("#tile10 .item").addClass("active");
                            }else if(food_count==2){
                            	$("#tile9 .item").addClass("active");
                            }           
                            
                            food_count++;
                    	}else{
                            if(coupon_count==0){
                                $("#tile5 .carousel-inner").empty();                                          	  
                            }else if(coupon_count==2){
                            	$("#tile6 .carousel-inner").empty();
                            }
                            
                            if(coupon_count<2){
                            	 $("#tile5 .carousel-inner").append(carousel_image);
                            }else{
                            	 $("#tile6 .carousel-inner").append(carousel_image);
                            }
                           
                       	    
                            if(coupon_count==0){
                             	$("#tile5 .item").addClass("active");
                            }else if(coupon_count==2){
                            	$("#tile6 .item").addClass("active");
                            }           
                            
                            coupon_count++;
                    	}
                        
                       	// 추천블로그 클릭
                       	if(category=='100' || category=='200'){
                       		$("#metro img[name=" + "P" + boardNo +"]").click(function(){
                       			blogListDetails(boardNo);
                            	$("div[id='blogListDetail'].modal").modal();
                       		});
                       	}else{
                       		$("#metro img[name=" + "C" + boardNo +"]").click(function(){
                        		couponData(boardNo);
                        		$("div[id='couponDetail'].modal").modal();
                       		});
                       	}
                       	
                       	// 추천쿠폰 클릭
                        $("#metro img[name=" + boardNo +"]").click(function(){
                        	if(category=='100' || category=='200'){
                                blogListDetails(boardNo);
                            	$("div[id='blogListDetail'].modal").modal();		
                        	}else{
                        		couponData(boardNo);
                        		$("div[id='couponDetail'].modal").modal();
                        	}
                        });
                    });
                    
                    $("#tile5 .item").height($("#tile1").width());
                    $("#tile5 img").css("height","60%");
                    $("#tile5 img").css("width","100%");
                    $("#tile5 .carousel-caption").css("top","50%");
                    
                    $("#tile6 .item").height($("#tile1").width());
                    $("#tile6 img").css("height","60%");
                    $("#tile6 img").css("width","100%");
                    $("#tile6 .carousel-caption").css("top","50%");
                    
                    $("#tile7 .item").height($("#tile1").width());
                    $("#tile7 img").css("height","100%");
                    $("#tile7 img").css("width","100%");
                    $("#tile7 .carousel-caption").css("top","50%");
                    
                    $("#tile8 .item").height($("#tile1").width());
                    $("#tile8 img").css("height","60%");
                    $("#tile8 img").css("width","100%");
					$("#tile8 .carousel-caption").css("top","50%");

                    $("#tile9 .item").height($("#tile1").width());
                    $("#tile9 img").css("height","60%");
                    $("#tile9 img").css("width","100%");
					$("#tile9 .carousel-caption").css("top","50%");
					
                    $("#tile10 .item").height($("#tile1").width());
                    $("#tile10 img").css("height","100%");
                    $("#tile10 img").css("width","100%");
					$("#tile10 .carousel-caption").css("top","50%");
			},
			error:function(data){
				alert("error : blogMap getRecommandBlog");
			}
		});	
	});
</script>
<script>
//세션 체크후 모달 오픈
$(function(){
	// 블로그 검색
	$("#blogSearch").click(function(){
		$("map").empty();
		$("#map_div").addClass("col-lg-12 col-md-12");
		$("#list_div").addClass("col-lg-12 col-md-12");
		
		$("div[id='blogListMain'].modal").modal();
		getBeginCondition();
	});	
	
	// 메세지 메인
	$("#mainMessageLink").click(function(){
		if (window.sessionStorage) {
	    	var email = sessionStorage.getItem('email');
	    	if(email!=null){
	    		messageView();
	    		$("div[id='mainMessage'].modal").modal();
	    	}else{
	    		alert("로그인 후 이용가능합니다.");
	    	}
	    }
	});
	
	// 제휴업체 메인
	$("#partner_Registration").click(function(){
		if (window.sessionStorage) {
	    	var email = sessionStorage.getItem('email');
	    	if(email!=null){
	    		getPartnerInfo();
	    		
	    		$("div[id='partnerMain'].modal").modal();
	    	}else{
	    		alert("로그인 후 이용가능합니다.");
	    	}
	    }
	});
	
	// 블로그 작성
	$("#blogMain_write").click(function(){
		if (window.sessionStorage) {
	    	var email = sessionStorage.getItem('email');
	    	if(email!=null){
	    		$("div[id='blogMapWrite'].modal").modal();
	    	}else{
	    		alert("로그인 후 이용가능합니다.");
	    	}
	    }
	});
	
	// 쿠폰정보
	$("#blogMain_coupon").click(function(){
		if (window.sessionStorage) {
	    	var email = sessionStorage.getItem('email');
	    	if(email!=null){
	    		$("div[id='blogMapCoupon'].modal").modal();
	    	}else{
	    		alert("로그인 후 이용가능합니다.");
	    	}
	    }
	});
});
</script>

</head>
<body style="padding:10px; padding-top:40px;">
<div>
	<!-- 회원관련 -->
	<div class="container" style="max-width:1170px; padding:0 0 0 0;">
		<nav class="navbar navbar-inverse" role="navigation" style="width:inherit;">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="http://localhost:8088/blogMap/">BlogMap</a>
				</div>
			
				<!-- Collect the nav links, forms, and other content for toggling -->
			   <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			      <ul class="nav navbar-nav navbar-right">
			      	<li id="mainMessageLink"><a style="cursor:Pointer"><b>Message</b></a></li>
			      	<li><a id="blogmap_main_myPage" data-toggle="modal" href="#blogmap_myPage" class="btn" style="text-align:left; display:none"><b>MyPage</b></a></li>
			        <li id="blogmap_login_bar" class="dropdown">
			          <a href="#" class="dropdown-toggle" data-toggle="dropdown" id="blogmap_before_login"><b id="login_text">Login</b> <span id="login_dropdown_btn" class="caret"></span></a>
						<ul id="login-dp" class="dropdown-menu">
							<li>
								 <div class="row">
										<div class="col-md-12">
										<br/>
										 <form class="form" role="form" method="post" action="login" accept-charset="UTF-8" id="login-nav">
												<div class="form-group">
													 <label class="sr-only" for="member_login_id">Email address</label>
													 <input type="email" class="form-control" id="member_login_id" placeholder="Email address" required>
												</div>
												
												<div class="form-group">
													 <label class="sr-only" for="member_login_password">Password</label>
													 <input type="password" class="form-control" id="member_login_password" placeholder="Password" required>
												</div>
												
												<div class="form-group">
													 <button type="button" id="login_btn" class="btn btn-primary btn-block">Sign in</button>
												</div>
												
										  </form> 
										  <div class="help-block text-right"><a data-toggle="modal" href="#blogmap_renew_pwd">Forget the password ?</a></div>
										  	

											<div class="social-buttons" style="text-align:center;">
												<!-- <a href="#" class="btn btn-fb" onclick="FB.login();"><i class="fa fa-facebook"></i> Facebook</a> -->
												<fb:login-button scope="public_profile,email" onlogin="checkLoginState();" size="large">Facebook 
												</fb:login-button>
												<!-- <br/><br/>
												<div class="fb-login-button" data-max-rows="1" data-size="large" data-show-faces="false" data-auto-logout-link="false" style="width:200px;">Facebook</div> -->
												
											</div>
										</div>
										
										<div class="bottom text-center">
											New here ? <a data-toggle="modal" href="#blogmapRegister"><b>Join Us</b></a>
										</div>
								 </div>
							</li>
						</ul>
			        </li>
			   
			      </ul>
				 </div><!-- /.navbar-collapse -->
		</nav>
	</div>
	<br/>
		


	<!-- Metro style dynamic Tiles -->
	<div id="metro" class="container dynamicTile">
		<div class="row ">
			<!-- 블로그 검색 -->
	    	<div class="col-sm-2 col-xs-4">
	    		<div id="tile1" class="tile">
		        
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active">
								<img id="blogSearch" src="${root}/images/blogMap/search.png" class="img-responsive" style="cursor:Pointer"/>
							</div>
						</div>
					</div>
		        
		   		</div>
			</div>
			
			<!-- 블로그맵 로고 -->
			<div class="col-sm-2 col-xs-4">
				<div id="tile2" class="tile">
			   	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active" style="m">
								<img src="${root }/images/blogMap/blogICon.jpg" class="img-responsive"/>
							</div>
						</div>
					</div>
			        
				</div>
			</div>
			
			<!-- 블로그 작성 -->
			<div class="col-sm-2 col-xs-4">
				<div id="tile3" class="tile">
			   	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active">
								<a id="blogMain_write" style="cursor:Pointer">
									<img src="${root}/images/blogMap/write_go.png" class="img-responsive"/>
								</a>
							</div>
						</div>
					</div>
			        
				</div>
			</div>
			
			<!-- 쿠폰정보 -->
			<div class="col-sm-2 col-xs-4">
				<div id="tile4" class="tile">
			   	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active">
								<a id="blogMain_coupon" style="cursor:Pointer">
									<img src="${root}/images/blogMap/coupon.png" class="img-responsive"/>
								</a>
							</div>
						</div>
					</div>
			        
				</div>
			</div>
			
			<!-- 쿠폰추천1 -->
			<div class="col-sm-2 col-xs-4">
				<div id="tile5" class="tile" style="cursor:Pointer">
			  	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active">
							</div>
						</div>
					</div>
 
				</div>
			</div>
			
			<!-- 쿠폰추천2 -->
			<div class="col-sm-2 col-xs-4">
				<div id="tile6" class="tile" style="cursor:Pointer">
			   	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active"></div>
						</div>
					</div>
			        
				</div>
			</div>
		</div>

		<div class="row">
			<!-- 여행추천1 -->
			<div class="col-sm-4 col-xs-8">
				<div id="tile7" class="tile" style="cursor:Pointer">
			   	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
					    	<div class="item active"></div>
						</div>
					</div>
			        
				</div>
			</div>
			
			<!-- 여행추천2 -->
			<div class="col-sm-2 col-xs-4">
				<div id="tile8" class="tile" style="cursor:Pointer">
			   	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active"></div>
						</div>
					</div>
			        
				</div>
			</div>
			
			<!-- 음식추천1 -->
			<div class="col-sm-2 col-xs-4">
				<div id="tile9" class="tile" style="cursor:Pointer">
				  	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active"></div>
						</div>
					</div>
				       
				</div>
			</div>
			
			<!-- 음식추천2 -->
			<div class="col-sm-4 col-xs-8">
				<div id="tile10" class="tile" style="cursor:Pointer">
				  	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active"></div>
						</div>
					</div>
				    
				</div>
			</div>
		
		</div>
	</div>
	<br/>

	<div class="container" style="max-width:1170px; height:50px;">
		<div style="width:100%; height:50px; text-align:right;">
			<p style="width:100%; line-height:46px;">
				<a id="partner_Registration" style="cursor:Pointer"><img src="${root}/images/blogMap/Partnership_32.png"></a>
				&nbsp;&nbsp;
				<a data-toggle="modal" href="#ManagerMain" id="manager_page_icon" style="display:none; "><img src="${root}/images/blogMap/gear_24.png" onclick="getMemberList()"></img></a>
			</p>
		</div>
	</div>
</div>

<div class="container-fluid">
		<!-- **********************************
	                        블로그 리스트 : 이헌주
	     ***********************************-->
		<!-- 블로그 리스트 - 블로그 리스트 검색 -->
		<div class="modal fade" id="blogListMain" data-backdrop="static">
			<div class="modal-dialog" style="height:100%; margin:1% 1% 1% 1%; overflow-y:hidden;">
				<div class="modal-content" style="height:100%;">
					<div class="modal-header" style="height:7%;">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Blog Search</h4>
					</div>
					<div class="modal-body" style="height:93%;">
						<div id="mainResult" style="height:100%;">
							<jsp:include page="board/blogListMain.jsp"/>
						</div>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 블로그 리스트 자세히 보기 : 황준 -->
		<div class="modal fade" id="blogListDetail" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" id="read_closeButton" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Blog Read</h4>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
 							<jsp:include page="board/blogRead.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
			   </div>
			</div>
		</div>
		
		<!-- **********************************
	                             블로그 작성 : 황준
	     ***********************************-->
		<!-- 블로그 작성 - blogMapWrite -->	
		<div class="modal fade" id="blogMapWrite" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Blog Write</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="board/blogWrite.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 블로그 작성 - 위치검색 map -->
		<div class="modal fade" id="blogWriteSub" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Blog Write Map</h4>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
					<jsp:include page="board/blogWriteMap.jsp"/> 
						</div>
						<br>
						<br>
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
					</div>
			   </div>
			</div>
		</div>
		
		<!-- **********************************
	                        블로그 수정 : 황준
	     ***********************************-->
	     <!-- 블로그 작성 - blogMapWrite -->	
		<div class="modal fade" id="blogMapUpdate" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Blog Update</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="board/blogUpdate.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
					</div>
				</div>
		    </div>
		</div>
	     
	  <!--쿠폰발급클릭시 쿠폰발급창 -->   
	    <div class="modal fade" id="blogRead_coupon" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h5 class="modal-title">조회 결과</h5>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
 							<jsp:include page="board/blogRead_coupon.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
			   </div>
			</div>
		</div> 
	     		
		<!-- **********************************
	                              제휴업체 : 변태훈
	     ***********************************-->
		<!-- 제휴업체 - 제휴업체등록 main -->
		<div class="modal fade" id="partnerMain" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Partner</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<div class="caption">	
								<jsp:include page="partner/mainHome.jsp" />
							</div>
						</div>					
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 제휴업체 - 제휴업체 정보 팝업 레이어 -->
		<section class="modal fade" id="modal_info">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">Partner Info</h4>
					</div>
					
					<div class="modal-body" id="data-body">
						<div class="row form-horizontal">
								<div class="col-md-3">
									<img class="img-responsive img" id="partnerDetail_imagers"/>
								</div>
								<div class="col-md-9">
								<div class="form-group">
									<label class="col-xs-3 control-label">카테고리:</label>
									<div class="col-xs-6">
 										<div class="form-control-static name" name="p_category_MNAME" style="display:inline-block;"></div>
 										<div class="form-control-static name" name="p_category_SNAME"style="display:inline-block;"></div>
									</div>
								</div>
							
								<div class="form-group">
									<label class="col-xs-3 control-label">업체명:</label>
									<div class="col-xs-6">
 										<p class="form-control-static name" name="p_name"></p> 
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-xs-3 control-label">전화번호:</label>
									<div class="col-xs-6">
 										<p class="form-control-static phone" name="p_phone"></p>  
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-xs-3 control-label">주소:</label>
									<div class="col-xs-6">
										<p class="form-control-static address" name="p_addr"></p> 
									</div>
								</div>
							</div>
						</div>						
						<div class="row">
							<div class="col-xs-12 text-right">
								<input type="button" class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target="#mainCoupon_Registration" value="쿠폰등록"/>								
								<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		
		<!-- 제휴쿠폰 업체 - 제휴쿠폰 업체 정보 팝업 레이어 -->
		<section class="modal fade" id="modalCoupon_info">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">PartnerCoupon Info</h4>
					</div>
					
					<div class="modal-body" id="data-body">
						<div class="row form-horizontal">
							<div class="col-md-3">
								<img class="img-responsive img" id="partnerCouponDetail_imagers"/>
							</div>
							<div class="col-md-9">
							
								<div class="form-group">
									<label class="col-xs-3 control-label">업체명:</label>
									<div class="col-xs-6">
 										<p class="form-control-static name" name="p_name"></p> 
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-xs-3 control-label">전화번호:</label>
									<div class="col-xs-6">
 										<p class="form-control-static phone" name="p_phone"></p>  
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-xs-3 control-label">주소:</label>
									<div class="col-xs-6">
										<p class="form-control-static address" name="p_addr"></p> 
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-xs-3 control-label">할인상품:</label>
									<div class="col-xs-6">
										<p class="form-control-static coupon_item" name="coupon_item"></p> 
									</div>
								</div>

								<div class="form-group">
									<label class="col-xs-3 control-label">할인율:</label>
									<div class="col-xs-6">
										<p class="form-control-static coupon_discount" name="coupon_discount"></p> 
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-xs-3 control-label">쿠폰적용시작일:</label>
									<div class="col-xs-6">
										<p class="form-control-static coupon_bymd" name="coupon_bymd"></p> 
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-xs-3 control-label">쿠폰적용종료일:</label>
									<div class="col-xs-6">
										<p class="form-control-static coupon_eymd" name="coupon_eymd"></p> 
									</div>
								</div>
							</div>
						</div>						
						<div class="row">
							<div class="col-xs-12 text-right">						
								<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		
		<!-- 제휴업체 - 제휴업체 등록 팝업 레이어 -->
		<section class="modal fade" id="write_pop">
			<div class="modal-dialog modal-lg">
				<form name="partnerWriter_form" id="write_form" class="col-xs-12 form-horizontal" method="post" action="${root}/partner/write.do" autocomplete="off" enctype="multipart/form-data">
					<div class="modal-content">
						
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title">Partner Register</h4>
						</div>
	
						<div class="modal-body" id="data-body">							
							<input type="hidden"  id="category_code" name="category_code"/>
							<input type="hidden"  id="member_id" name="member_id"/>
							
							<div id="blogPartnerSelect" class="form-group">
								<label class="col-xs-4 control-label">카테고리:</label> 
								<select id="headCategory" name="category_mname" class="selectpicker" data-width="140px" style="display: none" onchange="blogWrite_ChangeCategory(this.id)">
									<option value="%">대분류[전체]</option>
								</select> 
								<select id="detailCategory" name="category_sname"  class="selectpicker" data-width="140px" style="display: none">
									<option value="%">소분류[전체]</option>
								</select>
							</div>
							
							<div class="form-group">
								<label class="col-xs-4 control-label">업체명:</label>
								<div class="col-xs-6">
									<input type="text" class="form-control" name="partner_name" id="name" value="" required="required" placeholder="업체명"/>
								</div>
							</div>
	
							<div class="form-group">
								<label class="col-xs-4 control-label">전화번호:</label>
								<div class="col-xs-6">
									<input type="text" class="form-control" name="partner_phone" id="phone" value="" required="required" placeholder="전화번호"/>
								</div>
							</div>
	
							<div class="form-group">
								<label class="col-xs-4 control-label">주소:</label>
								<div class="col-xs-6">
									<input type="text" class="form-control" name="partner_addr" id="address" value="" required="required" placeholder="주소를 입력하세요"/>
								</div>											
							</div>
	
							<div class="form-group">
								<label class="col-xs-4 control-label">업체사진:</label>
								<div class="col-xs-6">
									<input type="file" class="form-control" name="img_src" id="partner_imagers"/>
								</div>
							</div>
						</div>
	
						<div class="modal-footer">
							<input type="button" class="btn btn-primary" id="partnerWriteSave_button" value="업체등록" onclick="return form_partnerWrite();"/>
						</div>
					</div>
				</form>
			</div>
		</section>
	
	  <!-- 제휴업체 - 쿠폰정보등록 팝업 레이어 -->	
	  <!-- 쿠폰 등록 작성 - 쿠폰정보등록 -->
      <section class="modal fade" id="mainCoupon_Registration">
      <div class="modal-dialog modal-lg">
         <form id="couponWrite_form" class="col-xs-12 form-horizontal" method="post" action="${root}/partner/couponWrite.do" autocomplete="off" enctype="multipart/form-data">
            <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                     <span aria-hidden="true">&times;</span>
                  </button>
                  <h4 class="modal-title">Coupon Register</h4>
               </div>

               <div class="modal-body" id="data-body">                     
				<input type="hidden" id="coupon_no" name="coupon_no"/>
				<input type="hidden" id="partner_no" name="partner_no"/>
                  <div class="form-group">
                     <label class="col-xs-4 control-label">할인상품</label>
                     <div class="col-xs-6">
                        <input type="text" class="form-control" name="coupon_item" id="coupon_items" required="required" placeholder="할인상품명을 입력하세요"/>
                     </div>
                  </div>

                  <div class="form-group">
                     <label class="col-xs-4 control-label">할인율</label>
                     <div class="col-xs-6">
                        <input type="text" class="form-control" name="coupon_discount" id="coupon_discount" required="required" placeholder="할인율 적어주세요"/>
                     </div>
                  </div>

                  <div class="form-group">
                     <label class="col-xs-4 control-label">쿠폰적용시작일</label>
                     <div class="col-xs-6">
                        <input type="date" class="form-control" name="coupon_bymd" id="coupon_bymd" required="required" placeholder="쿠폰 시작일"/>
                     </div>                                 
                  </div>
                  
                  <div class="form-group">
                     <label class="col-xs-4 control-label">쿠폰적용종료일</label>
                     <div class="col-xs-6">
                        <input type="date" class="form-control" name="coupon_eymd" id="coupon_eymd" required="required" placeholder="쿠폰 종료일"/>
                     </div>                                 
                  </div>

                  <div class="form-group">
                     <label class="col-xs-4 control-label">쿠폰사진</label>
                     <div class="col-xs-6">
                        <input type="file" class="form-control" name="img_src" id="coupon_imagers"/>
                     </div>
                  </div>
               </div>
               <div class="modal-footer">
                  <button type="button"  id="coupon_Register" class="btn btn-primary" onclick="return form_couponWrite();">신청하기</button>
               </div>
            </div>
         </form>
      </div>
   </section>
   
		
		<!-- **********************************
	                           회원관리 : 김정훈
	     ***********************************-->
		<!-- 회원관리 - 로그인 -->
		<div class="modal fade" id="blogmapLogin" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">BlogMap Login</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/login.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 회원관리 - 회원가입 -->
		<div class="modal fade" id="blogmapRegister" data-backdrop="static">
			<div class="modal-dialog modal-email-confrim">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/register.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 회원관리 - 비밀번호중복확인(사용가능) -->
		<div class="modal fade" id="blogmap_registerCheckOk" data-backdrop="static">
			<div class="modal-dialog modal-email-confrim">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/registerCheckOk.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 회원관리 - 비밀번호중복확인(불가능) -->
		<div class="modal fade" id="blogmap_registerCheckNo" data-backdrop="static">
			<div class="modal-dialog modal-email-confrim">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/registerCheckNo.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 회원관리 - 비밀번호 찾기 -->
		<div class="modal fade" id="blogmap_renew_pwd" data-backdrop="static">
			<div class="modal-dialog modal-email-confrim">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/renew_pwd.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					
				</div>
		    </div>
		</div>

		<!-- 회원관리 - 메일전송 확인 -->
		<div class="modal fade" id="blogmap_email_confirm" data-backdrop="static">
			<div class="modal-dialog modal-email-confrim">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Email Confirm</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/email_confirm.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
				</div>
		    </div>
		</div>
	
		<!-- 회원관리 - 마이페이지 -->
		<!-- 마이페이지 -->
		<div class="modal fade" id="blogmap_myPage" data-backdrop="static">
			<div class="modal-dialog modal-myPage">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">MyPage</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/myPage.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 회원관리 - 수정 -->
		<div class="modal fade" id="blogmap_myPageUpdate" data-backdrop="static">
			<div class="modal-dialog modal-email-confrim">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Member Update</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/myPageUpdate.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 회원관리 - 탈퇴 -->
		<div class="modal fade" id="blogmap_myPageDelete" data-backdrop="static">
			<div class="modal-dialog modal-email-confrim">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Member Withdraw</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/myPageDelete.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
				</div>
		    </div>
		</div>
		
		<!-- FaceBook 회원탈퇴시 이메일 인증 -->
		<div class="modal fade" id="blogmap_fb_myPageDelete" data-backdrop="static">
			<div class="modal-dialog modal-email-confrim">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Email Confirm</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/fb_delete_email_confirm.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
				</div>
		    </div>
		</div>
		
		<!-- **********************************
				관리자페이지 : 이동희
	     ***********************************-->
		<!-- 관리자페이지 - ManagerMain -->
		<div class="modal fade" id="ManagerMain" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Manager</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="manager/managerMain.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
				</div>
		    </div>
		</div>

		<!-- 관리자페이지 - memberInfo -->
		<div class="modal fade" id="memberInfo" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h5 class="modal-title">Member Manage</h5>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="manager/memberlist.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
			   </div>
			</div>
		</div>
		
		<!-- 관리자페이지 - partnerInfo -->
		<div class="modal fade" id="partnerInfo" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Partner Manage</h4>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="manager/partnerList.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
			   </div>
			</div>
		</div>

		<!-- 관리자페이지 - 제휴업체 상세조회 (관리자페이지 - 제휴업체 페이지 제휴업체 상세 페이지)-->
		<div class="modal fade" id="partnerDetail" data-backdrop="static">
			<div class="modal-dialog" style="max-width:800px; margin:auto;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">PartnerDetail Manage</h4>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="manager/partnerDetail.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
			   </div>
			</div>
		</div>
		
		<!-- 관리자페이지 - 쿠폰 상세조회 (관리자페이지 - 제휴업체 페이지 제휴업체 상세 페이지)-->
		<div class="modal fade" id="couponDetail" data-backdrop="static">
			<div class="modal-dialog" style="max-width:800px; margin:auto;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Coupon Manage</h4>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="manager/couponDetail.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
			   </div>
			</div>
		</div>



		<!-- **********************************
				메시지박스 : 정기창
	     ***********************************-->
		<!-- 메시지박스 - 메시지 메인 -->
		<div class="modal fade" id="mainMessage" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Message</h4>
					</div>
					<div class="modal-body">
						<jsp:include page="message/mainMessage.jsp"/>
						<br/>
						<br/>	
					</div>
				</div>
		    </div>
		</div>	
	
		<!-- 메시지박스 - 메시지 조회 -->
		<div class="modal fade" id="messageRead" data-backdrop="static">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Message Read</h4>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="message/messageRead.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
					<div class="modal-footer">
						<a data-toggle="modal" href="#messageDelete" data-dismiss="modal" class="btn btn-primary btn-delete">메시지 삭제</a>
					</div>
			   </div>
			</div>
		</div>
		
		<!-- 메시지박스 - 메시지 삭제 -->
		<div class="modal fade" id="messageDelete" data-backdrop="static">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Message Delete</h4>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="message/messageDelete.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
					<div class="modal-footer">
						<a class="btn btn-primary delete_btn" data-dismiss="modal" onclick="msgDelete()">메시지 삭제</a>
					</div>
			   </div>
			</div>
		</div>

		<!-- 메시지박스 - 쿠폰메인 -->
		<div class="modal fade" id="blogMapCoupon" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Coupon</h4>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="coupon/couponMain.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
					<div class="modal-footer">
						 <div class="col-md-6">
	                     <div id="custom-search-input">
	                            <div class="input-group col-md-12">
	                                <input type="text" class="form-control input-lg" name="coupon_search" id="coupon_search" placeholder="search for partner_name" />
	                                <span class="input-group-btn">
	                                    <button class="btn btn-info btn-lg" type="button" id="coupon_search_btn">
	                                        <i class="glyphicon glyphicon-search"></i>
	                                    </button>
	                                </span>
	                            </div>
	                        </div>
	                     </div>
					</div>
			   </div>
			</div>
		</div>
		
	</div>
</body>
</html>
