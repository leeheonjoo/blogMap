/**
 * 
 */

$("#delete").click(function(){
			alert("delete");
			$.ajax({
				type:'get',
				url:'${root}/manager/delete.do',
				contentType:'application/x-www-form-urlencoded;charset=UTF-8',
				success:function(responseData){
					var data=JSON.parse(responseData);
					
					if(!data){
						alert("데이타가 없습니다.");
						return false;
					}
				},error:function(data){
					alert("에러가 발생하였습니다.");
				}
			});
		});