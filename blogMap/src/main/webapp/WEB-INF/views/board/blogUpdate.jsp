<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<c:set var="root" value="${pageContext.request.contextPath}" />
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
<script type="text/javascript">
	
function readURLS(input,index) {
    if (input.files && input.files[0]) {
        var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
        reader.onload = function (e) { 
        //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
            $('#UpdateloadedImg'+index).attr('src', e.target.result);
            //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
            //(아래 코드에서 읽어들인 dataURL형식)
        }                    
        reader.readAsDataURL(input.files[0]);
        //File내용을 읽어 dataURL형식의 문자열로 저장
    }
}//readURL()--	
	
	//이미지 미리보기
	$(function(){
	  	//file 양식으로 이미지를 선택(값이 변경) 되었을때 처리하 는 코드
	    $('#blogUpdateattach input[type=file]').click(function() {
	    	var fileId=$(this).attr('id');
	    	var index=fileId.substring(8,9);
	    		$("#"+fileId).change(function(){
	    	        if(this.value==""||this.value==null){
						
	    	        	$('#UpdateloadedImg'+index).attr('src', e.target.result);
	    	        }
	    	        readURLS(this,index);
	    	    });
	    });
	    
	    //이미지 수에 따른 display 변화
	    $("#blogUpdateattach  #imageAttach").click(function() {
			var imageSelect=$("#blogUpdateattach  #imageAttach option:selected").val();
	    	if(imageSelect=="1"){
	    		 UpimageInline(0);
	    		 UpimageNone(1);
			}else if(imageSelect=="2"){
				 UpimageInline(1);
				 UpimageNone(2);
			}else if(imageSelect=="3"){
				 UpimageInline(2);
				 UpimageNone(3);
			 }else if(imageSelect=="4"){
				 UpimageInline(3);
				 UpimageNone(4);
			 }else if(imageSelect=="5"){
				 UpimageInline(4);
				 UpimageNone(5);
			 }else{
				 UpimageNone(0);
			 }
	    });
		
		
		
	 });

	
	
	
	//첨부이미지 갯수에 따른 Display=none
	function UpimageNone(start) {
		for (var i = start; i <= 4; i++) {
  			 $("#blogUpdateattach").find("span:eq("+i+")").css("display","none");
			}
	}
	//첨부이미지 갯수에 따른 Display=inline
	function UpimageInline(end) {
		for (var i = 0; i <= end; i++) {
			$("#blogUpdateattach").find("span:eq("+i+")").css("display","");
			}
	}
	
	
	
	
	
	



</script>
</head>
<body>
<!-- 전체적인 폼 내에서 Label / Text 창의 크기를 조절하기 위해 필요한 폼 -->
<form class="form-horizontal" name="blogUpdateForm" action="${root }/board/blogUpdateOk" method="POST" id="up_frm" enctype="multipart/form-data">		
<!-- <input type="hidden" name="member_id"/> -->
		<div class="thumbnail">	
		<div class="caption">
		<div class="col-md-12 col-sm-12 col-xs-12">		<!-- Div 를 3화면에서 12 칸 모두 사용 -->
			<br/>
		</div>
			
			<input id="blogUpdateFile_no" type="hidden" name="file_nos"/>
			<input id="blogUpdateBoard_no" type="hidden" name="board_no"/>
			
			<div class="form-group form-group-sm" id="blogUpdateSelect">
				<div class="col-md-2 col-sm-2 col-xs-2"><label class="control-label" for="formGroupInputSmall">카테고리:</label></div>
				<div class="col-md-7 col-sm-7 col-xs-7">
				<select id="headCategory" name="category_mname" class="selectpicker" data-width="140px" style="display: none" onchange="blogWrite_ChangeCategory(this.id)">
					<option value="%">대분류[전체]</option>
				</select> 
				<select id="detailCategory" name="category_sname"  class="selectpicker" data-width="140px" style="display: none">
					<option value="%">소분류[전체]</option>
				</select>
				</div>
			</div>
		
			<div class="form-group form-group-sm">
				<div class="col-md-2 col-sm-2 col-xs-2"><label class="control-label" for="formGroupInputSmall">작성자:</label></div>
				<div class="col-md-7 col-sm-7 col-xs-7">
					<input type="text"  class="form-control" name="member_id"  disabled="disabled"/>
					<input type="hidden" name="member_id" />
				</div>
			</div>
			
			<div id="blogUpdateAddr">
				<div class="form-group form-group-sm">
					<div class="col-md-2 col-sm-2 col-xs-2"><label class="control-label" for="formGroupInputSmall">위치검색:</label></div>
					<div class="col-md-6 col-sm-6 col-xs-6">
						<input type="text" class="form-control" id="Upaddr" name="addrress" value="" placeholder="예)미정국수" /> 
					</div>
					
					<div class="col-md-2 col-sm-2 col-xs-2">
						<a data-toggle="modal" href="#blogWriteSub" class="btn btn-primary" onclick="mapSearch();">위치검색</a>
						<input type="hidden" class="form-control" name="addr_sido"/>
						<input type="hidden" class="form-control" name="addr_sigugun"/>
						<input type="hidden" class="form-control" name="addr_dongri"/>
						<input type="hidden" class="form-control" name="addr_bunji"/>
					</div>
				</div>
				
				<div class="form-group form-group-sm">	
					<div class="col-md-2 col-sm-2 col-xs-2"><label class="control-label" for="formGroupInputSmall">업체,여행지명:</label></div>
					<div class="col-md-7 col-sm-7 col-xs-7">
						<input type="text" class="form-control" name="addr_title" size="40" disabled="disabled"/>
						<input type="hidden" class="form-control" name="addr_title"/>
					</div>
				</div>
				
				<div class="form-group form-group-sm">	
					<div class="col-md-2 col-sm-2 col-xs-2"><label class="control-label" for="formGroupInputSmall">주소:</label></div>
					<div class="col-md-7 col-sm-7 col-xs-7"><input type="text" class="form-control" name="realAddr" size="40" disabled="disabled"/></div>
				</div>	
			</div>
			
			<div class="form-group form-group-sm" id="blogUpdateTitle">				
				<div class="col-md-2 col-sm-2 col-xs-2"><label class="control-label" for="formGroupInputSmall">제목:</label></div>
				<div class="col-md-7 col-sm-7 col-xs-7"><input type="text" class="form-control" name="board_title" size="70"/></div>
			</div>
				
			<div class="form-group form-group-sm" id="blogUpdateContent">
				<div class="col-md-2 col-sm-2 col-xs-2"><label class="control-label" for="formGroupInputSmall">내용:</label></div>
				<div class="col-md-7 col-sm-7 col-xs-7"><textarea name="board_content" id="Upboard_content" class="form-control" style="width:710px; height:200px;" rows="10" cols="100"></textarea></div>
			</div>
			
			<div class="form-group form-group-sm"  id="blogUpdateattach">		
				<div class="col-md-2 col-sm-2 col-xs-2"><label class="control-label" for="formGroupInputSmall">첨부파일|코멘트:</label>
					<select id="imageAttach">
						<option value="0">이미지 첨부 갯수</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				</div>
				
				
					<span class="spanStyle" style="display:none;" id="blogUp0">
					<input id="UpimgInp0" class="form-control" type="file" name="file" onchange="readURLS(this);" style="position: absolute; margin-left: 10px; width: 62px;height: 120px;filter:alpha(opacity=0); opacity:0; -moz-opacity:0; cursor: pointer;"/>
					<img id="UpdateloadedImg0" src="${root }/images/blogWrite/noImage.gif" width="100" height="111" alt="your image"/> 
					<br/>
					<input type="text" class="form-control" name="comment" style="width:100px;" placeholder="예)최고에요"/>
					</span>
				
					<span class="spanStyle" style="display:none;" id="blogUp1">
					<input id="UpimgInp1" class="form-control" type="file" name="file" onchange="readURLS(this);" style="position: absolute; margin-left: 10px; width: 62px;height: 120px;filter:alpha(opacity=0); opacity:0; -moz-opacity:0; cursor: pointer;"/>
					<img id="UpdateloadedImg1" src="${root }/images/blogWrite/noImage.gif" width="100" height="111" alt="your image"/> 
					<br/>
					<input type="text" class="form-control" name="comment" style="width:100px;" placeholder="예)최고에요"/>
					</span>
				
					<span class="spanStyle" style="display:none;" id="blogUp2">
					<input id="UpimgInp2" class="form-control" type="file" name="file" onchange="readURLS(this);" style="position: absolute; margin-left: 10px; width: 62px;height: 120px;filter:alpha(opacity=0); opacity:0; -moz-opacity:0; cursor: pointer;"/>
					<img id="UpdateloadedImg2" src="${root }/images/blogWrite/noImage.gif" width="100" height="111" alt="your image"/> 
					<br/>
					<input type="text" class="form-control" name="comment" style="width:100px;"placeholder="예)최고에요"/>
					</span>
				
					<span class="spanStyle" style="display:none;" id="blogUp3">
					<input id="UpimgInp3" class="form-control" type="file" name="file" onchange="readURLS(this);" style="position: absolute; margin-left: 10px; width: 62px;height: 120px;filter:alpha(opacity=0); opacity:0; -moz-opacity:0; cursor: pointer;"/>
					<img id="UpdateloadedImg3" src="${root }/images/blogWrite/noImage.gif" width="100" height="111" alt="your image"/> 
					<br/>
					<input type="text" class="form-control" name="comment" style="width:100px;" placeholder="예)최고에요"/>
					</span>
				
					<span class="spanStyle" style="display:none;" id="blogUp4">
					<input id="UpimgInp4" class="form-control" type="file" name="file" onchange="readURLS(this);" style="position: absolute; margin-left: 10px; width: 62px;height: 120px;filter:alpha(opacity=0); opacity:0; -moz-opacity:0; cursor: pointer;"/>
					<img id="UpdateloadedImg4" src="${root }/images/blogWrite/noImage.gif" width="100" height="111" alt="your image"/> 
					<br/>
					<input type="text" class="form-control" name="comment" style="width:100px;" placeholder="예)최고에요"/>
					</span>
			</div>
			
			<!-- DB로 보낼 이미지 명칭 -->
			<div id="UPloadImg_hidden">
					<input type="hidden" name="UphiddenImg"/>
					<input type="hidden" name="UphiddenImg"/>
					<input type="hidden" name="UphiddenImg"/>
					<input type="hidden" name="UphiddenImg"/>
					<input type="hidden" name="UphiddenImg"/>
			</div>
			
			<div class="form-group form-group-sm" id="blogUpdateGrade">		<!-- 크기 조절을 하기 위한 기본 틀 -->
				<div class="col-md-2 col-sm-2 col-xs-2"><label class="control-label" for="formGroupInputSmall">평점</label></div> 
				
				<div class="col-md-8 col-sm-8 col-xs-8">
					<input type="radio" name="board_grade" value="0"/><img src="${root }/css/images/star0.jpg" width="100" height="20"/><br /> 
					<input type="radio" name="board_grade" value="1"/><img src="${root }/css/images/star1.jpg" width="100" height="20"/><br /> 
					<input type="radio" name="board_grade" value="2"/><img src="${root }/css/images/star2.jpg" width="100" height="20"/><br /> 
					<input type="radio" name="board_grade" value="3"/><img src="${root }/css/images/star3.jpg" width="100" height="20"/><br /> 
					<input type="radio" name="board_grade" value="4"/><img src="${root }/css/images/star4.jpg" width="100" height="20"/><br />
					<input type="radio" name="board_grade" value="5"/><img src="${root }/css/images/star5.jpg" width="100" height="20"/><br />
				</div>
			</div>	
		
			<div class="form-group form-group-sm" style="text-align: right;">
				<div class="col-md-10 col-sm-10 col-xs-10">	
					<div style="display: inline-block; margin-right: 15px;">
						<input type="button" class="btn btn-primary" id="blogUpdateButton" value="수정"/>		
					</div>
				</div>
			</div>		
		</div>		
	</div>
</form>
</body>
</html>