<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<c:set var="root" value="${pageContext.request.contextPath }"/>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>BLOG MAP</title>
<script type="text/javascript">

 $(document).ready(function(){	
	$("#tile4").click(function(){
		
		$.ajax({
			type:'get',
			url:'${root}/coupon/couponMain.do',
			contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
			success : function(responseData) {
				var data = JSON.parse(responseData);
				/* alert(data); */
			
				/* 데이타를 채우기 위해 복사 */
				$.each(data, function(i){
					
					$("#coupon_item_list1").append($("#coupon_item1").clone().css("display", "block"));
					$("#coupon_item1:last-child #list_coupon_S_item").append(data[i].coupon_item);
					$("#coupon_item1:last-child a[class='list_coupon_no']").attr("id", data[i].coupon_no);
					$("#coupon_item1:last-child #coupon_images").append(data[i].img_src);
					
					/* $("#item1:last_child .phone").append(data[i].partner_phone);
					$("#item1:last_child .addr").append(data[i].partner_addr); */
					//$("#item1:last_child .img").attr('src', data.data_img);
					
					// 각 업체를 클릭했을때 이벤트
					$("#coupon_" + data[i].partner_no).click(function(){
						alert("쿠폰" + data[i].partner_no + "클릭");
						couponData(data[i].partner_no);	
					});
				});
				
				if (!data) {
					alert("등록된 정보가 없습니다.");
					return false;
				}
			}
		});
		
		$.ajax({
			type:'post',
			url:'${root}/coupon/couponMain.do',
			contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
			success : function(responseData) {
				var data = JSON.parse(responseData);
				/* alert(data); */
			
				/* 데이타를 채우기 위해 복사 */
				$.each(data, function(i){
					
					$("#coupon_item_list").append($("#coupon_item").clone().css("display", "block"));
					$("#coupon_item:last-child #list_coupon_L_item").append(data[i].coupon_item);
					$("#coupon_item:last-child a[class='list_coupon_no']").attr("id", data[i].coupon_no);
					$("#coupon_item:last-child #coupon_images").append(data[i].img_src);
					
					/* $("#item1:last_child .phone").append(data[i].partner_phone);
					$("#item1:last_child .addr").append(data[i].partner_addr); */
					//$("#item1:last_child .img").attr('src', data.data_img);
					
					// 각 업체를 클릭했을때 이벤트
					$("#coupon_" + data[i].partner_no).click(function(){
						alert("쿠폰" + data[i].partner_no + "클릭");
						couponData(data[i].partner_no);	
					});
				});
				
				if (!data) {
					alert("등록된 정보가 없습니다.");
					return false;
				}
			}
		});	
	});
});
</script>
</head>
<body>
<article class="container-fluid">
	<div class="row">
		<section class="page-header">
		<h2 class="page-title">Coupon List</h2>
		</section>
	</div>
	<div class="row">
		<div>	
			<div class="tab-content col-md-12">
				<section role="tabpanel" class="tab-pane active" id="coupon_Total">
				<div class="row" id="coupon_item_list">
					<p>50% DisCount Coupon</p>
					<div class="col-md-6 col-sm-6 col-xs-6" id="coupon_item" role="button" style="display:none;">
						<div id="tour_info" class="thumbnail">
							<a data-toggle="modal" href="#modal_info" class="list_coupon_no"> 
								<img class="img-responsive" id="coupon_images"/>	
								<div class="caption">
									<p id="list_coupon_L_item"></p>
								</div>
							</a>
						</div>
					</div>
				</div>	
					
					<div class="row" id="coupon_item_list1">
					<p>30% DisCount Coupon</p>
					<div class="col-md-3 col-sm-3 col-xs-3" id="coupon_item1" role="button" style="display:none;">
						
						<div id="tour_info" class="thumbnail">
								<a data-toggle="modal" href="#modal_info" class="list_coupon_no"> 
									<img class="img-responsive" id="coupon_images"/>	
									<div class="caption">
										<p id="list_coupon_S_item"></p>
									</div>
								</a>
						</div>
					</div>	
					</div>
				
				</section>
				</div>
			</div>
		</div>
	</article>
</body>
</html>