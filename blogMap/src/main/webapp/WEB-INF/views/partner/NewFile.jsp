<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<section class="modal fade" id="write_pop">
			<div class="modal-dialog modal-lg">
				<form id="write_form" class="col-xs-12 form-horizontal" method="post" action="${root}/partner/write.do" autocomplete="off" enctype="multipart/form-data">
					<div class="modal-content">
						
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title">신규 업체 등록</h4>
						</div>
	
						<div class="modal-body" id="data-body">							
							<input type="hidden"  id="category_code" name="category_code"/>
							<input type="hidden"  id="member_id" name="member_id"/>
							
							<div class="form-group">
								<label class="col-xs-4 control-label">카테고리:</label> 
								<select id="headCategory" name="category_mname" class="selectpicker" data-width="140px" style="display: none" onchange="blogWrite_ChangeCategory(this.id)">
									<option value="%">대분류[전체]</option>
								</select> 
								<select id="detailCategory" name="category_sname"  class="selectpicker" data-width="140px" style="display: none">
									<option value="%">소분류[전체]</option>
								</select>
							</div>
							<div class="form-group">
								<label class="col-xs-4 control-label">업체명:</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="partner_name" id="name" value="" required="required" placeholder="업체명"/>
								</div>
							</div>
	
							<div class="form-group">
								<label class="col-xs-4 control-label">전화번호:</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="partner_phone" id="phone" value="" required="required" placeholder="전화번호"/>
								</div>
							</div>
	
							<div class="form-group">
								<label class="col-xs-4 control-label">주소:</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" name="partner_addr" id="address" value="" required="required" placeholder="주소를 입력하세요"/>
								</div>											
							</div>
	
							<div class="form-group">
								<label class="col-xs-4 control-label">업체사진:</label>
								<div class="col-xs-8">
									<input type="file" class="form-control" name="img_src" id="partner_imagers"/>
								</div>
							</div>
						</div>
	
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary" onclick="return form_validation();">신청하기</button>
						</div>
					</div>
				</form>
			</div>
		</section>
</body>
</html>