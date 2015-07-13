/**
 * 
 */
var root=null;  //root를 전역변수로 선언해서 사용! 
function writeToServer(requestRoot,boardNumber){
	root=requestRoot;
	//alert(root + "," + boardNumber);
	
	var writeReply=$("#writeReply").val();
	var sendData="boardNumber="+boardNumber+"&lineReply="+writeReply;
	var url=root+"/12_reply/replyWrite.do?"+sendData;
	$.ajax({
		url:url,
		type:"get",
		dataType:"text",
		success:function(data){
			var result=data.split(","); 
			var bunho=result[0].trim();  
			var reply=result[1].trim();
			alert(bunho + "," + reply);
			
			$("#writeReply").val("");
			$("#listAllDiv>div:eq(0)").clone().prependTo($("#listAllDiv"));
			$("#listAllDiv>div:eq(0)").css("display","block");
			$("#listAllDiv>div:eq(0)").attr("id",bunho);
		//	$("#listAllDiv>div:eq(0)").prepend($("#listAllDiv span:eq(0)").text(bunho));
		//	$("#listAllDiv>div:eq(0)").prepend($("#listAllDiv span:eq(1)").text(reply));
			$("#listAllDiv span:eq(0)").text(bunho);
			$("#listAllDiv span:eq(1)").text(reply);
			
			$("#listAllDiv a:eq(1)").text("삭제");
			$("#listAllDiv a:eq(1)").attr("href","javascript:deleteToServer(" + bunho + ",\'" + root + "\')");
			$("#listAllDiv a:eq(0)").text("수정");
			$("#listAllDiv a:eq(0)").attr("href","javascript:upSelectToServer(" + bunho + ",\'" + root + "\')");
			
		},
		
		error:function(xhr,status,error){
			alert(xhr + "," + status + "," + error);
		}
	});
}


	
