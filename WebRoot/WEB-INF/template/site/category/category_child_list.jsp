<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<!DOCTYPE html>
<html lang="en" class="app topadmineditpost">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>本然数据库</title>
  <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" /> 
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/animate.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/icon.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/app.css" type="text/css" /> 
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.min.css" type="text/css"> 
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/validform_style.css" type="text/css" />
  <!--[if lt IE 9]>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/html5shiv.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/respond.min.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/excanvas.js"></script>
  <![endif]-->  
<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.min.js"></script>
<!-- Bootstrap -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/bootstrap.js"></script>
  <!-- App -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.js"></script>  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/slimscroll/jquery.slimscroll.min.js"></script>
<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/sparkline/jquery.sparkline.min.js"></script>
<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>

<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/Validform_v5.3.2_min.js"></script>
<script type="text/javascript">
$(document).ready(function(){

	$('.form-horizontal').Validform({
		tiptype:function(msg,o,cssctl){
			//msg：提示信息;
			//o:{obj:*,type:*,curform:*}, obj指向的是当前验证的表单元素（或表单对象），type指示提示的状态，值为1、2、3、4， 1：正在检测/提交数据，2：通过验证，3：验证失败，4：提示ignore状态, curform为当前form对象;
			//cssctl:内置的提示信息样式控制函数，该函数需传入两个参数：显示提示信息的对象 和 当前提示的状态（既形参o中的type）;
			if(!o.obj.is("form")){//验证表单元素时o.obj为该表单元素，全部验证通过提交表单时o.obj为该表单对象;
				var objtip=o.obj.siblings(".Validform_checktip");
				cssctl(objtip,o.type);
				objtip.text(msg);
			}else{
				var objtip=o.obj.find("#msgdemo");
				cssctl(objtip,o.type);
				objtip.text(msg);
			}
		},
		ajaxPost:false
	});
	
	/******* 添加二级分类 *******/
	$('#addCategoryButton').click(function(){
		if ($('#categoryName').val() == '') {
			alert("请输入分类名！");
			return ;
		}
		if ($('#categoryAlias').val() == '') {
			alert("请输入分类别名！");
			return ;
		}
		$('#addCategoryForm').submit();
	});
	//$('#loadingdiv').hide();
	$('#addCategoryForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("添加分类成功！");
				location.reload();
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#addCategoryForm').submit();
				} else {
					alert(d.errorMessage);
				}
				
			}
		}    	
	});
	/******* 添加二级分类 *******/
	
	/******* 修改二级分类 *******/
	$('#updateCategoryForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("修改分类成功！");
				$("#modal-updatecat").find(".close").click();
				$('#updateButton').removeAttr('disabled');
				$('#updateButton').removeClass('disabled');
				location.reload();
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#updateCategoryForm').submit();
				} else {
					alert(d.errorMessage);
				}
			}
		}    	
	});
	/******* 修改二级分类 *******/
});

function deleteCategory(categoryId) {
	if(confirm("确认删除吗？")) {
		$.get("category_delete.action?category.id=" + categoryId, function(result){
		    location.reload();
		});
	}
}

//批量操作
function batchOperate() {
	if (typeof($("input[name='batchOperator']:checked").val()) == "undefined") {
		alert("请选择操作类型！");
		return ;
	}
	$('#batchOperateForm').submit();
	$("#modal-add-child").find(".close").click();
}
function cl() {
	parent.document.getElementById("modal").style.display='none';
	//$(o).modal('hide');
	$(parent.document).find("body").removeClass('modal-open');
	$(parent.document).find('.modal-backdrop').remove();
	parent.location.reload();
}

// 设置修改弹出层
function edit(id, name, alias) {
	$('#categoryIdEdit').val(id);
	$('#categoryNameEdit').val(name);
	$('#categoryAliasEdit').val(alias);
}
</script>
</head>
<body class="" >
	<div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="cl();">&times;</button>
          <h4 class="modal-title"><s:property value="parent.name" />的二级分类</h4>
    </div>
	<div class="modal-body" id="modal-add-child">
		<form id="addCategoryForm" method="post" action="category_saveChild.action">
			<section class="panel panel-default"> 
				<header class="panel-heading"> 添加新的二级分类 </header>
			<div class="panel-body">
				<div class="label-sm">
					<div class="m-b-xs prename col-sm-12">
						<span class="tagname" style="width: 7em;">二级分类名:</span>
						<div class="col-sm-12">
							<input id="categoryName" type="text" name="category.name" class="form-control" />
						</div>
						<span class="tagname" style="width: 8em;">二级分类别名:</span>
						<div class="col-sm-12">
							<input id="categoryAlias" type="text" name="category.alias" class="form-control" />
						</div>
						<span class="tagname" style="width: 1em;"></span>
						<div class="col-sm-12">
							<input type="button" id="addCategoryButton" class="btn btn-s-md btn-success btn-preset" value="添加新的二级分类" />
							<input type="hidden" name="parentId" value="<s:property value='parentId' />" />
						</div>
					</div>

				</div>
			</div>
			</section>
		</form>
		<section class="panel panel-default">
            <header class="panel-heading">
              二级分类
            </header>
		<div class="row wrapper b-b">
			<div class="col-sm-5">
				<div class="btn-group">
					<button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
					<span class="dropdown-label">批量操作</span> <span class="caret"></span>
				</button>
				 <ul class="dropdown-menu dropdown-select">
                                     <li class=""><a href="#"><input type="radio" name="batchOperator" value="1">删除</a></li>
                                     </ul>
                                     </div>
                                      <button class="btn btn-sm btn-default" onclick="batchOperate()">应用</button>  
			</div>

			<form id="searchForm" method="post" action="category_getChildren.action">
				<div class="col-sm-3 pull-right-lg">
					<div class="input-group">
						<input type="text" name="category.name" value="<s:property value='category.name' />" class="input-sm form-control" placeholder="搜索" />
							<span class="input-group-btn">
								<button class="btn btn-sm btn-default" type="submit">
									<i class="fa fa-search"></i>
								</button> 
								<input type="hidden" name="parentId" value="<s:property value='parentId' />" />
							</span>
					</div>
				</div>
			</form>
		</div>
		
		<div class="table-responsive catalogue-table">
              <table class="table table-striped m-b-none">
                <thead>
                  <tr>
                    <th width="20"><label class="checkbox m-n i-checks"><input type="checkbox"><i></i></label></th>
                    <th class="th-sortable" data-toggle="class">ID
                      <span class="th-sort">
                        <i class="fa fa-sort-down text"></i>
                        <i class="fa fa-sort-up text-active"></i>
                        <i class="fa fa-sort"></i>
                      </span>
                    </th>
                    <th>二级分类名称</th>
                    <th>别名</th>
                    <th>文章数量</th>
                    <th width="70">编辑</th>
                  </tr>
                </thead>
                <form id="batchOperateForm" method="post" action="category_batchDelete.action?category.parentId=<s:property value='parent.id' />">
                <tbody>
                <s:iterator value="childList" id="category" status="u">
                	<tr>
                    <td><label class="checkbox m-n i-checks"><input type="checkbox" name="categoryIds" value="<s:property value='id' />"><i></i>
						</label>
						</td>
                    <td><s:property value="id" /></td>
                    <td><s:property value="name" /></td>
                    <td><s:property value="alias" /></td>
                    <td><s:property value="articleNum" /></td>
                    <td>
                      <div class="btn-group open">
                          <a href="#modal-updatecat" class="iconbtn" data-toggle="modal" onclick="edit('<s:property value='id' />','<s:property value='name' />','<s:property value='alias' />')"><i class="fa fa-pencil"></i></a>
                          <a href="javascript:void(0)" onclick="deleteCategory(<s:property value='id' />)" class="iconbtn"><i class="fa fa-trash-o"></i></a></div>
                    </td>
                  </tr>
                </s:iterator>
                </tbody>
                </form>
              </table>
            </div>
            <footer class="panel-footer">
              <pages:pages page="page" params="params"/>
            </footer>
          </section>
        </div>
        
        
        <form id="updateCategoryForm" class="form-horizontal" method="post" action="category_updateAjax.action">
		<div class="modal fade" id="modal-updatecat" style="display: none;" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h3 class="m-t-none">修改分类</h3>
						<small>您可以在此修改分类。</small>
					</div>
					<div class="modal-body wrapper-lg">
						<div class="row">
							<div class="col-sm-12">
									<div class="form-group">
										<label class="col-sm-2 control-label tagselectname">二级分类名</label>
										<div class="col-sm-9">
											<input type="text" name="category.name" id="categoryNameEdit" datatype="s5-16" errormsg="名字至少5个字符,最多16个字符！" class="form-control" /> 
											<div class="Validform_checktip">
												此项为必填，新分类名不能和已有的标签名重复，大小写不限，不能使用特殊符号。
											</div>
										</div>
									</div>
									<div class="line line-dashed b-b line-lg pull-in"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label tagselectname">二级分类别名</label>
										<div class="col-sm-9">
											<input type="text" name="category.alias" id="categoryAliasEdit" datatype="s5-16" errormsg="名字至少5个字符,最多16个字符！" class="form-control" />
											<div class="Validform_checktip">此项为必填，请使用小写英文字母作为分类别名，特殊符号仅支持"-"和"_"。</div>
										</div>
									</div>
							</div>
						</div>
						<div class="line line-dashed b-b line-lg pull-in"></div>
						<div class="checkbox m-t-lg">
							<input type="hidden" id="categoryIdEdit" name="category.id" />
							<input type="submit" id="updateButton" value="保存" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" data-loading-text="保存中..." />
						</div>

					</div>
				</div>
			</div>
		</div>
		<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
		</div>
	</form>
</body>