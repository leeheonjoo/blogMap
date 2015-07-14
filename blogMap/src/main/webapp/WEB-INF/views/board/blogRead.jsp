<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!-- test를 위해 ID 입력 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${root}/css/board/boardCarousel.css"/>
<style type="text/css">
.input-group-addon.primary {
    color: rgb(255, 255, 255);
    background-color: rgb(50, 118, 177);
    border-color: rgb(40, 94, 142);
}
.input-group-addon.success {
    color: rgb(255, 255, 255);
    background-color: rgb(92, 184, 92);
    border-color: rgb(76, 174, 76);
}
.input-group-addon.info {
    color: rgb(255, 255, 255);
    background-color: rgb(57, 179, 215);
    border-color: rgb(38, 154, 188);
}
.input-group-addon.warning {
    color: rgb(255, 255, 255);
    background-color: rgb(240, 173, 78);
    border-color: rgb(238, 162, 54);
}
.input-group-addon.danger {
    color: rgb(255, 255, 255);
    background-color: rgb(217, 83, 79);
    border-color: rgb(212, 63, 58);
}
.replyDiv{	
	width:800px;height:30px; 
	border:solid 0px red;
	margin:4px 0px 0px 4px;
}

.cssBunho {
	border:solid 0px blue;
	display:block;
	float:left;
}


.cssReply {
	border:solid 0px blue;
	display:block;
	float:left;
}

.cssUpDel {
	border:solid 0px blue;
	display:block;
	float:left;
}
</style>

<script type="text/javascript" src="${root }/css/replyWrite.js"></script>
<script type="text/javascript" src="${root }/css/replyDelete.js"></script>
<script type="text/javascript" src="${root }/css/replyUpdate.js"></script>
<script type="text/javascript">
$(function() {
	var email=sessionStorage.getItem('email');
	
	$("#ggd").click(function() {
		alert("하하");
		$('[data-toggle="confirmation"]').confirmation(title);
	})
	
	
	$("span[class='glyphicon glyphicon-ok']").click(function() {
		var replyConent = $("#replyInsert").val();
		$("#replyInsert").val("");
		if(replyConent!=""){
		alert(replyConent);
		alert(email);
		var boardno=$("#blogRead_boardno > label:eq(0)").text();
		$.ajax({
			type : 'post',
			url : '${root}/board/blogWriteReply.do',
			data : {
				board_no : boardno,
				reply_content: replyConent,
				reply_member_id: email
				
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success : function(data) {
				if(data!="0"){
					$("#listAllDiv").empty();
					$.ajax({
						type : 'post',
						url : '${root}/board/blogReadReply.do',
						data : {
							board_no : boardno
						},
						contentType:'application/x-www-form-urlencoded;charset=UTF-8',
						success : function(data) {
							var data=JSON.parse(data);
							$.each(data,function(i){
								var replyNo=data[i].reply_no;
								var boardNo=data[i].board_no;
								var memberId=data[i].member_id;
								var replyContent=data[i].reply_content;
								var replyDate=new Date(data[i].reply_date);
								var replyfullDate=replyDate.getFullYear()+"/"+(replyDate.getMonth()+1)+"/"+replyDate.getDate();
								
								$("#listAllDiv").append($("#reply_content_insert").clone());
								$("#listAllDiv > #reply_content_insert").css("display","block");
								$("#listAllDiv > #reply_content_insert").attr("id","reply_content_insert"+i);
								$("#reply_content_insert"+i+" > span:eq(0)").text(replyNo);
								$("#reply_content_insert"+i+" > span:eq(1)").text(memberId);
								$("#reply_content_insert"+i+" > span:eq(2)").text(replyContent);
								$("#reply_content_insert"+i+" > span:eq(3)").text(replyfullDate);
								
							});
						},error: function(data) {
							
						}
							
					})
				}
			},
			error:function(data){
				
			}
		})
		}else{
			alert("NULL값으로 입력해주세요.");			
		}
})
	
});
function replyUpdate() {
	var a=$(this).text();
	alert(a);
}

</script>
</head>
<body>
	<div id="blogRead_boardno" style="display: none;">
		<label></label>
	</div>		
	<div id="blogRead_rgdate">
		<label>작성일:</label>
		<label></label>
	</div>
	<div id="blogRead_category">
		<label>카테고리:</label> 
		<label></label> |
		<label></label>
	</div>
	<div id="blogRead_writer">
		<label>작성자:</label> 
		<label></label>
	</div>
	<div id="blogRead_addr">
		<label>주소:</label>
		<label></label>
	</div>
	<div id="blogRead_title">
		<label>제목:</label>
		<label></label>
	</div>
	
<section class="awSlider">
  <div  class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target=".carousel" data-slide-to="0" class="active"></li>
      <li data-target=".carousel" data-slide-to="1"></li>
      <li data-target=".carousel" data-slide-to="2"></li>
      <li data-target=".carousel" data-slide-to="3"></li>
      <li data-target=".carousel" data-slide-to="4"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
      <div class="item active">
        <img src="${root }/css/board/images/no_detail_img.gif">
        <div class="carousel-caption">Görsel #1</div>
      </div>
      <div class="item">
        <img src="">
        <div class="carousel-caption">Görsel #2</div>
      </div>
      <div class="item">
        <img src="">
        <div class="carousel-caption">Görsel #3</div>
      </div>
      <div class="item">
        <img src="">
        <div class="carousel-caption">Görsel #4</div>
      </div>
      <div class="item">
        <img src="">
        <div class="carousel-caption">Görsel #5</div>
      </div>
    </div>

    <!-- Controls -->
    <a class="left carousel-control" href=".carousel" role="button" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
      <span class="sr-only">Geri</span>
    </a>
    <a class="right carousel-control" href=".carousel" role="button" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
      <span class="sr-only">İleri</span>
    </a>
  </div>
</section>
	
	<div id="blogRead_content">
		<label>내용:</label>
		<div></div>
	</div>
	<div style="display: none;">
	 <div id="imgHidden" class="item active">
        <div class="col-md-4">
            <a href="#"><img id="imgsrc" src="" class="img-responsive center-block"></a>
            <div class="text-center">1</div>
        </div>
    </div>
	</div>
	<div id="blogRead_grade">
		<label>평점:</label>
		<img src="" width="150" height="30"/><br /> 
	</div>
	<br/>
	<div>
	<input type="button" class="btn btn-primary" value="추천" />
	<input type="button" class="btn btn-primary" value="비추천" />
	<input type="button" class="btn btn-primary" value="즐겨찾기" />
	<input type="button" class="btn btn-primary" value="쿠폰발급" />
	</div>
	<br/>
	<div id="blogRead_reply">
		<label>답글:</label>
	   <div class="row form-group">
        <div class="input-group">
            <input id="replyInsert" type="text" class="form-control">
            <span class="input-group-addon success"><span class="glyphicon glyphicon-ok"></span></span>
        </div>
        </div>
        <div id="blogRead_reply_content" style="border: 1px; border-color: black;">
		<div id="reply_content_insert" class="replyDiv" style="display:none;">   <!-- div를 통해 한번에 삭제하기위함,, 자식들도 삭제되므로! -->
			<span style="display: none;"></span>
			<span></span>
			<span></span>
			<span></span>
			<span>
				<button>수정</button>
				<button>삭제</button>
			</span>
		</div>
	<div id="listAllDiv">
			
	</div>
        </div>
    </div>
	
	
	 <!-- 하단 버튼 -->
	<div align="right">
		<input type="button" class="btn btn-primary" id="Upbutton" value="수정" /> 
		<input type="button" class="btn btn-primary" id="Debutton" value="삭제" /> 
		<input type="button" class="btn btn-primary" value="목록" />
	</div>
	

</body>
</html>