<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!-- test를 위해 ID 입력 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.spanStyle{
    display:inline-block;
	margin-left: 10px;
	text-align: left; 	
}
</style>
<!-- 네이버 스마트에디터 -->
<script type="text/javascript">

//검색조건 시작
$(function(){
	$.ajax({
		type:'get',
		url:'${root}/board/getCategory.do',
		contentType:'application/x-www-form-urlencoded;charset=UTF-8',
		success:function(responseData){
			var data=JSON.parse(responseData);
			
			if(!data){
				alert("존재하지 않는 ID입니다");
				return false;
			}
			blogWrite_optionInsert("headCategory", data);
		},
		error:function(data){
			alert("error : blogWrite getBeginCondition");
		}
	});
	
	var email=sessionStorage.getItem('email');
	$("input[name='member_id']").attr("value",email);

	
});

//이미지 수에 따른 display 변화
function attact_comment_select() {
	
	var imageSelect=$("#imageAttach option:selected").val();
	if(imageSelect=="1"){
		 imageInline(0);
		 imageNone(1);
	
	}else if(imageSelect=="2"){
		 imageInline(1);
		 imageNone(2);

	}else if(imageSelect=="3"){
		 imageInline(2);
		 imageNone(3);
	
	}else if(imageSelect=="4"){
		 imageInline(3);
		 imageNone(4);
	
	}else if(imageSelect=="5"){
		 imageInline(4);
		 imageNone(5);
	}else{
		imageNone(0);
	}
}

function blogWrite_optionInsert(el, data){
	for (var i = 0; i < data.length; i++) {
		$("#blogWriteSelect #" + el).append("<option value=" + data[i] + ">" + data[i] + "</option>");
		$("#blogUpdateSelect #" + el).append("<option value=" + data[i] + ">" + data[i] + "</option>");
		$("#blogPartnerSelect #" + el).append("<option value=" + data[i] + ">" + data[i] + "</option>");
	}

		$("#blogWriteSelect #" + el).selectpicker('refresh');
		$("#blogUpdateSelect #" + el).selectpicker('refresh');
		$("#blogPartnerSelect #" + el).selectpicker('refresh');
};

//카테고리 select 변경
function blogWrite_ChangeCategory(el){
	var headData=$("#blogWriteSelect #headCategory").val();
	var headDatas=$("#blogUpdateSelect #headCategory").val();
	var headDatass=$("#blogPartnerSelect #headCategory").val();
	
	
	if(el=="headCategory"){
		$("#blogWriteSelect #detailCategory").empty();
		$("#blogWriteSelect #detailCategory").append("<option value='%'>소분류[전체]</option>");
		$("#blogWriteSelect #detailCategory").selectpicker("refresh");
		
		$("#blogUpdateSelect #detailCategory").empty();
		$("#blogUpdateSelect #detailCategory").append("<option value='%'>소분류[전체]</option>");
		$("#blogUpdateSelect #detailCategory").selectpicker("refresh");
		
		$("#blogPartnerSelect #detailCategory").empty();
		$("#blogPartnerSelect #detailCategory").append("<option value='%'>소분류[전체]</option>");
		$("#blogPartnerSelect #detailCategory").selectpicker("refresh");
		
		if(headData!="%"){
			blogWrite_getCategorySelect(el, headData);
		}else if(headData=="%" && headDatas!="%"){
			blogWrite_getCategorySelect(el, headDatas);
			
		} else if(headData=="%" && headDatas=="%" && headDatass!="%"){
			blogWrite_getCategorySelect(el, headDatass);
		} 
		
	}
}


//카테고리 select 로드
function blogWrite_getCategorySelect(el, headData){
	$.ajax({
		type:'get',
		url:'${root}/board/getCategoryCondition.do?el='+ el + '&headData=' + headData,
		contentType:'application/x-www-form-urlencoded;charset=UTF-8',
		success:function(responseData){
				var data=JSON.parse(responseData);
				if(!data){
					alert("존재하지 않는 ID입니다");
					return false;
				}
				
				$("#blogWriteSelect #detailCategory").empty();
				$("#blogWriteSelect #detailCategory").append("<option value='%'>소분류[전체]</option>");
				
				$("#blogUpdateSelect #detailCategory").empty();
				$("#blogUpdateSelect #detailCategory").append("<option value='%'>소분류[전체]</option>");
				
			 	$("#blogPartnerSelect #detailCategory").empty();
				$("#blogPartnerSelect #detailCategory").append("<option value='%'>소분류[전체]</option>"); 
				blogWrite_optionInsert('detailCategory', data);
		},
		error:function(data){
			alert("error : blogWrite getBeginCondition");
		}
	});

	}
	
	//이미지 미리보기
	$(document).ready(function(){
	    function readURL(input,index) {
	    	if (input.files && input.files[0]) {
	        	var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
	            reader.onload = function (e) { 
	            //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
	                $('#UploadedImg'+index).attr('src', e.target.result);
	                //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
	                //(아래 코드에서 읽어들인 dataURL형식)
	            }                    
	            reader.readAsDataURL(input.files[0]);
	            //File내용을 읽어 dataURL형식의 문자열로 저장
	        }
	    }//readURL()--
	
	    //file 양식으로 이미지를 선택(값이 변경) 되었을때 처리하 는 코드
	    $('input[type=file]').click(function() {
	    	var fileId=$(this).attr('id');
	    	var index=fileId.substring(6,7);
	    		
	    	$("#"+fileId).change(function(){
    	        if(this.value==""||this.value==null){
    	        	$('#UploadedImg'+index).attr('src', e.target.result);
    	        }
    	        readURL(this,index);
    	    });
	    });
	    
	    
	   
	 });

	//맛집,주소 검색
	function mapSearch() {
		
		$("#testMap").empty();
		//지도 좌표 배열
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
		var mapDiv='testMap';
		
		//맛집,주소 입력값
		var addrValue=$("#addr").val();
		if(addrValue==""){
			addrValue=$("#Upaddr").val();
		}
		
		
		//입력값을 상세주소로 반환하는 검색(지역) api 이용(xml 파싱)
		
		$.ajax({
					type : 'get',
					url : '${root}/board/search.do',
					data : {
						key : "6f94d45ce20648228b18911a4764bbd9",
						query : addrValue,
						target : "local",
						display : "100",
						start : "1",
						urls : "http://openapi.naver.com/search",
						num : "1",
					},
					dataType : navigator.userAgent.indexOf("MSIE") > 0 ? "xml"
							: "text",
					success : function(xml) {
						var total=$(xml).find('total').text(); //검색된 데이터 수
						
						$(xml).find('item').each(function() {
						var title = $(this).find('title').text();
						titleArray.push(title);
					
						var address = $(this).find('address').text();
								// 주소를 좌표로 반환하는 지도api 이용(xml 파싱)
								$.ajax({
												type : 'get',
												url : '${root}/board/search.do',
												data : {
													key : "60e9ac7ab8734daca3d2053c1e713dbd",
													query : address,
													encoding : "utf-8",
													output : "json",
													coord : "latlng",
													urls : "http://openapi.map.naver.com/api/geocode",
													num : "2"
												},
												contentType:'application/x-www-form-urlencoded;charset=UTF-8',
										
												success : function(result) {
													
													var address= result.items[0].address;
													var sido= result.items[0].addrdetail.sido;
													var sigugun= result.items[0].addrdetail.sigugun;
													var dongmyun= result.items[0].addrdetail.dongmyun;
													var rest=result.items[0].addrdetail.rest;
													var x=result.items[0].point.x;
													var y=result.items[0].point.y;
													//alert(address+"\n"+sido+"\n"+sigugun+"\n"+dongmyun+"\n"+rest+"\n"+x+"\n"+y);
													
													 m.push(new nhn.api.map.LatLng(y, x));
													 addrArray.push(address);
													 sidoArray.push(sido);
													 sigugunArray.push(sigugun);
													 dongmyunArray.push(dongmyun);
													 restArray.push(rest);
													 if(total==m.length||m.length==100){
														 alert(sidoArray.length);
										            	  mapLoad(m,addrArray,sidoArray,sigugunArray,dongmyunArray,restArray,titleArray,mapDiv,addrValue);
										              }
												},
												error : function(xml) {
													alert("The XML File could not be processed correctly.");
												}
												
											});
								
							});
							
					},
					
					error : function(xml) {
						alert("The XML File could not be processed correctly.");
					}
					
				});
		
		
	}
	/* 네이버 스마트 에디터(크기,색상,글꼴 등) */
	$(function() {
		//전역변수
		var obj=[];
		//스마트에디터 프레임생성
		nhn.husky.EZCreator.createInIFrame({
			oAppRef:obj,
			elPlaceHolder:"board_content",
			sSkinURI:"${root}/editor/SmartEditor2Skin.html",
			htParams:{
				//툴바 사용 여부(true:사용/false:사용하지 않음)
				bUseToolbar:true,
				//입력창 크기 조절바 사용 여부(true:사용/false:사용하지 않음)
				bUseVerticalResizer:true,
				//모드 탭(Editor|HTML|TEXT) 사용 여부 (true:사용/false:사용하지 않음)
				bUseModeChanger:true
			}
			
		});
		
		/* 전송 버튼 클릭시 */
		$("#save_button").click(function() {
			var realAddr=$("input type[name='addr_sido']").val();
		
			/* 유효성 검사 */
			if($("#blogWriteSelect > #headCategory option:selected").val()=="%"){
				alert("대분류 카테고리를 여행,음식 중 선택해주세요.");
				return false;
			}
			
			if(!$("input[name='addrress']").val()){
				alert("주소를 입력하세요.");
				$("#addr").focus();
				return false;
			}
			
			if(!$("input[name='board_title']").val()){
				alert("제목을 입력하세요.");
				$("#board_title").focus();
				return false;
			}
			
			
			
			var select_value=$("#imageAttach option:selected").val();
			if(select_value!="0"){
			var int_select_value=parseInt(select_value);
			for (var i = 0; i < int_select_value; i++) {
					if($("#attach > span:eq("+i+") > input:eq(1)").val()==""){
						alert("첨부이미지에 대한 간단한 코멘트를 입력해주세요.");
						return false;
					}
					if($("#attach > span:eq("+i+") > input[type='file']").val()==""){
						alert("첨부할 이미지를 추가해주세요.");
						return false;
					}
				}
			}
			
			if(!($("input[type='radio']").is(":checked"))){
				alert("평점을 선택해주세요.")
				return false;
			}
			
			/* obj.getById["board_content"].exec("UPDATE_IR_FIELD", []); //내용 적용 

	        var content = document.getElementById("board_content").value; 

	        if (content == "" || content == null || content == '&nbsp;' || content == '<p>&nbsp;</p>') { 
	                alert("내용을 입력하세요."); 
	                obj.getById["board_content"].exec("FOCUS"); //포커싱 
	                return false; 
	        }else{ 
	        }  */
			
			obj.getById["board_content"].exec("UPDATE_CONTENTS_FIELD",[]);
			
			//폼 submit();
			$("#frm").submit();
		});
	})
		
	
	//첨부이미지 갯수에 따른 Display=none
	function imageNone(start) {
		for (var i = start; i <= 4; i++) {
			$("#write_img"+i).css("display","none");
			}
	}
	//첨부이미지 갯수에 따른 Display=inline
	function imageInline(end) {
		for (var i = 0; i <= end; i++) {
			$("#write_img"+i).css("display","");
			}
	}
	
	
</script>
</head>
<body>

<form class="form-horizontal" name="blogWriteForm" action="${root }/board/blogWrite" method="POST" id="frm" enctype="multipart/form-data">		<!-- 전체적인 폼 내에서 Label / Text 창의 크기를 조절하기 위해 필요한 폼 -->
		<!-- <input type="hidden" name="member_id"/> -->
		
			<div class="col-md-1 col-sm-1 col-xs-1"></div>
			<div class="col-md-10 col-sm-10 col-xs-10">
			<div id="blogWriteSelect" class="form-group form-group-sm">
				<select id="headCategory" name="category_mname" class="selectpicker" data-width="140px" style="display: none" onchange="blogWrite_ChangeCategory(this.id)">
					<option value="%">대분류[전체]</option>
				</select> 
				<select id="detailCategory" name="category_sname"  class="selectpicker" data-width="140px" style="display: none">
					<option value="%">소분류[전체]</option>
				</select>
			</div>
	
			<div class="form-group form-group-sm">
				
					<input type="text"  class="form-control" name="member_id"  disabled="disabled"/>
					<input type="hidden" class="form-control" name="member_id" />
				
			</div>

			<div class="form-group form-group-sm">
				
				 
				<div style="width: 100%;">
					<input type="text" style=" width:79%; height: 30px; padding: 5px 10px;font-size: 12px; line-height: 1.5;border-radius: 3px; box-shadow:inset 0 1px 1px rgba(0,0,0,.075);" id="addr" name="addrress" value="" placeholder="예)미정국수" /> 
				
				
					<a style="width: 20%;" data-toggle="modal" href="#blogWriteSub" class="btn btn-primary" onclick="mapSearch();">위치검색</a>
					<input type="hidden" class="form-control" name="addr_sido"/>
					<input type="hidden" class="form-control" name="addr_sigugun"/>
					<input type="hidden" class="form-control" name="addr_dongri"/>
					<input type="hidden" class="form-control" name="addr_bunji"/>
				</div>
				
			</div>
			
			<div class="form-group form-group-sm">	
					<input type="text" class="form-control" name="addr_title" size="40" disabled="disabled" placeholder="업체/여행지를 입력하세요."/>
					<input type="hidden" class="form-control" name="addr_title"/>
			</div>
			
			<div class="form-group form-group-sm">	
				<input type="text" class="form-control" name="realAddr" size="40" disabled="disabled" placeholder="주소를 입력하세요."/>
			</div>	
			
			
				
			<div class="form-group form-group-sm">
				<input type="text" class="form-control" id="board_title" name="board_title" size="70" placeholder="게시글의 제목을 입력하세요."/>
			</div>	
				
			
			<div class="form-group form-group-sm">
				<textarea name="board_content" id="board_content" class="form-control" style="width:100%; height:200px;" rows="10" cols="100"  placeholder="내용을 입력하세요"></textarea>
			</div>


			<div id="attach" class="form-group form-group-sm">		<!-- 크기 조절을 하기 위한 기본 틀 -->
				<label class="control-label" for="formGroupInputSmall">첨부파일|코멘트:</label>
					<select id="imageAttach" class="selectpicker" data-width="150px" onchange="attact_comment_select()">
						<option value="0">이미지 첨부 갯수</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
			
			</div>
			<div class="form-group form-group-sm">	
					<span class="spanStyle" style="display:none;" id="write_img0">
					<input id="imgInp0" class="form-control" type="file" name="file" onchange="readURL(this);" style="position: absolute; margin-left: 10px; width: 62px;height: 120px;filter:alpha(opacity=0); opacity:0; -moz-opacity:0; cursor: pointer;"/>
					<img id="UploadedImg0" src="${root }/images/blogWrite/noImage.gif" width="100" height="111" alt="your image"/> 
					<br/>
					<input type="text" class="form-control" name="comment" style="width:100px;" placeholder="예)최고에요"/>
					</span>
				
					<span class="spanStyle" style="display: none;" id="write_img1">
					<input id="imgInp1" class="form-control" type="file" name="file" onchange="readURL(this);" style="position: absolute; margin-left: 10px; width: 62px;height: 120px;filter:alpha(opacity=0); opacity:0; -moz-opacity:0; cursor: pointer;"/>
					<img id="UploadedImg1" src="${root }/images/blogWrite/noImage.gif" width="100" height="111" alt="your image"/> 
					<br/>
					<input type="text" class="form-control" name="comment" style="width:100px;" placeholder="예)최고에요"/>
					</span>
					
					<span class="spanStyle" style="display: none;" id="write_img2">
					<input id="imgInp2" class="form-control" type="file" name="file" onchange="readURL(this);" style="position: absolute; margin-left: 10px; width: 62px;height: 120px;filter:alpha(opacity=0); opacity:0; -moz-opacity:0; cursor: pointer;"/>
					<img id="UploadedImg2" src="${root }/images/blogWrite/noImage.gif" width="100" height="111" alt="your image"/> 
					<br/>
					<input type="text" class="form-control" name="comment" style="width:100px;"placeholder="예)최고에요"/>
					</span>
					
					<span class="spanStyle" style="display: none;" id="write_img3">
					<input id="imgInp3" class="form-control" type="file" name="file" onchange="readURL(this);" style="position: absolute; margin-left: 10px; width: 62px;height: 120px;filter:alpha(opacity=0); opacity:0; -moz-opacity:0; cursor: pointer;"/>
					<img id="UploadedImg3" src="${root }/images/blogWrite/noImage.gif" width="100" height="111" alt="your image"/> 
					<br/>
					<input type="text" class="form-control" name="comment" style="width:100px;" placeholder="예)최고에요"/>
					</span>
					
					<span class="spanStyle" style="display: none;" id="write_img4">
					<input id="imgInp4" class="form-control" type="file" name="file" onchange="readURL(this);" style="position: absolute; margin-left: 10px; width: 62px;height: 120px;filter:alpha(opacity=0); opacity:0; -moz-opacity:0; cursor: pointer;"/>
					<img id="UploadedImg4" src="${root }/images/blogWrite/noImage.gif" width="100" height="111" alt="your image"/> 
					<br/>
					<input type="text" class="form-control" name="comment" style="width:100px;" placeholder="예)최고에요"/>
					</span>
			</div>
	
			<div class="form-group form-group-sm">		<!-- 크기 조절을 하기 위한 기본 틀 -->
					<input type="radio" name="board_grade" value="0"/><img src="${root }/css/images/star0.jpg" width="100" height="20"/>
					<input type="radio" name="board_grade" value="1"/><img src="${root }/css/images/star1.jpg" width="100" height="20"/>
					<input type="radio" name="board_grade" value="2"/><img src="${root }/css/images/star2.jpg" width="100" height="20"/>
					<input type="radio" name="board_grade" value="3"/><img src="${root }/css/images/star3.jpg" width="100" height="20"/>
					<input type="radio" name="board_grade" value="4"/><img src="${root }/css/images/star4.jpg" width="100" height="20"/>
					<input type="radio" name="board_grade" value="5"/><img src="${root }/css/images/star5.jpg" width="100" height="20"/>
			</div>

			<div class="form-group form-group-sm" style="text-align: right;">
					
					<div style="display: inline-block;">
						<input type="reset" class="btn btn-primary" value="취소" />
						<input type="button" class="btn btn-primary" id="save_button" value="작성"/>			
					</div>
				
			</div>
			</div>
			<div class="col-md-1 col-sm-1 col-xs-1"></div>		
</form>
</body>
</html>
