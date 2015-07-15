/**
 * 
 */
if(sessionStorage.getItem('email')!=null){
	$(function(){
		var startPage=0; 
		var endPage=0;
		var pageBlock=1;
		
		$.ajax({
			type:'POST',
			url:'${root}/member/board_info.do',
			data:{
				member_id:sessionStorage.getItem("email")
				//member_id:"kimjh112339@naver.com"
				
			},
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			success:function(responseData){
				//alert(responseData);
				
				var data=responseData.split("|");
				/* alert(data[0]);
				alert(data[1]);
				alert(data[2]);
				alert(data[3]); */
				
				var boardSize=data[1];
				var count=data[2];
				var currentPage=data[3];
				
				var pageCount=count/boardSize+(count%boardSize==0 ? 0:1);
				//alert(pageCount);
				startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
				endPage=startPage+pageBlock-1;
				
				
				//$("#myPage_member_point_list").empty();
				//$("#myPage_member_point_list_title").append("<div><span>번호</span><span>발생일</span><span>내용</span><span>포인트</span></div>");
				//$("#myPage_member_point_list_title").append("<tr><td>번호</td><td>발생일</td><td>내용</td><td>포인트</td></tr>");
				$("#myPage_member_board_list_title").append("<div class='col-md-1'><div class='header'>게시글번호</div></div><div class='col-md-3'><div class='header'>작성일</div></div><div class='col-md-6'><div class='header'>카테고리</div></div><div class='col-md-2'><div class='header'>제목</div></div>");
				var board_data=JSON.parse(data[0]);
				
				
				$.each(board_data,function(i){
					//alert(data[i].BOARD_TITLE);
					//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
					//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
					$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
					+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+board_data[i].BOARD_RGDATE+'</code></div></div></div>'
					+'<div class="col-md-6"><div class="cell"><div class="isrequired">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
					+'<div class="col-md-2"><div class="cell"><div class="description">'+board_data[i].BOARD_TITLE+'</div></div></div></div>');
				});
				
				if(endPage>pageCount){
					endPage=pageCount;
				}
				//
				//페이징
				//$("#myPage_member_point_list_pageNum").empty();
				/* $("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
				$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
				
				//이전
				//alert("startPage"+startPage);
				//alert("pageCount"+pageCount);
				if(startPage>pageBlock){
					$("#myPage_member_board_list_before").css("display","inline-block");
				}
				
				if(startPage<=pageBlock){
					$("#myPage_member_board_list_before").css("display","none");
				}
				
				
				for(var i=startPage;i<=endPage;i++){
					$("#myPage_member_board_list_pageNum").append("<a href='#' id='board_paging_num"+i+"'>"+i+"</a>");
					$("#board_paging_num"+i).click(function(){
						//alert($(this).text());
						$.ajax({
							type:'POST',
							url:'${root}/member/board_info.do',
							data:{
								member_id:sessionStorage.getItem("email"),
								pageNumber:$(this).text()
							},
							contentType:'application/x-www-form-urlencoded;charset=UTF-8',
							success:function(responseData){
								//alert(responseData);
								
								var data=responseData.split("|");
								
								var boardSize=data[1];
								var count=data[2];
								var currentPage=data[3];
								
								$("#myPage_member_board_list_title").empty();
								$("#myPage_member_board_list_content").empty();
								$("#myPage_member_board_list_title").append("<div class='col-md-1'><div class='header'>게시글번호</div></div><div class='col-md-3'><div class='header'>작성일</div></div><div class='col-md-6'><div class='header'>카테고리</div></div><div class='col-md-2'><div class='header'>제목</div></div>");
								var board_data=JSON.parse(data[0]);
								
								
								$.each(board_data,function(i){
									//alert(data[i].BOARD_TITLE);
									//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
									//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
									$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
									+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+board_data[i].BOARD_RGDATE+'</code></div></div></div>'
									+'<div class="col-md-6"><div class="cell"><div class="isrequired">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
									+'<div class="col-md-2"><div class="cell"><div class="description">'+board_data[i].BOARD_TITLE+'</div></div></div></div>');
								});
							}
						});
					});
				}
				
				
				//alert("endPage:"+endPage);
				//alert("pageCount:"+pageCount);
				//다음
				if(endPage<pageCount){
					$("#myPage_member_board_list_after").css("display","inline-block");
					
					
				}
				
				if(endPage>=pageCount){
					$("#myPage_member_board_list_after").css("display","none");
				}
				
				
				/* alert($("#myPage_member_point_list").css("display"));
				if($("#myPage_member_point_list").css("display")=="none"){
					alert("aa");
					$("#myPage_member_point_list").css("display","block");
				}else if($("#myPage_member_point_list").css("display")=="block"){
					alert("bb");
					$("#myPage_member_point_list").css("display","none");
				} 			 */
			}			
		});
		//});
		
		//다음클릭시
		$("#board_paging_after").click(function(){
			alert("Aa");
			$.ajax({
				type:'POST',
				url:'${root}/member/board_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					//member_id:"kimjh112339@naver.com",
					pageNumber:startPage+pageBlock
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					//alert(responseData);
					
					var data=responseData.split("|");
					/* alert(data[0]);
					alert(data[1]);
					alert(data[2]);
					alert(data[3]); */
					
					var boardSize=data[1];
					var count=data[2];
					var currentPage=data[3];
					var pageBlock=1;
					var pageCount=count/boardSize+(count%boardSize==0 ? 0:1);
					alert(pageCount);
					startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					endPage=startPage+pageBlock-1;
					
					$("#myPage_member_board_list_title").empty();
					$("#myPage_member_board_list_content").empty();
					$("#myPage_member_board_list_title").append("<div class='col-md-1'><div class='header'>게시글번호</div></div><div class='col-md-3'><div class='header'>작성일</div></div><div class='col-md-6'><div class='header'>카테고리</div></div><div class='col-md-2'><div class='header'>제목</div></div>");
					var board_data=JSON.parse(data[0]);
					
					$.each(board_data,function(i){
						//alert(data[i].BOARD_TITLE);
						//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
						//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
						$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
						+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+board_data[i].BOARD_RGDATE+'</code></div></div></div>'
						+'<div class="col-md-6"><div class="cell"><div class="isrequired">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="description">'+board_data[i].BOARD_TITLE+'</div></div></div></div>');
					});
					
				/* 	$("#myPage_member_point_list_pageNum").remove();
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
					
					
					alert("다음startPage:"+startPage);
					alert("다음endPage:"+endPage);
					alert("다음pageBlock"+pageBlock)
					//이전
					if(startPage>pageBlock){
						alert("block");
						$("#myPage_member_board_list_before").css("display","inline-block");
					}
					
					if(startPage<=pageBlock){
						//alert("hidden");
						$("#myPage_member_board_list_before").css("display","none");
					}
					
					$("#myPage_member_board_list_pageNum").empty();
					for(var i=startPage;i<=endPage;i++){
						$("#myPage_member_board_list_pageNum").append("<a href='#' id='board_paging_num"+i+"'>"+i+"</a>");
						$("#board_paging_num"+i).click(function(){
							alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/board_info.do',
								data:{
									member_id:sessionStorage.getItem("email"),
									//member_id:"kimjh112339@naver.com",
									pageNumber:$(this).text()
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									//alert(responseData);
									
									var data=responseData.split("|");
									/* alert(data[0]);
									alert(data[1]);
									alert(data[2]);
									alert(data[3]); */
									
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
									
									$("#myPage_member_board_list_title").empty();
									$("#myPage_member_board_list_content").empty();
									$("#myPage_member_board_list_title").append("<div class='col-md-1'><div class='header'>게시글번호</div></div><div class='col-md-3'><div class='header'>작성일</div></div><div class='col-md-6'><div class='header'>카테고리</div></div><div class='col-md-2'><div class='header'>제목</div></div>");
									var board_data=JSON.parse(data[0]);
									
									$.each(board_data,function(i){
										//alert(data[i].BOARD_TITLE);
										//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
										//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
										$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
										+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+board_data[i].BOARD_RGDATE+'</code></div></div></div>'
										+'<div class="col-md-6"><div class="cell"><div class="isrequired">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="description">'+board_data[i].BOARD_TITLE+'</div></div></div></div>');
									});
								}
							});
						});
					}
					alert("다음endPage:"+endPage);
					alert("다음pageCount"+pageCount);
					alert("다음마지막startPage:"+startPage);
					//다음
					if(endPage<pageCount){
						alert("다음block");
						$("#myPage_member_board_list_after").css("display","inline-block");
					}
					
					if(endPage>=pageCount){
						alert("다음hidden");
						$("#myPage_member_board_list_after").css("display","none");
						alert("bbbbbb");
					}
					
				}
			});
		});
		
		
		//이전클릭시
		$("#board_paging_before").click(function(){
			alert("이전startPage:"+startPage);
			alert("이전pageBlock:"+pageBlock);
			$.ajax({
				type:'POST',
				url:'${root}/member/board_info.do',
				data:{
					member_id:sessionStorage.getItem("email"),
					//member_id:"kimjh112339@naver.com",
					pageNumber:startPage-pageBlock
				},
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					//alert(responseData);
					
					var data=responseData.split("|");
					/* alert(data[0]);
					alert(data[1]);
					alert(data[2]);
					alert(data[3]); */
					
					var boardSize=data[1];
					var count=data[2];
					var currentPage=data[3];
					var pageBlock=1;
					var pageCount=count/boardSize+(count%boardSize==0 ? 0:1);
					alert(pageCount);
					startPage=parseInt((currentPage-1)/pageBlock)*pageBlock+1;
					endPage=startPage+pageBlock-1;
					
					$("#myPage_member_board_list_title").empty();
					$("#myPage_member_board_list_content").empty();
					$("#myPage_member_board_list_title").append("<div class='col-md-1'><div class='header'>게시글번호</div></div><div class='col-md-3'><div class='header'>작성일</div></div><div class='col-md-6'><div class='header'>카테고리</div></div><div class='col-md-2'><div class='header'>제목</div></div>");
					var board_data=JSON.parse(data[0]);
					
					$.each(board_data,function(i){
						//alert(data[i].BOARD_TITLE);
						//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
						//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
						$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
						+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+board_data[i].BOARD_RGDATE+'</code></div></div></div>'
						+'<div class="col-md-6"><div class="cell"><div class="isrequired">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
						+'<div class="col-md-2"><div class="cell"><div class="description">'+board_data[i].BOARD_TITLE+'</div></div></div></div>');
					});
					
				/* 	$("#myPage_member_point_list_pageNum").remove();
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_before'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_pageNum'></span>");
					$("#myPage_member_point_list").after("<span id='myPage_member_point_list_after'></span>"); */
					
					alert("startPage:"+startPage);
					alert("pageBlock:"+pageBlock);
					//이전
					if(startPage>pageBlock){
						$("#myPage_member_board_list_before").css("display","inline-block");
					}
					
					if(startPage<=pageBlock){
						$("#myPage_member_board_list_before").css("display","none");
					}
					
					$("#myPage_member_board_list_pageNum").empty();
					for(var i=startPage;i<=endPage;i++){
						$("#myPage_member_board_list_pageNum").append("<a href='#' id='board_paging_num"+i+"'>"+i+"</a>");
						$("#board_paging_num"+i).click(function(){
							alert($(this).text());
							$.ajax({
								type:'POST',
								url:'${root}/member/board_info.do',
								data:{
									member_id:sessionStorage.getItem("email"),
									//member_id:"kimjh112339@naver.com",
									pageNumber:$(this).text()
								},
								contentType:'application/x-www-form-urlencoded;charset=UTF-8',
								success:function(responseData){
									//alert(responseData);
									
									var data=responseData.split("|");
									/* alert(data[0]);
									alert(data[1]);
									alert(data[2]);
									alert(data[3]); */
									
									var boardSize=data[1];
									var count=data[2];
									var currentPage=data[3];
									
									
									$("#myPage_member_board_list_title").empty();
									$("#myPage_member_board_list_content").empty();
									$("#myPage_member_board_list_title").append("<div class='col-md-1'><div class='header'>게시글번호</div></div><div class='col-md-3'><div class='header'>작성일</div></div><div class='col-md-6'><div class='header'>카테고리</div></div><div class='col-md-2'><div class='header'>제목</div></div>");
									var board_data=JSON.parse(data[0]);
									
									$.each(board_data,function(i){
										//alert(data[i].BOARD_TITLE);
										//$("#myPage_member_point_list_content").append("<div><span>"+point_data[i].POINT_NO+"</span><span>"+point_data[i].POINT_DATE+"</span><span>"+point_data[i].BOARD_TITLE+"</span><span>"+point_data[i].POINT_VALUE+"</span></div>");
										//$("#myPage_member_point_list_content").append("<tr><td>"+point_data[i].POINT_NO+"</td><td>"+point_data[i].POINT_DATE+"</td><td>"+point_data[i].BOARD_TITLE+"</td><td>"+point_data[i].POINT_VALUE+"</td></tr>");
										$("#myPage_member_board_list_content").append('<div class="row margin-0"><div class="col-md-1"><div class="cell"><div class="propertyname">'+board_data[i].BOARD_NO+'</div></div></div>'
										+'<div class="col-md-3"><div class="cell"><div class="type"><code>'+board_data[i].BOARD_RGDATE+'</code></div></div></div>'
										+'<div class="col-md-6"><div class="cell"><div class="isrequired">'+board_data[i].CATEGORY_MNAME+'</div></div></div>'
										+'<div class="col-md-2"><div class="cell"><div class="description">'+board_data[i].BOARD_TITLE+'</div></div></div></div>');
									});
								}
							});
						});
					}
					
					//다음
					if(endPage<pageCount){
						$("#myPage_member_board_list_after").css("display","inline-block");
					}
					
					if(endPage>=pageCount){
						$("#myPage_member_board_list_after").css("display","none");
					}
				}
			});
		});
		
	});
}