<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="root" value="${pageContext.request.contextPath }" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
<title>Insert title here</title>
<style>
v\:* {
	behavior: url(#default#VML);
}
</style>
<!-- 네이버 지도 -->
<script type="text/javascript"
	src="http://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&key=1b79d7553c7736aca4e7243cdecfecbc"></script>
<script type="text/javascript">
	try {
		document.execCommand('BackgroundImageCache', false, true);
	} catch (e) {
	}
</script>
<script type="text/javascript">
	//현재 위치를 좌표값으로 받아오기 위한 스크립트
	function mapLoad(m,addrArray,sidoArray,sigugunArray,restArray,titleArray) {
			var output = document.getElementById("out");
			if (!navigator.geolocation) {
				output.innerHTML = "<p>사용자의 브라우저는 지오로케이션을 지원하지 않습니다.</p>";
				return;
			}

			function success(position) {
				var latitude = position.coords.latitude; //위도
				var longitude = position.coords.longitude; //경도
				
				latitude = latitude.toFixed(7);
				longitude = longitude.toFixed(7);
				output.innerHTML = '<p>위도 : ' + latitude + ' <br>경도 : ' + longitude
						+ '</p>';
				mapCreate(latitude, longitude);
			}
			
			function error() {
				output.innerHTML = "사용자의 위치를 찾을 수 없습니다.";
			}
			
			output.innerHTML = "<p>Locating…</p>";

			navigator.geolocation.getCurrentPosition(success, error);
		
		function mapCreate(latitude, longitude) {
			//좌표 전달받아 지도 생성
			var oPoint = new nhn.api.map.LatLng(latitude, longitude);
			nhn.api.map.setDefaultPoint('LatLng');
			var oMap = new nhn.api.map.Map('testMap', {
				point : oPoint,
				zoom : 12,
				boundary:m,
				enableWheelZoom : true,
				enableDragPan : true,
				enableDblClickZoom : false,
				mapMode : 0,
				activateTrafficMap : false,
				activateBicycleMap : false,
				minMaxLevel : [ 1, 14 ],
				size : new nhn.api.map.Size(500, 400),
				detectCoveredMarker : true 
			});
			

			var eventFlag = false; // - 동일한 이벤트가 무한정 추가되는 것을 막기 위한 flag.

			var clickEvent = function(pos) { // - 클릭 이벤트 핸들러
				alert(pos.point.getX() + " , " + pos.point.getY()); // - 마우스를 클릭했을때의 좌표를 alert 창으로 알려줌.
			};

			
			//마커 아이콘 사이즈 및 이미지 
			var oSize = new nhn.api.map.Size(28, 37);
			var oOffset = new nhn.api.map.Size(14, 37);
			var oIcon = new nhn.api.map.Icon(
					'http://static.naver.com/maps2/icons/pin_spot2.png', oSize,
					oOffset);

			var mapInfoTestWindow = new nhn.api.map.InfoWindow(); // - info window 생성
			
			mapInfoTestWindow.setVisible(false); // - infowindow 표시 여부 지정.
			oMap.addOverlay(mapInfoTestWindow); // - 지도에 추가.     

			var oLabel = new nhn.api.map.MarkerLabel(); // - 마커 라벨 선언.
			oMap.addOverlay(oLabel); // - 마커 라벨 지도에 추가. 기본은 라벨이 보이지 않는 상태로 추가됨.

			mapInfoTestWindow.attach('changeVisible', function(oCustomEvent) {
				if (oCustomEvent.visible) {
					oLabel.setVisible(false);
				}
			});
			
			// 마커위에 마우스 올라간거면
			oMap.attach('mouseenter', function(oCustomEvent) {
				var oTarget = oCustomEvent.target;
				if (oTarget instanceof nhn.api.map.Marker) {
					var oMarker = oTarget;
					oLabel.setVisible(true, oMarker); // - 특정 마커를 지정하여 해당 마커의 title을 보여준다.
				}
			});
			
			// 마커위에서 마우스 나간거면
			oMap.attach('mouseleave', function(oCustomEvent) {
				var oTarget = oCustomEvent.target;
				if (oTarget instanceof nhn.api.map.Marker) {
					oLabel.setVisible(false);
				}
			});

			oMap.attach('click',function(oCustomEvent) {
			
				
					
					
				
								var oPoint = oCustomEvent.point;
								var oTarget = oCustomEvent.target;
								mapInfoTestWindow.setVisible(false);
								// 마커 클릭하면
								if (oTarget instanceof nhn.api.map.Marker) {
									var pullAddr=oCustomEvent.target.getTitle();
									var pAddr=pullAddr.split(" ");
									var pAddr4=pAddr[4];
									
									
									$("input[name=realAddr]").val(pAddr[1]+" "+pAddr[2]+" "+pAddr[3]+" "+pAddr4.trim());
									$("input[name=addr_sido]").val(pAddr[1]);
									$("input[name=addr_sigugun]").val(pAddr[2]);
									$("input[name=addr_dongri]").val(pAddr[3]);
									$("input[name=addr_bunji]").val(pAddr4.trim());
									$("div[id=blogWriteSub].modal").modal("hide");
									
									// 겹침 마커 클릭한거면
									if (oCustomEvent.clickCoveredMarker) {
										return;
									}
									// - InfoWindow 에 들어갈 내용은 setContent 로 자유롭게 넣을 수 있습니다. 외부 css를 이용할 수 있으며, 
									// - 외부 css에 선언된 class를 이용하면 해당 class의 스타일을 바로 적용할 수 있습니다.
									// - 단, DIV 의 position style 은 absolute 가 되면 안되며, 
									// - absolute 의 경우 autoPosition 이 동작하지 않습니다. 
									
										
										
									
									
									mapInfoTestWindow.setPoint(oTarget.getPoint());
									mapInfoTestWindow.setVisible(true);
									mapInfoTestWindow.setPosition({
										right : 15,
										top : 30
									});
									mapInfoTestWindow.autoPosition(); 
									return;
								}
							/* 	var oMarker = new nhn.api.map.Marker(oIcon, {
									title : '마커 : ' + oPoint.toString()
								});
								oMarker.setPoint(oPoint);
								oMap.addOverlay(oMarker); */
							});
			var mapZoom = new nhn.api.map.ZoomControl(); // - 줌 컨트롤 선언
			mapZoom.setPosition({
				left : 10,
				bottom : 40
			}); // - 줌 컨트롤 위치 지정
			oMap.addControl(mapZoom); // - 줌 컨트롤 추가.

			//마커 띄우기(현재 접속된 위치)
			var oMarker = new nhn.api.map.Marker(oIcon, {
				point : oPoint,
				
				zIndex : 1,
				title : '현재위치'
			});
			oMarker.setPoint(oPoint);
			oMap.addOverlay(oMarker);
			oLabel.setVisible(true, oMarker);
			oLabel.setPosition(true);

			 for(var i=0;i<m.length;i++){ //마커생성 
	                 var oPoint = m[i]; 
	                 var oMarker = new nhn.api.map.Marker(oIcon, { title :"["+titleArray[i]+"]"+" "+addrArray[i]});
	                 oMarker.setPoint(oPoint); 
	                 oMap.addOverlay(oMarker); 
	                /*  mapInfoTestWindow
						.setContent('<DIV style="border-top:1px solid; border-bottom:2px groove black; border-left:1px solid; border-right:2px groove black;margin-bottom:1px;color:black;background-color:white; width:auto; height:auto;">'
								+ '<button data-dismiss="modal" style="color: #000000 !important;display: inline-block;font-size: 12px !important;font-weight: bold !important;letter-spacing: -1px !important;white-space: nowrap !important; padding: 2px 2px 2px 2px !important">'
								+ title :titleArray[i]
								+ '</buton></div>'); */
	             } 
			
		};
	};

</script>
</head>
<body>
	<!-- 지도 -->
	<div id="testMap"
		style="border: 1px solid #000; width: 500px; height: 400px; margin: 20px;"></div>
	
	<!-- 현재위치 좌표 출력 -->
	<label>현재위치</label>
	<div id="out"></div>
</body>
</html>