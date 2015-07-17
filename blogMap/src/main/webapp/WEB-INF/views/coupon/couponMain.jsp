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

img { max-width:100%; }

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
	//Carousel Auto-Cycle
	$(document).ready(function() {
	  $('.carousel').carousel({
	    interval: 6000
	  })
	});
</script>
<script type="text/javascript">
 $(document).ready(function(){		 
	$("#tile4").click(function(){
		//$("#coupon_slide_List_L").empty();
		
		$.ajax({
			type:'post',
			url:'${root}/coupon/couponMain.do',
			contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
			success : function(responseData) {
				var data = JSON.parse(responseData);
				
// 				var count= 1;
				/* alert(data); */
				
				$("#coupon_List").empty();
				
				$.each(data, function(i){
					var item_var = "<div class='caption'>";
					item_var += "<ul class='thumbnails' id='coupon_slide_1'>";
					item_var += "<li class='col-md-3 col-sm-3 col-xs-3' id='coupon_slide_List_L'>";
					item_var += "<div class='fff'>";
					item_var += "<div class='thumbnail'>";
					item_var += "<a href='#' class='coupon_list_no'>";
					item_var += "<img class='img-responsive' id='coupon_L_images'>";
					item_var += "</a>";
					item_var += "</div>";
					item_var += "</div>";
					item_var += "</li>";
					item_var += "</ul>";
					item_var += "</div>";
					
					if(i%8==0){
						/* DIV 추가 */
						$("#coupon_List").append("<div class='item'></div>");
							
						if(i==0){
							$("#coupon_List .item").addClass("active");
						}
					}
					
					$("#coupont_List > .item:last-child").append(item_var);

					
							
// 	=======================================================================================================================
				
// 				/* 데이타를 채우기 위해 복사 */
// 				$.each(data, function(i){
// 					var pic=data[i].COUPON_PIC_NAME;
// 					var partner_name=data[i].PARTNER_NAME;
										
// 					$("#coupon_slide_"+ count).append($("#coupon_slide_List_L").clone().css("display", "inline-block"));
					
// 					$("#coupon_slide_List_L:last-child #coupon_L_images").attr("src", "${root}/pds/coupon/" + pic);	
					
// 					if((i+1) % 8 == 0){
// 						$("#coupon_List").append($("#couponSlide_0").clone().attr("id","couponslide_"+(count +1)));
// 						$("#couponslide_"+(count+1) +" ul[id='coupon_slide_0']").attr("id","coupon_slide_"+(count +1));
// 						count += 1;
							
// 					}

// 	=======================================================================================================================				
							
					// 각 업체를 클릭했을때 이벤트
					$("#coupon_" + data[i].PARTNER_NO).click(function(){
// 						alert("쿠폰" + data[i].PARTNER_NO + "클릭");
						couponData(data[i].PARTNER_NO);	
					});
 				});
				
				if (!data) {
					alert("등록된 정보가 없습니다.");
					return false;
				}
			}
		});	
	});
	
	$("#coupon_search_btn").click(function(){
		//$("#coupon_slide_"+ count).empty();
		
		$.ajax({
			type:'get',
			url:'${root}/coupon/couponMain.do',
			data : {
				member_id : email,
				partner_name : $("input[name='coupon_search']").val()
			},
			contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
			success : function(responseData) {
				var data = JSON.parse(responseData);
				var count= 1;
				/* alert(data); */
				
				/* 데이타를 채우기 위해 복사 */
				$.each(data, function(i){
					var pic=data[i].COUPON_PIC_NAME;
					var partner_name=data[i].PARTNER_NAME;
					//alert(count);
					//alert("사진 이름 : "+pic + " / " + "업체명 : " + partner_name + " / " + " I 값 : " + i);
										
					$("#coupon_slide_"+ count).append($("#coupon_slide_List_L").clone().css("display", "inline-block"));
					//$("#coupon_slide_List_L:last-child a[class='coupon_list_no']").attr("id", data[i].COUPON_NO);
					$("#coupon_slide_List_L:last-child #coupon_L_images").attr("src", "${root}/pds/coupon/" + pic);	
					//alert((i+1) % 8);
					
					if((i+1) % 8 == 0){
						$("#coupon_List").append($("#couponSlide_0").clone().attr("id","couponslide_"+(count +1)));
						$("#couponslide_"+(count+1) +" ul[id='coupon_slide_0']").attr("id","coupon_slide_"+(count +1));
						count += 1;
							
					}
							
					// 각 업체를 클릭했을때 이벤트
					$("#coupon_" + data[i].PARTNER_NO).click(function(){
// 						alert("쿠폰" + data[i].PARTNER_NO + "클릭");
						couponData(data[i].PARTNER_NO);	
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
											<img class="img-responsive" id="coupon_L_images">
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

<!--  쿠폰 기본틀 -->            	
<!-- 	<li class="col-md-3 col-sm-3 col-xs-3" id="coupon_slide_List_L" style="display: none;"> -->
<!-- 		<div class="fff"> -->
<!-- 			<div class="thumbnail"> -->
<!-- 				<a href="#" class="coupon_list_no"> -->
<!-- 				<img class="img-responsive" id="coupon_L_images"> -->
<!-- 				</a> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</li> -->
	
<!-- 	<div class="item" id="couponSlide_0"> -->
<!-- 		<div class="caption"> -->
<!-- 			<ul class="thumbnails" id="coupon_slide_0">                      -->
			
<!-- 			</ul> -->
<!-- 		</div> -->
<!-- 	</div>			 -->
</body>
</html>