/**
 * 
 */
function deleteToServer(bunho,root){
	//alert(bunho + "," + root);
	var params="bunho="+bunho;
	var url=root+"/12_reply/delete.do?"+params;
	
	$.ajax({
		url:url,
		type:"get",
		dataType:"html",
		success:function(data){
			var bunho=parseInt(data);
			var divBunho=$("#"+bunho);
			//alert(divBunho);
			
			$("#"+bunho).remove();
		}
	});
}
