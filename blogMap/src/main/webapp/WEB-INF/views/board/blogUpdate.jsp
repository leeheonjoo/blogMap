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
	//이미지 미리보기
	$(function(){
		
/* 네이버 스마트 에디터(크기,색상,글꼴 등) */
		
	
		
		
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

	    //file 양식으로 이미지를 선택(값이 변경) 되었을때 처리하 는 코드
	    $('input[type=file]').click(function() {
	    	var fileId=$(this).attr('id');
	    	var index=fileId.substring(6,7);
	    		$("#"+fileId).change(function(){
	    	        if(this.value==""||this.value==null){
	    	        	  $('#UpdateloadedImg'+index).attr('src', e.target.result);
	    	        }
	    	        readURLS(this,index);
	    	    });
	    });
	    
	    //이미지 수에 따른 display 변화
	    $("#blogUpdateattach > #imageAttach").click(function() {
			var imageSelect=$("#blogUpdateattach > #imageAttach option:selected").val();
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

<form name="blogUpdateForm" action="${root }/board/blogUpdateOk" method="POST" id="up_frm" enctype="multipart/form-data">
<div>
	<input id="blogUpdateFile_no" type="hidden" name="file_nos"/>
	<input id="blogUpdateBoard_no" type="hidden" name="board_no"/>
	<div id="blogUpdateSelect">
		<label>카테고리:</label> 
		<select id="headCategory" name="category_mname" class="selectpicker" data-width="140px" style="display: none" onchange="blogWrite_ChangeCategory(this.id)">
			<option value="%">대분류[전체]</option>
		</select> 
		<select id="detailCategory" name="category_sname"  class="selectpicker" data-width="140px" style="display: none">
			<option value="%">소분류[전체]</option>
		</select>
	</div>
	<div >
		<label>작성자:</label> 
		<%-- <input type="text" name="writer" value="${member.id }"/> --%>
		<input type="text" name="member_id"  disabled="disabled"/>
		<input type="hidden" name="member_id" />
	</div>
	<div id="blogUpdateAddr">
		<label>위치검색:</label> 
		<input type="text" id="Upaddr" name="addrress" value="" placeholder="예)미정국수" /> 
		<a data-toggle="modal" href="#blogWriteSub" class="btn btn-primary" onclick="mapSearch();">위치검색</a>
		<input type="hidden" name="addr_sido"/>
		<input type="hidden" name="addr_sigugun"/>
		<input type="hidden" name="addr_dongri"/>
		<input type="hidden" name="addr_bunji"/>
		<br/>
		<label>업체,여행지명:</label>
		<input type="text" name="addr_title" size="40" disabled="disabled"/>
		<input type="hidden" name="addr_title"/>
		<br/>
		<label>주소:</label>
		<input type="text" name="realAddr" size="40" disabled="disabled"/>
	</div>
	<div id="blogUpdateTitle">
		<label>제목:</label>
		<input type="text" name="board_title" size="70"/>
	</div>
	<div id="blogUpdateContent">
		<label>내용:</label>
		<textarea name="board_content" id="Upboard_content"  rows="10" cols="100" style="width:766px; height:200px;"></textarea>
	</div>
	<div id="blogUpdateattach">
		<label>첨부파일|코멘트:</label>
		<select id="imageAttach">
			<option value="0">이미지 첨부 갯수</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
		</select>
		<br/>
		<span class="spanStyle" style="display:none;">
		<input id="imgInp0" type="file" name="file" onchange="readURLS(this);" style="position: absolute; margin-left: 10px; width: 62px;height: 120px;filter:alpha(opacity=0); opacity:0; -moz-opacity:0; cursor: pointer;"/>
		<img id="UpdateloadedImg0" src="${root }/images/blogWrite/noImage.gif" width="100" height="111" alt="your image"/> 
		<br/>
		<input type="text" name="comment" style="width:100px;" placeholder="예)최고에요"/>
		</span>
		<span class="spanStyle" style="display: none;">
		<input id="imgInp1" type="file" name="file" onchange="readURLS(this);" style="position: absolute; margin-left: 10px; width: 62px;height: 120px;filter:alpha(opacity=0); opacity:0; -moz-opacity:0; cursor: pointer;"/>
		<img id="UpdateloadedImg1" src="${root }/images/blogWrite/noImage.gif" width="100" height="111" alt="your image"/> 
		<br/>
		<input type="text" name="comment" style="width:100px;" placeholder="예)최고에요"/>
		</span>
		<span class="spanStyle" style="display: none;">
		<input id="imgInp2" type="file" name="file" onchange="readURLS(this);" style="position: absolute; margin-left: 10px; width: 62px;height: 120px;filter:alpha(opacity=0); opacity:0; -moz-opacity:0; cursor: pointer;"/>
		<img id="UpdateloadedImg2" src="${root }/images/blogWrite/noImage.gif" width="100" height="111" alt="your image"/> 
		<br/>
		<input type="text" name="comment" style="width:100px;"placeholder="예)최고에요"/>
		</span>
		<span class="spanStyle" style="display: none;">
		<input id="imgInp3" type="file" name="file" onchange="readURLS(this);" style="position: absolute; margin-left: 10px; width: 62px;height: 120px;filter:alpha(opacity=0); opacity:0; -moz-opacity:0; cursor: pointer;"/>
		<img id="UpdateloadedImg3" src="${root }/images/blogWrite/noImage.gif" width="100" height="111" alt="your image"/> 
		<br/>
		<input type="text" name="comment" style="width:100px;" placeholder="예)최고에요"/>
		</span>
		<span class="spanStyle" style="display: none;">
		<input id="imgInp4" type="file" name="file" onchange="readURLS(this);" style="position: absolute; margin-left: 10px; width: 62px;height: 120px;filter:alpha(opacity=0); opacity:0; -moz-opacity:0; cursor: pointer;"/>
		<img id="UpdateloadedImg4" src="${root }/images/blogWrite/noImage.gif" width="100" height="111" alt="your image"/> 
		<br/>
		<input type="text" name="comment" style="width:100px;" placeholder="예)최고에요"/>
		</span>
	</div>
	
	<div id="blogUpdateGrade">
		<label>평점</label><br/> 
		<input type="radio" name="board_grade" value="0"/><img src="${root }/css/images/star0.jpg" width="100" height="20"/><br /> 
		<input type="radio" name="board_grade" value="1"/><img src="${root }/css/images/star1.jpg" width="100" height="20"/><br /> 
		<input type="radio" name="board_grade" value="2"/><img src="${root }/css/images/star2.jpg" width="100" height="20"/><br /> 
		<input type="radio" name="board_grade" value="3"/><img src="${root }/css/images/star3.jpg" width="100" height="20"/><br /> 
		<input type="radio" name="board_grade" value="4"/><img src="${root }/css/images/star4.jpg" width="100" height="20"/><br />
		<input type="radio" name="board_grade" value="5"/><img src="${root }/css/images/star5.jpg" width="100" height="20"/><br />
	</div>

	 <!-- 하단 버튼 -->
	<div align="right">
		<input type="button" id="blogUpdateButton" value="수정"/>
	</div>
	
</div>	

</form>
</body>
</html>