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
		
// 		$.ajax({
// 			type:'get',
// 			url:'${root}/coupon/couponMain.do',
// 			data : {
// 				member_id : email
// 			},
// 			contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
// 			success : function(responseData) {
// 				var data = JSON.parse(responseData);
// 				/* alert(data);  */
			
// 				/* 데이타를 채우기 위해 복사 */
// 				$.each(data, function(i){
// 					var pic=data[i].coupon_pic_name;
// 					var partner_name=data[i].partner_name
// 					alert(pic + "/" + partner_name);
					
// 					$("#coupon_item_list_S").append($("#coupon_item_S").clone().css("display", "block"));
// 					$("#coupon_item_S:last-child #list_coupon_S_item").append(partner_name);
// 					$("#coupon_item_S:last-child a[class='list_coupon_no1']").attr("id", data[i].coupon_no);
// 					$("#coupon_item_S:last-child #coupon_images1").attr("src", "${root}/css/coupon_images/" + pic);
					
// 					/* $("#item1:last_child .phone").append(data[i].partner_phone);
// 					$("#item1:last_child .addr").append(data[i].partner_addr); */
// 					//$("#item1:last_child .img").attr('src', data.data_img);
					
// 					// 각 업체를 클릭했을때 이벤트
// 					$("#coupon_" + data[i].partner_no).click(function(){
// 						alert("쿠폰" + data[i].partner_no + "클릭");
// 						couponData(data[i].partner_no);	
// 					});
// 				});
				
// 				if (!data) {
// 					alert("등록된 정보가 없습니다.");
// 					return false;
// 				}
// 			}
// 		});
		
		$.ajax({
			type:'post',
			url:'${root}/coupon/couponMain.do',
			data : {
				member_id : email
			},
			contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
			success : function(responseData) {
				var data = JSON.parse(responseData);
				/* alert(data); */
			
				/* 데이타를 채우기 위해 복사 */
				$.each(data, function(i){
					var pic=data[i].COUPON_PIC_NAME;
					var partner_name=data[i].PARTNER_NAME;
					alert("coupon L : "+pic + " / " + partner_name);
					
// 					for(var pageCount=0; pageCount < couponCount/8; pageCountCount++){
// 						for(var couponCount=0; couponCount < 8; couponCount++){
							$("#coupon_slide_List_L").append($("#coupon_slide_List_1").clone().css("display", "block"));
							$("#coupon_slide_List_1:last-child a[class='coupon_list_no']").attr("id", data[i].COUPON_NO);
							$("#coupon_slide_List_1:last-child #coupon_images1").attr("src", "${root}/pds/coupon/" + pic);	
// 						}	
// 					}
					
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
<!-- 	<div class="row"> -->
<!-- 		<section class="page-header"> -->
<!-- 		<h2 class="page-title">Coupon List</h2> -->
<!-- 		</section> -->
<!-- 	</div> -->
	<div class="row">
		<div>	
			<div class="carousel slide" id="myCarousel">
		        <div class="carousel-inner col-md-12 col-sm-12 col-xs-12" id="coupon_List">
		            <div class="item active">
		       	    	<div class="caption" id="coupon_slide_List_L" style="display: none;">
                   		</div>
              		</div><!-- /Slide1 --> 
		            
		            <div class="item" id="coupon_slide_List_1">
		            	<ul class="thumbnails">
		                         <li class="col-md-3 col-sm-3 col-xs-3">
		    						<div class="fff">
										<div class="thumbnail">
											<a href="#" class="coupon_list_no"><img class="img-responsive" id="coupon_images1"></a>
										</div>
		                            </div>
		                        </li>
		                  	</ul>
		              </div><!-- /Slide2 --> 
		              
		              
<!-- 		            <div class="item"> -->
<!-- 		                    <ul class="thumbnails"> -->
<!-- 		                        <li class="col-sm-3">	 -->
<!-- 									<div class="fff"> -->
<!-- 										<div class="thumbnail"> -->
<!-- 											<a href="#"><img src="http://placehold.it/360x240" alt=""></a> -->
<!-- 										</div> -->
<!-- 										<div class="caption"> -->
<!-- 											<h4>Praesent commodo</h4> -->
<!-- 											<p>Nullam Condimentum Nibh Etiam Sem</p> -->
<!-- 											<a class="btn btn-mini" href="#">» Read More</a> -->
<!-- 										</div> -->
<!-- 		                            </div> -->
<!-- 		                        </li> -->
<!-- 		                        <li class="col-sm-3"> -->
<!-- 									<div class="fff"> -->
<!-- 										<div class="thumbnail"> -->
<!-- 											<a href="#"><img src="http://placehold.it/360x240" alt=""></a> -->
<!-- 										</div> -->
<!-- 										<div class="caption"> -->
<!-- 											<h4>Praesent commodo</h4> -->
<!-- 											<p>Nullam Condimentum Nibh Etiam Sem</p> -->
<!-- 											<a class="btn btn-mini" href="#">» Read More</a> -->
<!-- 										</div> -->
<!-- 		                            </div> -->
<!-- 		                        </li> -->
<!-- 		                        <li class="col-sm-3"> -->
<!-- 									<div class="fff"> -->
<!-- 										<div class="thumbnail"> -->
<!-- 											<a href="#"><img src="http://placehold.it/360x240" alt=""></a> -->
<!-- 										</div> -->
<!-- 										<div class="caption"> -->
<!-- 											<h4>Praesent commodo</h4> -->
<!-- 											<p>Nullam Condimentum Nibh Etiam Sem</p> -->
<!-- 											<a class="btn btn-mini" href="#">» Read More</a> -->
<!-- 										</div> -->
<!-- 		                            </div> -->
<!-- 		                        </li> -->
<!-- 		                        <li class="col-sm-3"> -->
<!-- 									<div class="fff"> -->
<!-- 										<div class="thumbnail"> -->
<!-- 											<a href="#"><img src="http://placehold.it/360x240" alt=""></a> -->
<!-- 										</div> -->
<!-- 										<div class="caption"> -->
<!-- 											<h4>Praesent commodo</h4> -->
<!-- 											<p>Nullam Condimentum Nibh Etiam Sem</p> -->
<!-- 											<a class="btn btn-mini" href="#">» Read More</a> -->
<!-- 										</div> -->
<!-- 		                            </div> -->
<!-- 		                        </li> -->
<!-- 		                    </ul> -->
<!-- 		              </div>/Slide3  -->
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


<!-- <article class="container-fluid"> -->
<!-- 	<div class="row"> -->
<!-- 		<section class="page-header"> -->
<!-- 		<h2 class="page-title">Coupon List</h2> -->
<!-- 		</section> -->
<!-- 	</div> -->
<!-- 	<div class="row"> -->
<!-- 		<div>	 -->
<!-- 			<div class="tab-content col-md-12"> -->
<!-- 				<section role="tabpanel" class="tab-pane active" id="coupon_Total"> -->
<!-- 				<div class="row" id="coupon_item_list_L"> -->
<!-- 					<p>50% DisCount Coupon</p> -->
<!-- 					<div class="col-md-6 col-sm-6 col-xs-6" id="coupon_item_L" role="button" style="display:none;"> -->
<!-- 						<div id="tour_info" class="thumbnail clean2"> -->
<!-- 							<a data-toggle="modal" href="#modal_info" class="list_coupon_no">  -->
<!-- 								<img class="img-responsive" id="coupon_images"/>	 -->
<!-- 								<div class="caption"> -->
<!-- 									<p id="list_coupon_L_item"></p> -->
<!-- 								</div> -->
<!-- 							</a> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div>	 -->
					
<!-- 				<div class="row" id="coupon_item_list_S"> -->
<!-- 				<p>30% DisCount Coupon</p> -->
<!-- 				<div class="col-md-3 col-sm-3 col-xs-3" id="coupon_item_S" role="button" style="display:none;"> -->
					
<!-- 					<div id="tour_info" class="thumbnail clean1"> -->
<!-- 						<a data-toggle="modal" href="#modal_info" class="list_coupon_no1">  -->
<!-- 							<img class="img-responsive" id="coupon_images1"/>	 -->
<!-- 							<div class="caption"> -->
<!-- 								<p id="list_coupon_S_item"></p> -->
<!-- 							</div> -->
<!-- 						</a> -->
<!-- 					</div> -->
<!-- 				</div>	 -->
<!-- 				</div>			 -->
<!-- 				</section> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </article>  -->
</body>
</html>