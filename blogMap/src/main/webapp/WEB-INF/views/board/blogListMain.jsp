 <?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<c:set var="root" value="${pageContext.request.contextPath}"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1"/>

<!-- [검색조건 관련 스크립트] -->
<!-- 적용 페이지 : blogListMain.jsp | blogWrite.jsp-->
<script type="text/javascript">
	// 	20150626 이헌주 - blogListMain.jsp 호출시 검색조건(시도,대분류 카테고리) load를 위한 function
	$(function(){
		
		$("#blogList_Search").click(function() {
			var sido=$("#si_select:first-child").text();
			if(sido=="시도[전체]"){
				sido="%";
			}
			var sigugun=$("#gun_select:first-child").text();
			if(sigugun=="시구군[전체]"){
				sigugun="%";
			}
			var dongmyunri=$("#dong_select").attr("value");
			var headCategory=$("#headCategory_select").attr("value");
			var detailCategory=$("#detailCategory_select").attr("value");
			var search_value=$("#blogList_text").val();
			
			/* alert(sido);
			alert(sigugun);
			alert(dongmyunri);
			alert(headCategory);
			alert(detailCategory);
			alert(search_value); */
			var m = new Array();
			//주소 배열
			var addrArray = new Array();
			//시도 배열
			var sidoArray = new Array();
			//시구군 배열
			var sigugunArray = new Array();
			//동면 배열
			var dongmyunArray = new Array();
			//번지 배열
			var restArray=new Array();
			//타이틀 배열
			var titleArray=new Array();
			var pullAddr="";
			
			var mapDiv='map';
			$.ajax({
				type:'post',
				url:'${root}/board/blogListSearch.do',
				data:{
					search_sido:sido,
					search_sigugun:sigugun,
					search_dongmyunri:dongmyunri,
					search_headCategory:headCategory,
					search_detailCategory:detailCategory,
					search_search_value:search_value
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(data){
					var data=JSON.parse(data);
					$.each(data,function(i){
						var board_no=data[i].BOARD_NO;
						var member_id=data[i].MEMBER_ID;
						var category_code=data[i].CATEGORY_CODE;
						var board_rgdate=data[i].BOARD_RGDATE;
						var board_title=data[i].BOARD_TITLE;
						var board_content=data[i].BOARD_CONTENT;
						var board_grade=data[i].BOARD_GRADE;
						var board_count=data[i].BOARD_COUNT;
						var total_cnt=data[i].TOT_CNT;
						total_cnt=parseInt(total_cnt);
						$.ajax({
							type:'post',
							url:'${root}/board/blogListSearchSub1.do',
							data:{
								board_no: board_no
								/* category_code: category_code,
								key : "60e9ac7ab8734daca3d2053c1e713dbd",
								encoding : "utf-8",
								output : "json",
								coord : "latlng",
								urls : "http://openapi.map.naver.com/api/geocode" */
							},
							contentType:'application/x-www-form-urlencoded;charset=UTF-8',
							success:function(data){
								var data=JSON.parse(data);
								var board_no=data[0].board_no;
								var addr_sido=data[0].addr_sido;
								var addr_sigugun=data[0].addr_sigugun;
								var addr_dongri=data[0].addr_dongri
								var addr_bunji=data[0].addr_bunji;
								
								if(addr_sigugun!=null){
								pullAddr=addr_sido+" "+addr_sigugun+" "+addr_dongri+" "+addr_bunji;
								}else if(addr_bunji==""||addr_bunji=="undefined"){
									pullAddr=addr_sido+" "+addr_sigugun+" "+addr_dongri;
								}else{
									pullAddr=addr_sido+" "+addr_dongri+" "+addr_bunji;	
								}
								
								$.ajax({
									type:'post',
									url:'${root}/board/blogListSearchSub2.do',
									data:{
										query: pullAddr, 
										key : "60e9ac7ab8734daca3d2053c1e713dbd",
										encoding : "utf-8",
										output : "json",
										coord : "latlng",
										urls : "http://openapi.map.naver.com/api/geocode"
									},
									contentType:'application/x-www-form-urlencoded;charset=UTF-8',
									success:function(data){
										var address= data.items[0].address;
										var sido= data.items[0].addrdetail.sido;
										var sigugun= data.items[0].addrdetail.sigugun;
										var dongmyun= data.items[0].addrdetail.dongmyun;
										var rest=data.items[0].addrdetail.rest;
										var x=data.items[0].point.x;
										var y=data.items[0].point.y;
										 
										m.push(new nhn.api.map.LatLng(y, x));
										addrArray.push(address);
										sidoArray.push(sido);
										sigugunArray.push(sigugun);
										dongmyunArray.push(dongmyun);
										restArray.push(rest);
										
										if(total_cnt==m.length){
											$("#map").empty();
											mapLoad(m,addrArray,sidoArray,sigugunArray,dongmyunArray,restArray,titleArray,mapDiv,search_value);
										}
									},
									error:function(data){
										
									}
								})
								
								
								
							},
							error:function(data){
								
							}
						})
					})
					
					
			},
			error:function(data){
				alert("error : blogListMain blogListSearch");
			}
			})
			//+headCategory+"/"+detailCategory+"/"+search_value
			
			
			
		})
		
	})
	
	function getBeginCondition(){
		$.ajax({
			type:'get',
			url:'${root}/board/getBeginCondition.do',
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
					var data=JSON.parse(responseData);
					if(!data){
						alert("blogListMain 최초 조회조건 get error");
						return false;
					}
					blogList_ConditionInsert("si", data.sido);
					blogList_ConditionInsert("headCategory", data.header);
			},
			error:function(data){
				alert("error : blogListMain getBeginCondition");
			}
		});		
	}
	


	// 	20150629 이헌주 - select 메뉴에 option을 추가하기 위한 function 
	//  el : option id     |     va : 추가 option
	function blogList_ConditionInsert(el, va){
		$(va).each(function( i ) {
			if(!va[i]){
					return false;	
			}else{
				var vaTrim=va[i];
				
				$("#blogListMain #" + el).append("<li><a><option id='item' value=" + va[i] + ">" + va[i] + "</option></a></li>");
			}
		});
		
		$("#blogListMain #" + el + " option").click(function(){
// 			alert($(this).val() + " " + $(this).text());
			$("#blogListMain #" + el + "_select").attr("value",$(this).val()).html($(this).text() + "<span class='caret'></span>");
			if(el=="headCategory"){
				blogList_category_changeCondition(el);
			}else if(el=="detailCategory"){
				
			}else{
				blogList_loc_changeCondition(el);
			}
		});
	};
	
	// 20150629 이헌주 - 주소 검색조건 변경시 하위 조건 초기화 function
	function blogList_loc_changeCondition(el){
		var siData=$("#blogListMain #si_select").attr("value");
		var gunData=$("#blogListMain #gun_select").attr("value");
		
// 		alert(siData + " " + gunData);
		
		if(el=="si"){
			$("#blogListMain #gun").empty();
			$("#blogListMain #gun").append("<li><a><option id='item' value='%'>시구군[전체]</option></a></li>");
			$("#blogListMain #gun_select").attr("value",'%').html("시구군[전체]<span class='caret'></span>");

			$("#blogListMain #dong").empty();
			$("#blogListMain #dong").append("<li><a><option id='item' value='%'>동면[전체]</option></a></li>");
			$("#blogListMain #dong_select").attr("value",'%').html("동면[전체]<span class='caret'></span>");
			
			if(siData!="%"){
				blogList_loc_getCondition(el, siData, gunData);
			}
		}else if(el=="gun"){
			$("#blogListMain #dong").empty();
			$("#blogListMain #dong").append("<li><a><option id='item' value='%'>동면[전체]</option></a></li>");
			$("#blogListMain #dong_select").attr("value",'%').html("동면[전체]<span class='caret'></span>");
			
			if(gunData!="%"){
				blogList_loc_getCondition(el, siData, gunData);
			}
		}
	}
	
	// 20150629 이헌주 - 주소 검색조건 변경시 하위 조건 추가 function
	function blogList_loc_getCondition(el, siData, gunData){
		$.ajax({
			type:'get',
			url:'${root}/board/getLocationCondition.do?el='+ el + '&siData=' + siData + '&gunData=' + gunData,
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
					var data=JSON.parse(responseData);
					
					if(el=='si'){
 						if(data.gunList[0]!="blank"){
 							blogList_ConditionInsert("gun", data.gunList);
 						}else{
 							blogList_ConditionInsert("dong", data.dongList);
 						}
					}else{						
						blogList_ConditionInsert("dong", data.dongList);
					}
			},
			error:function(data){
				alert("error : blogListMain getLocationCondition");
			}
		});
	}
	
	// 20150630 이헌주 - 카테고리 검색조건 변경시 하위 조건 초기화 function
	function blogList_category_changeCondition(el){
		var headData=$("#blogListMain #headCategory_select").attr("value");
		
		$("#blogListMain #detailCategory").empty();
		$("#blogListMain #detailCategory").append("<li><a><option id='item' value='%'>소분류[전체]</option></a></li>");
		$("#blogListMain #detailCategory_select").attr("value",'%').html("소분류[전체]<span class='caret'></span>");
		
		if(headData!="%"){
			blogList_category_getCondition(el, headData);
		}
	}
	
	// 20150630 이헌주 - 카테고리 검색조건 변경시 하위 조건 추가 function
	function blogList_category_getCondition(el, headData){
		$.ajax({
			type:'get',
			url:'${root}/board/getCategoryCondition.do?el='+ el + '&headData=' + headData,
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
					var data=JSON.parse(responseData);
					if(!data){
						alert("blogList_category_getCondition error");
						return false;
					}
					
					$("#blogListMain #detailCategory").empty();
					$("#blogListMain #detailCategory").append("<li><a><option id='item' value='%'>소분류[전체]</option></a></li>");
					$("#blogListMain #detailCategory_select").attr("value",'%').html("소분류[전체]<span class='caret'></span>");

					blogList_ConditionInsert('detailCategory', data);
			},
			error:function(data){
				alert("error : blogListMain getBeginCondition");
			}
		});
	}
</script>

<!-- [지도 관련 스크립트] -->
</head>
<body>
	<!-- 검색조건 navbar : 20150706 이헌주 -->
	<nav id="blogListMain" class="navbar navbar-inverse ">
		<div class="container-fluid">
		  	<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
			  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2">
			    <span class="sr-only">Toggle navigation</span>
			    <span class="icon-bar"></span>
			    <span class="icon-bar"></span>
			    <span class="icon-bar"></span>
			  </button>
			  <a class="navbar-brand">검색조건</a>
			</div>
		
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
				<ul class="nav navbar-nav">
					<!-- 검색조건(시도) -->
					<li id="dropdown" class="dropdown">
						<a id="si_select" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" value="%">시도[전체]<span class="caret"></span></a>
						<ul id="si" class="dropdown-menu" role="menu" style="overflow: scroll; height: 400px;" >
							<li><a><option id="item" value="%">시도[전체]</option></a></li>
						</ul>
					</li>
					
					<!-- 검색조건(시구군) -->
					<li class="dropdown">
						<a id="gun_select" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" value="%">시구군[전체]<span class="caret"></span></a>
						<ul id="gun" class="dropdown-menu" role="menu" style="overflow: scroll; height: 400px;">
							<li><a><option id="item" value="%">시구군[전체]</option></a></li>
						</ul>
					</li>
					
					<!-- 검색조건(동면) -->
					<li class="dropdown">
						<a id="dong_select" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" value="%">동면[전체]<span class="caret"></span></a>
						<ul id="dong" class="dropdown-menu" role="menu" style="overflow: scroll; height: 400px;">
							<li><a><option id="item" value="%">동면[전체]</option></a></li>
						</ul>
					</li>
					
					<!-- 검색조건(대분류) -->
					<li class="dropdown">
						<a id="headCategory_select" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" value="%">대분류[전체]<span class="caret"></span></a>
						<ul id="headCategory" class="dropdown-menu" role="menu" style="overflow: scroll; height: 400px;">
							<li><a value="%">대분류[전체]</a></li>
						</ul>
					</li>
					
					<!-- 검색조건(소분류) -->
					<li class="dropdown">
						<a id="detailCategory_select" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" value="%">소분류[전체]<span class="caret"></span></a>
						<ul id="detailCategory" class="dropdown-menu" role="menu" style="overflow: scroll; height: 400px;">
							<li><a value="%">소분류[전체]</a></li>
						</ul>
					</li>
				</ul>
				<form class="navbar-form navbar-left" role="search">
					<!-- 검색조건(문장) -->
					<div class="form-group">
						<input type="text"  id="blogList_text" class="form-control" placeholder="Search"/>
						<button type="button" id="blogList_Search" class="btn btn-default">검색</button>
					</div>
				</form>
			</div><!-- /.navbar-collapse -->
		</div><!-- /.container-fluid -->
	</nav>
	<br/>
		
		<div>
			<div id="map" style="display:inline-block; border:1px solid #000;"></div>
			<div style="display:inline-block">
				<div>
					
				</div>
			</div>
		</div>

		<br/><br/>
		<!-- <a data-toggle="modal" href="#blogListSub" class="btn btn-primary">Launch modal</a> -->
<script type="text/javascript">
$(function(){
	if (!navigator.geolocation) {
		var latitude = 37.5675451; //위도
		var longitude = 126.9773356; //경도
		blogListMapCreate(latitude, longitude);
	}

	function success(position) {
		var latitude = position.coords.latitude; //위도
		var longitude = position.coords.longitude; //경도
		
		latitude = latitude.toFixed(7);
		longitude = longitude.toFixed(7);
		blogListMapCreate(latitude, longitude);
	}

	function error() {
		var latitude = 37.5675451; //위도
		var longitude = 126.9773356; //경도
		
		blogListMapCreate(latitude, longitude);
	}

	navigator.geolocation.getCurrentPosition(success, error);
	
	//좌표 전달받아 지도 생성
	function blogListMapCreate(latitude, longitude){
		
	//	$("map").emty();
	// 	alert(latitude + " " + longitude);
	// 	var oDefaultPoint = new nhn.api.map.LatLng(37.5675451, 126.9773356);	// 기본위치
		var oPoint = new nhn.api.map.LatLng(latitude, longitude);
		nhn.api.map.setDefaultPoint('LatLng');
		
		var defaultLevel = 11;	// 기본지도레벨
		var oMap = new nhn.api.map.Map(document.getElementById('map'), { 
		                                point : oPoint,
		                                zoom : defaultLevel,
		                                enableWheelZoom : true,
		                                enableDragPan : true,
		                                enableDblClickZoom : false,
		                                mapMode : 0,
		                                activateTrafficMap : false,
		                                activateBicycleMap : false,
		                                minMaxLevel : [ 1, 14 ],
		                                size : new nhn.api.map.Size(500, 400)});
	                
				// zoomSlider
				var oSlider = new nhn.api.map.ZoomControl();
				oSlider.setPosition({
				        top : 10,
				        left : 10
				});
				oMap.addControl(oSlider);
				
				
				var oSize = new nhn.api.map.Size(28, 37);
				var oOffset = new nhn.api.map.Size(14, 37);
				var oIcon = new nhn.api.map.Icon('http://static.naver.com/maps2/icons/pin_spot2.png', oSize, oOffset);
				
				var oInfoWnd = new nhn.api.map.InfoWindow();
				oInfoWnd.setVisible(false);
				oMap.addOverlay(oInfoWnd);
				
				oInfoWnd.setPosition({
				        top : 20,
				        left :20
				});
				
				
				var oLabel = new nhn.api.map.MarkerLabel(); // - 마커 라벨 선언.
				oMap.addOverlay(oLabel); // - 마커 라벨 지도에 추가. 기본은 라벨이 보이지 않는 상태로 추가됨.
				
				oInfoWnd.attach('changeVisible', function(oCustomEvent) {
				        if (oCustomEvent.visible) {
				                oLabel.setVisible(false);
				        }
				});
				
				oMap.attach('mouseenter', function(oCustomEvent) {
				
				        var oTarget = oCustomEvent.target;
				        // 마커위에 마우스 올라간거면
				        if (oTarget instanceof nhn.api.map.Marker) {
				                var oMarker = oTarget;
				                oLabel.setVisible(true, oMarker); // - 특정 마커를 지정하여 해당 마커의 title을 보여준다.
				        }
				});
				
				oMap.attach('mouseleave', function(oCustomEvent) {
				
				        var oTarget = oCustomEvent.target;
				        // 마커위에서 마우스 나간거면
				        if (oTarget instanceof nhn.api.map.Marker) {
				                oLabel.setVisible(false);
				        }
				});
				
				oMap.attach('click', function(oCustomEvent) {
				        var oPoint = oCustomEvent.point;
				        var oTarget = oCustomEvent.target;
				        oInfoWnd.setVisible(false);
				        // 마커 클릭하면
				        if (oTarget instanceof nhn.api.map.Marker) {
				                // 겹침 마커 클릭한거면
				                if (oCustomEvent.clickCoveredMarker) {
				                        return;
				                }
				                // - InfoWindow 에 들어갈 내용은 setContent 로 자유롭게 넣을 수 있습니다. 외부 css를 이용할 수 있으며, 
				                // - 외부 css에 선언된 class를 이용하면 해당 class의 스타일을 바로 적용할 수 있습니다.
				                // - 단, DIV 의 position style 은 absolute 가 되면 안되며, 
				                // - absolute 의 경우 autoPosition 이 동작하지 않습니다. 
				                /* oInfoWnd.setContent('<DIV style="border-top:1px solid; border-bottom:2px groove black; border-left:1px solid; border-right:2px groove black;margin-bottom:1px;color:black;background-color:white; width:auto; height:auto;">'+
				                        '<span style="color: #000000 !important;display: inline-block;font-size: 12px !important;font-weight: bold !important;letter-spacing: -1px !important;white-space: nowrap !important; padding: 2px 5px 2px 2px !important">' + 
				                        'Hello World <br /> ' + oTarget.getPoint()
				                        +'<span></div>');
				                oInfoWnd.setPoint(oTarget.getPoint());
				                oInfoWnd.setPosition({right : 15, top : 30});
				                oInfoWnd.setVisible(true);
				                oInfoWnd.autoPosition(); */
				                return;
				        }
				        var oMarker = new nhn.api.map.Marker(oIcon, { title : '마커 : ' + oPoint.toString() });
				        oMarker.setPoint(oPoint);
				        oMap.addOverlay(oMarker);
				});
				//마커 띄우기(현재 접속된 위치)
				

			/*	 for(var i=0;i<m.length;i++){ //마커생성 
		                 var oPoint = m[i]; 
		                 var oMarker = new nhn.api.map.Marker(oIcon, { title :"["+titleArray[i]+"]"+" "+sidoArray[i]+"/"+sigugunArray[i]+"/"+dongmyunArray[i]+"/"+restArray[i]});
		                 oMarker.setPoint(oPoint); 
		                 oMap.addOverlay(oMarker); 
		                  mapInfoTestWindow
							.setContent('<DIV style="border-top:1px solid; border-bottom:2px groove black; border-left:1px solid; border-right:2px groove black;margin-bottom:1px;color:black;background-color:white; width:auto; height:auto;">'
									+ '<button data-dismiss="modal" style="color: #000000 !important;display: inline-block;font-size: 12px !important;font-weight: bold !important;letter-spacing: -1px !important;white-space: nowrap !important; padding: 2px 2px 2px 2px !important">'
									+ title :titleArray[i]
									+ '</buton></div>'); 

		 				oLabel.setVisible(true, oMarker);
		 				oLabel.setPosition(true);
		             } */
	};
});
</script>
</body>
</html>
