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
	.modal-lg{
		width: auto;
		margin: 1% 1% 0px 1%;
 		height: 600px;
/*    		max-height: 600px; */
    		overflow-y:scroll;
	}

/*이미지 슬라이더*/	
.carousel-inner.onebyone-carosel { margin: auto; width: 90%; }
.onebyone-carosel .active.left { left: -33.33%; }
.onebyone-carosel .active.right { left: 33.33%; }
.onebyone-carosel .next { left: 33.33%; }
.onebyone-carosel .prev { left: -33.33%; }
</style>

<!--[if lt IE 9]>
	<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
        
<!-- CDN 서비스에서 javascript를 불러옵니다 -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>												<!-- jquery javascript를 로드 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>						<!-- bootstrap javascript를 로드 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.7.3/js/bootstrap-select.js"></script>	<!-- bootstrap-select javascript를 로드 -->
<script src="https://netdna.bootstrapcdn.com/twitter-bootstrap/2.0.4/js/bootstrap-dropdown.js"></script>		<!-- bootstrap-dropdown javascript를 로드 -->

<script type="text/javasciprt" src="${root}/css/bootstrap-confirmation.js"></script>
<!-- Modal, Metro style javascript를 로드 -->
<script type="text/javascript" src="${root}/css/blogMap/blogMap.js"></script>
<script type="text/javascript" src="http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=60e9ac7ab8734daca3d2053c1e713dbd"></script>
<!-- 네이버 스마트에디터 -->
<script type="text/javascript" src="${root }/editor/js/HuskyEZCreator.js" charset="utf-8"></script>	
<!-- modal, session check -->
<script type="text/javascript">
	$(document).ready(function() {
		 $('#myCarousel').carousel({
		        interval: 10000
		    })
		    $('.fdi-Carousel .item').each(function () {
		        var next = $(this).next();
		        if (!next.length) {
		            next = $(this).siblings(':first');
		        } t.children(':first-child').clone().appendTo($(this));

		        if (next.next().length > 0) {
		            next.next().children(':first-child').clone().appendTo($(this));
		        }
		        else {
		            $(this).siblings(':first').children(':first-child').clone().appendTo($(this));
		        }
		    });

//			<session check -> button change>
			if(sessionStorage.getItem('email')!=null){
				//<li><a href="#" class="dropdown-toggle" id="blogmap_after_login" style="display:none;"><b>Logout</b></a></li>
				//$("#blogmap_login_bar").fadeOut();
				$("#blogmap_before_login span").remove();
				$("#blogmap_before_login").attr("data-toggle","");
				$("#login_text").text("Logout");
				
				if($("#login_text").text()=="Logout"){
					$("#blogmap_before_login").click(function(){
						if(sessionStorage.getItem('jointype')=="0002"){
							FB.logout();
						}
						sessionStorage.clear();
						//$("#blogmap_after_login").css("display","none");
						//$("#blogmap_login_bar").fadeIn();
						location.href="${root}/";
					});
				}
			}
	});

	



</script>
</head>
<body>
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
					<a class="navbar-brand" href="#">BlogMap</a>
				</div>
			
				<!-- Collect the nav links, forms, and other content for toggling -->
			   <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			      <ul class="nav navbar-nav navbar-right">
			      	<li> <a id="mainMessageLink" data-toggle="modal" href="#mainMessage" class="btn" style="text-align:left;"><b>Message</b></a></li>
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
													<a href="#" class="btn btn-fb"  onclick="FB.login();"><i class="fa fa-facebook"></i> Facebook</a>
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
	<div class="container dynamicTile">
		<div class="row ">
	    	<div class="col-sm-2 col-xs-4">
	    		<div id="tile1" class="tile">
		        
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active">
								<a data-toggle="modal" href="#blogListMain">
									<img src="${root}/css/blogMap/images/search.png" class="img-responsive"/>
								</a>
							</div>
						</div>
					</div>
		        
		   		</div>
			</div>
			
			<div class="col-sm-2 col-xs-4">
				<div id="tile2" class="tile">
			   	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active">
								<img src="http://handsontek.net/demoimages/tiles/hot.png" class="img-responsive"/>
							</div>
							<div class="item">
								<img src="http://handsontek.net/demoimages/tiles/hot2.png" class="img-responsive"/>
							</div>
							<div class="item">
								<img src="http://handsontek.net/demoimages/tiles/hot3.png" class="img-responsive"/>
							</div>
						</div>
					</div>
			        
				</div>
			</div>
			
			<div class="col-sm-2 col-xs-4">
				<div id="tile3" class="tile">
			   	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active">
								<a data-toggle="modal" href="#blogMapWrite">
									<img src="${root}/css/blogMap/images/write_go.png" class="img-responsive"/>
								</a>
							</div>
						</div>
					</div>
			        
				</div>
			</div>
			
			<div class="col-sm-2 col-xs-4">
				<div id="tile4" class="tile">
			   	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active">
								<a data-toggle="modal" href="#blogMapCoupon">
									<img src="${root}/css/blogMap/images/coupon_2.png" class="img-responsive"/>
								</a>
							</div>
						</div>
					</div>
			        
				</div>
			</div>
			
			<div class="col-sm-2 col-xs-4">
				<div id="tile5" class="tile">
			  	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active">
								<img src="http://handsontek.net/demoimages/tiles/neews.png" class="img-responsive"/>
							</div>
							<div class="item">
								<img src="http://handsontek.net/demoimages/tiles/neews2.png" class="img-responsive"/>
							</div>
						</div>
					</div>
 
				</div>
			</div>
			
			<div class="col-sm-2 col-xs-4">
				<div id="tile6" class="tile">
			   	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active">
								<img src="http://handsontek.net/demoimages/tiles/skype.png" class="img-responsive"/>
							</div>
							<div class="item">
								<img src="http://handsontek.net/demoimages/tiles/skype2.png" class="img-responsive"/>
							</div>
						</div>
					</div>
			        
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-sm-4 col-xs-8">
				<div id="tile7" class="tile">
			   	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
					    	<div class="item active">
								<img src="http://handsontek.net/demoimages/tiles/gallery.png" class="img-responsive"/>
						    </div>
						    <div class="item">
								<img src="http://handsontek.net/demoimages/tiles/gallery2.png" class="img-responsive"/>
						    </div>
						    <div class="item">
								<img src="http://handsontek.net/demoimages/tiles/gallery3.png" class="img-responsive"/>
						    </div>
						</div>
					</div>
			        
				</div>
			</div>
			
			<div class="col-sm-2 col-xs-4">
				<div id="tile8" class="tile">
			   	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active">
								<img src="http://handsontek.net/demoimages/tiles/music.png" class="img-responsive"/>
							</div>
							<div class="item">
								<img src="http://handsontek.net/demoimages/tiles/music2.png" class="img-responsive"/>
							</div>
						</div>
					</div>
			        
				</div>
			</div>
			
			<div class="col-sm-2 col-xs-4">
				<div id="tile9" class="tile">
				  	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active">
								<img src="http://handsontek.net/demoimages/tiles/calendar.png" class="img-responsive"/>
							</div>
							<div class="item">
								<img src="http://handsontek.net/demoimages/tiles/calendar2.png" class="img-responsive"/>
							</div>
						</div>
					</div>
				       
				</div>
			</div>
			
			<div class="col-sm-4 col-xs-8">
				<div id="tile10" class="tile">
				  	 
					<div class="carousel slide" data-ride="carousel">
						<!-- Wrapper for slides -->
						<div class="carousel-inner">
							<div class="item active">
								<h3 class="tilecaption"><i class="fa fa-child fa-4x"></i></h3>
							</div>
							<div class="item">
								<h3 class="tilecaption">Customize your tiles</h3>
							</div>
							<div class="item">
								<h3 class="tilecaption">Text, Icons, Images</h3>
							</div>
							<div class="item">
								<h3 class="tilecaption">Combine them and create your metro style</h3>
							</div>
						</div>
					</div>
				    
				</div>
			</div>
			
		</div>
	</div>
	<br/><br/>

	<div class="container" style="max-width:1170px; height:50px; padding:0 0 0 0;">
		<div class="navbar navbar-inverse" style="height:50px; color:gray; width:inherit;">
				<div class="col-sm-10 col-xs-9">
					<div class="col-sm-12 col-xs-12" style="height:50px; text-align:center;">
						<p style="width:inherit; line-height:46px;">
							<b style="width:inherit;">주소 : 경기도 분당시 삼평동 752-18 유스페이스 B동</b>
						</p>
					</div>
				</div>
				<div class="col-sm-2 col-xs-3" >
					<div class="col-sm-12 col-xs-12" style="height:50px; text-align:center;">
						<p style="width:inherit; line-height:46px;">
							<b style="width:inherit;"><a data-toggle="modal" href="#partnerMain" id ="partner_Registration" style="color:gray;">제휴업체</a></b>
						</p>
					</div>
				</div>
		</div><img src="${root}/css/blogMap/images/gear_24.png"></img>

	</div>
	<br/><br/>


<div class="container-fluid">

	<!-- **********************************
	                        블로그 리스트 : 이헌주
	     ***********************************-->
		<!-- 블로그 리스트 - 블로그 리스트 검색 -->
		<div class="modal fade" id="blogListMain" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h5 class="modal-title">blogListMain</h5>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="board/blogListMain.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 블로그 리스트 : 황준-->
		<div class="modal fade" id="blogListSub" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h5 class="modal-title">조회 결과</h5>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
 							<jsp:include page="board/list_backup.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
			   </div>
			</div>
		</div>
		
		<!-- 블로그 리스트 자세히 보기 : 황준 -->
		<div class="modal fade" id="blogListDetail" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h5 class="modal-title">블로그 읽기</h5>
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
						<h4 class="modal-title">Map Search</h4>
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
	                        제휴업체 : 변태훈
	     ***********************************-->
		<!-- 제휴업체 - 제휴업체등록 main -->
		<div class="modal fade" id="partnerMain" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">제휴업체등록</h4>
						<div class="row">
					  		<div class="col-lg-4">
							    <div class="input-group">
					      			<input type="text" class="form-control" placeholder="Search for..."/>
						      		<span class="input-group-btn">
						        		<button class="btn btn-default" type="button">검색</button>
						      		</span>
							    </div>	<!-- /input-group -->
					  		</div>	<!-- /.col-lg-6 -->
						</div>		<!-- /.row -->	
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="partner/mainHome.jsp" />
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
						<h4 class="modal-title">업체 정보</h4>
					</div>
					
					<div class="modal-body" id="data-body">
						<div class="row form-horizontal">
							<div class="col-md-3">
								<img class="img-responsive img" name="tour_image" src="http://placehold.it/300x300"/>
							</div>
							<div class="col-md-9">
								<div class="form-group">
									<label class="col-xs-3 control-label">업체명</label>
									<div class="col-xs-9">
 										<p class="form-control-static name" name="p_name"></p> 
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-xs-3 control-label">전화번호</label>
									<div class="col-xs-9">
 										<p class="form-control-static phone" name="p_phone"></p>  
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-xs-3 control-label">주소</label>
									<div class="col-xs-9">
										<p class="form-control-static address" name="p_addr"></p> 
									</div>
								</div>
							</div>
						</div>						
					</div>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</section>
		
		<!-- 제휴업체 - 제휴업체 등록 팝업 레이어 -->
		<section class="modal fade" id="write_pop">
			<div class="modal-dialog modal-lg">
				<form id="write_form" class="col-xs-12 form-horizontal" method="post" action="${root}/partner/write.do" autocomplete="off" enctype="multipart/form-data">
					<div class="modal-content">
						
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title">신규 업체 등록</h4>
						</div>
	
						<div class="modal-body" id="data-body">							
							<input type="hidden"  id="category_code" name="category_code"/>
							<input type="hidden"  id="member_id" name="member_id"/>
							<div class="form-group">
								<label class="col-xs-4 control-label">업체명</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="partner_name" id="name" value="" required="required" placeholder="업체명"/>
								</div>
							</div>
	
							<div class="form-group">
								<label class="col-xs-4 control-label">전화번호</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="partner_phone" id="phone" value="" required="required" placeholder="전화번호"/>
								</div>
							</div>
	
							<div class="form-group">
								<label class="col-xs-4 control-label">주소</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="partner_addr" id="address" value="" required="required" placeholder="주소를 입력하세요"/>
									<a data-toggle="modal" href="#blogWriteSub" class="btn btn-primary" onclick="mapSearch();">위치검색</a>
								</div>											
							</div>
	
							<div class="form-group">
								<label class="col-xs-4 control-label">업체사진</label>
								<div class="col-xs-8">
									<input type="file" class="form-control" name="img_src" id="img_src"/>
								</div>
							</div>
						</div>
	
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary" onclick="return form_validation();">신청하기</button>
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
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/login.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 회원관리 - 회원가입 -->
		<div class="modal fade" id="blogmapRegister" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/register.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 회원관리 - 비밀번호중복확인(사용가능) -->
		<div class="modal fade" id="blogmap_registerCheckOk" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/registerCheckOk.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 회원관리 - 비밀번호중복확인(불가능) -->
		<div class="modal fade" id="blogmap_registerCheckNo" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/registerCheckNo.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 회원관리 - 비밀번호 찾기 -->
		<div class="modal fade" id="blogmap_renew_pwd" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/renew_pwd.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>

		<!-- 회원관리 - 메일전송 확인 -->
		<div class="modal fade" id="blogmap_email_confirm" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/email_confirm.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
	
		<!-- 회원관리 - 마이페이지 -->
		<a data-toggle="modal" href="#blogmap_myPage" class="btn btn-primary">blogMapMypage</a>
		<br/><br/>
		<!-- 마이페이지 -->
		<div class="modal fade" id="blogmap_myPage" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/myPage.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 회원관리 - 수정 -->
		<div class="modal fade" id="blogmap_myPageUpdate" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/myPageUpdate.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
		
		<!-- 회원관리 - 탈퇴 -->
		<div class="modal fade" id="blogmap_myPageDelete" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Modal Main</h4>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="member/myPageDelete.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
				</div>
		    </div>
		</div>
		
	<!-- **********************************
				관리자페이지 : 이동희
	     ***********************************-->
		<a data-toggle="modal" href="#ManagerMain" class="btn btn-primary">Manager</a>
		<br/><br/>
		
		<!-- 관리자페이지 - ManagerMain -->
		<div class="modal fade" id="ManagerMain" data-backdrop="static">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h5 class="modal-title">Manager Main</h5>
					</div>
					<div class="modal-body">
						<div id="mainResult">
							<%--<jsp:include page="manager/main.jsp"/>--%>
							<jsp:include page="manager/managerMain_test.jsp"/>
						</div>
						<br/>
						<br/>
						
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<!-- <a href="#" class="btn btn-primary">Save changes</a> -->
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
						<h5 class="modal-title">MemberInfo</h5>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="manager/memberlist.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<!-- <a href="#" class="btn btn-primary">Save changes</a> -->
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
						<h5 class="modal-title">PartnerInfo</h5>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="manager/partnerList.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<!-- <a href="#" class="btn btn-primary">Save changes</a> -->
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
						<h4 class="modal-title">BlogMap</h4>
					</div>
					<div class="modal-body">
						<jsp:include page="message/mainMessage.jsp"/>
						<br/>
						<br/>	
					</div>
					
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
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
						<h5 class="modal-title">BlogMap</h5>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="message/messageRead.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
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
						<h5 class="modal-title">BlogMap</h5>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="message/messageDelete.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">취소</a>
						<a class="btn btn-primary delete_btn" data-dismiss="modal" onclick="msgDelete()">메시지 삭제</a>
					</div>
			   </div>
			</div>
		</div>

		<!-- 메시지박스 - 메시지 삭제 -->
		<div class="modal fade" id="blogMapCoupon" data-backdrop="static">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h5 class="modal-title">Coupon</h5>
					</div><div class="container"></div>
					<div class="modal-body">
						<div id="mainResult">
							<jsp:include page="coupon/couponMain.jsp"/>
						</div>
						<br/>
						<br/>
					</div>
					<div class="modal-footer">
						<a href="#" data-dismiss="modal" class="btn">Close</a>
						<a href="#" class="btn btn-primary">Save changes</a>
					</div>
			   </div>
			</div>
		</div>
	</div>
</body>
</html>
