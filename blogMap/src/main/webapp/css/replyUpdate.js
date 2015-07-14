/**
 * 
 */
var root=null;
var updateDiv=null;
function upSelectToServer(bunho,requestRoot){
	//alert(bunho + "," + root);
	root=requestRoot;
	var params="bunho="+bunho;
	var url=root + "/12_reply/replySelect.do?" + params;
	
	$.ajax({
		url:url,
		type:"get",
		dataType:"html",
		success:function(data){
			upSelectProcess(data);
		}
	});
}

function upSelectProcess(data){
	var result=data.split(",");
	var bunho=result[0].trim();
	var reply=result[1].trim();
	var bunhoDiv=$("#"+bunho);
	//alert(bunho + "," + reply + "," + bunhoDiv);
	$("#"+bunho).append("<div id='upBunho"+bunho+"'></div>");
	$("#upBunho"+bunho).append("<input id='newText' type='text' value='" + reply + "'/>");
	$("#upBunho"+bunho).append("<input type='button' value='수정' id='up'/>");
	$("#up").click(function(){
		updateToServer(bunho,$("#newText").val());
	});
}

function updateToServer(bunho, value){
	//alert(bunho + "," + value);
	var params="bunho="+bunho+"&lineReply="+value;
	var url=root+"/12_reply/replyUpdate.do?"+params;
	
	$.ajax({
		url:url,
		type:"get",
		dataType:"html",
		success:function(data){
			updateProcess(data);
		}
	});
}

function updateProcess(data){
	var result=data.split(",");
	var bunho=result[0].trim();
	var reply=result[1].trim();
	
	var bunhoDiv=$("#"+bunho);
	var updateDiv=$("#upBunho"+bunho);
	//alert(bunho + "," + reply + "," + bunhoDiv + updateDiv);
	
	updateDiv.remove();
	bunhoDiv.find($(".cssReply")).text(reply);
	
}