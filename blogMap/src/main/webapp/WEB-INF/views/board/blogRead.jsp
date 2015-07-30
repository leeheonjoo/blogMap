<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!-- test를 위해 ID 입력 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${root }/css/board/imageSlide.css"/>
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
	//전역변수
	var obj=[];
	
	//댓글입력 버튼 클릭시 
	$("span[class='glyphicon glyphicon-ok']").click(function() {
		if(email==""||email==null){
			alert("로그인후 댓글이용 해주세요.");
			$("#replyInsert").val("");
			return false;
		}
		var replyConent = $("#replyInsert").val();
		$("#replyInsert").val("");
	
		if(replyConent!=""){
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
								
								/* $("#listAllDiv").append($("#reply_content_insert").clone());
								$("#listAllDiv > #reply_content_insert").css("display","block");
								$("#listAllDiv > #reply_content_insert").attr("id","reply_content_insert"+i);
					
								$("#reply_content_insert"+i+" > span:eq(0)").text(replyNo);
				                $("#reply_content_insert"+i+" > span:eq(1)").css("font-weight","bold").text(memberId);
				                $("#reply_content_insert"+i+" > span:eq(2)").text(replyfullDate); 
				                $("#reply_content_insert"+i+" > input:eq(0)").val(replyContent);
								$("#reply_content_insert"+i+" > span:eq(3)").attr("id","reply_buttons"+i);
								
								$("#reply_buttons"+i+" > button:eq(0)").attr("id","reply_content_update"+i);
								$("#reply_buttons"+i+" > button:eq(1)").attr("id","reply_content_delete"+i); */
								
								
								var asdf098="<br/><hr style='width: 95%;'>";
			                    
			                    $("#listAllDiv").append($("#reply_content_insert").clone());
			                    $("#listAllDiv > #reply_content_insert").css("display","block");
			                    $("#listAllDiv > #reply_content_insert").attr("id","reply_content_insert"+i);
			                    $("#reply_content_insert"+i+" > span:eq(0)").text(replyNo);
			                    $("#reply_content_insert"+i+" > span:eq(1)").css("font-weight","bold").text(memberId);
			                    $("#reply_content_insert"+i+" > span:eq(2)").text(replyfullDate); 
			                	$("#reply_content_insert"+i+" > input:eq(0)").val(replyContent);
			                    $("#reply_content_insert"+i+" > span:eq(3)").attr("id","reply_buttons"+i);
								$("#reply_buttons"+i+" > button:eq(0)").attr("id","reply_content_update"+i);
								$("#reply_buttons"+i+" > button:eq(1)").attr("id","reply_content_delete"+i);
								$("#listAllDiv:last-child").append(asdf098); 
								
								if(email!=memberId){
									$("#reply_buttons"+i+" > button:eq(0)").css("display","none");
									$("#reply_buttons"+i+" > button:eq(1)").css("display","none");
								}else{
									$("#reply_buttons"+i+" > button:eq(0)").css("display","");
									$("#reply_buttons"+i+" > button:eq(1)").css("display","");
									
								}	
			                    
								 
							});
							
						},error: function(data){
						}	
					});
				}
			},
			error:function(data){
			}
			
		});
		}else{
			alert("NULL값으로 입력해주세요.");			
		}
	});
	
	/*추천 기능*/
	$("#blog_reference").click(function() {
		if(email==""||email==null){
			alert("로그인후 이용해주세요.");
			return false;
		}
		
		alert("추천 클릭하였습니다.");
		var boardNo=$("#blogRead_boardno > label:eq(0)").text()
		$.ajax({
					type:'post',
					url:'${root}/board/blogReadReference.do',
					data:{
						board_no:boardNo,
						member_id:email
					},
					contentType:'application/x-www-form-urlencoded;charset=UTF-8',
					success : function(data) {
						$.ajax({
							type:'post',
							url:'${root}/board/blogReadDetail.do',
							data:{
								board_no:boardNo
							},
							contentType:'application/x-www-form-urlencoded;charset=UTF-8',
							success : function(data) {
								var data=JSON.parse(data);
								
								var recommand_y=data[0].YES;
                                var recommand_n=data[0].NO;
                                $("#blog_reference_count").empty();
                                $("#blog_noreference_count").empty();
                                $("#blog_reference_count").html("<b style='color:blue;'>"+recommand_y+"</b>");
                                $("#blog_noreference_count").html("<b style='color:red;'>"+recommand_n+"</b>");
								
							},
							error: function(data) {
								
							}
						});
					},
					error: function(data) {
						
					}
				});
	})
	
	/*비추천 기능 */
	$("#blog_noreference").click(function() {
		if(email==""||email==null){
			alert("로그인후 이용해주세요.");
			return false;
		}
		
		alert("비추천 클릭하였습니다.");
		var boardNo=$("#blogRead_boardno > label:eq(0)").text()
		$.ajax({
					type:'post',
					url:'${root}/board/blogReadNoreference.do',
					data:{
						board_no:boardNo,
						member_id:email
					},
					contentType:'application/x-www-form-urlencoded;charset=UTF-8',
					success : function(data) {
						$.ajax({
							type:'post',
							url:'${root}/board/blogReadDetail.do',
							data:{
								board_no:boardNo
							},
							contentType:'application/x-www-form-urlencoded;charset=UTF-8',
							success : function(data) {
								var data=JSON.parse(data);
								
								var recommand_y=data[0].YES;
                                var recommand_n=data[0].NO;
                                $("#blog_reference_count").empty();
                                $("#blog_noreference_count").empty();
                                $("#blog_reference_count").html("<b style='color:blue;'>"+recommand_y+"</b>");
                                $("#blog_noreference_count").html("<b style='color:red;'>"+recommand_n+"</b>");
								
							},
							error: function(data) {
								
							}
						});
							
					
					},
					error: function(data) {
						
					}
				});
	})
	
	/* 즐겨찾기 기능 */
	$("#blogBookmark").click(function() {
		if(email==""||email==null){
			alert("로그인후 이용해주세요.");
			return false;
		}
		
		var transImage=$("#blogBookmark > img").attr("src");
		if(transImage=="${root}/images/blogMap/Bookmark1.png"){
			alert("즐겨찾기 추가 되었습니다.");
			$("#blogBookmark > img").attr("src","${root}/images/blogMap/Bookmark0.png");
			var boardNo=$("#blogRead_boardno > label:eq(0)").text();
			
			$.ajax({
				type:'post',
				url:'${root}/board/bookMark.do',
				data:{
					board_no: boardNo,
					member_id: email
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success : function(data) {
					
				},
				error: function(data) {
					
				}
			});
		}else{
			alert("즐겨찾기 해제 되었습니다.");
			var boardNo=$("#blogRead_boardno > label:eq(0)").text();
			$("#blogBookmark > img").attr("src","${root}/images/blogMap/Bookmark1.png");
			$.ajax({
				type:'post',
				url:'${root}/board/NobookMark.do',
				data:{
					board_no: boardNo,
					member_id: email
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success : function(data) {
					 
				},
				error: function(data) {
					
				}
			});
		}
	})
	/*목록보기 기능*/
	$("#Listbutton").click(function() {
		
	})
	
	/*삭제 기능*/
	$("#Debutton").click(function() {
		if(confirm("정말 삭제하시겠습니까??") == true){
		var boardNo=$("#blogRead_boardno > label:eq(0)").text();
		$.ajax({
			type:'post',
			url:'${root}/board/blogDelete.do',
			data:{
				board_no: boardNo,
				member_id: email
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success : function(data) {
				alert("삭제성공")
				location.href="${root}/";
			},
			error: function(data) {
				
			}
		})
		}else{
			return;
		}
	});
	/* 수정 기능 */
	$("#Upbutton").click(function() {
		 var boardNo=$("#blogRead_boardno > label:eq(0)").text();
			$.ajax({
				type:'post',
				url:'${root}/board/blogUpdate.do',
				data:{
					board_no: boardNo
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success : function(data) {
					var data=JSON.parse(data);
					var file_no="";
					var board_content="";
					$.each(data,function(i){
						var file_size=data[i].FILE_SIZE;
						var file_path=data[i].FILE_PATH;
						var file_name=data[i].FILE_NAME;
						var file_comment=data[i].FILE_COMMENT;
						
						if(data[i].FILE_NO==undefined){
							$("#blogUpdateattach option:eq(0)").attr("selected","selected");
					 		$("#blogUpdateattach #blogUp0").css("display","none");
							$("#blogUpdateattach #blogUp1").css("display","none");
							$("#blogUpdateattach #blogUp2").css("display","none");
							$("#blogUpdateattach #blogUp3").css("display","none");
							$("#blogUpdateattach #blogUp4").css("display","none");
						}else{
							$("#blogUpdateattach option:eq("+(i+1)+")").attr("selected","selected");
							$("#blogUpdateattach #blogUp"+i).css("display","");
							$("#blogUpdateattach #blogUp"+i+" input[name='comment']" ).val(file_comment);
							if(file_name==undefined||file_name==null||file_name==""){
								$("#UpdateloadedImg"+i).attr("src","${root }/images/blogWrite/noImage.gif");
								$("#UPloadImg_hidden >input:eq("+i+")").val("");
							}else{
								$("#UpdateloadedImg"+i).attr("src","${root}/pds/board/"+file_name);
								$("#UPloadImg_hidden >input:eq("+i+")").val(file_name);
							}
						}
						
						file_no+=data[i].FILE_NO+",";
						
						
						
						var category_code=data[i].CATEGORY_CODE;
						var category_mname=data[i].CATEGORY_MNAME;
						var category_sname=data[i].CATEGORY_SNAME;
						
						var addr_bunji=data[i].ADDR_BUNJI;
						var addr_sido=data[i].ADDR_SIDO;
						var addr_sigugn=data[i].ADDR_SIGUGUN;
						var addr_dongri=data[i].ADDR_DONGRI;
						var addr_title=data[i].ADDR_TITLE;
						
						var board_no=data[i].BOARD_NO;
						var board_grade=data[i].BOARD_GRADE;
						board_content=data[i].BOARD_CONTENT;
						var board_title=data[i].BOARD_TITLE;
						var board_rgdate=data[i].BOARD_RGDATE;
						
						$("#blogUpdateAddr input[name='addr_sido']").val(addr_sido);
						$("#blogUpdateAddr input[name='addr_sigugun']").val(addr_sigugn);
						$("#blogUpdateAddr input[name='addr_dongri']").val(addr_dongri);
						$("#blogUpdateAddr input[name='addr_bunji']").val(addr_bunji);
						$("#blogUpdateAddr input[name='addr_title']").val(addr_title);
						$("#blogUpdateAddr input[name='realAddr']").val(addr_sido+" "+addr_sigugn+" "+addr_dongri+" "+addr_bunji);
						
						$("#blogUpdateTitle input[name='board_title']").val(board_title);
						//$("#Upboard_content").html(board_content);
						
						if(board_grade=="0"){
							$("#blogUpdateGrade input:eq(0)").attr("checked","checked");
						}else if(board_grade=="1"){
							$("#blogUpdateGrade input:eq(1)").attr("checked","checked");
						}else if(board_grade=="2"){
							$("#blogUpdateGrade input:eq(2)").attr("checked","checked");
						}else if(board_grade=="3"){
							$("#blogUpdateGrade input:eq(3)").attr("checked","checked");
						}else if(board_grade=="4"){
							$("#blogUpdateGrade input:eq(4)").attr("checked","checked");
						}else{
							$("#blogUpdateGrade input:eq(5)").attr("checked","checked");
						}
						
						$("#blogUpdateBoard_no").val(board_no);
						$("#blogUpdateFile_no").val(file_no);
								
						/* var option_length=$("#blogUpdateSelect > #headCategory option").length;
						
						for (var j = 0; j < option_length; j++) {
							var option_value=$("#blogUpdateSelect > #headCategory option:eq("+j+")").val();
							if(option_value==category_mname){
								$("#blogUpdateSelect > #headCategory option:eq("+j+")")attr('selected', 'selected');
							}
						} */
					});
					$("#blogUpdateFile_no").val(file_no);
					$("#blogUpdateContent iframe").remove();
					
					//스마트에디터 프레임생성
					nhn.husky.EZCreator.createInIFrame({
						oAppRef:obj,
						elPlaceHolder:"Upboard_content",
						sSkinURI:"${root}/editor/SmartEditor2Skin.html",
						htParams:{
							//툴바 사용 여부(true:사용/false:사용하지 않음)
							bUseToolbar:true,
							//입력창 크기 조절바 사용 여부(true:사용/false:사용하지 않음)
							bUseVerticalResizer:true,
							//모드 탭(Editor|HTML|TEXT) 사용 여부 (true:사용/false:사용하지 않음)
							bUseModeChanger:true
						},
						fOnAppLoad:function(){
							var spa=board_content;
							//id가 smarteditor인 textarea에 에디터에서 대입
							obj.getById["Upboard_content"].exec("PASTE_HTML",[spa]);
						},
						fCreator:"createSEditor2"
					});
					

				},
				error: function(data) {
					
				}
			})
			
			
	});
	$("#blogUpdateButton").click(function() {
		
		/* 유효성 검사 */
		if($("#blogUpdateSelect  #headCategory option:selected").val()=="%"){
			alert("대분류 카테고리를 여행,음식 중 선택해주세요.");
			return false;
		}
		
		
		if(!$("#blogUpdateTitle input[name='board_title']").val()){
			alert("제목을 입력하세요.");
			$("#blogUpdateTitle input[name='board_title']").focus();
			return false;
		}

		
		
		var select_value=$("#blogUpdateattach option:selected").val();
		if(select_value!="0"){
		var int_select_value=parseInt(select_value);
		for (var i = 0; i < int_select_value; i++) {
				if($("#blogUpdateattach > span:eq("+i+") > input:eq(1)").val()==""){
					alert("첨부이미지에 대한 간단한 코멘트를 입력해주세요.");
					return false;
				}
				if($("#blogUpdateattach > span:eq("+i+") > input[type='file']").val()==""){
					alert("첨부할 이미지를 추가해주세요.");
					return false;
				}
			}
		}
		
		if(!($("input[type='radio']").is(":checked"))){
			alert("평점을 선택해주세요.")
			return false;
		}
		
		obj.getById["Upboard_content"].exec("UPDATE_CONTENTS_FIELD",[]);
		$("#up_frm").submit();
	});	
	
	
	/* $("#coupon_issue_btn").click(function(){
		
		//alert("보드넘버"+$("#blogRead_boardno label").text());
	}); */
	
	/*닫기버튼 클릭시*/
	$("#read_closeButton").click(function () {
		$("#listAllDiv").empty();
		$("#read_div label").text("");
		$("#blogRead_content div").html("");
        $("#carousel_page").empty();
        $("#carousel_image .active").empty();
	/* 	var image_child=$("#carousel_image").children();
		
		for(var i=1; i<image_child; i++){
			$("#carousel_page > li:eq("+i+")").remove();
			$("#carousel_image > div:eq("+i+")").remove();
		}
		$("#carousel_page > li:eq(0)").attr("class","active");
		$("#carousel_image > div:eq(0)").attr("class","item active");
		$("#carousel_image > div:eq(0)").find('img').attr("src","");
		$("#carousel_image > div:eq(0)").find('div').empty(); */
		
		
	});
	
});
function reply_update(UThis) { 
	var updateId=$(UThis).attr("id");
	var index=updateId.substring(20,21);
	var replyNo=$("#reply_content_insert"+index+" > span:eq(0)").text();
	
	
	var member_id=$("#reply_content_insert"+index+" > span:eq(1)").text();
	var reply_Upcontent=$("#reply_content_insert"+index+" > input:eq(0)").val();
	
	
	/* $("#reply_content_insert"+index).append("<span id='upBunho"+index+"'></span>");
	$("#upBunho"+index).append("<input id='newText' type='text' value='" + reply + "'/>");
	$("#upBunho"+index).append("<input type='button' value='수정' id='up"+index+"'/>");
	$("#upBunho"+index).append("<input type='button' value='취소' id='cancel"+index+"'/>"); */
	
	
		if($("#reply_content_update"+index).text()=='수정'){
			$("#reply_content_insert"+index+" > input:eq(0)").removeAttr("disabled");
			$("#reply_content_insert"+index+" > input:eq(0)").css("background-color","white");
			$("#reply_content_insert"+index+" > input:eq(0)").focus();
			$("#reply_content_update"+index).text("수정완료");
		}else if($("#reply_content_update"+index).text()=='수정완료'){
			$.ajax({
				type : 'post',
				url : '${root}/board/blogReadReplyUpdate.do',
				data : {
					reply_no : replyNo,
					reply_content: reply_Upcontent,
					member_id: member_id
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success : function(data) {
					if(data!="0"){
						alert("댓글 수정완료");
						$("#reply_content_insert"+index+" > input:eq(0)").attr("disabled","disabled");
						$("#reply_content_insert"+index+" > input:eq(0)").css("background-color","#eee");
						$("#reply_content_update"+index).text("수정");
						
					}
					
				},
				error: function(data) {
					
				}
			})   
		}
		
		
		
		 
	
	
	
	// carousel 호출
	$('.carousel').carousel({
		interval : 3000
	})
}
function reply_delete(DThis) {
	
	var deleteId=$(DThis).attr('id');
	var index=deleteId.substring(20,21);
	if($("#reply_content_update"+index).text()=='수정'){
		var replyNo=$("#reply_content_insert"+index+" > span:eq(0)").text();
		
		var member_id=$("#reply_content_insert"+index+" > span:eq(1)").text();
	
	if (confirm("정말 삭제하시	겠습니까??") == true){ //확인
		$.ajax({
			type : 'post',
			url : '${root}/board/blogReadReplyDelete.do',
			data : {
				reply_no : replyNo,
				member_id: member_id
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success : function(data) {
				if(data!="0"){
					alert("댓글삭제완료");
					$("#reply_content_insert"+index).remove();
				}
			},
			error: function(data) {
				
			}
		}) 
	}else{ //취소
		return;
	}
	
	}

}
</script>
</head>
<body>
	<div class="col-md-1 col-sm-1 col-xs-1"></div>
	<div class="col-md-10 col-sm-10 col-xs-10">
		<div id="read_div">
			<div class="row" style="height:35px; border-bottom:1px solid #e5e5e5;">
				<div id="blogReadBox" class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="height:100%;">
					<!-- 업체명 -->
					<div id="blogRead_addrtitle" class="form-group form-group-sm" style="display:inline-block; float:left; height:100%;"></div>
					<!-- 카테고리 -->
					<div id="blogRead_category" class="form-group form-group-sm" style="display:inline-block; float:left; height:100%;"></div>
					<!-- 제목 -->
					<div id="blogRead_title" class="form-group form-group-sm" style="display:inline-block; float:left; height:100%;"></div>
			
					<!-- 작성일 -->
					<div id="blogRead_rgdate" class="form-group form-group-sm" style="display:inline-block; float:right; height:100%;"></div>
					<!-- 작성자 -->
					<div id="blogRead_writer" class="form-group form-group-sm" style="display:inline-block; float:right; height:100%;"></div>
				</div>
			</div>
			
			<div class="row" style="height:25px;">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="height:100%;">
					<!-- 주소 -->
					<div id="blogRead_addr" class="form-group form-group-sm" style="float:left; height:100%;"></div>
				</div>
			</div>
			<br/>
			
			<div id="blogRead_boardno" style="display: none;">
					<label></label>
			</div>
		</div>
		<br/>
		
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="height:100%;">
				<div id="blogRead_content" class="form-group form-group-sm" style="float:left;" style="float:left;">
					<div></div>
				</div>
			</div>
		</div>
		<br/>
	</div>
	
	<!-- 이미지 슬라이드 -->
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="height:100%;">
			<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
			  <!-- Indicators -->
			  <ol id="carousel_page" class="carousel-indicators">
			    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
			  </ol>
			
			  <!-- Wrapper for slides -->
			  <div id="carousel_image" class="carousel-inner" role="listbox">
			    <div class="item active">
			      <img src="" alt="...">
			      <div class="carousel-caption"></div>
			    </div>
			  </div>
			</div>
		</div>
	</div>
<br/><br/>

	<div id="blogRead_grade">
		<div style="font-weight: bold;">평점</div>
		<img src="" width="100" height="20"/>
	</div>
	<br/>
	<!-- 추천 /비추천 -->
	<span id="blog_reference">
	<img src="${root}/images/blogMap/reference0.jpg">
	<span id="blog_reference_count"></span>
	</span>
	<span id="blog_noreference">
	<img src="${root}/images/blogMap/reference1.jpg">
	<span id="blog_noreference_count"></span>
	</span>
	<span id="blogBookmark"><img src="${root}/images/blogMap/Bookmark1.png"/><b style="color: #03A9F4;">즐겨찾기</b></span>
	&nbsp;&nbsp;&nbsp;&nbsp;<span><img src="${root}/images/blogMap/coupon_img.png" id="coupon_issue_btn" style="width:80px;"/></span>
	<br/>
	<div id="blogRead_reply">
        <div class="input-group row form-group" style="margin: auto; width: 95%;">
            <input id="replyInsert" type="text" class="form-control" placeholder="답글 입력란">
            <span class="input-group-addon success"><span class="glyphicon glyphicon-ok"></span></span>
        </div>
        <div id="blogRead_reply_content" class="form-group form-group-sm" style="border: 1bpx; border-color: black;">
		<div id="reply_content_insert" class="replyDiv" style="display:none; width: 95%;">   <!-- div를 통해 한번에 삭제하기위함,, 자식들도 삭제되므로! -->
			<span style="display: none;  margin-left: 15px"></span>
			<span style="text-align: left;  margin-left: 15px"></span>
		    <span style="float: right;  margin-left: 15px" ></span>
			<input type="text" name="readReplyInsertContent" disabled="disabled" style="width: 80%; height:30px;padding: 5px 10px;font-size: 12px;line-height: 1.5;border-radius: 3px;  background-color: #eee;opacity: 1; border: 0px;  margin-left: 15px">
			<span>
				<button onclick="reply_update(this)">수정</button>
				<button onclick="reply_delete(this)">삭제</button>
			</span>
		</div>
		
		<hr style="width: 95%"/>
		
		<div id="listAllDiv">
			
	</div>
        </div>
        
    </div>
	
	
	 <!-- 하단 버튼 -->
	<div class="form-group form-group-sm" style="text-align: right;">
		<a data-toggle="modal" href="#blogMapUpdate" class="btn btn-primary" id="Upbutton">수정</a>
		<input type="button" class="btn btn-primary" id="Debutton" value="삭제" /> 
	</div>
	</div>
	<div class="col-md-1 col-sm-1 col-xs-1"></div>

</body>
</html>
