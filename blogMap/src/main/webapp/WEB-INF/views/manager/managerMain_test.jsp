<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>BLOG MAP</title>
<script type="text/javascript">
	$(document).ready(function(){

		// memberList
 		$("input#getMemberList").click(function(){	// 회원정보버튼 클릭시 실행
			getMemberList();	// 회원리스트 불러오는 함수 호출
		}); 
		
		// partnerList
		$("input#getPartnerList").click(function(){		// 제휴업체 정보버튼 클릭시 실행
			getPartnerList();		// 제휴업체 정보를 불러오는 함수 호출
			
		});
		
		 // couponList
		$("input#couponInfo2").click(function(){		// 쿠폰 정보버튼 클릭시 실행
			getCouponlist()		// 제휴업체 정보를 불러오는 함수 호출
		}); 
		
		// managerList
		$("input#managerInfo2").click(function(){		//관리자정보 버튼을 클릭시 실행
			getManagerList();		// 관리자 정보를 불러오는 함수 호출			
			
		});
		
	});
	
	
</script>
</head>
<body>
		<article class="container-fluid">

			<div class="row">
				<section class="page-header">
					<h2 class="page-title">관리자 모드</h2>
				</section>
			</div>

			<div class="row">

				<div>
					<!-- 큰 사이즈 화면에서 탭 목록-->					
					<ul class="nav nav-pills nav-stacked col-md-2 hidden-xs hidden-sm" role="tablist">
						<li role="presentation" class="active">
							<a href="#tab_member" aria-controls="tab_member" role="tab" data-toggle="tab" onclick="getMemberList()">회원정보</a>
						</li>
						
						<li role="presentation">
							<a href="#tab_partner" aria-controls="tab_partner" role="tab" data-toggle="tab" onclick="getPartnerList()">제휴업체</a>
						</li>
						
						<li role="presentation">
							<a href="#tab_coupon" aria-controls="tab_coupon" role="tab" data-toggle="tab" onclick="getCouponlist()">쿠폰정보</a>
						</li>
						
						<li role="presentation">
							<a href="#tab_manager" aria-controls="tab_manager" role="tab" data-toggle="tab" onclick="getManagerList()">관리자정보</a>
						</li>
					</ul>
					
					<!-- 작은 사이즈 화면에서 탭 목록-->
					<ul class="nav nav-tabs hidden-md hidden-lg" role="tablist">
						<li role="presentation" class="active">
							<a href="#tab_member" aria-controls="tab_member" role="tab" data-toggle="tab" onclick="getMemberList()">회원정보</a>
						</li>
						
						<li role="presentation">
							<a href="#tab_partner" aria-controls="tab_partner" role="tab" data-toggle="tab" onclick="getPartnerList()">제휴업체</a>
						</li>
						
						<li role="presentation">
							<a href="#tab_coupon" aria-controls="tab_coupon" role="tab" data-toggle="tab" onclick="getCouponlist()">쿠폰정보</a>
						</li>
						
						<li role="presentation">
							<a href="#tab_manager" aria-controls="tab_manager" role="tab" data-toggle="tab" onclick="getManagerList()">관리자정보</a>
						</li>
					</ul>

					<!-- 탭 내용 -->
					<div class="tab-content col-md-10">
						<section role="tabpanel" class="tab-pane active" id="tab_member">
							<div class="row" id="memberInfo_list">
								<div class="thumbnail">
									<div class="caption">	
									<!-- 메인 탭 내용시작 -->	
										<jsp:include page="memberlist.jsp"/>										
									</div>
								</div>
							</div>								
						</section>				
										
						
						<div role="tabpanel" class="tab-pane" id="tab_partner">
							<div class="row" id="memberInfo_list">
								<div class="thumbnail">
									<div class="caption">	
										<jsp:include page="partnerList.jsp"/>
									</div>
								</div>
							</div>
						</div>
						
						<div role="tabpanel" class="tab-pane" id="tab_coupon">
							<div class="row" id="memberInfo_list">
								<div class="thumbnail">
									<div class="caption">	
										<jsp:include page="couponList.jsp"/>
									</div>
								</div>
							</div>
						</div>
						
						<div role="tabpanel" class="tab-pane" id="tab_manager">
							<div class="row" id="memberInfo_list">
								<div class="thumbnail">
									<div class="caption">	
										<jsp:include page="managerList.jsp"/>
									</div>
								</div>
							</div>						
						</div>
					</div>
	
			</div>
		</article>
		
</body>
</html>
