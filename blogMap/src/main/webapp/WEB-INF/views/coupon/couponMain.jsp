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
			data : {
				member_id : email
			},
			contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
			success : function(responseData) {
				var data = JSON.parse(responseData);
				/* alert(data);  */
			
				/* 데이타를 채우기 위해 복사 */
				$.each(data, function(i){
					var pic=data[i].coupon_pic_name;
					var partner_name=data[i].partner_name
					alert(pic + "/" + partner_name);
					
					$("#coupon_item_list_S").append($("#coupon_item_S").clone().css("display", "block"));
					$("#coupon_item_S:last-child #list_coupon_S_item").append(partner_name);
					$("#coupon_item_S:last-child a[class='list_coupon_no1']").attr("id", data[i].coupon_no);
					$("#coupon_item_S:last-child #coupon_images1").attr("src", "${root}/css/coupon_images/" + pic);
					
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
			data : {
				member_id : email
			},
			contentType : 'application/x-www-form-urlencoded;charset=UTF-8',
			success : function(responseData) {
				var data = JSON.parse(responseData);
				/* alert(data); */
			
				/* 데이타를 채우기 위해 복사 */
				$.each(data, function(i){
					var pic=data[i].coupon_pic_name;
					var partner_name=data[i].partner_name;
					/* alert("L"+pic); */
					
					$("#coupon_item_list_L").append($("#coupon_item_L").clone().css("display", "block"));
					$("#coupon_item_L:last-child #list_coupon_L_item").append(partner_name);
					$("#coupon_item_L:last-child a[class='list_coupon_no']").attr("id", data[i].coupon_no);
					$("#coupon_item_L:last-child #coupon_images").attr("src", "${root}/css/coupon_images/" + pic);
					
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
<div class="container-fluid">
<div class="col-xs-12">

    <div class="page-header">
        <h3>Coupon List</h3>
    </div>
        
    <div class="carousel slide" id="myCarousel">
        <div class="carousel-inner">
            <div class="item active">
                    <ul class="thumbnails">
                        <li class="col-sm-3">
    						<div class="fff">
								<div class="thumbnail">
									<a href="#"><img src="http://placehold.it/360x240" alt=""></a>
								</div>
								<div class="caption">
									<h4>Praesent commodo</h4>
									<p>Nullam Condimentum Nibh Etiam Sem</p>
									<a class="btn btn-mini" href="#">» Read More</a>
								</div>
                            </div>
                        </li>
                        <li class="col-sm-3">
							<div class="fff">
								<div class="thumbnail">
									<a href="#"><img src="http://placehold.it/360x240" alt=""></a>
								</div>
								<div class="caption">
									<h4>Praesent commodo</h4>
									<p>Nullam Condimentum Nibh Etiam Sem</p>
									<a class="btn btn-mini" href="#">» Read More</a>
								</div>
                            </div>
                        </li>
                        <li class="col-sm-3">
							<div class="fff">
								<div class="thumbnail">
									<a href="#"><img src="http://placehold.it/360x240" alt=""></a>
								</div>
								<div class="caption">
									<h4>Praesent commodo</h4>
									<p>Nullam Condimentum Nibh Etiam Sem</p>
									<a class="btn btn-mini" href="#">» Read More</a>
								</div>
                            </div>
                        </li>
                        <li class="col-sm-3">
							<div class="fff">
								<div class="thumbnail">
									<a href="#"><img src="http://placehold.it/360x240" alt=""></a>
								</div>
								<div class="caption">
									<h4>Praesent commodo</h4>
									<p>Nullam Condimentum Nibh Etiam Sem</p>
									<a class="btn btn-mini" href="#">» Read More</a>
								</div>
                            </div>
                        </li>
                    </ul>
              </div><!-- /Slide1 --> 
            <div class="item">
                    <ul class="thumbnails">
                        <li class="col-sm-3">
							<div class="fff">
								<div class="thumbnail">
									<a href="#"><img src="http://placehold.it/360x240" alt=""></a>
								</div>
								<div class="caption">
									<h4>Praesent commodo</h4>
									<p>Nullam Condimentum Nibh Etiam Sem</p>
									<a class="btn btn-mini" href="#">» Read More</a>
								</div>
                            </div>
                        </li>
                        <li class="col-sm-3">
							<div class="fff">
								<div class="thumbnail">
									<a href="#"><img src="http://placehold.it/360x240" alt=""></a>
								</div>
								<div class="caption">
									<h4>Praesent commodo</h4>
									<p>Nullam Condimentum Nibh Etiam Sem</p>
									<a class="btn btn-mini" href="#">» Read More</a>
								</div>
                            </div>
                        </li>
                        <li class="col-sm-3">
							<div class="fff">
								<div class="thumbnail">
									<a href="#"><img src="http://placehold.it/360x240" alt=""></a>
								</div>
								<div class="caption">
									<h4>Praesent commodo</h4>
									<p>Nullam Condimentum Nibh Etiam Sem</p>
									<a class="btn btn-mini" href="#">» Read More</a>
								</div>
                            </div>
                        </li>
                        <li class="col-sm-3">
							<div class="fff">
								<div class="thumbnail">
									<a href="#"><img src="http://placehold.it/360x240" alt=""></a>
								</div>
								<div class="caption">
									<h4>Praesent commodo</h4>
									<p>Nullam Condimentum Nibh Etiam Sem</p>
									<a class="btn btn-mini" href="#">» Read More</a>
								</div>
                            </div>
                        </li>
                    </ul>
              </div><!-- /Slide2 --> 
            <div class="item">
                    <ul class="thumbnails">
                        <li class="col-sm-3">	
							<div class="fff">
								<div class="thumbnail">
									<a href="#"><img src="http://placehold.it/360x240" alt=""></a>
								</div>
								<div class="caption">
									<h4>Praesent commodo</h4>
									<p>Nullam Condimentum Nibh Etiam Sem</p>
									<a class="btn btn-mini" href="#">» Read More</a>
								</div>
                            </div>
                        </li>
                        <li class="col-sm-3">
							<div class="fff">
								<div class="thumbnail">
									<a href="#"><img src="http://placehold.it/360x240" alt=""></a>
								</div>
								<div class="caption">
									<h4>Praesent commodo</h4>
									<p>Nullam Condimentum Nibh Etiam Sem</p>
									<a class="btn btn-mini" href="#">» Read More</a>
								</div>
                            </div>
                        </li>
                        <li class="col-sm-3">
							<div class="fff">
								<div class="thumbnail">
									<a href="#"><img src="http://placehold.it/360x240" alt=""></a>
								</div>
								<div class="caption">
									<h4>Praesent commodo</h4>
									<p>Nullam Condimentum Nibh Etiam Sem</p>
									<a class="btn btn-mini" href="#">» Read More</a>
								</div>
                            </div>
                        </li>
                        <li class="col-sm-3">
							<div class="fff">
								<div class="thumbnail">
									<a href="#"><img src="http://placehold.it/360x240" alt=""></a>
								</div>
								<div class="caption">
									<h4>Praesent commodo</h4>
									<p>Nullam Condimentum Nibh Etiam Sem</p>
									<a class="btn btn-mini" href="#">» Read More</a>
								</div>
                            </div>
                        </li>
                    </ul>
              </div><!-- /Slide3 --> 
        </div>
        
       
<!-- 	   <nav> -->
<!-- 			<ul class="control-box pager"> -->
<!-- 				<li><a data-slide="prev" href="#myCarousel" class=""><i class="glyphicon glyphicon-chevron-left"></i></a></li> -->
<!-- 				<li><a data-slide="next" href="#myCarousel" class=""><i class="glyphicon glyphicon-chevron-right"></i></li> -->
<!-- 			</ul> -->
<!-- 		</nav> -->
	   <!-- /.control-box -->   
                              
    </div><!-- /#myCarousel -->
        
</div><!-- /.col-xs-12 -->          

</div><!-- /.container -->



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
<!-- </article> -->
</body>
</html>