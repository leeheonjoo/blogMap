<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="root" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	$("#coupon_issue_btn").click(function(){
		var board_no=$("#blogRead_boardno label").text();
		$.ajax({
			type:'POST',
			url:'${root}/board/coupon_issue.do',
			data:{
				board_no:board_no
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				//alert(responseData);
				var coupon_issue_data=JSON.parse(responseData);
				
				$("#blogRead_coupon_list_content").empty();
				$.each(coupon_issue_data,function(i){
					var getbymd = new Date(coupon_issue_data[i].COUPON_BYMD);	// 등록일 날짜 변환
					var byear = getbymd.getFullYear();
					var bmonth = getbymd.getMonth() + 1;
					var bday = getbymd.getDate();
					var bymd = byear + "년 " + bmonth + "월 "	+ bday + "일";
					//alert(bymd);
					
					var geteymd = new Date(coupon_issue_data[i].COUPON_EYMD);	// 승인일 날짜 변환
					var eyear = geteymd.getFullYear();
					var emonth = geteymd.getMonth() + 1;
					var eday = geteymd.getDate();
					var eymd = eyear + "년 " + emonth + "월 "	+ eday + "일";
					//alert(eymd);
					
					//$("#myPage_member_coupon_list_content").append('<li class="col-sm-3"><div class="fff"><div class="thumbnail"><img src="${root}/css/coupon/images/'+couponInfo[i].COUPON_PIC_NAME+'" alt=""><div class="caption"><h4>'+couponInfo[i].PARTNER_NAME+'</h4><div>할인상품:'+couponInfo[i].COUPON_ITEM+'</div><div>유효기간:'+couponInfo[i].COUPON_EYMD+'</div></div></div></div></li>');
					$("#blogRead_coupon_list_content").append('<div class="col-sm-6 col-md-4"><div class="thumbnail" ><h4 class="text-center"><span class="label label-info">'+coupon_issue_data[i].PARTNER_NAME+'</span></h4><img id="coupon_issue'+i+'" src="${root}/pds/coupon/'+coupon_issue_data[i].COUPON_PIC_NAME+'" class="img-responsive"><div class="caption"><div class="row"><div class="col-md-6 col-xs-6"><h4>'+coupon_issue_data[i].COUPON_ITEM+'</h4></div><div class="col-md-6 col-xs-6 price"><h4><label>'+coupon_issue_data[i].COUPON_DISCOUNT+'%</label></h4></div></div><p style="font-size:14px;">'+ bymd +' ~ '+ eymd +'</p><p style="font-size:14px;">'+coupon_issue_data[i].PARTNER_PHONE+'</p></div></div></div>');
					
					$("#coupon_issue"+i).click(function(){
						alert(coupon_issue_data[i].COUPON_NO);
						var result=confirm("쿠폰을 받으시겠습니까?");

						if(result){
							$.ajax({
								type:'post',
								url:'${root}/board/getCoupon.do',
								data:{
									coupon_no:coupon_issue_data[i].COUPON_NO,
									member_id:sessionStorage.getItem('email')
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									//alert(responseData);
									if(responseData=="1"){
										alert("쿠폰이 발급되었습니다.");
									}else if(responseData=="2"){
										alert("이미 발급받은 쿠폰입니다.");
									}else{
										alert("쿠폰이 발급 되지 않았습니다.");
									}
								}
							});	
						}
						
					});
					
				});
			}
			
		});
	});
	
	
</script>
</head>
<body>
<!-- <div class="col-md-6">
     <h4>Checkbox Buttons</h4>

    <div class="funkyradio">
        <div class="funkyradio-default">
            <input type="checkbox" name="checkbox" id="checkbox1" checked/>
            <label for="checkbox1">First Option default</label>
        </div>
        <div class="funkyradio-primary">
            <input type="checkbox" name="checkbox" id="checkbox2" checked/>
            <label for="checkbox2">Second Option primary</label>
        </div>
        <div class="funkyradio-success">
            <input type="checkbox" name="checkbox" id="checkbox3" checked/>
            <label for="checkbox3">Third Option success</label>
        </div>
        <div class="funkyradio-danger">
            <input type="checkbox" name="checkbox" id="checkbox4" checked/>
            <label for="checkbox4">Fourth Option danger</label>
        </div>
        <div class="funkyradio-warning">
            <input type="checkbox" name="checkbox" id="checkbox5" checked/>
            <label for="checkbox5">Fifth Option warning</label>
        </div>
        <div class="funkyradio-info">
            <input type="checkbox" name="checkbox" id="checkbox6" checked/>
            <label for="checkbox6">Sixth Option info</label>
        </div>
    </div>
</div> -->

			<!-- <div class="row">
		    	<div class="col-sm-8 col-xs-8 col-md-8">
					<div class="col-xs-6 col-sm-6 col-md-4">
						<div class="thumbnail" id="blogRead_coupon_list">
							<div id="blogRead_coupon_list_content">
								<h4 class="text-center"><span class="label label-info">업체명</span></h4>
								<img src="http://placehold.it/650x450&text=Galaxy S5" class="img-responsive">
								<div class="caption">
									<div class="row">
										<div class="col-md-6 col-xs-6">
											<h4>할인품목</h4>
										</div>
										
										<div class="col-md-6 col-xs-6 price">
											<h4><label>할인율</label></h4>
										</div>
									</div>
									
									<p style="font-size:14px;">사용기한</p>
								
									<p style="font-size:14px;">업체 전화번호</p>
								</div>
							</div>
							
						</div>
					</div>
					
		        </div> 
		        
				
			</div> -->
			
			
<div class="container">
    <div class="row">
    	<div class="col-md-12" id="blogRead_coupon_list_content">
			
        </div> 
	</div>
</div>

</body>
</html>