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
<script type="text/javascript">
$(document).ready(function(){
	/*$('.form-horizontal').Validform({
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
	});*/
	
	$("#childrenFrame").load(function(){
		var mainheight = $(this).contents().find("body").height()+30;
		$(this).height("810px");
	});
	
	/******* 添加一级分类 *******/
	$('#addCategoryButton').click(function(){
		/* if ($('#tagName').val() == '') {
			alert("请输入标签名！");
			return ;
		}
		if ($('#tagAlias').val() == '') {
			alert("请输入标签别名！");
			return ;
		}
		if ($("input[name='tag.categoryId']:checked").val() <= 0) {
			alert("请选择标签分类！");
			return ;
		} */
		$('#addParentCategoryForm').submit();
	});
	//$('#loadingdiv').hide();
	$('#addParentCategoryForm').ajaxForm({
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
				alert(d.errorMessage);
			}
		}    	
	});
	/******* 添加一级分类 *******/
	
	$(".th-sortable").click(function(){
		if($(this).attr('orderfield') != undefined && $(this).attr('orderfield') != '') {
			$("#orderById").val($(this).attr('orderfield'));
			
			if($(this).attr('orderCond') == 'desc') {
				$("#oderByCondition").val("asc");
			} else {
				$("#oderByCondition").val("desc");
			}
			$('#searchForm').submit();
		}
	});
	
	if($("#orderById").val() != '') {
		$(".th-sortable").each(function(){
			if($(this).attr('orderfield') == $("#orderById").val()) {
				$(this).attr('orderCond',$("#oderByCondition").val());
				
				if($("#oderByCondition").val() == 'desc') {
					$(this).addClass("active");
				}
			}
			
		});
	}
});
	
function showChildren(parentId) {
	$("#childrenFrame").attr("src","category_getChildren.action?parentId=" + parentId);
}

function deleteCategory(categoryId) {
	if(confirm("确认删除吗？")) {
		location.href = "category_delete.action?category.id=" + categoryId;
	}
}

// 设置修改弹出层
function edit(id, name, alias) {
	$('#categoryId').val(id);
	$('#categoryName').val(name);
	$('#categoryAlias').val(alias);
}

//批量操作
function batchOperate() {
	if (typeof($("input[name='batchOperator']:checked").val()) == "undefined") {
		alert("请选择操作类型！");
		return ;
	}
	$('#batchOperateForm').submit();
}
</script>
</head>
<body class="" >
<%@include file="../head.jsp" %>
        <!-- /.aside -->
        <section id="content">
          <section class="vbox">
            <section class="scrollable padder">
              <div class="m-b-md">
              <div class="row">
                <div class="col-sm-6">
                <h3 class="m-b-none">类别管理</h3>
                <small>您可以添加、编辑、删除一级和二级分类</small>
              </div>
              </div>
              </div>

	<section class="panel panel-default"> <header
		class="panel-heading"> 一级分类
	<s:if test ="#session.user.role.id != 3"><button href="#modal-addcat" class="btn btn-s-md btn-success btn-preset" style="margin: 5px 5px 5px 15px;" data-toggle="modal">
		<i class="fa fa-plus text"></i> <span class="text">添加新的一级分类</span>
	</button>
	</s:if>
	</header>
	<div class="row wrapper b-b">
		<div class="col-sm-5">
			<div class="btn-group">
				<button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
					<span class="dropdown-label">批量操作</span> <span class="caret"></span>
				</button>
				<s:if test ="#session.user.role.id != 3"><ul class="dropdown-menu dropdown-select">
                	<li class=""><a href="#"><input type="radio" name="batchOperator" value="1">删除</a></li>
                </ul>
                </s:if>
            </div>
            <button class="btn btn-sm btn-default" onclick="batchOperate()">应用</button>     
		</div>
		<s:if test ="#session.user.role.id != 3"><div class="col-sm-3 text-center m-b-xs">
	        <div class="btn-group" data-toggle="buttons">
	          <label class="btn btn-sm btn-default <s:if test="showType == 1">active</s:if>" onclick='location="category_manage.action?menuUrl=category_manage&showType=1"' data-toggle="tooltip" data-placement="top" title="" data-original-title="网格显示">
	            <input type="radio" name="options"><i class="i i-grid2"></i>
	          </label>
	          <label class="btn btn-sm btn-default <s:if test="showType == 0">active</s:if>" onclick='location="category_manage.action?menuUrl=category_manage&showType=0"' data-toggle="tooltip" data-placement="top" title="" data-original-title="列表显示">
	            <input type="radio" name="options"><i class="fa fa-list-ul"></i>
	          </label>
	        </div>
        </div>
        </s:if>
		<form id="searchForm" method="post" action="category_manage.action">
		<div class="col-sm-3 pull-right-lg">
			<div class="input-group">
				<input type="text" name="category.name" value="<s:property value='category.name' />" class="input-sm form-control" placeholder="搜索" />
				<span class="input-group-btn">
					<button class="btn btn-sm btn-default" type="submit">
						<i class="fa fa-search"></i>
					</button> 
				</span>
			</div>
		</div>
		<input type="hidden" name="oderByCondition" id="oderByCondition" value="<s:property value='oderByCondition' />" />
		<input type="hidden" name="orderById" id="orderById" value="<s:property value='orderById' />"  />
		</form>
	</div>
	<div class="table-responsive catalogue-table">
		<table class="table table-striped m-b-none">
			<thead>
				<tr>
					<th width="20"><label class="checkbox m-n i-checks">
						<input type="checkbox"><i></i>
					</label>
					</th>
					<th class="th-sortable" data-toggle="class" orderfield="id" orderCond="asc">
						ID 
						<span class="th-sort"> 
							<i class="fa fa-sort-down text"></i> 
							<i class="fa fa-sort-up text-active"></i> 
							<i class="fa fa-sort"></i>
						</span>
					</th>
                    <th class="th-sortable" data-toggle="class" orderfield="cattag">
                    	分类标签<span class="th-sort"> 
                    	<i class="fa fa-sort-down text"></i> 
                    	<i class="fa fa-sort-up text-active"></i> 
                    	<i class="fa fa-sort"></i>
						</span>
					</th>
					<th>一级分类名称</th>
					<th>别名</th>
					<th class="th-sortable" data-toggle="class" orderfield="articleNum">文章数量<span
						class="th-sort"> <i class="fa fa-sort-down text"></i> <i
							class="fa fa-sort-up text-active"></i> <i class="fa fa-sort"></i>
					</span></th>
					<s:if test ="#session.user.role.id != 3"><th width="70">编辑</th></s:if>
					<th width="100">二级分类</th>
				</tr>
			</thead>
			<form id="batchOperateForm" method="post" action="category_batchDelete.action">
			<tbody>
				<s:iterator value="parentList" id="catetgory" status="u">
					<tr>
						<td><label class="checkbox m-n i-checks"><input type="checkbox" name="categoryIds" value="<s:property value='id' />"><i></i>
						</label>
						</td>
						<td><s:property value="id" />
						</td>
                        <td><s:property value="tagName" />
						</td>
						<td><s:property value="name" />
						</td>
						<td><s:property value="alias" />
						</td>
						<td><s:property value="articleNum" />
						</td>
						<s:if test ="#session.user.role.id != 3">
						<td>
							<div class="btn-group open">
								<a href="#modal-updatecat" class="iconbtn"  data-toggle="modal" onclick="edit('<s:property value='id' />','<s:property value='name' />','<s:property value='alias' />','<s:property value='tagName' />')">
									<i class="fa fa-pencil"></i>
								</a>
								
								<a href="javascript:void(0)" onclick="deleteCategory(<s:property value='id' />)" class="iconbtn">
									<i class="fa fa-trash-o"></i>
								</a>
								
							</div></td>
							</s:if>
						<td><a href="#modal" data-toggle="modal"
							onclick="showChildren(<s:property value='id' />)"><i
								class="fa fa-search-plus text-muted"></i>点击查看</a>
						</td>
					</tr>
				</s:iterator>
			</tbody>
			</form>
		</table>
	</div>
	<footer class="panel-footer"> <pages:pages page="page"
		params="params" /> </footer> </section>
            </section>
          </section>
          <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
        </section>
      </section>
    </section>
  </section>
  
  <div class="modal fade" id="modal">
  <div class="modal-dialog" style="width: 800px;">
      <div class="modal-content">
  	  <iframe id="childrenFrame" width ="100%" height="100%" frameborder="0"></iframe>
  	  </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div>
  
	<form id="addParentCategoryForm" class="form-horizontal" method="post" action="category_saveParent.action">
		<div class="modal fade" id="modal-addcat" style="display: none;" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h3 class="m-t-none">添加新的一级分类</h3>
						<small>您可以在此添加新的一级分类。</small>
					</div>
					<div class="modal-body wrapper-lg">
						<div class="row">
							<div class="col-sm-12">
									<div class="form-group">
										<label class="col-sm-2 control-label tagselectname">一级分类名</label>
										<div class="col-sm-9">
											<input type="text" name="category.name" datatype="s5-16" errormsg="名字至少5个字符,最多16个字符！" class="form-control" /> 
											<div class="Validform_checktip">
												此项为必填，新分类名不能和已有的标签名重复，大小写不限，不能使用特殊符号。
											</div>
										</div>
									</div>
									<div class="line line-dashed b-b line-lg pull-in"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label tagselectname">一级分类别名</label>
										<div class="col-sm-9">
											<input type="text" name="category.alias" datatype="s5-16" errormsg="名字至少5个字符,最多16个字符！" class="form-control" />
											<div class="Validform_checktip">此项为必填，请使用小写英文字母作为分类别名，特殊符号仅支持"-"和"_"。</div>
										</div>
									</div>
									<div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                       <label class="col-sm-2 control-label tagselectname">分类标签</label>
                                       <div class="col-sm-9">
                                      		<input type="text" class="form-control" name="category.tagName">
                                       		<span class="help-block m-b-none">此项为必填。</span>
                                       </div>
                                  </div>
							</div>
						</div>
						<div class="line line-dashed b-b line-lg pull-in"></div>
						<div class="checkbox m-t-lg">
							<input type="button" value="添加新的一级分类" id="addCategoryButton" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs"/>
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
	
	<form id="updateCategoryForm" class="form-horizontal" method="post" action="category_update.action">
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
										<label class="col-sm-2 control-label tagselectname">分类名</label>
										<div class="col-sm-9">
											<input type="text" name="category.name" id="categoryName" datatype="s5-16" errormsg="名字至少5个字符,最多16个字符！" class="form-control" /> 
											<div class="Validform_checktip">
												此项为必填，新分类名不能和已有的标签名重复，大小写不限，不能使用特殊符号。
											</div>
										</div>
									</div>
									<div class="line line-dashed b-b line-lg pull-in"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label tagselectname">一级分类别名</label>
										<div class="col-sm-9">
											<input type="text" name="category.alias" id="categoryAlias" datatype="s5-16" errormsg="名字至少5个字符,最多16个字符！" class="form-control" />
											<div class="Validform_checktip">此项为必填，请使用小写英文字母作为分类别名，特殊符号仅支持"-"和"_"。</div>
										</div>
									</div>
									<div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                       <label class="col-sm-2 control-label tagselectname">分类标签</label>
                                       <div class="col-sm-9">
                                      		<input type="text" class="form-control" name="category.tagName" id="categoryTagName">
                                       		<span class="help-block m-b-none">此项为必填。</span>
                                       </div>
                                  </div>
							</div>
						</div>
						<div class="line line-dashed b-b line-lg pull-in"></div>
						<div class="checkbox m-t-lg">
							<input type="hidden" id="categoryId" name="category.id" />
							<input type="submit" value="保存" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" data-loading-text="保存中..." />
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
</html>