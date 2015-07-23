<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<c:set var="root" value="${pageContext.request.contextPath }"/>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>BLOG MAP</title>
<style>
/* Global */

/* #coupon_L_images {  */
/* 			max-width: 100%; */
/* 			height: 150px; */
/* } */

a {
    -webkit-transition: all 150ms ease;
	-moz-transition: all 150ms ease;
	-ms-transition: all 150ms ease;
	-o-transition: all 150ms ease;
	transition: all 150ms ease; 
	}
    a:hover {
        -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=50)"; /* IE 8 */
        filter: alpha(opacity=50); /* IE7 */
        opacity: 0.6;
        text-decoration: none;
    }

.thumbnails li> .fff .caption { background:#fff !important; padding:10px }
/* Page Header */
.page-header {
    background: #f9f9f9;
    margin: -30px -40px 40px;
    padding: 20px 40px;
    border-top: 4px solid #ccc;
    color: #999;
    text-transform: uppercase;
    }
    .page-header h3 {
        line-height: 0.88rem;
        color: #000;
        }



/* Thumbnail Box */
.caption h4 {
   
    color: #444;
    }
    .caption p {
       
        color: #999;
        }
	.btn.btn-mini {
            
	}

/* Carousel Control */
.control-box {
    text-align: center;
    width: 100%;
    }
    .carousel-control{
        background: #666;
        border: 0px;
        border-radius: 0px;
        display: inline-block;
        font-size: 34px;
        font-weight: 200;
        line-height: 18px;
        opacity: 0.5;
        padding: 4px 10px 0px;
        position: static;
        height: 30px;
        width: 15px;
        }

/* Mobile Only */
@media (max-width: 767px) {
    .page-header, .control-box {
    text-align: center;
    } 
}
@media (max-width: 479px) {
    .caption {
    word-break: break-all;
    }
}

li { list-style-type:none;}

::selection { background: #ff5e99; color: #FFFFFF; text-shadow: 0; }
::-moz-selection { background: #ff5e99; color: #FFFFFF; }
</style>
<style>
#custom-search-input{
    padding: 3px;
    border: solid 1px #E4E4E4;
    border-radius: 6px;
    background-color: #fff;
}

#custom-search-input input{
    border: 0;
    box-shadow: none;
}

#custom-search-input button{
    margin: 2px 0 0 0;
    background: none;
    box-shadow: none;
    border: 0;
    color: #666666;
    padding: 0 8px 0 10px;
    border-left: solid 1px #ccc;
}

#custom-search-input button:hover{
    border: 0;
    box-shadow: none;
    border-left: solid 1px #ccc;
}

#custom-search-input .glyphicon-search{
    font-size: 23px;
}

</style>
<script type="text/javascript">
 $(document).ready(function(){		 
	$("#tile4").click(function(){		
		couponListView();
	});
	$("#coupon_search_btn").click(function(){
		coupon_Search();
	});
 });
		
 	function couponListView(){
		$.ajax({
			type:'post',
			url:'${root}/coupon/couponMain.do',
			contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
			success : function(responseData) {
				var data = JSON.parse(responseData);
				
				$("#coupon_List").empty();
				
				$.each(data, function(i){
					var getbymd = new Date(data[i].COUPON_BYMD);
              		var bymd = leadingZeros(getbymd.getFullYear(), 4) + '/' + leadingZeros(getbymd.getMonth() + 1, 2) + '/' + leadingZeros(getbymd.getDate(), 2);
              		
              		var geteymd = new Date(data[i].COUPON_EYMD);
              		var eymd = leadingZeros(geteymd.getFullYear(), 4) + '/' + leadingZeros(geteymd.getMonth() + 1, 2) + '/' + leadingZeros(geteymd.getDate(), 2);
					
					var pic=data[i].COUPON_PIC_NAME;
// 					alert("PIC NAME : " + pic);
					var coupon_no=data[i].COUPON_NO;
					
					var item_var = "<div class='caption'>";
					item_var += "<ul class='thumbnails' id='coupon_slide_1'>";
					item_var += "<li class='col-md-3 col-sm-3 col-xs-3' id='coupon_slide_List_L'>";
					item_var += "<div class='fff'>";
					item_var += "<div class='thumbnail'>";
					item_var += "<a data-toggle='modal' href='#couponDetail' class='coupon_list_no btn-example' id=coupon_no_" + coupon_no +">";
					item_var += "<h5 style='text-align:center'>" + data[i].PARTNER_NAME + "</h5>";	
					item_var += "<img src=" + "${root}/pds/coupon/" + pic + " class='img-responsive' id='coupon_L_images'>";
					item_var += "<div class='caption'>";	
					item_var += "<h5>" + data[i].COUPON_ITEM + " " + data[i].COUPON_DISCOUNT + "% 할인" + "</h5>";
					item_var += "<h5> 종료일 : " + eymd + "</h5>";
					item_var += "</div>";	
					item_var += "</a>";
					item_var += "</div>";
					item_var += "</div>";
					item_var += "</li>";
					item_var += "</ul>";
					item_var += "</div>";
					
					if(i%8==0){
						/* DIV 추가 */
						$("#coupon_List").append("<div class='item' id='coupon_create_list'></div>");
							
						if(i==0){
							$("#coupon_List #coupon_create_list").addClass("active");
						}
					}
					
					$("#coupon_create_list:last-child").append(item_var);

					$(".coupon_list_no #coupon_L_images").css({
						'width':"100%",
						'height':"150px"
					});
				
					// 각 업체를 클릭했을때 이벤트
					$("#coupon_no_" + coupon_no).click(function(){
// 						alert("쿠폰" + data[i].PARTNER_NO + "클릭");
						couponData(coupon_no);	
					});
 				});
				
				if (!data) {
					alert("등록된 정보가 없습니다.");
					return false;
				}	
			}	
		});	
 	}
 	
 	function couponData(couponNo){
 		if(sessionStorage.getItem('email')!=null && sessionStorage.getItem('manager_yn')== null){
			//alert();
			$("#coupon_detail_issue").css("display","inline-block");
		}
		if(sessionStorage.getItem('manager_yn')=="Y"){
			$("#coupon_detail_button").css("display","inline-block");
		}
		
		$("#couponDetailResult").empty();
		$.ajax({
			type:'get',
			url:'${root}/manager/couponDetail.do?coupon_no='+couponNo,
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			 success:function(responseData){
				var data=JSON.parse(responseData);
				
				var getbymd = new Date(data[0].COUPON_BYMD);
          		var bymd = leadingZeros(getbymd.getFullYear(), 4) + '년' + leadingZeros(getbymd.getMonth() + 1, 2) + '월' + leadingZeros(getbymd.getDate(), 2) +'일';
          		
          		var geteymd = new Date(data[0].COUPON_EYMD);
          		var eymd = leadingZeros(geteymd.getFullYear(), 4) + '년' + leadingZeros(geteymd.getMonth() + 1, 2) + '월' + leadingZeros(geteymd.getDate(), 2) +'일';
				
				//var filename=data.partner_pic_name
				//alert(data[0].PARTNER_NAME);
				
				
				/* var getbymd = new Date(data[0].COUPON_BYMD);	// 등록일 날짜 변환
				var byear = getbymd.getFullYear();
				var bmonth = getbymd.getMonth() + 1;
				var bday = getbymd.getDate();
				var bymd = byear + "년 " + bmonth + "월 "	+ bday + "일";
				//alert(bymd);
				
				var geteymd = new Date(data[0].COUPON_EYMD);	// 승인일 날짜 변환
				var eyear = geteymd.getFullYear();
				var emonth = geteymd.getMonth() + 1;
				var eday = geteymd.getDate();
				var eymd = eyear + "년 " + emonth + "월 "	+ eday + "일";
				//alert(eymd); */
				
				$("#couponDetailResult").append($("#couponDetailMain").clone().css("display","block"));
				$("#couponDetailMain:last-child #coupon_img").attr("src", "${root}/pds/coupon/"+data[0].COUPON_PIC_NAME);
				$("#couponDetailMain:last-child #partner_no").html(data[0].PARTNER_NAME);
				$("#couponDetailMain:last-child #coupon_item").html(data[0].COUPON_ITEM);
				$("#couponDetailMain:last-child #coupon_discount").html(data[0].COUPON_DISCOUNT+"%");
				$("#couponDetailMain:last-child #coupon_bymd").html(bymd);
				$("#couponDetailMain:last-child #coupon_eymd").html(eymd);					
				$("#couponDetailMain:last-child #coupon_detail_issue").attr("name",data[0].COUPON_NO);
				if(data[0].COUPON_YN == "Y"){
					//$("#partner_submit").css("display", "none");
					$("#couponDetailMain:last-child #coupon_detail_button").attr({"name":data[0].COUPON_NO, "value":"쿠폰취소"});
				}else if(data[0].COUPON_YN == "N"){
					//$("#partner_delete").css("display", "none");
					$("#couponDetailMain:last-child #coupon_detail_button").attr({"name":data[0].COUPON_NO, "value":"쿠폰승인"});
				} 
				
				$("#coupon_detail_button[value='쿠폰취소']").click(function(){
					var couponNo = $(this).attr('name');
					//alert(couponNo);
					var check = confirm("쿠폰 발행을 취소하시겠습니까?");
					if(check == "1"){
						couponCancle(couponNo);
					}else{
						alert("취소하셨습니다.")
					}
				});
				
				$("#coupon_detail_button[value='쿠폰승인']").click(function(){			// 승인버튼을 클릭시 실행
					var couponNo = $(this).attr('name');		
					//alert(couponNo);
					var check = confirm("쿠폰을 승인 하시겠습니까?");
					if(check == "1"){
						couponSubmit(couponNo);
					}else{
						alert("취소하셨습니다.")
					}
				});
				
				$("#coupon_detail_issue[value='발급']").click(function(){
					var couponNo = $(this).attr('name');
					//alert(couponNo);
					blogmap_coupon_issue(couponNo);
				});
			},error:function(data){
				alert("에러가 발생했습니다.");
			}

		});
	};
	
	function coupon_Search(){
		$.ajax({
			type:'get',
			url:'${root}/coupon/couponMain.do',
			data : {
				partner_name : $("input[name='coupon_search']").val(),
				member_id : email
			},
			contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
			success : function(responseData) {
				var data = JSON.parse(responseData);
						
				$("#coupon_List").empty();
				
				$.each(data, function(i){
					
					var pic=data[i].COUPON_PIC_NAME;
					var partner_name=data[i].PARTNER_NAME;
						/* alert("PIC NAME : " + pic + " / PARTNER_NAME : " + partner_name); */
					var coupon_no=data[i].COUPON_NO;
					
					var item_var = "<div class='caption'>";
					item_var += "<ul class='thumbnails' id='coupon_slide_1'>";
					item_var += "<li class='col-md-3 col-sm-3 col-xs-3' id='coupon_slide_List_L'>";
					item_var += "<div class='fff'>";
					item_var += "<div class='thumbnail'>";
					item_var += "<a data-toggle='modal' href='#couponDetail' class='coupon_list_no btn-example' id=coupon_no_" + coupon_no +">";
					item_var += "<h5 style='text-align:center'>" + data[i].PARTNER_NAME + "</h5>";	
					item_var += "<img src=" + "${root}/pds/coupon/" + pic + " class='img-responsive' id='coupon_L_images'>";
					item_var += "<div class='caption'>";	
					item_var += "<h5>" + data[i].COUPON_ITEM + " " + data[i].COUPON_DISCOUNT + "% 할인" + "</h5>";
					item_var += "<h5>" + data[i].COUPON_EYMD + "</h5>";
					item_var += "</div>";	
					item_var += "</a>";
					item_var += "</div>";
					item_var += "</div>";
					item_var += "</li>";
					item_var += "</ul>";
					item_var += "</div>";
					
					if(i%8==0){
						/* DIV 추가 */
						$("#coupon_List").append("<div class='item' id='coupon_create_list'></div>");
							
						if(i==0){
							$("#coupon_List #coupon_create_list").addClass("active");
						}
					}
					
					$("#coupon_create_list:last-child").append(item_var);
					
					$(".coupon_list_no #coupon_L_images").css({
						'width':"100%",
						'height':"150px"
					});
					
					// 각 업체를 클릭했을때 이벤트
					$("#coupon_no_" + coupon_no).click(function(){
//						alert("쿠폰" + data[i].PARTNER_NO + "클릭");
						couponData(coupon_no);	
					});
				});
				
				if (!data) {
					alert("등록된 정보가 없습니다.");
					return false;
				}	
			}	
		});		
	};
	
</script>
</head>
<body>
<article class="container-fluid">
	<div class="row">
		<div>	
			<div class="carousel slide" id="myCarousel">
		        <div class="carousel-inner col-md-12 col-sm-12 col-xs-12" id="coupon_List">
		            <div class="item active" id="couponSlide_1">
		            	<div class="caption">
   		                    <ul class="thumbnails" id="coupon_slide_1">
								<li class="col-md-3 col-sm-3 col-xs-3" id="coupon_slide_List_L">
									<div class="fff">
										<div class="thumbnail">
											<a href="#" class="coupon_list_no">
												<h5 style="text-align: center;"></h5>
												<img class="img-responsive" id="coupon_L_images">
												<div class="caption">
													<h5></h5>
													<h5></h5>
													<a class="btn btn-mini" href="#">» Read More</a>
												</div>
											</a>
										</div>
									</div>
								</li>		                        
		                    </ul>
						</div>
	             	</div>			
				</div>
				<nav>
					<ul class="control-box pager">
						<li><a data-slide="prev" href="#myCarousel" class=""><i class="glyphicon glyphicon-chevron-left"></i></a></li>
						<li><a data-slide="next" href="#myCarousel" class=""><i class="glyphicon glyphicon-chevron-right"></i></li>
					</ul>
				</nav>
			   <!-- /.control-box -->   
		                              
		    </div><!-- /#myCarousel -->
		</div>
	</div>
</article>
</body>
</html>
